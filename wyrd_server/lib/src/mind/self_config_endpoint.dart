import '../generated/protocol.dart';
import 'self_config_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/self-config, /api/cop-log, and /api/self-modify/trigger from server.js.
/// Public/unauthenticated, matching Node.
class SelfConfigEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxCopLogEntries = 100;

  Future<SelfConfig> getConfig(Session session) async {
    return await SelfConfigService.getConfig(session);
  }

  Future<List<CopLogEntry>> getCopLog(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxCopLogEntries);
    final entries = await CopLogEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries;
  }

  Future<SelfConfigChange?> trigger(Session session) async {
    return await SelfConfigService.attemptSelfModification(session);
  }
}
