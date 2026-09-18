import '../generated/protocol.dart';
import 'dream_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/dreams and /api/dreams/trigger from server.js. Public/unauthenticated, matching
/// Node. See dream_service.dart for what's intentionally not ported yet (automatic idle-tick
/// scheduling, which needs real chat-activity tracking).
class DreamEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxEntries = 100;

  Future<List<DreamEntry>> getEntries(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxEntries);
    final entries = await DreamEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries.reversed.toList();
  }

  Future<DreamEntry?> trigger(Session session) async {
    return await DreamService.generateDream(session);
  }
}
