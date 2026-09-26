import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
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
    for (final sense in senses.cast<Map<String, dynamic>>()) {
      for (final d in (sense['definitions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()) {
        final text = stripHtml(d['definition'] as String? ?? '');
        if (text.isNotEmpty) {
          return (partOfSpeech: (sense['partOfSpeech'] as String? ?? 'unknown').toLowerCase(), definition: text);
        }
      }
    }
    return null;
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
    final meanings = (data.first as Map<String, dynamic>)['meanings'] as List<dynamic>?;
    final meaning = meanings != null && meanings.isNotEmpty ? meanings.first as Map<String, dynamic> : null;
    final definitions = meaning?['definitions'] as List<dynamic>?;
    final definition = definitions != null && definitions.isNotEmpty
        ? (definitions.first as Map<String, dynamic>)['definition'] as String?
        : null;
    if (definition == null || definition.trim().isEmpty) return null;
    return (partOfSpeech: meaning!['partOfSpeech'] as String? ?? 'unknown', definition: definition.trim());
  }

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
  static Future<bool> tick(Session session) async {
    final dictionary = await _ensureDictionary(session);
    if (dictionary == null || dictionary.isEmpty) return false;

    final pool = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _recentBlocks,
    );
    final seen = pool
        .expand((b) => b.topics)
        .where(dictionary.contains)
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
