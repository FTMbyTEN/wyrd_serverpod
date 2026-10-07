import 'owner_guard.dart';
import '../generated/protocol.dart';
import 'reasoning_log_service.dart';
import 'reasoning_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/reasoning and /api/reasoning/trigger from server.js. Public/unauthenticated,
/// matching Node.
class ReasoningEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    // starting WYRD's work by hand is the owner's: strangers can't spend its budget or block its runs
    await OwnerGuard.check(session, 'that');
    // public: a few per 10 minutes, so nobody can hammer it (the scheduler runs it anyway)
    if (RateLimiter.isLimited('trigger:reasoning', 6, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    PublicCache.clear(); // only once a run really goes ahead
    return await ReasoningService.tick(session);
  }

  /// Newest first: neural firings (kind 'firing', JSON), self-questions (kind 'self') and older
  /// reasoning traces (kind 'reasoning').
  Future<List<ReasoningNote>> getNotes(Session session, {int? limit}) =>
      PublicCache.get(session, 'reasoning.getNotes:$limit', const Duration(seconds: 8), () => _getNotes(session, limit: limit));

  Future<List<ReasoningNote>> _getNotes(Session session, {int? limit}) =>
      ReasoningLogService.recent(session, limit ?? 50);

  /// The strongest part of WYRD's neural network of ideas (see ReasoningService).
  Future<NeuralNetwork> getNetwork(Session session, {int limit = 60}) =>
      PublicCache.get(session, 'reasoning.getNetwork:$limit', const Duration(seconds: 15), () => _getNetwork(session, limit: limit));

  Future<NeuralNetwork> _getNetwork(Session session, {int limit = 60}) =>
      ReasoningService.network(session, limit.clamp(10, 200));
}
