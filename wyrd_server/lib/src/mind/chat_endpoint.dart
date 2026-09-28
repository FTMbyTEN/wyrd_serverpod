import '../generated/protocol.dart';
import 'chat_service.dart';
import 'rating_vote_service.dart';
import 'learned_answer_service.dart';
import 'memory_recall_service.dart';
import 'topic_service.dart';
import 'trust_service.dart';
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
    return ChatReply(reply: result.reply, mind: result.mind, action: result.action, fromMemory: result.fromMemory, turnId: result.turn.id, judgement: result.judgement);
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
    await _trustFromRating(session, turn, rating - (turn.rating ?? 0));
    await ConversationTurn.db.updateRow(session, turn.copyWith(rating: rating == 0 ? null : rating), columns: (t) => [t.rating]);
  }

  /// Bias 2: a rating is evidence about where the reply's knowledge came from and what was asked.
  /// [delta] is the change (a changed mind only counts the difference).
  static Future<void> _trustFromRating(Session session, ConversationTurn turn, int delta) async {
    if (delta == 0) return;
    // each person has one capped vote per source and topic, however many replies they rate
    final weight = await RatingVoteService.weightFor(session, turn.authUserId);
    final ids = turn.groundingIds ?? const [];
    if (ids.isNotEmpty) {
      final blocks = await MemoryBlock.db.find(session, where: (t) => t.id.inSet(ids.toSet()));
      final sources = blocks.map((b) => TrustService.sourceKey(url: b.url, feedSource: b.feedSource)).whereType<String>().toSet();
      for (final s in sources) {
        final change = await RatingVoteService.apply(session, turn.authUserId, TrustService.source, s, delta * weight, limit: 1);
        await TrustService.record(session, TrustService.source, s, change);
      }
    }
    final topics = MemoryRecallService.contentTopics(TopicService.extractTopics(turn.userText)).where(TopicService.isIdea).toSet();
    for (final t in topics.take(6)) {
      final change = await RatingVoteService.apply(session, turn.authUserId, TrustService.topic, t, delta * 0.5 * weight, limit: 0.5);
      await TrustService.record(session, TrustService.topic, t, change);
    }
  }
}
