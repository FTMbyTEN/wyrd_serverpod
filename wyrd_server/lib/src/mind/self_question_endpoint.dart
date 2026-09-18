import 'self_question_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/self/trigger from server.js. Public/unauthenticated, matching Node.
class SelfQuestionEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    return await SelfQuestionService.tick(session);
  }
}
