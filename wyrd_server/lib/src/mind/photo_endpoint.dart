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

  Future<ChatReply> describe(Session session, String imageBase64Jpeg, {String? caption}) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);

    if (RateLimiter.isLimited('photo:$authUserId', _rateLimit, _rateWindow)) {
      throw Exception('slow down a bit — try again in a moment');
    }

    final result = await PhotoService.describe(
      session,
      authUserId: authUserId,
      imageBase64Jpeg: imageBase64Jpeg,
      caption: caption,
    );
    return ChatReply(reply: result.reply, mind: result.mind);
  }
}
