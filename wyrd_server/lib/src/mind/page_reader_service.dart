import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'browser_safety.dart';

/// One slice of a page or text, read without a browser.
class PageSlice {
  PageSlice({required this.url, required this.title, required this.text, required this.offset, required this.total});
  final String url;
  final String title;
  final String text;
  final int offset;
  final int total;
  int? get nextOffset => offset + text.length < total ? offset + text.length : null;
}

/// A book in Project Gutenberg's free public-domain catalogue.
class BookHit {
  BookHit({required this.id, required this.title, required this.authors, required this.textUrl});
  final int id;
  final String title;
  final List<String> authors;
  final String? textUrl;
}

/// Reading without a browser: fetches a page or plain-text file directly and turns it into
/// readable text. The server has no Chrome (its container can't run one), so this is how WYRD
/// reads articles and whole public-domain books -- one slice at a time, since a book is far
/// longer than one reply can hold.
///
/// Every address, including each redirect, goes through BrowserSafety, so nothing can bounce
/// the server onto a private or internal network.
class PageReaderService {
  static const sliceChars = 6000; // ~1,700 tokens: a passage, not a chapter, per step
  static const _maxBytes = 6 * 1024 * 1024;
  static const _maxRedirects = 5;
  static const _timeout = Duration(seconds: 45); // a whole book is ~400 KB
  static const _userAgent = 'wyrd-bot/1.0 (+https://wryd00.serverpod.space; reading public pages)';

  static Future<PageSlice> read(String rawUrl, {int offset = 0}) async {
    var uri = await BrowserSafety.assertSafePublicUrl(rawUrl);
    final client = IOClient(BrowserSafety.pinnedClient()); // connects only to checked addresses
    try {
      http.StreamedResponse res;
      for (var hop = 0;; hop++) {
        final req = http.Request('GET', uri)
          ..followRedirects = false
          ..headers['User-Agent'] = _userAgent
          ..headers['Accept'] = 'text/html,text/plain;q=0.9,*/*;q=0.5';
        res = await client.send(req).timeout(_timeout);
        final location = res.headers['location'];
        if (res.isRedirect && location != null) {
          if (hop >= _maxRedirects) throw Exception('too many redirects');
          uri = await BrowserSafety.assertSafePublicUrl(uri.resolve(location).toString());
          await res.stream.drain<void>();
          continue;
        }
        break;
      }
      if (res.statusCode >= 400) throw Exception('the site answered HTTP ${res.statusCode}');

      final bytes = <int>[];
      await for (final chunk in res.stream.timeout(_timeout)) {
        bytes.addAll(chunk);
        if (bytes.length > _maxBytes) break; // enough of anything
      }
      final type = (res.headers['content-type'] ?? '').toLowerCase();
      if (!type.contains('text') && !type.contains('html') && !type.contains('xml') && type.isNotEmpty) {
        throw Exception('that address is not text or a web page ($type)');
      }
      final raw = utf8.decode(bytes, allowMalformed: true);
      final isHtml = type.contains('html') || RegExp(r'<html|<body|<p[\s>]', caseSensitive: false).hasMatch(raw.substring(0, raw.length.clamp(0, 2000)));
      final title = isHtml ? _title(raw) : _gutenbergTitle(raw) ?? uri.pathSegments.lastOrNull ?? uri.host;
      final text = _gutenbergBody(isHtml ? htmlToText(raw) : reflow(raw.replaceAll('\r\n', '\n')));

      return sliceText(url: uri.toString(), title: title, text: text, offset: offset);
    } finally {
      client.close();
    }
  }

  /// One reading-sized slice of [text] from [offset], ending at a paragraph, line or sentence
  /// break when there's one nearby.
  static PageSlice sliceText({required String url, required String title, required String text, required int offset}) {
    final start = offset.clamp(0, text.length);
    final end = (start + sliceChars).clamp(0, text.length);
    var cut = end;
    if (end < text.length) {
      final floor = start + sliceChars * 0.6;
      final para = text.lastIndexOf('\n\n', end);
      final line = text.lastIndexOf('\n', end);
      final sentence = text.lastIndexOf('. ', end);
      cut = para > floor ? para : line > floor ? line : (sentence > floor ? sentence + 1 : end);
    }
    return PageSlice(url: url, title: title, text: text.substring(start, cut).trim(), offset: start, total: text.length);
  }

  /// Searches Project Gutenberg's own catalogue feed (OPDS) for public-domain books. (The
  /// third-party Gutendex API was tried first; it took ~25 s to answer, too slow for a chat.)
  static Future<List<BookHit>> findBooks(String query) async {
    final uri = Uri.https('www.gutenberg.org', '/ebooks/search.opds/', {'query': query});
    final res = await http.get(uri, headers: {'User-Agent': _userAgent}).timeout(_timeout);
    if (res.statusCode != 200) throw Exception('the book catalogue answered HTTP ${res.statusCode}');
    return parseOpds(utf8.decode(res.bodyBytes, allowMalformed: true));
  }

  /// Books in a Gutenberg OPDS feed: entries whose id is `/ebooks/<number>.opds` (the other
  /// entries are "Authors"/"Subjects" group links). The plain text lives at a stable address.
  static List<BookHit> parseOpds(String xml) {
    final out = <BookHit>[];
    for (final m in RegExp(r'<entry>([\s\S]*?)</entry>').allMatches(xml)) {
      final e = m.group(1)!;
      final id = RegExp(r'<id>[^<]*/ebooks/(\d+)\.opds</id>').firstMatch(e)?.group(1);
      if (id == null) continue;
      final title = RegExp(r'<title>([\s\S]*?)</title>').firstMatch(e)?.group(1);
      final author = RegExp(r'<content type="text">([\s\S]*?)</content>').firstMatch(e)?.group(1);
      out.add(BookHit(
        id: int.parse(id),
        title: _entities(title ?? 'untitled').trim(),
        authors: author == null || author.trim().isEmpty ? [] : [_entities(author).trim()],
        // the file itself, skipping the redirect (and slower mirror) behind /ebooks/<id>.txt.utf-8
        textUrl: 'https://www.gutenberg.org/cache/epub/$id/pg$id.txt',
      ));
      if (out.length == 6) break;
    }
    return out;
  }

