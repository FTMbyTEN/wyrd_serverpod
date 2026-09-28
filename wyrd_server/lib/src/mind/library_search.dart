import '../generated/protocol.dart';
import 'page_reader_service.dart';
import 'works_service.dart';

/// One search across all of the Academy's libraries, for chat: OpenStax's open textbooks,
/// Wikisource (in the reader's language) and Project Gutenberg. Used by WYRD's own brain and by
/// the AI's find_book tool, so both find the same things.
class LibrarySearch {
  /// Language names people type ("in French", "en español") → Wikisource codes.
  static const _languages = <String, String>{
    'english': 'en', 'french': 'fr', 'français': 'fr', 'francais': 'fr', 'spanish': 'es', 'español': 'es', 'espanol': 'es',
    'portuguese': 'pt', 'português': 'pt', 'portugues': 'pt', 'german': 'de', 'deutsch': 'de', 'italian': 'it', 'italiano': 'it',
    'russian': 'ru', 'arabic': 'ar', 'chinese': 'zh', 'mandarin': 'zh', 'hindi': 'hi', 'bengali': 'bn', 'bangla': 'bn',
    'persian': 'fa', 'farsi': 'fa', 'polish': 'pl', 'polski': 'pl', 'ukrainian': 'uk', 'latin': 'la',
  };

  static final _scripts = <(RegExp, String)>[
    (RegExp(r'[؀-ۿ]'), 'ar'), (RegExp(r'[ऀ-ॿ]'), 'hi'), (RegExp(r'[ঀ-৿]'), 'bn'),
    (RegExp(r'[一-鿿]'), 'zh'), (RegExp(r'[Ѐ-ӿ]'), 'ru'),
  ];

  static final _inLanguage = RegExp(r'\s+(?:in|en|auf|em)\s+([A-Za-zÀ-ÿ]+)\s*$', caseSensitive: false);

  /// Splits "Les Misérables in French" into ("Les Misérables", "fr").
  static (String, String?) splitLanguage(String query) {
    final m = _inLanguage.firstMatch(query.trim());
    final code = m == null ? null : _languages[m.group(1)!.toLowerCase()];
    if (code == null) return (query.trim(), null);
    return (query.trim().substring(0, m!.start).trim(), code);
  }

  /// The Wikisource language [query] is written in, judging by its script (null for Latin script).
  static String? scriptLanguage(String query) => _scripts.where((x) => x.$1.hasMatch(query)).map((x) => x.$2).firstOrNull;

  static Set<String> words(String s) => RegExp(r'[a-z0-9]{3,}').allMatches(s.toLowerCase()).map((m) => m.group(0)!)
      .where((w) => !const {'the', 'and', 'book', 'books', 'textbook', 'textbooks', 'free', 'good', 'about', 'for', 'some'}.contains(w))
      .toSet();

  /// Topics a student might ask about, and the word in the title of the textbook that covers
  /// them ("genetics" is taught in Biology).
  static const _topicTextbook = <String, String>{
    'genetics': 'biology', 'evolution': 'biology', 'cell': 'biology', 'cells': 'biology', 'ecology': 'biology',
    'photosynthesis': 'biology', 'dna': 'biology', 'heredity': 'biology', 'botany': 'biology', 'zoology': 'biology',
    'anatomy': 'anatomy', 'physiology': 'anatomy', 'microbes': 'microbiology', 'bacteria': 'microbiology',
    'mechanics': 'physics', 'motion': 'physics', 'electricity': 'physics', 'magnetism': 'physics', 'optics': 'physics',
    'thermodynamics': 'physics', 'quantum': 'physics', 'forces': 'physics', 'energy': 'physics',
    'atoms': 'chemistry', 'molecules': 'chemistry', 'reactions': 'chemistry', 'organic': 'chemistry',
    'planets': 'astronomy', 'stars': 'astronomy', 'galaxies': 'astronomy', 'universe': 'astronomy', 'space': 'astronomy',
    'derivatives': 'calculus', 'integrals': 'calculus', 'integration': 'calculus', 'limits': 'calculus',
    'equations': 'algebra', 'functions': 'algebra', 'trigonometry': 'trigonometry', 'probability': 'statistics',
    'maths': 'algebra', 'math': 'algebra', 'mathematics': 'algebra', 'arithmetic': 'arithmetic',
    'supply': 'economics', 'demand': 'economics', 'markets': 'economics', 'inflation': 'macroeconomics',
    'money': 'economics', 'finance': 'finance', 'accounting': 'accounting', 'marketing': 'marketing',
    'business': 'business', 'management': 'management', 'entrepreneurship': 'entrepreneurship',
    'mind': 'psychology', 'behaviour': 'psychology', 'behavior': 'psychology', 'brain': 'psychology',
    'society': 'sociology', 'culture': 'anthropology', 'government': 'government', 'politics': 'political',
    'law': 'law', 'ethics': 'philosophy', 'logic': 'philosophy', 'programming': 'programming', 'coding': 'programming',
    'python': 'python', 'computers': 'computer', 'data': 'data', 'nursing': 'nursing', 'health': 'health',
    'nutrition': 'nutrition', 'writing': 'writing', 'grammar': 'writing', 'history': 'history', 'art': 'art',
  };

