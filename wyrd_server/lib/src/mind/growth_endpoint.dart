import '../generated/protocol.dart';
import 'learned_answer_service.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/growth (read) from server.js. Public/unauthenticated, matching Node. There is
/// no manual /trigger for growth in Node -- snapshots are purely wall-clock (see
/// growth_future_call.dart) -- so this endpoint is read-only.
class GrowthEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxSnapshots = 500;

  Future<List<GrowthSnapshot>> getSnapshots(Session session, {int? limit}) =>
      PublicCache.get(session, 'growth.getSnapshots:$limit', const Duration(seconds: 60), () => _getSnapshots(session, limit: limit));

  Future<List<GrowthSnapshot>> _getSnapshots(Session session, {int? limit}) async {
    final take = (limit ?? 120).clamp(1, _maxSnapshots);
    final snapshots = await GrowthSnapshot.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return snapshots.reversed.toList();
  }

  /// Growth over a readable span -- 'day', 'week', 'month' or 'all' -- averaged into at most
  /// ~120 points, so the panel can show days and weeks instead of only the newest few hours.
  Future<List<GrowthSnapshot>> getHistory(Session session, String range) =>
      PublicCache.get(session, 'growth.getHistory:$range', const Duration(seconds: 120), () => _getHistory(session, range));

  Future<List<GrowthSnapshot>> _getHistory(Session session, String range) async {
    final span = switch (range) {
      'day' => const Duration(days: 1),
      'week' => const Duration(days: 7),
      'month' => const Duration(days: 30),
      _ => null,
    };
    final now = DateTime.now().toUtc();
    final from = span == null ? null : now.subtract(span);
    final first = await GrowthSnapshot.db.findFirstRow(
      session,
      where: from == null ? null : (t) => t.timestamp >= from,
      orderBy: (t) => t.timestamp,
    );
    if (first == null) return [];
    final start = from ?? first.timestamp;
    final bucketSec = (now.difference(start).inSeconds / 120).ceil().clamp(60, 1 << 30);

    final rows = await session.db.unsafeQuery(
      'SELECT max("timestamp"), max("vocabCount"), max("blockCount"), avg("digestPercent")::float8, '
      'avg("curiosity")::float8, avg("confidence")::float8 FROM "growth_snapshot" WHERE "timestamp" >= @from '
      'GROUP BY floor(extract(epoch FROM "timestamp") / @bucket) ORDER BY 1',
      parameters: QueryParameters.named({'from': start, 'bucket': bucketSec}),
    );
    return [
      for (final r in rows)
        GrowthSnapshot(
          timestamp: r[0] as DateTime,
          vocabCount: r[1] as int,
          blockCount: r[2] as int,
          digestPercent: (r[3] as num).toDouble(),
          curiosity: (r[4] as num).toDouble(),
          confidence: (r[5] as num).toDouble(),
        ),
    ];
  }

  /// How much WYRD has learned from its own answers: kept, shared, reused (AI calls saved), improved.
  Future<LearningStats> getLearning(Session session) =>
      PublicCache.get(session, 'growth.getLearning', const Duration(seconds: 60), () => _getLearning(session));

  Future<LearningStats> _getLearning(Session session) => LearnedAnswerService.stats(session);
}
