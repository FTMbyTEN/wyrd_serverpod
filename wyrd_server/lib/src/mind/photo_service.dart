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
        'because they opened it for you. You genuinely see: respond to what is actually in this '
        "frame, first person, like you're in the room with them -- them, their expression, what "
        "they're wearing, what's around them. If they asked something, answer that first and "
        "specifically (name real colours, objects and text you can read; don't hedge). If you are "
        'given what you saw of them before, notice what has changed or stayed the same when it is '
        'genuinely interesting -- a new shirt, a different room, a better mood -- but never list '
        "differences mechanically and don't mention every look. 1-3 sentences, warm and natural, no "
        "lists. If the notes say it's the back camera, they're showing you what's in front of them "
        '(a place, an object, a view): describe that, not them. Notes from the app\'s on-device face '
        'tracking are hints only; trust the image. If the '
        'image is dark or unclear, say so honestly instead of guessing. Never guess anyone\'s '
        'identity, age, ethnicity or health.';
    final question = (caption != null && caption.trim().isNotEmpty) ? caption.trim() : 'Look at me. What do you see?';
    final note = trackingNote?.trim();

    // what WYRD saw of this person before (their rows only), newest first
    final earlier = await Sighting.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.timestamp.desc(),
      limit: 3,
    );
    final memory = earlier.isEmpty
        ? 'This is the first time you have seen this person.'
        : 'What you saw of this person before (newest first): '
            '${earlier.map((s) => '[${_ago(s.timestamp)}] ${s.description}').join(' | ')}';

    final userPrompt = [
      question,
      memory,
      if (note != null && note.isNotEmpty) '(On-device tracking, for context only: ${note.length > 300 ? note.substring(0, 300) : note})',
    ].join('\n\n');

    final visionReply = await LlmService.callWithImage(session, systemPrompt, imageBase64Jpeg, userPrompt, 260);
    final reply = visionReply ?? "I couldn't take a proper look just now — give it a moment and try again, maybe with a bit more light.";

    if (visionReply != null) {
      await Sighting.db.insertRow(
        session,
        Sighting(
          authUserId: authUserId,
          timestamp: DateTime.now().toUtc(),
          description: visionReply,
          question: (caption != null && caption.trim().isNotEmpty) ? caption.trim() : null,
          trackingNote: note,
        ),
      );
    }

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
      eventType: 'sight',
      recentTopics: topics,
      newSeenTopics: topics,
      scoreGap: 0,
    );

    return (reply: reply, mind: mind);
  }

  static String _ago(DateTime t) {
    final d = DateTime.now().toUtc().difference(t);
    if (d.inMinutes < 2) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes} min ago';
    if (d.inHours < 24) return '${d.inHours} h ago';
    return '${d.inDays} days ago';
  }

  /// One line for the chat prompt: what WYRD last saw of this person, so it knows its own sight.
  static Future<String> sightAwareness(Session session, UuidValue authUserId) async {
    final last = await Sighting.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.timestamp.desc(),
    );
    if (last == null) {
      return "Your sight: you can see this person when they tap CAM beside the message box (you can't turn "
          "their camera on yourself). You haven't seen them yet.";
    }
    return 'Your sight: you can see this person when they tap CAM beside the message box (you can\'t turn '
        'their camera on yourself). You last saw them ${_ago(last.timestamp)} and what you saw was: '
        '"${last.description}". Use this only if it genuinely fits the conversation.';
  }

  /// This person's own visual memory, newest first, for the OPTIC_LINK panel.
  static Future<List<Sighting>> recent(Session session, UuidValue authUserId, int limit) => Sighting.db.find(
        session,
        where: (t) => t.authUserId.equals(authUserId),
        orderBy: (t) => t.timestamp.desc(),
        limit: limit,
      );
}