  /// Textbooks whose title contains every word of [query] (or of the subject that teaches it),
  /// or failing that, whose subject does.
  static Future<List<WorkHit>> textbooks(String query, {String lang = 'en'}) async {
    final w = words(query);
    if (w.isEmpty) return [];
    final all = (await WorksService.textbooks()).where((b) => (b.language ?? 'en') == lang).toList();
    List<WorkHit> titled(Set<String> ws) =>
        all.where((b) => ws.every((x) => words(b.title).any((t) => t == x || (x.length >= 5 && t.startsWith(x.substring(0, x.length - 1)))))).toList()
          ..sort((a, b) => a.title.length.compareTo(b.title.length));
    final byTitle = titled(w);
    if (byTitle.isNotEmpty) return byTitle;
    final mapped = {for (final x in w) _topicTextbook[x] ?? x};
    if (!mapped.every(w.contains)) {
      final byTopic = titled(mapped);
      if (byTopic.isNotEmpty) return byTopic;
    }
    return all.where((b) => w.every((x) => b.subjects.any((s) => s.toLowerCase().contains(x)))).toList();
  }

  /// Everything matching [query], best first: textbooks (when the query is in English), then
  /// Wikisource in [lang] (or the query's script), then Gutenberg, then English Wikisource.
  /// [topic] means a subject ("physics") rather than a title.
  static Future<List<WorkHit>> all(String query, {String? lang, String? author, bool topic = false, int limit = 8}) async {
    final (q, named) = splitLanguage(query);
    final language = lang ?? named ?? scriptLanguage(q);
    final out = <WorkHit>[];
    Future<void> add(Future<List<WorkHit>> Function() find) async {
      if (out.length >= limit) return;
      try {
        out.addAll(await find());
      } catch (_) {
        // one library being down shouldn't stop the others
      }
    }

    if (author == null && (language == null || language == 'en')) await add(() => textbooks(q));
    if (language != null && language != 'en') await add(() => WorksService.searchWikisource(language, q));
    if (language == null || language == 'en') {
      final qw = words(q);
      await add(() async => [
            for (final h in (await PageReaderService.findBooks([q, ?author].join(' '))).where((h) => h.textUrl != null))
              // for a subject, only books that say so in their title ("genetics" shouldn't find a memoir)
              if (!topic || words(h.title).any((t) => qw.any((x) => t.startsWith(x.length > 5 ? x.substring(0, 5) : x))))
                WorkHit(source: 'gutenberg', id: h.textUrl!, title: h.title, author: h.authors.isEmpty ? null : h.authors.join(', '), subjects: const []),
          ]);
    }
    if (!topic) await add(() => WorksService.searchWikisource(language ?? 'en', q));
    final seen = <String>{};
    return out.where((h) => seen.add('${h.source}:${h.id}')).take(limit).toList();
  }

  /// A work's id as the AI sees it: `openstax:ID`, `wikisource:LANG:TITLE` or `gutenberg:URL`.
  static String key(WorkHit h) => '${h.source}:${h.id}';

  static (String, String)? parseKey(String key) {
    final i = key.indexOf(':');
    if (i < 0) return null;
    final source = key.substring(0, i);
    if (!const {'openstax', 'wikisource', 'gutenberg'}.contains(source)) return null;
    return (source, key.substring(i + 1));
  }

  static String describe(WorkHit h) {
    final where = switch (h.source) { 'openstax' => 'OpenStax textbook', 'wikisource' => 'Wikisource (${h.language ?? 'en'})', _ => 'Project Gutenberg' };
    return '${key(h)} — "${h.title}"${h.author != null && h.source != 'openstax' ? ' by ${h.author}' : ''} [$where]'
        '${h.subjects.isNotEmpty ? ' (${h.subjects.take(3).join(', ')})' : ''}';
  }
}
