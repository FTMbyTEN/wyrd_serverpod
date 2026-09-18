import 'reasoning_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/reasoning/trigger from server.js. Public/unauthenticated, matching Node.
/// GET /api/reasoning (the human-readable .md log) is not ported -- see reasoning_service.dart.
class ReasoningEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    return await ReasoningService.tick(session);
  }
}
