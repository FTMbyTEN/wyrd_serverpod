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
    'company', 'companies', 'data', 'information', 'version', 'feature', 'features', 'tool', 'tools',
  };

  static Future<void> _load(Session session) async {
    if (_nouns != null && _loadedAt != null && DateTime.now().difference(_loadedAt!) < const Duration(hours: 12)) return;
    final rows = await session.db.unsafeQuery(
      'SELECT "lemma", bool_or("pos" = \'n\') FROM "word_sense" WHERE "lemma" NOT LIKE \'%\\_%\' GROUP BY "lemma"',
    );
    final nouns = <String>{};
    final known = <String>{};
    for (final r in rows) {
      final lemma = r[0] as String;
      known.add(lemma);
      if (r[1] == true) nouns.add(lemma);
    }
    _nouns = nouns;
    _known = known;
    _loadedAt = DateTime.now();
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
    // not in the dictionary at all: a name (company, place, technology), if it looks like a word
    return !known.contains(w) && !known.contains(s) && w.length >= 5 && RegExp(r'^[a-z][a-z-]*$').hasMatch(w);
  }

  /// The concepts among [words], in order.
  static Future<List<String>> concepts(Session session, Iterable<String> words) async {
    await _load(session);
    return words.where(isConcept).toList();
  }

  static Future<void> load(Session session) => _load(session);
}
