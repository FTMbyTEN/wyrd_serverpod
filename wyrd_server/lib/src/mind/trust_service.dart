import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Bias 2: what WYRD has learned to trust, from experience.
///
/// Every source (a website, or a feed like Hacker News) and every topic keeps a tally of good
/// and bad evidence, and its trust is (good + 1) / (good + bad + 2): it starts neutral at 0.5 and
/// only moves as evidence piles up, so one rating can't swing it far. Evidence comes from:
///  - people's thumbs on replies, reaching the sources of the memories that grounded the reply
///    and the topics asked about (ChatEndpoint.rate);
///  - the ingest filter: a site whose items keep getting quarantined loses trust, one that keeps
///    delivering clean articles gains it (IngestFilter.judge);
///  - corrections of learned answers (LearnedAnswerService.feedback).
/// Trust then biases WYRD: memories from trusted sources rank higher in recall, and a trusted
/// site's borderline article gets through the filter where an untrusted one's wouldn't.
class TrustService {
  static const source = 'source';
  static const topic = 'topic';

  static double scoreOf(double good, double bad) => (good + 1) / (good + bad + 2);

  /// The source key for a memory or item: its website (without "www."), or its feed.
  static String? sourceKey({String? url, String? feedSource}) {
    final host = url == null ? null : Uri.tryParse(url)?.host.toLowerCase();
    if (host != null && host.isNotEmpty) {
      if (host == 'news.ycombinator.com') return 'hackernews';
      return host.startsWith('www.') ? host.substring(4) : host;
    }
    return feedSource;
  }

  /// Adds evidence: [weight] > 0 is good, < 0 is bad.
  static Future<void> record(Session session, String kind, String key, double weight) async {
    if (key.isEmpty || weight == 0) return;
    final good = weight > 0 ? weight : 0.0, bad = weight < 0 ? -weight : 0.0;
    await session.db.unsafeExecute(
      'INSERT INTO "trust_score" ("kind", "key", "good", "bad", "score", "updatedAt") '
      'VALUES (@kind, @key, @g::float8, @b::float8, (@g::float8 + 1) / (@g::float8 + @b::float8 + 2), @t) '
      'ON CONFLICT ("kind", "key") DO UPDATE SET "good" = "trust_score"."good" + @g::float8, "bad" = "trust_score"."bad" + @b::float8, '
      '"score" = ("trust_score"."good" + @g::float8 + 1) / ("trust_score"."good" + @g::float8 + "trust_score"."bad" + @b::float8 + 2), "updatedAt" = @t',
      parameters: QueryParameters.named({'kind': kind, 'key': key, 'g': good, 'b': bad, 't': DateTime.now().toUtc()}),
    );
  }

  /// Trust for each of [keys] (0.5, neutral, for any without evidence yet).
  static Future<Map<String, double>> scores(Session session, String kind, Iterable<String> keys) async {
    final set = keys.where((k) => k.isNotEmpty).toSet();
    if (set.isEmpty) return {};
    final rows = await TrustScore.db.find(session, where: (t) => t.kind.equals(kind) & t.key.inSet(set));
    final known = {for (final r in rows) r.key: r.score};
    return {for (final k in set) k: known[k] ?? 0.5};
  }

  static Future<double> scoreFor(Session session, String kind, String? key) async =>
      key == null ? 0.5 : (await scores(session, kind, [key]))[key] ?? 0.5;

  /// The most and least trusted sources and topics that have real evidence behind them.
  static Future<TrustReport> report(Session session) async {
    Future<List<TrustScore>> pick(String kind, {required bool top}) async {
      // only scores with at least two units of evidence mean anything yet
      final rows = await session.db.unsafeQuery(
        'SELECT "id" FROM "trust_score" WHERE "kind" = @kind AND "good" + "bad" >= 2 '
        'ORDER BY "score" ${top ? 'DESC' : 'ASC'} LIMIT 6',
        parameters: QueryParameters.named({'kind': kind}),
      );
      final order = [for (final r in rows) r[0] as int];
      final found = await TrustScore.db.find(session, where: (t) => t.id.inSet(order.toSet()));
      return found..sort((a, b) => order.indexOf(a.id!).compareTo(order.indexOf(b.id!)));
    }
    final evidence = await session.db.unsafeQuery('SELECT count(*), coalesce(sum("good" + "bad"), 0)::float8 FROM "trust_score"');
    return TrustReport(
      trustedSources: (await pick(source, top: true)).where((s) => s.score >= 0.5).toList(),
      doubtedSources: (await pick(source, top: false)).where((s) => s.score < 0.5).toList(),
      trustedTopics: (await pick(topic, top: true)).where((s) => s.score >= 0.5).toList(),
      doubtedTopics: (await pick(topic, top: false)).where((s) => s.score < 0.5).toList(),
      tracked: evidence.first[0] as int,
      evidence: (evidence.first[1] as num).toDouble(),
    );
  }
}
