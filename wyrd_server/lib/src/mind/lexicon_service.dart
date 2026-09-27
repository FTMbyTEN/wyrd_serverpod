import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'wordnet_service.dart';
import '../generated/protocol.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's lexiconTick: picks a real English word WYRD has run into in recent memory
/// but never looked up, fetches its definition (Wiktionary, falling back to dictionaryapi.dev,
/// which server.js used alone and which has been unreliable), and stores it in
/// lexicon_entry (understood or not). A word that gets defined nudges Mind's confidence.
class LexiconService {
  static const _wordlistUrl =
      'https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt';
  static const _recentBlocks = 60;

  /// Every valid English word, loaded once per server process (~370k words). Null until the
  /// first successful load; a failed load is retried on a later tick rather than pausing forever.
  static Set<String>? _dictionary;
  static Future<Set<String>?>? _loading;

  /// Lets tests supply a small wordlist instead of downloading the real one.
  static set dictionaryForTesting(Set<String>? words) => _dictionary = words;

  static Future<Set<String>?> _ensureDictionary(Session session) async {
    if (_dictionary != null) return _dictionary;
    return _loading ??= () async {
      try {
        final res = await http
            .get(Uri.parse(_wordlistUrl))
            .timeout(const Duration(seconds: 60));
        if (res.statusCode != 200) throw Exception('http ${res.statusCode}');
        final words = const LineSplitter()
            .convert(res.body)
            .map((w) => w.trim().toLowerCase())
            .where((w) => w.isNotEmpty)
            .toSet();
        return _dictionary = words;
      } catch (e) {
        session.log(
          '[lexicon] wordlist load failed: $e',
          level: LogLevel.warning,
        );
        return null;
      } finally {
        _loading = null;
      }
    }();
  }

  static const _lookupTimeout = Duration(seconds: 8);
  static const _userAgent = 'wyrd-bot/1.0 (https://wyrd.com.ng)';

  /// Looks [word] up in Wiktionary, falling back to dictionaryapi.dev. Returns the definition,
  /// or null when a source answered that the word doesn't exist (404). Throws when no source
  /// could be reached -- an outage must not be recorded as "not a word".
  static Future<({String partOfSpeech, String definition})?> _define(String word) async {
    final sources = [_fromWiktionary, _fromDictionaryApi];
    Object? lastError;
    var anyNotFound = false;
    for (final source in sources) {
      try {
        final result = await source(word);
        if (result != null) return result;
        anyNotFound = true;
      } catch (e) {
        lastError = e; // this source is down or slow -- try the next one
      }
    }
    if (anyNotFound) return null;
    throw Exception('no dictionary reachable: $lastError');
  }

