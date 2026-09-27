import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's own dictionary: WordNet 3.1, imported once into `word_sense` from
/// web/data/wordnet.tsv.gz (built from the official Princeton files; see web/data/WORDNET_LICENSE.txt).
///
/// Words are looked up locally -- no dictionary websites, no AI calls -- and the right sense is
/// chosen with the Lesk algorithm: the sense whose definition, example, synonyms and broader
/// term share the most words with what WYRD read around that word wins. So "programming" next
/// to "languages" and "code" means writing software, not scheduling TV.
class WordNetService {
  // under web/ because the server image only copies config/, web/ and migrations/
  static const _dataFile = 'web/data/wordnet.tsv.gz';
  static const _importMark = 'wordnet-3.1-s4'; // up to 4 senses per word and part of speech
  static const _batch = 800;

  static bool? _ready;
  static bool _importing = false;
  static DateTime? _lastAttempt;

  /// Human-readable import state, for LexiconEndpoint.wordnetStatus and the logs.
  static String status = 'not started';

  static void _say(Session session, String msg, {bool warn = false}) {
    status = msg;
    // ignore: avoid_print
    print('[wordnet] $msg'); // container log, in case session logs are sampled
    session.log('[wordnet] $msg', level: warn ? LogLevel.warning : LogLevel.info);
  }

  /// Starts an import in the background if WordNet isn't loaded, none is running, and the last
  /// attempt was over 10 minutes ago -- so a failed startup import heals itself.
  static void retryIfNeeded(Future<void> Function() run) {
    if (_ready == true || _importing) return;
    final last = _lastAttempt;
    if (last != null && DateTime.now().difference(last) < const Duration(minutes: 10)) return;
    _lastAttempt = DateTime.now();
    run();
  }

  /// True once the import has finished (cached after the first positive check).
  static Future<bool> isReady(Session session) async {
    if (_ready == true) return true;
    final mark = await MaintenanceRun.db.findFirstRow(session, where: (t) => t.name.equals(_importMark));
    return _ready = mark != null;
  }

  /// Imports the data file if it hasn't been yet. Safe to call on every start and from several
  /// servers at once: rows are keyed (lemma, pos, rank) and inserted with ON CONFLICT DO NOTHING.
  static Future<void> ensureImported(Session session) async {
    if (await isReady(session)) {
      status = 'ready';
      return;
    }
    if (_importing) return;
    _importing = true;
    _lastAttempt = DateTime.now();
    try {
      final file = File(_dataFile);
      if (!file.existsSync()) {
        _say(session, '$_dataFile not found (looked in ${file.absolute.path}); using web dictionaries', warn: true);
        return;
      }
      _say(session, 'importing from ${file.absolute.path}');
      await _import(session, file);
    } catch (e) {
      _say(session, 'import failed: $e', warn: true);
    } finally {
      _importing = false;
    }
  }

  static Future<void> _import(Session session, File file) async {
    final sw = Stopwatch()..start();
    final lines = const LineSplitter().convert(utf8.decode(gzip.decode(await file.readAsBytes())));
    final n = await importLines(session, lines);
    await session.db.unsafeExecute(
      'INSERT INTO "maintenance_run" ("name", "ranAt", "note") VALUES (@n, @t, @note) ON CONFLICT ("name") DO NOTHING',
      parameters: QueryParameters.named({'n': _importMark, 't': DateTime.now().toUtc(), 'note': '$n senses'}),
    );
    _ready = true;
    _say(session, 'ready: imported $n senses in ${sw.elapsed.inSeconds}s');
  }

  /// Inserts TSV lines (lemma, pos, rank, tagCount, definition, example, synonyms, hypernym).
  static Future<int> importLines(Session session, List<String> lines) async {
    var count = 0;
    for (var i = 0; i < lines.length; i += _batch) {
      final chunk = lines.sublist(i, min(i + _batch, lines.length)).where((l) => l.isNotEmpty).toList();
      if (chunk.isEmpty) continue;
      final params = <String, Object?>{};
      final values = <String>[];
      for (var j = 0; j < chunk.length; j++) {
        final f = chunk[j].split('\t');
        if (f.length < 8) continue;
        params['l$j'] = f[0];
        params['p$j'] = f[1];
        params['r$j'] = int.parse(f[2]);
        params['c$j'] = int.parse(f[3]);
        params['d$j'] = f[4];
        params['e$j'] = f[5].isEmpty ? null : f[5];
        params['s$j'] = jsonEncode(f[6].isEmpty ? <String>[] : f[6].split(','));
        params['h$j'] = f[7].isEmpty ? null : f[7];
        values.add('(@l$j, @p$j, @r$j, @c$j, @d$j, @e$j, @s$j::json, @h$j)');
        count++;
      }
      if (values.isEmpty) continue;
      await session.db.unsafeExecute(
        'INSERT INTO "word_sense" ("lemma", "pos", "rank", "tagCount", "definition", "example", "synonyms", "hypernym") '
        'VALUES ${values.join(', ')} ON CONFLICT ("lemma", "pos", "rank") DO NOTHING',
        parameters: QueryParameters.named(params),
      );
    }
    return count;
  }

  // ---- morphology: WordNet's "morphy" suffix rules, to find the dictionary form of a word ----

