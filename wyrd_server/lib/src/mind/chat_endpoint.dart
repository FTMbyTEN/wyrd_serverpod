import '../generated/protocol.dart';
import 'chat_service.dart';
import 'learned_answer_service.dart';
import 'rate_limiter.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/chat from server.js (the core reply path -- see chat_service.dart for what's
/// intentionally not ported yet). Requires login, matching Node's requireAuth.
class ChatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _rateLimit = 30;
  static const _rateWindow = Duration(minutes: 1);

  Future<ChatReply> sendMessage(Session session, String text) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);

    if (RateLimiter.isLimited('chat:$authUserId', _rateLimit, _rateWindow)) {
      throw Exception('slow down a bit — try again in a moment');
    }
    if (text.trim().isEmpty) {
      throw Exception('empty message');
    }

    final result = await ChatService.processMessage(session, authUserId, text);
    return ChatReply(reply: result.reply, mind: result.mind, action: result.action, fromMemory: result.fromMemory, turnId: result.turn.id);
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

  /// 👍 (1), 👎 (-1) or clear (0) one of your own conversation turns. Trains the learned answer
  /// behind it, and is kept on the turn as a record of what helped.
  Future<void> rate(Session session, int turnId, int rating) async {
    if (rating < -1 || rating > 1) throw Exception('rating must be -1, 0 or 1');
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final turn = await ConversationTurn.db.findById(session, turnId);
    if (turn == null || turn.authUserId != authUserId) throw Exception('no such reply');
    await LearnedAnswerService.rate(session, turn, rating);
    await ConversationTurn.db.updateRow(session, turn.copyWith(rating: rating == 0 ? null : rating), columns: (t) => [t.rating]);
  }
}
