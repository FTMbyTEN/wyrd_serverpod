import 'dart:convert';

import 'package:http/http.dart' as http;

import '../generated/protocol.dart';
import 'page_reader_service.dart';

/// One readable part of a work: a textbook section, a chapter on Wikisource.
class WorkPart {
  WorkPart({required this.title, required this.ref, required this.url});
  final String title;
  final String ref; // what the source needs to fetch it
  final String url; // where a person can see it (attribution)
}

/// Free works that come in parts, for the Academy: OpenStax's open textbooks (CC BY) and
/// Wikisource's public-domain library in many languages. Everything is fetched directly from
/// their public APIs -- no AI. Catalogues, tables of contents and recently read parts are cached
/// in memory, so reading on is quick and polite to both services.
class WorksService {
  static const _ua = 'wyrd-academy/1.0 (+https://wryd00.serverpod.space; free reading for students)';
  static const _timeout = Duration(seconds: 30);

  /// Wikisource languages the Academy offers, as (code, name in its own script).
  static const wikisourceLanguages = <(String, String)>[
    ('en', 'English'), ('fr', 'Français'), ('es', 'Español'), ('pt', 'Português'), ('de', 'Deutsch'),
    ('it', 'Italiano'), ('ru', 'Русский'), ('ar', 'العربية'), ('zh', '中文'), ('hi', 'हिन्दी'),
    ('bn', 'বাংলা'), ('fa', 'فارسی'), ('pl', 'Polski'), ('uk', 'Українська'), ('la', 'Latina'),
  ];

  static String key(String source, String id) => '$source:$id';

  // ---- plumbing

  static Future<dynamic> _json(Uri uri) async {
    final res = await http.get(uri, headers: {'User-Agent': _ua, 'Accept': 'application/json'}).timeout(_timeout);
    if (res.statusCode != 200) throw Exception('${uri.host} answered HTTP ${res.statusCode}');
    return jsonDecode(utf8.decode(res.bodyBytes, allowMalformed: true));
  }

  static final _parts = <String, (DateTime, List<WorkPart>)>{};
  static final _texts = <String, String>{}; // insertion-ordered: the oldest is dropped first

  static String _strip(String html) =>
      PageReaderService.entities(html.replaceAll(RegExp(r'<[^>]+>'), ' ')).replaceAll(RegExp(r'\s+'), ' ').trim();

  static Future<String> _cachedText(String k, Future<String> Function() load) async {
    final hit = _texts.remove(k);
    if (hit != null) return _texts[k] = hit;
    final text = await load();
    _texts[k] = text;
    while (_texts.length > 24) {
      _texts.remove(_texts.keys.first);
    }
    return text;
  }

  // ---- OpenStax

  static (DateTime, String, Map<String, String>)? _release;
  static (DateTime, List<WorkHit>, Map<String, String>)? _catalog; // hits, bookId -> slug

  static Future<(String, Map<String, String>)> _openstaxRelease() async {
    final r = _release;
    if (r != null && DateTime.now().difference(r.$1) < const Duration(hours: 6)) return (r.$2, r.$3);
    final j = await _json(Uri.parse('https://openstax.org/rex/release.json')) as Map<String, dynamic>;
    final archive = j['archiveUrl'] as String;
    final versions = <String, String>{};
    (j['books'] as Map<String, dynamic>).forEach((id, v) {
      final m = v as Map<String, dynamic>;
      if (m['retired'] != true && m['defaultVersion'] != null) versions[id] = m['defaultVersion'] as String;
    });
    _release = (DateTime.now(), archive, versions);
    return (archive, versions);
  }

  /// Every live OpenStax textbook, with its subjects and cover.
  static Future<List<WorkHit>> textbooks() async {
    final c = _catalog;
    if (c != null && DateTime.now().difference(c.$1) < const Duration(hours: 12)) return c.$2;
    final (_, versions) = await _openstaxRelease();
    final j = await _json(Uri.parse(
      'https://openstax.org/apps/cms/api/v2/pages/?type=books.Book&fields=title,cnx_id,book_state,book_subjects,cover_url&limit=250',
    )) as Map<String, dynamic>;
    final hits = <WorkHit>[];
    final slugs = <String, String>{};
    for (final raw in (j['items'] as List).cast<Map<String, dynamic>>()) {
      final id = raw['cnx_id'] as String?;
      if (id == null || raw['book_state'] != 'live' || !versions.containsKey(id)) continue;
      final meta = raw['meta'] as Map<String, dynamic>;
      slugs[id] = meta['slug'] as String;
      hits.add(WorkHit(
        source: 'openstax',
        id: id,
        title: raw['title'] as String,
        author: 'OpenStax',
        subjects: [for (final s in (raw['book_subjects'] as List? ?? const [])) (s as Map<String, dynamic>)['subject_name'] as String],
        coverUrl: raw['cover_url'] as String?,
        language: meta['locale'] as String?,
      ));
    }
    hits.sort((a, b) => a.title.compareTo(b.title));
    _catalog = (DateTime.now(), hits, slugs);
    return hits;
  }

