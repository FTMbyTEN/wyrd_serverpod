import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's describePhotoWithVision + /api/chat/photo -- a single frame from the
/// user's own camera (gated by the browser/app's own permission prompt, one explicit click
/// per photo, no continuous capture), described by the vision-capable model. Node also
/// persisted the raw JPEG to disk per user (capped at 30 photos); that file-storage side isn't
/// ported here -- only the description and its effect on Memory/Mind, which is the part that
/// actually matters to the rest of the app.
class PhotoService {
  static const _maxBase64Chars = 6 * 1024 * 1024; // ~4.5MB decoded -- generous for one JPEG frame

  static Future<({String reply, Mind mind})> describe(
    Session session, {
    required UuidValue authUserId,
    required String imageBase64Jpeg,
    String? caption,
    String? trackingNote,
  }) async {
    if (imageBase64Jpeg.length > _maxBase64Chars) {
      throw Exception('image too large');
    }

    const systemPrompt =
        'You are WYRD, looking at the person you talk with through their own camera, right now, '
        'because they opened it for you. Respond to what you actually see, first person, like '
        "you're in the room with them: them, their expression, what they're wearing, what's around "
        "them. If they asked something, answer that first and specifically (name real colours and "
        "objects, don't hedge). 1-3 sentences, warm and natural, no lists. You may get notes from "
        "the app's on-device face tracking; use them only as hints and trust the image over them. "
        "If the image is dark or unclear, say so honestly instead of guessing. Never guess anyone's "
        'identity, age, ethnicity or health.';
    final question = (caption != null && caption.trim().isNotEmpty) ? caption.trim() : 'Look at me. What do you see?';
    final note = trackingNote?.trim();
    final userPrompt = note != null && note.isNotEmpty
        ? '$question\n\n(On-device tracking, for context only: ${note.length > 300 ? note.substring(0, 300) : note})'
        : question;

    final visionReply = await LlmService.callWithImage(session, systemPrompt, imageBase64Jpeg, userPrompt, 220);
    final reply = visionReply ?? "I couldn't take a proper look just now — give it a moment and try again, maybe with a bit more light.";

    final displayCaption = (caption != null && caption.trim().isNotEmpty) ? caption.trim() : '[let you look through their camera]';
    final topics = TopicService.extractTopics(reply);

    await MemoryBlock.db.insertRow(
      session,
      MemoryBlock(
        timestamp: DateTime.now().toUtc(),
        source: 'photo',
        userText: displayCaption,
        botText: reply,
        topics: topics,
      ),
    );

    await ConversationTurn.db.insertRow(
      session,
      ConversationTurn(
        authUserId: authUserId,
        userText: displayCaption,
        botText: reply,
        timestamp: DateTime.now().toUtc(),
      ),
    );

    final mind = await MindService.recordEvent(
      session,
      eventType: 'chat',
      recentTopics: topics,
      newSeenTopics: topics,
      scoreGap: 0,
    );

    return (reply: reply, mind: mind);
  }
}
