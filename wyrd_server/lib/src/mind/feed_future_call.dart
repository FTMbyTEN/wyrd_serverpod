import 'feed_service.dart';
import 'tick_schedule.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's NET_CYCLE_MS interval (Node: max(6s, 60s/TURBO_FACTOR)). Node's
/// TURBO_FACTOR speed-scaling isn't ported; this uses a fixed, real-time interval instead.
class FeedFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('feed', TickSchedule.feed)) return;
    await FeedService.tick(session);
  }
}
