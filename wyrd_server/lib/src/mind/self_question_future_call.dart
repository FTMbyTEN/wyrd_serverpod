import 'self_question_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's SELF_CYCLE_MS self-questioning interval. Node scales this by a runtime
/// TURBO_FACTOR (not ported); this uses a fixed, real-time interval instead.
class SelfQuestionFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    await SelfQuestionService.tick(session);
  }
}