  static const _rules = [
    ('ses', 's'), ('xes', 'x'), ('zes', 'z'), ('ches', 'ch'), ('shes', 'sh'), ('men', 'man'), ('ies', 'y'),
    ('s', ''), ('es', 'e'), ('es', ''), ('ed', 'e'), ('ed', ''), ('ing', 'e'), ('ing', ''), ('er', ''), ('est', ''),
    ('er', 'e'), ('est', 'e'),
  ];

  /// The word itself plus every base form the suffix rules allow ("languages" -> "language").
  static Set<String> baseForms(String word) {
    final w = word.toLowerCase();
    final out = {w};
    for (final (suffix, repl) in _rules) {
      if (w.length > suffix.length + 2 && w.endsWith(suffix)) out.add(w.substring(0, w.length - suffix.length) + repl);
    }
    return out;
  }

  /// Which of [words] WordNet knows, each mapped to the base form it was found under.
  static Future<Map<String, String>> known(Session session, Iterable<String> words) async {
    final forms = {for (final w in words) w: baseForms(w)};
    final all = forms.values.expand((f) => f).toSet().toList();
    if (all.isEmpty) return {};
    final rows = await session.db.unsafeQuery(
      'SELECT DISTINCT "lemma" FROM "word_sense" WHERE "lemma" = ANY(@w::text[])',
      parameters: QueryParameters.named({'w': all}),
    );
    final hit = rows.map((r) => r[0] as String).toSet();
    final out = <String, String>{};
    forms.forEach((w, f) {
      // prefer the word as written, then the shortest base form
      final found = f.where(hit.contains).toList()..sort((a, b) => a == w ? -1 : b == w ? 1 : a.length.compareTo(b.length));
      if (found.isNotEmpty) out[w] = found.first;
    });
    return out;
  }

  static final _token = RegExp(r"[a-z][a-z'-]+");
  static const _ignore = {
    'the', 'and', 'for', 'with', 'that', 'this', 'from', 'into', 'used', 'using', 'which', 'something', 'someone',
    'having', 'being', 'make', 'made', 'act', 'state', 'quality', 'person', 'thing', 'things', 'especially',
    'other', 'more', 'most', 'one', 'two', 'its', 'their', 'such', 'not', 'any', 'all', 'way', 'part',
  };

  static Set<String> _words(String text) => _token
      .allMatches(text.toLowerCase())
      .map((m) => m.group(0)!)
      .where((w) => w.length > 2 && !_ignore.contains(w))
      .expand(baseForms)
      .toSet();

  static Set<String> _signature(WordSense s) =>
      _words([s.definition, s.example ?? '', s.synonyms.join(' '), s.hypernym ?? ''].join(' '));

  /// Defines [word] from WordNet, choosing the sense that best fits [context] (the words WYRD
  /// read around it). Null if WordNet doesn't know the word.
  static Future<({String partOfSpeech, String definition, String lemma})?> define(
    Session session,
    String word, {
    Iterable<String> context = const [],
  }) async {
    final lemma = (await known(session, [word]))[word];
    if (lemma == null) return null;
    final senses = await WordSense.db.find(session, where: (t) => t.lemma.equals(lemma));
    if (senses.isEmpty) return null;

    final own = baseForms(word);
    final ctx = context.expand((c) => _words(c)).toSet()..removeAll(own);

    // Extended Lesk: the context also includes what the surrounding words *mean*. "code" and
    // "software" are defined with "computer", "instructions" and "program" -- which is what
    // separates programming-as-coding from programming-as-scheduling.
    final around = ctx.where((w) => w.length > 3).take(40).toList();
    final extended = <String>{};
    if (around.isNotEmpty) {
      final rows = await session.db.unsafeQuery(
        'SELECT "definition", "hypernym" FROM "word_sense" WHERE "lemma" = ANY(@w::text[]) AND "rank" = 0',
        parameters: QueryParameters.named({'w': around}),
      );
      for (final r in rows) {
        extended.addAll(_words('${r[0]} ${r[1] ?? ''}'));
      }
      extended.removeAll(own);
    }

    final maxTag = senses.map((s) => s.tagCount).fold(0, max);
    int direct(WordSense s) => _signature(s).intersection(ctx).length;
    int indirect(WordSense s) => _signature(s).intersection(extended).length;
    double score(WordSense s) =>
        direct(s) * 3 // Lesk: shared words with what WYRD read around it
        + indirect(s) * 1.0 // extended Lesk: shared words with what those words mean
        + (s.rank == 0 ? 1 : 0) // WordNet lists a word's commonest sense first
        + (maxTag > 0 ? 1.5 * s.tagCount / maxTag : 0) // how common this part of speech is for the word
        + (s.pos == 'noun' ? 0.3 : 0); // topics are mostly things, not actions

    senses.sort((a, b) => score(b).compareTo(score(a)));
    final best = senses.first;

    // A rare word whose every sense is unrelated to a rich context is probably something else
    // here (e.g. "llms" -> LL.M., a law degree, among AI topics): better unknown than wrong.
    if (ctx.length >= 10 && maxTag == 0 && direct(best) == 0 && indirect(best) == 0) return null;
    final def = best.definition[0].toUpperCase() + best.definition.substring(1);
    return (partOfSpeech: best.pos, definition: def.endsWith('.') ? def : '$def.', lemma: lemma);
  }
}
