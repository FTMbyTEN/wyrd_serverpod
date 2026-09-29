import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Filter + sort, for thoughts: which words can be the subject of a thought. Headlines are full
/// of words that are real English but not ideas -- "shows", "updated", "weird", "ending", "best"
/// -- and WYRD used to reason about them ("support" → "google" → "weird"). A concept is a noun
/// in its own dictionary (WordNet), or a name its dictionary doesn't know (a company, a place, a
/// technology: "nvidia", "rafah", "kubernetes"); words its dictionary knows only as verbs or
/// adjectives, and generic headline filler, are not.
class ConceptFilter {
  static Set<String>? _nouns;
  static Set<String>? _known;
  static DateTime? _loadedAt;
  static Set<String>? _names;
  static DateTime? _namesAt;

  static const _filler = {
    'show', 'shows', 'showed', 'update', 'updated', 'updates', 'weird', 'ending', 'early', 'late', 'best',
    'better', 'worst', 'top', 'today', 'week', 'weeks', 'year', 'years', 'month', 'months', 'day', 'days',
    'time', 'times', 'people', 'thing', 'things', 'way', 'ways', 'news', 'report', 'reports', 'says', 'study',
    'finds', 'first', 'last', 'next', 'big', 'small', 'good', 'bad', 'high', 'low', 'free', 'open', 'based',
    'using', 'take', 'look', 'want', 'need', 'latest', 'launch', 'launches', 'release', 'released',
    'announces', 'introducing', 'ask', 'tell', 'video', 'watch', 'read', 'source', 'article', 'post',
    'blog', 'page', 'site', 'link', 'online', 'part', 'lot', 'kind', 'sort', 'case', 'point', 'fact',
    'number', 'side', 'end', 'start', 'set', 'run', 'full', 'real', 'true', 'long', 'short', 'old', 'young',
    'right', 'left', 'hard', 'easy', 'able', 'sure', 'hand', 'home', 'work', 'job', 'life', 'world', 'group',
    'area', 'place', 'level', 'line', 'term', 'result', 'results', 'issue', 'issues', 'problem', 'problems',
    'question', 'questions', 'idea', 'ideas', 'story', 'stories', 'reason', 'example', 'system', 'systems',
    'toward', 'towards', 'among', 'amongst', 'within', 'without', 'upon', 'onto', 'across', 'whether', 'though',
    'although', 'since', 'until', 'unless', 'perhaps', 'maybe', 'about', 'above', 'below', 'behind', 'beyond',
    'despite', 'during', 'except', 'inside', 'outside', 'through', 'throughout', 'around', 'against', 'along',
    'seem', 'seems', 'seemed', 'become', 'becomes', 'became', 'rather', 'quite', 'really', 'still', 'even',
    'company', 'companies', 'data', 'information', 'version', 'feature', 'features', 'tool', 'tools',
  };

  static Future<void> _load(Session session) async {
    await _loadNames(session);
    if (_nouns != null && _loadedAt != null && DateTime.now().difference(_loadedAt!) < const Duration(hours: 12)) return;
    // how much each part of speech is actually used (WordNet's corpus tag counts) and how many
    // senses it has: a word is a noun here only when "noun" is its main use -- "language" is,
    // "funny" (rarely "a joke") and "found" (rarely "board and lodging") are not
    final rows = await session.db.unsafeQuery(
      'SELECT "lemma", "pos", sum("tagCount")::int, count(*)::int FROM "word_sense" '
      'WHERE "lemma" NOT LIKE \'%\\_%\' GROUP BY "lemma", "pos"',
    );
    final use = <String, Map<String, (num, int)>>{};
    for (final r in rows) {
      (use[r[0] as String] ??= {})[r[1] as String] = ((r[2] as num?) ?? 0, r[3] as int);
    }
    final nouns = <String>{};
    for (final MapEntry(key: lemma, value: byPos) in use.entries) {
      final noun = byPos['noun'];
      if (noun == null) continue;
      final others = byPos.entries.where((e) => e.key != 'noun').map((e) => e.value);
      // usage counts are small and sparse, so senses count too: noun must be its main use by both
      double weight((num, int) u) => u.$1 * 2.0 + u.$2;
      final mainUse = others.every((o) => weight(noun) >= weight(o));
      if (mainUse) nouns.add(lemma);
    }
    final known = use.keys.toSet();
    _nouns = nouns;
    _known = known;
    _loadedAt = DateTime.now();
  }