  static Future<List<WorkPart>> _openstaxParts(String bookId) async {
    final (archive, versions) = await _openstaxRelease();
    await textbooks(); // for the slugs
    final version = versions[bookId];
    if (version == null) throw Exception('that textbook is no longer published');
    final slug = _catalog!.$3[bookId] ?? '';
    final tree = await _json(Uri.parse('https://openstax.org$archive/contents/$bookId@$version.json')) as Map<String, dynamic>;
    final out = <WorkPart>[];
    void walk(Map<String, dynamic> node, String chapter) {
      final kids = node['contents'] as List?;
      final title = _strip(node['title'] as String? ?? '');
      if (kids == null) {
        final pageId = (node['id'] as String).split('@').first;
        final label = chapter.isNotEmpty && !RegExp(r'^\d').hasMatch(title) ? '$chapter · $title' : title;
        out.add(WorkPart(
          title: label,
          ref: '$bookId@$version:$pageId',
          url: 'https://openstax.org/books/$slug/pages/${node['slug'] ?? ''}',
        ));
        return;
      }
      final isChapter = node['toc_type'] == 'chapter';
      for (final k in kids.cast<Map<String, dynamic>>()) {
        walk(k, isChapter ? title : chapter);
      }
    }
    walk(tree['tree'] as Map<String, dynamic>, '');
    return out;
  }

  static Future<String> _openstaxText(String ref) async {
    final (archive, _) = await _openstaxRelease();
    final j = await _json(Uri.parse('https://openstax.org$archive/contents/$ref.json')) as Map<String, dynamic>;
    var html = j['content'] as String? ?? '';
    // maths: keep the readable alt text of formulas, not the MathML markup
    html = html.replaceAllMapped(
      RegExp(r'<math[^>]*?alttext="([^"]*)"[\s\S]*?</math>', caseSensitive: false),
      (m) => ' ${m.group(1)} ',
    );
    html = html.replaceAll(RegExp(r'<annotation[\s\S]*?</annotation>', caseSensitive: false), ' ');
    return PageReaderService.htmlToText(html);
  }

  // ---- Wikisource

  static Uri _wsApi(String lang, Map<String, String> q) =>
      Uri.https('$lang.wikisource.org', '/w/api.php', {...q, 'format': 'json', 'formatversion': '2'});

  static bool _knownLang(String lang) => wikisourceLanguages.any((l) => l.$1 == lang);

  /// Works on Wikisource in [lang] matching [query], one per work (not per chapter).
  static Future<List<WorkHit>> searchWikisource(String lang, String query) async {
    if (!_knownLang(lang)) throw Exception('that language is not offered yet');
    final j = await _json(_wsApi(lang, {
      'action': 'query', 'list': 'search', 'srsearch': query, 'srnamespace': '0', 'srlimit': '30', 'srwhat': 'text',
    })) as Map<String, dynamic>;
    final seen = <String>{};
    final out = <WorkHit>[];
    for (final r in ((j['query'] as Map<String, dynamic>?)?['search'] as List? ?? const []).cast<Map<String, dynamic>>()) {
      final root = (r['title'] as String).split('/').first;
      if (!seen.add(root)) continue;
      out.add(WorkHit(
        source: 'wikisource',
        id: '$lang:$root',
        title: root,
        author: null,
        subjects: const [],
        blurb: _strip(r['snippet'] as String? ?? ''),
        language: lang,
      ));
      if (out.length == 14) break;
    }
    // "Hamlet may refer to…" pages aren't works: drop disambiguation pages
    if (out.isNotEmpty) {
      final p = await _json(_wsApi(lang, {
        'action': 'query', 'prop': 'pageprops', 'ppprop': 'disambiguation', 'titles': out.map((h) => h.title).join('|'),
      })) as Map<String, dynamic>;
      final disambig = {
        for (final pg in ((p['query'] as Map<String, dynamic>?)?['pages'] as List? ?? const []).cast<Map<String, dynamic>>())
          if ((pg['pageprops'] as Map?)?.containsKey('disambiguation') ?? false) pg['title'] as String,
      };
      out.removeWhere((h) => disambig.contains(h.title));
    }
    return out.take(10).toList();
  }

