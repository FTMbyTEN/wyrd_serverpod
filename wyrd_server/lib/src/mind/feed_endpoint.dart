import 'owner_guard.dart';
import '../generated/protocol.dart';
import 'feed_service.dart';
import 'ingest_filter.dart';
import 'trust_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/feed/recent and /api/feed/trigger from server.js. Public/unauthenticated,
/// matching Node. /api/feed/next (nextTickAt/cycleMs) is not ported -- it depended on Node's
/// TURBO_FACTOR speed-scaling, which isn't ported either (see feed_future_call.dart).
class FeedEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<FeedIngest>> getRecent(Session session) =>
      PublicCache.get(session, 'feed.getRecent', const Duration(seconds: 15), () => _getRecent(session));

  Future<List<FeedIngest>> _getRecent(Session session) async {
    return FeedService.recentIngests;
  }

  Future<bool> trigger(Session session) async {
    // starting WYRD's work by hand is the owner's: strangers can't spend its budget or block its runs
    await OwnerGuard.check(session, 'that');
    // public: a few per 10 minutes, so nobody can hammer it (the scheduler runs it anyway)
    if (RateLimiter.isLimited('trigger:feed', 3, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    PublicCache.clear(); // only once a run really goes ahead
    return await FeedService.tick(session);
  }

  /// Today's filter decisions (kept, duplicates skipped, quarantined and why, by category) and
  /// the latest items kept out.
  Future<FilterReport> getFilterReport(Session session) =>
      PublicCache.get(session, 'feed.getFilterReport', const Duration(seconds: 60), () => _getFilterReport(session));

  Future<FilterReport> _getFilterReport(Session session) => IngestFilter.report(session);

  /// Bias 2: the sources and topics WYRD has learned to trust, and to doubt.
  Future<TrustReport> getTrust(Session session) =>
      PublicCache.get(session, 'feed.getTrust', const Duration(seconds: 60), () => _getTrust(session));

  Future<TrustReport> _getTrust(Session session) => TrustService.report(session);

  /// Filter + judgement: how many replies the gate checked this week, and what it did (counts
  /// only -- no conversation text leaves).
  Future<JudgementReport> getJudgementReport(Session session) =>
      PublicCache.get(session, 'feed.getJudgementReport', const Duration(seconds: 60), () => _getJudgementReport(session));

  Future<JudgementReport> _getJudgementReport(Session session) async {
    final since = DateTime.now().toUtc().subtract(const Duration(days: 7));
    final totals = await session.db.unsafeQuery(
      'SELECT count(*), count(*) FILTER (WHERE "judgement" = \'pass\'), '
      'count(*) FILTER (WHERE "judgement" LIKE \'softened%\'), count(*) FILTER (WHERE "judgement" LIKE \'corrected%\'), '
      'count(*) FILTER (WHERE "judgement" LIKE \'blocked%\') FROM "conversation_turn" WHERE "judgement" IS NOT NULL AND "timestamp" >= @since',
      parameters: QueryParameters.named({'since': since}),
    );
    final flagged = await session.db.unsafeQuery(
      'SELECT "judgement" FROM "conversation_turn" WHERE "judgement" IS NOT NULL AND "judgement" <> \'pass\' AND "timestamp" >= @since LIMIT 2000',
      parameters: QueryParameters.named({'since': since}),
    );
    final reasons = <String, int>{};
    for (final r in flagged) {
      final s = r[0] as String;
      final i = s.indexOf(': ');
      if (i < 0) continue;
      for (final why in s.substring(i + 2).split('; ')) {
        reasons[why] = (reasons[why] ?? 0) + 1;
      }
    }
    final t = totals.first;
    return JudgementReport(checked: t[0] as int, passed: t[1] as int, softened: t[2] as int, corrected: t[3] as int, blocked: t[4] as int, reasons: reasons);
  }
}