  /// Words written the way names are, in running text: capitalised in mid-sentence ("shares of
  /// Nvidia rose", "talks in Rafah") far more often than not. Sentence starts prove nothing, and
  /// neither do title-case headlines, where every word is capitalised. Returns lowercase names.
  static Set<String> learnNames(Iterable<String> texts) {
    final upper = RegExp(r'^\p{Lu}', unicode: true);
    final cap = <String, int>{};
    final low = <String, int>{};
    for (final text in texts) {
      final words = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
      if (words.length < 3) continue;
      if (words.where(upper.hasMatch).length / words.length > 0.5) continue; // a title-case headline
      for (var i = 1; i < words.length; i++) {
        if (RegExp(r'[.!?:;"“”]$').hasMatch(words[i - 1])) continue; // starts a sentence or a quote
        final w = words[i].replaceAll(RegExp(r'^[^\p{L}]+|[^\p{L}]+$', unicode: true), '').replaceAll(RegExp(r"['’]s$"), '');
        if (w.length < 3 || !RegExp(r'^\p{L}+$', unicode: true).hasMatch(w)) continue;
        final l = w.toLowerCase();
        if (upper.hasMatch(w)) {
          cap[l] = (cap[l] ?? 0) + 1;
        } else {
          low[l] = (low[l] ?? 0) + 1;
        }
      }
    }
    return {for (final e in cap.entries) if (e.value >= 2 && e.value >= 3 * (low[e.key] ?? 0)) e.key};
  }

  static Future<void> _loadNames(Session session) async {
    if (_names != null && _namesAt != null && DateTime.now().difference(_namesAt!) < const Duration(hours: 1)) return;
    final rows = await session.db.unsafeQuery(
      'SELECT "title", "extract" FROM "memory_block" '
      'WHERE "source" IN (\'net\', \'feed\', \'ingest\', \'curriculum\', \'library\') ORDER BY "id" DESC LIMIT 4000',
    );
    _names = learnNames([
      for (final r in rows) ...[if (r[0] != null) r[0] as String, if (r[1] != null) r[1] as String],
    ]);
    _namesAt = DateTime.now();
  }

  static String _singular(String w) {
    if (w.endsWith('ies') && w.length > 4) return '${w.substring(0, w.length - 3)}y';
    if (w.endsWith('ses') || w.endsWith('xes') || w.endsWith('ches') || w.endsWith('shes')) return w.substring(0, w.length - 2);
    if (w.endsWith('s') && !w.endsWith('ss') && w.length > 3) return w.substring(0, w.length - 1);
    return w;
  }

  static bool inflectedKnown(String w, Set<String> known) {
    for (final suffix in const ['ing', 'ed', 'ly']) {
      if (!w.endsWith(suffix) || w.length < suffix.length + 3) continue;
      final stem = w.substring(0, w.length - suffix.length);
      final candidates = {
        stem, '${stem}e', // feared -> fear, rising -> rise
        if (stem.length > 2 && stem[stem.length - 1] == stem[stem.length - 2]) stem.substring(0, stem.length - 1), // stopped -> stop
        if (stem.endsWith('i')) '${stem.substring(0, stem.length - 1)}y', // carried -> carry, happily -> happy
      };
      if (candidates.any(known.contains)) return true;
    }
    return false;
  }

  /// True when [w] can be the subject of a thought. Needs [load] first (see [concepts]).
  static bool isConcept(String w) {
    if (!TopicService.isIdea(w) || w.length < 4 || _filler.contains(w) || RegExp(r'\d').hasMatch(w)) return false;
    final nouns = _nouns, known = _known;
    if (nouns == null || known == null || known.isEmpty) return true; // no dictionary (yet): don't block thinking
    final s = _singular(w);
    if (nouns.contains(w) || nouns.contains(s)) return true;
    // an inflected verb or adverb whose base word the dictionary knows ("feared", "rising",
    // "quickly") is not a name, even though the dictionary doesn't list that form
    if (inflectedKnown(w, known)) return false;
    // not in the dictionary at all: a name (company, place, technology) -- but only if it is
    // written like one where WYRD read it. Typos ("comming"), irregular verbs ("wrote") and
    // comparatives ("longer") are never capitalised in mid-sentence, so they don't pass.
    return !known.contains(w) && !known.contains(s) && (_names?.contains(w) ?? false);
  }

  /// The concepts among [words], in order.
  static Future<List<String>> concepts(Session session, Iterable<String> words) async {
    await _load(session);
    return words.where(isConcept).toList();
  }

  static Future<void> load(Session session) => _load(session);
}
