import 'owner_guard.dart';
import '../generated/protocol.dart';
import 'self_config_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/self-config, /api/cop-log, and /api/self-modify/trigger from server.js.
/// Public/unauthenticated, matching Node.
class SelfConfigEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxCopLogEntries = 100;

  Future<SelfConfig> getConfig(Session session) =>
      PublicCache.get(session, 'self_config.getConfig', const Duration(seconds: 30), () => _getConfig(session));

  Future<SelfConfig> _getConfig(Session session) async {
    return await SelfConfigService.getConfig(session);
  }

  /// COP's reviews of WYRD's self-changes: for WYRD's owner (the operator accounts) only.
  Future<List<CopLogEntry>> getCopLog(Session session, {int? limit}) async {
    await OwnerGuard.check(session, 'COP');
    return PublicCache.get(session, 'self_config.getCopLog:$limit', const Duration(seconds: 30), () => _getCopLog(session, limit: limit));
  }

  Future<List<CopLogEntry>> _getCopLog(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxCopLogEntries);
    final entries = await CopLogEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries;
  }

  Future<SelfConfigChange?> trigger(Session session) async {
    // starting WYRD's work by hand is the owner's: strangers can't spend its budget or block its runs
    await OwnerGuard.check(session, 'that');
    // public and AI-backed: a few per 10 minutes, so nobody can spend WYRD's budget on demand
    if (RateLimiter.isLimited('trigger:self_config', 3, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    PublicCache.clear(); // only once a run really goes ahead
    return await SelfConfigService.attemptSelfModification(session);
  }
}
