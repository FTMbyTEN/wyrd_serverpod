import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import 'withdrawals.dart';

/// Where the payout provider reports what happened to a payout: POST /rewards/v1/provider/{name}, the raw JSON body
/// signed with HMAC-SHA256 (REWARDS_PROVIDER_SECRET) in the x-wyrd-signature header. Every report is recorded once;
/// only a signed, in-order report moves money (see Withdrawals.onProviderEvent).
class RewardProviderRoute extends Route {
  RewardProviderRoute() : super(methods: {Method.post});

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    final path = request.url.path;
    final name = path.substring(path.lastIndexOf('/') + 1);
    if (!RegExp(r'^[a-z0-9_-]{1,40}$').hasMatch(name)) return _json(404, {'error': 'not found'});
    String body;
    try {
      body = await request.readAsString(maxLength: 64 * 1024);
    } catch (_) {
      return _json(413, {'error': 'too large'});
    }
    final sig = request.headers['x-wyrd-signature']?.join(',') ?? '';
    String outcome;
    try {
      outcome = await Withdrawals.onProviderEvent(session, provider: name, body: body, signature: sig);
    } catch (e) {
      session.log('[rewards] provider event failed: $e', level: LogLevel.error);
      return _json(500, {'error': 'retry later'}); // nothing recorded, so the provider's retry is safe
    }
    // Acknowledge anything we recorded so the provider stops retrying; only a bad signature is refused.
    return _json(outcome == 'rejected_signature' ? 401 : 200, {'outcome': outcome});
  }

  static Response _json(int status, Map<String, Object> m) =>
      Response(status, body: Body.fromString(jsonEncode(m), mimeType: MimeType.json), headers: Headers.fromMap({'cache-control': ['no-store']}));
}
