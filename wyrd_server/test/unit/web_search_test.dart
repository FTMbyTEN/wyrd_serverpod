import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/web_search_service.dart';

void main() {
  test('news: outlet split off the headline, newest first by time, dates as UTC', () {
    const xml = '<rss><channel>'
        '<item><title>Gold slips as dollar firms - Reuters</title><link>https://news.google.com/a</link>'
        '<pubDate>Mon, 12 Oct 2026 08:10:24 GMT</pubDate><source url="https://reuters.com">Reuters</source></item>'
        '<item><title>Bitcoin &amp; ether rise - CoinDesk</title><link>https://news.google.com/b</link>'
        '<pubDate>Sun, 11 Oct 2026 21:00:00 GMT</pubDate><source url="https://coindesk.com">CoinDesk</source></item>'
        '</channel></rss>';
    final hits = WebSearchService.parseRss(xml, news: true);
    expect(hits.first.title, 'Gold slips as dollar firms');
    expect(hits.first.source, 'Reuters');
    expect(hits.first.date, '2026-10-12T08:10:24.000Z');
    expect(hits.last.title, 'Bitcoin & ether rise');
  });

  test('search results keep a short snippet and the link', () {
    const xml = '<rss><channel><item><title>Gold Price Today</title><link>https://example.com/gold</link>'
        '<description>The price of gold &lt;b&gt;today&lt;/b&gt;, per ounce.</description></item></channel></rss>';
    final hit = WebSearchService.parseRss(xml).single;
    expect(hit.url, 'https://example.com/gold');
    expect(hit.snippet, contains('today'));
    expect(hit.snippet, isNot(contains('<b>')));
  });

  test('prices: dollars and naira with the day change; gold is the ounce; unknowns said plainly', () {
    final out = WebSearchService.describePrices({
      'bitcoin': {'usd': 83346, 'ngn': 110938246, 'usd_24h_change': 0.31},
      'tether-gold': {'usd': 4164.2, 'ngn': 5542421, 'usd_24h_change': -0.42},
    }, ['bitcoin', 'tether-gold', 'nonsense']);
    expect(out, contains(r'bitcoin: $83,346 / ₦110,938,246, +0.31% in 24h'));
    expect(out, contains('Gold (per troy ounce'));
    expect(out, contains('-0.42%'));
    expect(out, contains('nonsense: no price found'));
  });
}
