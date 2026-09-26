import '../generated/protocol.dart';
import 'dream_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's dreamTickIfIdle (checked every 15 real minutes): dream only when nobody
/// has chatted for a while, and never more than once per [_minGap]. Idleness and the last dream
/// are read from the database rather than kept in memory, so it holds across restarts and
/// multiple server instances.
class DreamFutureCall extends FutureCall {
  static const _idleThreshold = Duration(minutes: 10);
  static const _minGap = Duration(minutes: 30);

  Future<void> checkIdle(Session session) async {
    final now = DateTime.now().toUtc();

    final lastChat = await ConversationTurn.db.findFirstRow(
      session,
      orderBy: (t) => t.id.desc(),
    );
    if (lastChat != null &&
        now.difference(lastChat.timestamp) < _idleThreshold) {
      return;
    }

    final lastDream = await DreamEntry.db.findFirstRow(
      session,
      orderBy: (t) => t.id.desc(),
    );
    if (lastDream != null && now.difference(lastDream.timestamp) < _minGap) {
      return;
    }

    await DreamService.generateDream(session);
  }
}
