import '../generated/protocol.dart';
import 'photo_service.dart';
import 'rate_limiter.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/chat/photo from server.js. Requires login, matching Node's requireAuth.
class PhotoEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _rateLimit = 10;
  static const _rateWindow = Duration(minutes: 1);

  /// [trackingNote] is what the app's on-device face tracking saw (pose, expression, distance);
  /// it helps WYRD read the moment but is never shown as something the person said.
  Future<ChatReply> describe(Session session, String imageBase64Jpeg, {String? caption, String? trackingNote, String? thumb}) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);

    if (RateLimiter.isLimited('photo:$authUserId', _rateLimit, _rateWindow)) {
      throw Exception('slow down a bit — try again in a moment');
    }

    final result = await PhotoService.describe(
      session,
      authUserId: authUserId,
      imageBase64Jpeg: imageBase64Jpeg,
      caption: caption,
      trackingNote: trackingNote,
      thumb: thumb,
    );
    return ChatReply(reply: result.reply, mind: result.mind);
  }

  /// What WYRD remembers seeing of the signed-in person (descriptions only), newest first.
  Future<List<Sighting>> getSightings(Session session, {int limit = 5}) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return PhotoService.recent(session, authUserId, limit.clamp(1, 20));
  }
}
