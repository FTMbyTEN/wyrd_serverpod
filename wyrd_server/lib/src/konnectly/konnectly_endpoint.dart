import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../mind/llm_service.dart';
import '../mind/local_brain_service.dart';
import '../mind/rate_limiter.dart';
import 'konnectly_care.dart';
import 'konnectly_service.dart';

/// WYRD for Konnectly, demo mode: open to anyone (no sign-in, no Konnectly data), so it is held to
/// a shared pace and a daily allowance of its own (see KonnectlyService). The demo page lives at
/// /konnectly on the web server. Replies are JSON strings so the page needs no generated client;
/// a failure comes back as {"error": "..."} (a thrown exception would reach the page as a bare 500).
class KonnectlyEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _perMinute = 8;

  static bool _ready(Session session) => LlmService.isConfigured(session) && !LlmMode.off(session);

  Future<String> _safe(Session session, Future<String> Function() job) async {
    try {
      if (RateLimiter.isLimited('konnectly-demo', _perMinute, const Duration(minutes: 1))) {
        throw Exception('a lot of people are trying the demo — give it a minute');
      }
      if (!_ready(session)) throw Exception('WYRD isn\'t connected to its AI right now');
      if (!KonnectlyService.take(session)) throw Exception('the demo has used today\'s allowance — back tomorrow');
      return await job();
    } catch (e) {
      final msg = '$e'.replaceFirst('Exception: ', '');
      session.log('[konnectly] $msg', level: LogLevel.info);
      return jsonEncode({'error': msg.length > 200 ? 'something went wrong — try again' : msg});
    }
  }

  /// {"ready": bool, "left": calls left today}
  Future<String> status(Session session) async => jsonEncode({'ready': _ready(session), 'left': KonnectlyService.left(session)});

  /// See KonnectlyService.writeListing.
  Future<String> writeListing(Session session, String imageBase64Jpeg, {String? note, String? campus}) =>
      _safe(session, () => KonnectlyService.writeListing(session, imageBase64Jpeg, note: note, campus: campus));

  /// Customer care, scripted (KonnectlyCare): no AI, so it costs nothing and isn't counted against
  /// the demo's daily allowance. [lastTopic] is the topic of the previous reply, for follow-ups.
  /// {"reply", "suggestions", "handoff", "topic"}
  Future<String> care(Session session, String message, {String? lastTopic}) async {
    if (RateLimiter.isLimited('konnectly-care', 60, const Duration(minutes: 1))) {
      return jsonEncode({'error': 'a lot of people are asking at once — give it a minute'});
    }
    final text = message.trim();
    if (text.isEmpty) return jsonEncode({'error': 'type a question first'});
    return jsonEncode(KonnectlyCare.answer(text.length > 800 ? text.substring(0, 800) : text, lastTopic: lastTopic));
  }

  /// See KonnectlyService.checkReceipt.
  Future<String> checkReceipt(Session session, String imageBase64Jpeg, {int? expectedAmount, String? expectedAccount}) =>
      _safe(session,
          () => KonnectlyService.checkReceipt(session, imageBase64Jpeg, expectedAmount: expectedAmount, expectedAccount: expectedAccount));
}
