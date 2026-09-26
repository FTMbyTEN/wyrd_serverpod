import '../generated/protocol.dart';
import 'reasoning_log_service.dart';
import 'reasoning_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/reasoning and /api/reasoning/trigger from server.js. Public/unauthenticated,
/// matching Node.
class ReasoningEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> trigger(Session session) async {
    return await ReasoningService.tick(session);
  }

  /// Newest first: the traces written by reasoning passes (kind 'reasoning') and
  /// self-questions (kind 'self').
  Future<List<ReasoningNote>> getNotes(Session session, {int? limit}) =>
      ReasoningLogService.recent(session, limit ?? 50);
}
