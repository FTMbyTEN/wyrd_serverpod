import 'owner_guard.dart';
import 'self_question_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/self/trigger from server.js. Public/unauthenticated, matching Node.
class SelfQuestionEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    // starting WYRD's work by hand is the owner's: strangers can't spend its budget or block its runs
    await OwnerGuard.check(session, 'that');
    // public and AI-backed: a few per 10 minutes, so nobody can spend WYRD's budget on demand
    if (RateLimiter.isLimited('trigger:self_question', 3, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    PublicCache.clear(); // only once a run really goes ahead
    return await SelfQuestionService.tick(session);
  }
}
