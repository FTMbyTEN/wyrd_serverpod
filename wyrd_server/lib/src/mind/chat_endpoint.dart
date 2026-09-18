import '../generated/protocol.dart';
import 'chat_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/chat from server.js (the core reply path -- see chat_service.dart for what's
/// intentionally not ported yet). Requires login, matching Node's requireAuth. Node's
/// per-user rate limiting (30 messages/min) is not ported yet either.
class ChatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<ChatReply> sendMessage(Session session, String text) async {
    if (text.trim().isEmpty) {
      throw Exception('empty message');
    }
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final result = await ChatService.processMessage(session, authUserId, text);
    return ChatReply(reply: result.reply, mind: result.mind);
  }

  Future<List<ConversationTurn>> getHistory(Session session, {int? limit}) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final take = (limit ?? 50).clamp(1, 2000);
    final turns = await ConversationTurn.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return turns.reversed.toList();
  }
}
