import 'dart:convert';

import 'package:http/http.dart' as http;

import 'page_reader_service.dart';

/// One search or news result.
class SearchHit {
  SearchHit(this.title, this.url, this.snippet, {this.source, this.date});

  final String title, url, snippet;
  final String? source, date;

  String describe() => [
        '- $title${source == null ? '' : ' ($source)'}${date == null ? '' : ', $date'}',
        if (snippet.isNotEmpty) '  $snippet',
        '  $url',
      ].join('\n');
}

/// What WYRD's agent searches with. DuckDuckGo's HTML page, which it used to read, now answers a
/// server with a bot wall (HTTP 202, no results), so every search came back empty. These are feeds
/// published for programs to read, with no key needed:
///  - [search]: Bing's RSS results (titles, snippets, links);
///  - [news]: Google News RSS (headline, outlet, time) -- its links go through Google and often
///    can't be read directly, so the headlines and times are the news;
///  - [prices]: CoinGecko's live prices, in dollars and naira, with the day's change.
class WebSearchService {
  static const _userAgent = 'wyrd-bot/1.0 (+https://wryd00.serverpod.space; reading public pages)';
  static const _timeout = Duration(seconds: 20);

  static Future<String> _get(Uri uri) async {
    final res = await http.get(uri, headers: {'User-Agent': _userAgent}).timeout(_timeout);
    if (res.statusCode != 200) throw Exception('${uri.host} answered HTTP ${res.statusCode}');
    return utf8.decode(res.bodyBytes, allowMalformed: true);
  }

  static Future<List<SearchHit>> search(String query, {int max = 8}) async =>
      parseRss(await _get(Uri.https('www.bing.com', '/search', {'q': query, 'format': 'rss', 'mkt': 'en-US'})), max: max);

  /// Recent news on [query], newest first.
  static Future<List<SearchHit>> news(String query, {int max = 10}) async {
    final hits = parseRss(await _get(Uri.https('news.google.com', '/rss/search', {'q': query, 'hl': 'en-NG', 'gl': 'NG', 'ceid': 'NG:en'})), max: 40, news: true);
    DateTime? at(SearchHit h) => h.date == null ? null : DateTime.tryParse(h.date!);
    hits.sort((a, b) => (at(b) ?? DateTime(2000)).compareTo(at(a) ?? DateTime(2000)));
    return hits.take(max).toList();
  }

  /// Items from an RSS feed. For news, the outlet is split off the headline ("Title - Outlet") and
  /// the date given as ISO time.
  static List<SearchHit> parseRss(String xml, {int max = 10, bool news = false}) {
    String? tag(String item, String name) {
      final m = RegExp('<$name(?:\\s[^>]*)?>([\\s\\S]*?)</$name>').firstMatch(item);
      if (m == null) return null;
      var v = m.group(1)!.trim();
      final cdata = RegExp(r'^<!\[CDATA\[([\s\S]*)\]\]>$').firstMatch(v);
      if (cdata != null) v = cdata.group(1)!;
      return _unescape(v);
    }

    final hits = <SearchHit>[];
    for (final m in RegExp(r'<item>([\s\S]*?)</item>').allMatches(xml)) {
      final item = m.group(1)!;
      var title = tag(item, 'title') ?? '';
      final url = tag(item, 'link') ?? '';
      if (title.isEmpty || url.isEmpty) continue;
      String? source = tag(item, 'source');
      if (news && source != null && title.endsWith(' - $source')) title = title.substring(0, title.length - source.length - 3);
      // (Google News' description is only a link back to the headline: no snippet there)
      final snippet = news ? '' : PageReaderService.htmlToText(tag(item, 'description') ?? '').replaceAll(RegExp(r'\s+'), ' ').trim();
      final pub = tag(item, 'pubDate');
      hits.add(SearchHit(title, url, snippet.length > 280 ? '${snippet.substring(0, 277)}...' : snippet, source: source, date: pub == null ? null : _rfc822(pub)?.toUtc().toIso8601String()));
      if (hits.length >= max && !news) break;
    }
    return hits;
  }

  // what people call them -> CoinGecko's ids
  static const _assets = {
    'btc': 'bitcoin', 'bitcoin': 'bitcoin',
    'eth': 'ethereum', 'ethereum': 'ethereum',
    'gold': 'tether-gold', 'xau': 'tether-gold',
    'sol': 'solana', 'solana': 'solana',
    'usdt': 'tether', 'tether': 'tether',
    'bnb': 'binancecoin', 'xrp': 'ripple',
  };

  /// Live prices for [assets] (btc, eth, gold, ...): in US dollars and naira, with the change over
  /// 24 hours. Gold is read from a token backed by one troy ounce of gold, so it's the ounce price.
  static Future<String> prices(List<String> assets) async {
    final ids = {
      for (final a in assets) _assets[a.trim().toLowerCase()] ?? a.trim().toLowerCase().replaceAll(' ', '-'),
    }.where((s) => RegExp(r'^[a-z0-9-]{2,40}$').hasMatch(s)).take(8).toList();
    if (ids.isEmpty) return 'Name the assets, e.g. btc, eth, gold.';
    final body = jsonDecode(await _get(Uri.https('api.coingecko.com', '/api/v3/simple/price', {
      'ids': ids.join(','),
      'vs_currencies': 'usd,ngn',
      'include_24hr_change': 'true',
      'include_last_updated_at': 'true',
    }))) as Map<String, dynamic>;
    return describePrices(body, ids);
  }

  static String describePrices(Map<String, dynamic> body, List<String> ids) {
    String money(num v, String sym) => '$sym${v >= 100 ? v.round().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+$)'), (_) => ',') : v.toStringAsFixed(v >= 1 ? 2 : 4)}';
    return [
      for (final id in ids)
        if (body[id] is Map)
          () {
            final p = (body[id] as Map).cast<String, dynamic>();
            final change = p['usd_24h_change'] as num?;
            final at = p['last_updated_at'] as num?;
            return '- ${id == 'tether-gold' ? 'Gold (per troy ounce, via the XAUt token)' : id}: '
                '${money(p['usd'] as num, r'$')} / ${money(p['ngn'] as num, '₦')}'
                '${change == null ? '' : ', ${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}% in 24h'}'
                '${at == null ? '' : ' (as of ${DateTime.fromMillisecondsSinceEpoch(at.toInt() * 1000, isUtc: true).toIso8601String().substring(0, 16)} UTC)'}';
          }()
        else
          '- $id: no price found (not a known asset)',
      'Source: CoinGecko.',
    ].join('\n');
  }

  static String _unescape(String s) => s
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&apos;', "'")
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&');

  static const _months = {'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12};

  /// "Mon, 12 Oct 2026 08:10:24 GMT" (RSS dates).
  static DateTime? _rfc822(String s) {
    final m = RegExp(r'(\d{1,2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2})').firstMatch(s);
    final month = m == null ? null : _months[m.group(2)];
    if (m == null || month == null) return null;
    return DateTime.utc(int.parse(m.group(3)!), month, int.parse(m.group(1)!), int.parse(m.group(4)!), int.parse(m.group(5)!), int.parse(m.group(6)!));
  }
}