  static Future<String> _wsHtml(String lang, String page) async {
    final j = await _json(_wsApi(lang, {'action': 'parse', 'page': page, 'prop': 'text', 'redirects': '1'})) as Map<String, dynamic>;
    if (j['error'] != null) throw Exception('Wikisource has no page "$page"');
    return (j['parse'] as Map<String, dynamic>)['text'] as String? ?? '';
  }

  static Future<List<WorkPart>> _wikisourceParts(String lang, String title, {bool followVersions = true}) async {
    final html = await _wsHtml(lang, title);
    // a "Versions of…" page lists editions rather than text: open the first edition it lists
    final hasSubpages = html.contains('href="/wiki/${Uri.encodeComponent(title.replaceAll(' ', '_')).replaceAll('%2F', '/')}/');
    if (followVersions && !hasSubpages && html.length < 60000 && RegExp(r'ws-versions|Versions of|Translations of|Éditions de|Versiones de', caseSensitive: false).hasMatch(html)) {
      for (final m in RegExp(r'<li>\s*(?:<(?:i|b|span)[^>]*>\s*)*<a href="/wiki/([^"#?]+)"').allMatches(html)) {
        final t = Uri.decodeComponent(m.group(1)!).replaceAll('_', ' ');
        if (t.contains(':') || t == title) continue;
        return _wikisourceParts(lang, t, followVersions: false);
      }
    }
    String pageUrl(String t) => 'https://$lang.wikisource.org/wiki/${Uri.encodeComponent(t.replaceAll(' ', '_'))}';
    final seen = <String>{};
    final parts = <WorkPart>[];
    for (final m in RegExp(r'href="/wiki/([^"#?]+)"').allMatches(html)) {
      final t = Uri.decodeComponent(m.group(1)!).replaceAll('_', ' ');
      if (!t.startsWith('$title/') || !seen.add(t)) continue;
      parts.add(WorkPart(title: t.substring(title.length + 1).replaceAll('/', ' · '), ref: '$lang|$t', url: pageUrl(t)));
    }
    // a work on one page, or one whose contents aren't subpages
    if (parts.isEmpty) return [WorkPart(title: title, ref: '$lang|$title', url: pageUrl(title))];
    return parts;
  }

  static Future<String> _wikisourceText(String ref) async {
    final i = ref.indexOf('|');
    var html = await _wsHtml(ref.substring(0, i), ref.substring(i + 1));
    // drop Wikisource's own navigation and notes around the text
    html = html
        .replaceAll(RegExp(r'<style[\s\S]*?</style>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<span class="mw-editsection-bracket">[^<]*</span>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<a[^>]*action=edit[^>]*>[\s\S]*?</a>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<(div|table|span|sup)[^>]*class="[^"]*(ws-noexport|wst-header|mw-editsection|reference|ws-summary)[^"]*"[\s\S]*?</\1>', caseSensitive: false), ' ');
    return PageReaderService.htmlToText(html);
  }

  // ---- common

  /// The parts of work [source]/[id], in reading order (cached for an hour).
  static Future<List<WorkPart>> parts(String source, String id) async {
    final k = key(source, id);
    final hit = _parts[k];
    if (hit != null && DateTime.now().difference(hit.$1) < const Duration(hours: 1)) return hit.$2;
    final list = switch (source) {
      'openstax' => await _openstaxParts(id),
      'wikisource' => await _wikisourceParts(id.substring(0, id.indexOf(':')), id.substring(id.indexOf(':') + 1)),
      _ => throw Exception('unknown source $source'),
    };
    if (list.isEmpty) throw Exception('that work has no readable parts');
    _parts[k] = (DateTime.now(), list);
    if (_parts.length > 64) _parts.remove(_parts.keys.first);
    return list;
  }

  /// The text of one part.
  static Future<String> text(String source, WorkPart part) => _cachedText(
        '$source|${part.ref}',
        () => switch (source) {
          'openstax' => _openstaxText(part.ref),
          'wikisource' => _wikisourceText(part.ref),
          _ => throw Exception('unknown source $source'),
        },
      );

  /// A display title and author for a work being opened.
  static Future<(String, String?)> describe(String source, String id) async {
    if (source == 'openstax') {
      final book = (await textbooks()).where((b) => b.id == id).firstOrNull;
      return (book?.title ?? 'OpenStax textbook', 'OpenStax');
    }
    return (id.substring(id.indexOf(':') + 1), null);
  }
}