  static String _title(String html) {
    final m = RegExp(r'<title[^>]*>([\s\S]*?)</title>', caseSensitive: false).firstMatch(html);
    return m == null ? '' : _entities(m.group(1)!).replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String? _gutenbergTitle(String text) =>
      RegExp(r'^Title:\s*(.+)$', multiLine: true).firstMatch(text)?.group(1)?.trim();

  /// Drops Project Gutenberg's licence header and footer, keeping the book itself.
  static String _gutenbergBody(String text) {
    final start = RegExp(r'\*\*\*\s*START OF (THE|THIS) PROJECT GUTENBERG[^\n]*\n', caseSensitive: false).firstMatch(text);
    final end = RegExp(r'\*\*\*\s*END OF (THE|THIS) PROJECT GUTENBERG', caseSensitive: false).firstMatch(text);
    if (start == null) return text.trim();
    return text.substring(start.end, end != null && end.start > start.end ? end.start : text.length).trim();
  }

  /// Readable text from HTML: scripts, styles and navigation dropped; blocks become paragraphs
  /// (separated by a blank line), headings become "## " lines, and italics stay as _underscores_.
  static String htmlToText(String html) {
    var s = html
        .replaceAll(RegExp(r'<head[\s>][\s\S]*?</head>', caseSensitive: false), ' ') // title is read separately
        .replaceAll(RegExp(r'<(script|style|noscript|svg|nav|header|footer|form)[\s\S]*?</\1>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<!--[\s\S]*?-->'), ' ')
        .replaceAllMapped(
          RegExp(r'<h[1-6][^>]*>([\s\S]*?)</h[1-6]>', caseSensitive: false),
          (m) => '\n\n## ${m.group(1)!.replaceAll(RegExp(r'<[^>]+>'), ' ').replaceAll('\n', ' ')}\n\n',
        )
        .replaceAll(RegExp(r'<(i|em|cite)(\s[^>]*)?>', caseSensitive: false), '_')
        .replaceAll(RegExp(r'</(i|em|cite)>', caseSensitive: false), '_')
        .replaceAll(RegExp(r'<li(\s[^>]*)?>', caseSensitive: false), '\n\n• ')
        .replaceAll(RegExp(r'<br[^>]*>', caseSensitive: false), '\n')
        .replaceAll(
          RegExp(r'</?(p|div|tr|blockquote|section|article|figure|figcaption|table|ul|ol|dl|dt|dd|caption|pre)(\s[^>]*)?>', caseSensitive: false),
          '\n\n',
        )
        .replaceAll(RegExp(r'<[^>]+>'), ' ');
    s = _entities(s);
    // tidy each paragraph: no stray spaces, no empty lines inside
    s = s
        .split(RegExp(r'\n[ \t ]*\n'))
        .map((p) => p.split('\n').map((l) => l.replaceAll(RegExp(r'[ \t ]+'), ' ').trim()).where((l) => l.isNotEmpty).join('\n'))
        .where((p) => p.isNotEmpty && p != '•' && p != '##')
        .join('\n\n');
    return s
        // "word ," left where inline tags were
        .replaceAllMapped(RegExp(r' +([,.;:!?)\]])'), (m) => m.group(1)!)
        .replaceAllMapped(RegExp(r'([(\[]) +'), (m) => m.group(1)!)
        .replaceAllMapped(RegExp(r'_ +([^_\n]+?) +_'), (m) => '_${m.group(1)}_')
        // "Figure" / "1.21" / caption, split across blocks: one line
        .replaceAllMapped(
          RegExp(r'\b(Figure|Table|Example|Equation|Checkpoint)\s*\n+\s*(\d+(?:\.\d+)*)\s*\n+'),
          (m) => '${m.group(1)} ${m.group(2)} — ',
        )
        // "## 1.3" then "Accuracy…": one heading
        .replaceAllMapped(RegExp(r'^## (\d+(?:\.\d+)*)\s*\n+(?:## )?(.+)$', multiLine: true), (m) => '## ${m.group(1)} ${m.group(2)}')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  /// Plain text re-flowed for reading: paragraphs hard-wrapped at ~70 characters (as Project
  /// Gutenberg files are) are joined into single lines; short-line text (poetry, verse, lists)
  /// keeps its line breaks. Each break becomes one space, so offsets stay put.
  static String reflow(String text) => text.splitMapJoin(
        RegExp(r'\n[ \t]*\n+'),
        onNonMatch: (para) {
          final lines = para.split('\n');
          if (lines.length < 2) return para;
          // hard-wrapped prose: every line but the last runs close to the wrap width
          final wrapped = lines.sublist(0, lines.length - 1).every((l) => l.trim().length >= 45);
          return wrapped ? lines.join(' ') : para;
        },
      );

  static String entities(String s) => _entities(s);

  static String _entities(String s) => s
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&rsquo;', '’')
      .replaceAll('&lsquo;', '‘')
      .replaceAll('&ldquo;', '“')
      .replaceAll('&rdquo;', '”')
      .replaceAll('&mdash;', '—')
      .replaceAll('&ndash;', '–')
      .replaceAllMapped(RegExp(r'&#(\d+);'), (m) => String.fromCharCode(int.parse(m.group(1)!)));
}
