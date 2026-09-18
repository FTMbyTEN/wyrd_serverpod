import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/growth (read) from server.js. Public/unauthenticated, matching Node. There is
/// no manual /trigger for growth in Node -- snapshots are purely wall-clock (see
/// growth_future_call.dart) -- so this endpoint is read-only.
class GrowthEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxSnapshots = 2000;

  Future<List<GrowthSnapshot>> getSnapshots(Session session, {int? limit}) async {
    final take = (limit ?? 500).clamp(1, _maxSnapshots);
    final snapshots = await GrowthSnapshot.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return snapshots.reversed.toList();
  }
}
