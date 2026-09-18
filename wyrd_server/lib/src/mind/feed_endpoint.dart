import '../generated/protocol.dart';
import 'feed_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/feed/recent and /api/feed/trigger from server.js. Public/unauthenticated,
/// matching Node. /api/feed/next (nextTickAt/cycleMs) is not ported -- it depended on Node's
/// TURBO_FACTOR speed-scaling, which isn't ported either (see feed_future_call.dart).
class FeedEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<FeedIngest>> getRecent(Session session) async {
    return FeedService.recentIngests;
  }

  Future<bool> trigger(Session session) async {
    return await FeedService.tick(session);
  }
}