  /// Wiktionary's REST API. Null on a 404 (unknown word) or when it has no usable English sense.
  static Future<({String partOfSpeech, String definition})?> _fromWiktionary(String word) async {
    final res = await http.get(
      Uri.parse('https://en.wiktionary.org/api/rest_v1/page/definition/${Uri.encodeComponent(word)}'),
      headers: {'User-Agent': _userAgent, 'Accept': 'application/json'},
    ).timeout(_lookupTimeout);
    if (res.statusCode == 404) return null;
    if (res.statusCode != 200) throw Exception('wiktionary http ${res.statusCode}');
    final senses = (jsonDecode(res.body) as Map<String, dynamic>)['en'] as List<dynamic>? ?? [];
    final candidates = <({String partOfSpeech, String definition})>[];
    for (final sense in senses.cast<Map<String, dynamic>>()) {
      final pos = (sense['partOfSpeech'] as String? ?? 'unknown').toLowerCase();
      for (final d in (sense['definitions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()) {
        final text = stripHtml(d['definition'] as String? ?? '');
        if (text.isNotEmpty) candidates.add((partOfSpeech: pos, definition: text));
      }
    }
    return bestSense(candidates);
  }

  /// dictionaryapi.dev (the original server.js source). Null on a 404 (unknown word).
  static Future<({String partOfSpeech, String definition})?> _fromDictionaryApi(String word) async {
    final res = await http
        .get(Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/${Uri.encodeComponent(word)}'))
        .timeout(_lookupTimeout);
    if (res.statusCode == 404) return null;
    if (res.statusCode != 200) throw Exception('dictionaryapi http ${res.statusCode}');
    final data = jsonDecode(res.body);
    if (data is! List || data.isEmpty) return null;
    final candidates = <({String partOfSpeech, String definition})>[];
    for (final m in ((data.first as Map<String, dynamic>)['meanings'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()) {
      final pos = (m['partOfSpeech'] as String? ?? 'unknown').toLowerCase();
      for (final d in (m['definitions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()) {
        final text = (d['definition'] as String? ?? '').trim();
        if (text.isNotEmpty) candidates.add((partOfSpeech: pos, definition: text));
      }
    }
    return bestSense(candidates);
  }

  // Parts of speech that describe the word as people actually use it, best first. Anything not
  // listed (symbol, abbreviation, initialism, proper noun, letter, affix...) is a last resort --
  // that's how "got" ended up defined as "ISO 639 language code for Gothic".
  static const _posRank = {
    'noun': 0, 'verb': 0, 'adjective': 0, 'adverb': 0,
    'pronoun': 1, 'preposition': 1, 'conjunction': 1, 'determiner': 1,
    'interjection': 1, 'numeral': 1, 'particle': 1, 'participle': 1,
  };
  static final _technical = RegExp(
    r'\b(ISO 639|language code|abbreviation of|initialism of|acronym of|symbol for|chemical symbol|'
        r'alternative (letter-case|spelling) form of|misspelling of)\b',
    caseSensitive: false,
  );
  static final _marginal = RegExp(
    r'^\(?(obsolete|archaic|rare|dated|dialectal|dialect|nonstandard|slang|vulgar|historical)\b',
    caseSensitive: false,
  );

  /// Picks the sense a reader would expect: everyday parts of speech over symbols and codes,
  /// current senses over obsolete or rare ones, and a real explanation over a stub. "Past tense
  /// of get"-style entries are fine -- for inflected words that's the right answer. Earlier
  /// entries win ties, since dictionaries list the main sense first. Null if nothing qualifies.
  static ({String partOfSpeech, String definition})? bestSense(
    List<({String partOfSpeech, String definition})> candidates,
  ) {
    ({String partOfSpeech, String definition})? best;
    var bestScore = 1 << 30;
    for (final c in candidates) {
      var score = (_posRank[c.partOfSpeech] ?? 5) * 10;
      if (_technical.hasMatch(c.definition)) score += 40;
      if (_marginal.hasMatch(c.definition)) score += 15;
      if (c.definition.length < 12) score += 8;
      if (score < bestScore) {
        bestScore = score;
        best = c;
      }
    }
    return best;
  }

  /// True for entries learned before [bestSense] existed that are clearly the wrong sense.
  static bool isPoorDefinition(LexiconEntry e) =>
      e.understood &&
      ((e.partOfSpeech != null && !_posRank.containsKey(e.partOfSpeech)) || _technical.hasMatch(e.definition ?? ''));

  /// Wiktionary definitions are HTML fragments (links, spans, italics). Plain text for storage.
  static String stripHtml(String html) => html
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&amp;', '&')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  /// Returns true if a word was attempted (false when there's no wordlist yet or nothing new
  /// to learn).
  // Short and filler words ("who", "got", "into") are real English but say nothing about what
  // WYRD is learning; its vocabulary time goes to meaningful words instead.
  static const _minWordLength = 4;
  static const _filler = {
    'that', 'this', 'with', 'from', 'have', 'been', 'were', 'they', 'them', 'then', 'than', 'what', 'when',
    'where', 'which', 'while', 'would', 'could', 'should', 'there', 'these', 'those', 'their', 'about', 'into',
    'just', 'like', 'some', 'only', 'over', 'very', 'also', 'more', 'most', 'much', 'many', 'such', 'here',
    'your', 'yours', 'ours', 'will', 'shall', 'does', 'done', 'being', 'each', 'every', 'other', 'another',
    'thing', 'things', 'something', 'anything', 'nothing', 'before', 'after', 'least', 'little', 'seen',
  };

  /// Re-defines one word that was learned with the wrong sense (e.g. "got" as a language code).
  /// Returns true if one was handled this tick.
  static Future<bool> _repairOne(Session session) async {
    final recent = await LexiconEntry.db.find(
      session,
      where: (t) => t.understood.equals(true),
      orderBy: (t) => t.id.desc(),
      limit: 300,
    );
    final poor = recent.where(isPoorDefinition).firstOrNull;
    if (poor == null) return false;
    final ({String partOfSpeech, String definition})? def;
    try {
      def = await _define(poor.word);
    } catch (_) {
      return false; // dictionaries unreachable -- try again later
    }
    final fixed = def != null && !isPoorDefinition(poor.copyWith(partOfSpeech: def.partOfSpeech, definition: def.definition));
    await LexiconEntry.db.updateRow(
      session,
      fixed
          ? poor.copyWith(partOfSpeech: def.partOfSpeech, definition: def.definition)
          // only a code/symbol sense exists: it isn't vocabulary, so stop counting it as understood
          : poor.copyWith(understood: false),
    );
    session.log('[lexicon] repaired "${poor.word}": ${fixed ? def.definition : 'no everyday sense'}');
    return true;
  }

  static const _wordsPerTick = 6;
  static const _relearnPerTick = 40;
  static const _relearnMark = 'wordnet-relearn-2'; // re-run with extended Lesk

  /// Learns from WordNet (local, no web or AI calls) once it's loaded; until then, the old
  /// one-word-per-tick web dictionary path below.
  static Future<bool> tick(Session session) async {
    if (await WordNetService.isReady(session)) return _tickWordNet(session);
    // not loaded yet: (re)start the import in the background, then carry on the old way
    WordNetService.retryIfNeeded(() async {
      final s = await Serverpod.instance.createSession(enableLogging: true);
      try {
        await WordNetService.ensureImported(s);
      } finally {
        await s.close();
      }
    });
    return _tickWeb(session);
  }

  static Future<bool> _tickWordNet(Session session) async {
    if (await _relearnSome(session)) return true;

    final pool = await MemoryBlock.db.find(
      session,
      where: (t) => t.source.notEquals('chat') & t.source.notEquals('photo'),
      orderBy: (t) => t.id.desc(),
      limit: 1000,
    );
    final seen = pool
        .expand((b) => b.topics)
        .where((w) => w.length >= _minWordLength && !_filler.contains(w))
        .toSet();
    if (seen.isEmpty) return false;
    final already = (await LexiconEntry.db.find(session, where: (t) => t.word.inSet(seen))).map((e) => e.word).toSet();
    final fresh = seen.difference(already);
    if (fresh.isEmpty) return false;
    final inWordNet = await WordNetService.known(session, fresh);
    if (inWordNet.isEmpty) return false;

    final words = inWordNet.keys.toList()..shuffle();
    var learned = 0;
    for (final word in words.take(_wordsPerTick)) {
      final context = pool.where((b) => b.topics.contains(word)).expand((b) => b.topics).toList();
      final def = await WordNetService.define(session, word, context: context);
      if (def == null) continue;
      await session.db.unsafeExecute(
        'INSERT INTO "lexicon_entry" ("word", "understood", "definition", "partOfSpeech", "learnedAt") '
        'VALUES (@w, true, @d, @p, @t) ON CONFLICT ("word") DO NOTHING',
        parameters: QueryParameters.named({'w': word, 'd': def.definition, 'p': def.partOfSpeech, 't': DateTime.now().toUtc()}),
      );
      learned++;
    }
    if (learned > 0) await _nudgeConfidence(session);
    return learned > 0;
  }

  /// Once WordNet is loaded, re-defines the words learned earlier from the web, choosing the
  /// sense that fits what WYRD actually read (fixes e.g. "programming" as TV scheduling).
  static Future<bool> _relearnSome(Session session) async {
    final mark = await MaintenanceRun.db.findFirstRow(session, where: (t) => t.name.equals(_relearnMark));
    if (mark?.note == 'done') return false;
    final lastId = int.tryParse(mark?.note ?? '') ?? 0;
    final batch = await LexiconEntry.db.find(
      session,
      where: (t) => t.id > lastId,
      orderBy: (t) => t.id,
      limit: _relearnPerTick,
    );
    for (final e in batch) {
      final ctxRows = await session.db.unsafeQuery(
        'SELECT "topics"::text FROM "memory_block" WHERE "source" NOT IN (\'chat\', \'photo\') '
        'AND "topics"::jsonb ? @w ORDER BY "id" DESC LIMIT 15',
        parameters: QueryParameters.named({'w': e.word}),
      );
      final context = ctxRows.expand((r) => (jsonDecode(r[0] as String) as List).cast<String>()).toList();
      final def = await WordNetService.define(session, e.word, context: context);
      if (def != null) {
        await LexiconEntry.db.updateRow(session, e.copyWith(understood: true, definition: def.definition, partOfSpeech: def.partOfSpeech));
      } else if ((await WordNetService.known(session, [e.word])).isNotEmpty) {
        // WordNet knows the word but none of its meanings fit how WYRD meets it (e.g. "llms" as a
        // law degree): better not understood than wrong
        await LexiconEntry.db.updateRow(session, e.copyWith(understood: false));
      }
    }
    final note = batch.length < _relearnPerTick ? 'done' : '${batch.last.id}';
    await session.db.unsafeExecute(
      'INSERT INTO "maintenance_run" ("name", "ranAt", "note") VALUES (@n, @t, @note) '
      'ON CONFLICT ("name") DO UPDATE SET "note" = @note, "ranAt" = @t',
      parameters: QueryParameters.named({'n': _relearnMark, 't': DateTime.now().toUtc(), 'note': note}),
    );
    if (note == 'done') session.log('[lexicon] relearned existing vocabulary from WordNet');
    return batch.isNotEmpty;
  }

  static Future<void> _nudgeConfidence(Session session) async {
    final mind = await MindService.load(session);
    const pull = 0.15;
    await Mind.db.updateRow(
      session,
      mind.copyWith(
        confidence: min(0.98, ((mind.confidence * (1 - pull) + 0.9 * pull) * 100).round() / 100),
        lastEvent: 'lexicon',
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  static Future<bool> _tickWeb(Session session) async {
    final dictionary = await _ensureDictionary(session);
    if (dictionary == null || dictionary.isEmpty) return false;
    if (await _repairOne(session)) return true;

    final pool = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _recentBlocks,
    );
    final seen = pool
        .expand((b) => b.topics)
        .where((w) => w.length >= _minWordLength && !_filler.contains(w) && dictionary.contains(w))
        .toSet();
    if (seen.isEmpty) return false;

    final known = await LexiconEntry.db.find(
      session,
      where: (t) => t.word.inSet(seen),
    );
    final candidates = seen
        .difference(known.map((e) => e.word).toSet())
        .toList();
    if (candidates.isEmpty) return false;

    final word = candidates[Random().nextInt(candidates.length)];
    final ({String partOfSpeech, String definition})? def;
    try {
      def = await _define(word);
    } catch (e) {
      session.log(
        '[lexicon] define "$word" failed: $e',
        level: LogLevel.warning,
      );
      return false; // network trouble -- leave the word unattempted so it's retried later
    }

    await LexiconEntry.db.insertRow(
      session,
      LexiconEntry(
        word: word,
        understood: def != null,
        definition: def?.definition,
        partOfSpeech: def?.partOfSpeech,
        learnedAt: DateTime.now().toUtc(),
      ),
    );

    if (def != null) {
      final mind = await MindService.load(session);
      const pull = 0.15;
      await Mind.db.updateRow(
        session,
        mind.copyWith(
          confidence: min(
            0.98,
            ((mind.confidence * (1 - pull) + 0.9 * pull) * 100).round() / 100,
          ),
          lastEvent: 'lexicon',
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
    return true;
  }
}
