import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import '../generated/protocol.dart';
import 'curriculum_data.dart';
import 'curriculum_service.dart';
import 'ingest_filter.dart';
import 'mind_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

class _FetchedItem {
  final String source;
  final String title;
  final String extract;
  final String? url;
  final CurriculumEntry? curriculum;

  _FetchedItem({
    required this.source,
    required this.title,
    required this.extract,
    this.url,
    this.curriculum,
  });
}

/// Ports server.js's fetchWikipedia/fetchHackerNews/netFeedTick -- WYRD's continuous net feed.
/// Wikipedia ingestion is curriculum-driven (see curriculum_service.dart), not random, so what
/// it reads builds on a real basic-to-advanced syllabus. Alternates with Hacker News every
/// other tick. [recentIngests] is deliberately in-memory/transient (matches Node's
/// recentIngests array) -- it's a short "what just happened" feed for the UI, not history.
class FeedService {
  /// Wikipedia/curriculum learning is paused for now: every tick reads Hacker News instead, and
  /// the curriculum keeps its place so flipping this back resumes where it left off.
  static const wikipediaEnabled = false;

  static int _netIndex = 0;
  static const _maxAttempts = 5;
  static final List<FeedIngest> _recentIngests = [];
  static const _maxRecentIngests = 20;

  static List<FeedIngest> get recentIngests => List.unmodifiable(_recentIngests);

  static Future<_FetchedItem> _fetchWikipediaSummary(String title) async {
    final res = await http.get(
      Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(title)}'),
      headers: {'User-Agent': 'wyrd-bot/1.0'},
    );
    if (res.statusCode != 200) throw Exception('wikipedia ${res.statusCode}');
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return _FetchedItem(
      source: 'wikipedia',
      title: data['title'] as String? ?? title,
      extract: data['extract'] as String? ?? '',
      url: (data['content_urls'] as Map<String, dynamic>?)?['desktop']?['page'] as String?,
    );
  }

  static Future<_FetchedItem> _fetchWikipedia(Session session) async {
    final (entry, _) = await CurriculumService.nextEntry(session);
    try {
      final item = await _fetchWikipediaSummary(entry.title);
      await CurriculumService.advance(session, entry.title);
      return _FetchedItem(
        source: item.source,
        title: item.title,
        extract: item.extract,
        url: item.url,
        curriculum: entry,
      );
    } catch (_) {
      // a renamed/missing article shouldn't stall the whole curriculum -- skip it and move on
      await CurriculumService.advance(session, entry.title);
      rethrow;
    }
  }

  static Future<_FetchedItem> _fetchHackerNews() async {
    final topRes = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json'));
    if (topRes.statusCode != 200) throw Exception('hn top ${topRes.statusCode}');
    final ids = (jsonDecode(topRes.body) as List).cast<int>();
    final id = ids[Random().nextInt(min(30, ids.length))];

    final itemRes = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json'));
    if (itemRes.statusCode != 200) throw Exception('hn item ${itemRes.statusCode}');
    final item = jsonDecode(itemRes.body) as Map<String, dynamic>;

    final text = item['text'] as String?;
    return _FetchedItem(
      source: 'hackernews',
      title: item['title'] as String? ?? 'untitled',
      extract: text != null ? text.replaceAll(RegExp(r'<[^>]+>'), '') : '',
      url: item['url'] as String? ?? 'https://news.ycombinator.com/item?id=$id',
    );
  }

  /// Returns true if an item was successfully ingested (false on a fetch failure -- matches
  /// Node treating a failed tick as a no-op that still records an 'error' Mind event).
  static Future<bool> tick(Session session) async {
    _netIndex = (_netIndex + 1) % 2;

    try {
      // Filter + sort (IngestFilter): a story already in memory is skipped and another tried --
      // the feed re-offers the same top stories every minute -- and anything low-quality is
      // quarantined instead of becoming knowledge.
      _FetchedItem? item;
      late List<String> topics;
      late IngestVerdict verdict;
      for (var attempt = 0; attempt < _maxAttempts; attempt++) {
        final candidate = wikipediaEnabled && _netIndex == 0 ? await _fetchWikipedia(session) : await _fetchHackerNews();
        final text = '${candidate.title}. ${candidate.extract}';
        topics = TopicService.extractTopics(text.substring(0, min(2000, text.length)));
        verdict = await IngestFilter.judge(
          session,
          source: candidate.source,
          title: candidate.title,
          extract: candidate.extract,
          url: candidate.url,
          topics: topics,
        );
        if (verdict.duplicate) continue;
        if (verdict.keep) item = candidate;
        break;
      }
      if (item == null) return false; // only duplicates on offer, or it was quarantined
      final now = DateTime.now().toUtc();

      await MemoryBlock.db.insertRow(
        session,
        MemoryBlock(
          timestamp: now,
          source: 'net',
          feedSource: item.source,
          title: item.title,
          extract: item.extract,
          url: item.url,
          topics: topics,
          curriculumSubject: item.curriculum?.subject,
          curriculumLevel: item.curriculum?.level,
          quality: verdict.score,
          category: verdict.category,
        ),
      );

      _recentIngests.insert(
        0,
        FeedIngest(
          title: item.title,
          feedSource: item.source,
          url: item.url,
          timestamp: now,
          curriculumSubject: item.curriculum?.subject,
          curriculumLevel: item.curriculum?.level,
        ),
      );
      if (_recentIngests.length > _maxRecentIngests) {
        _recentIngests.removeLast();
      }

      await MindService.recordEvent(session, eventType: 'ingest', recentTopics: topics, newSeenTopics: topics);
      return true;
    } catch (_) {
      await MindService.recordEvent(session, eventType: 'error', recentTopics: []);
      return false;
    }
  }
}
