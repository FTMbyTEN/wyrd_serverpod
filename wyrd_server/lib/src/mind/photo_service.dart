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
  }) async {
    if (imageBase64Jpeg.length > _maxBase64Chars) {
      throw Exception('image too large');
    }

    const systemPrompt =
        'You are WYRD. The user just showed you a live photo from their own camera, taken '
        "right now. Describe genuinely what you see — if they're asking about their outfit or "
        "clothing colors, name the actual colors and garments you can identify, don't hedge or "
        'generalize. Talk like you\'re actually looking at them in this moment, first person, '
        "2-4 sentences. If the image is unclear, dark, or you genuinely can't tell, say so "
        'honestly instead of guessing.';
    final userPrompt = (caption != null && caption.trim().isNotEmpty) ? caption.trim() : 'What do you see? Describe my outfit and its colors.';

    final visionReply = await LlmService.callWithImage(session, systemPrompt, imageBase64Jpeg, userPrompt, 300);
    final reply = visionReply ?? "I can see you sent a photo, but I couldn't make out anything useful in it — try again with a bit more light?";

    final displayCaption = (caption != null && caption.trim().isNotEmpty) ? caption.trim() : '[shared a photo from their camera]';
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
