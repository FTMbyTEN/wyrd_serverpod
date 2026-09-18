import 'growth_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's GROWTH_SNAPSHOT_MS wall-clock interval (every 30 real minutes). Scheduled
/// once at server startup in server.dart via pod.futureCalls.growth.takeSnapshot.callRecurring().
class GrowthFutureCall extends FutureCall {
  Future<void> takeSnapshot(Session session) async {
    await GrowthService.takeSnapshot(session);
  }
}
