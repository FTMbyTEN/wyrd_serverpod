import 'synthesis_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/synthesis/trigger from server.js. Public/unauthenticated, matching Node.
class SynthesisEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    PublicCache.clear();
    // public and AI-backed: a few per 10 minutes, so nobody can spend WYRD's budget on demand
    if (RateLimiter.isLimited('trigger:synthesis', 3, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    return await SynthesisService.tick(session);
  }
}
