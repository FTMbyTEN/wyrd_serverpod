import 'synthesis_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/synthesis/trigger from server.js. Public/unauthenticated, matching Node.
class SynthesisEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    return await SynthesisService.tick(session);
  }
}
