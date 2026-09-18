import '../generated/protocol.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Real GET /mind, backed by the persisted singleton row (see [MindService]) instead of the
/// earlier hardcoded placeholder. Public/unauthenticated, matching server.js's /api/mind.
class MindEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<Mind> getMind(Session session) async {
    return await MindService.load(session);
  }
}
