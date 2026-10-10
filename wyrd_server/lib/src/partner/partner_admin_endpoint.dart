import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import 'partner_api.dart';

/// The owner's controls for the partner API: issue and revoke keys, open staging once it's paid for, see the keys.
/// Owner only.
class PartnerAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> _owner(Session session) async {
    final user = UuidValue.fromString(session.authenticated!.userIdentifier);
    if (!await DroneService.isOperator(session, user))
      throw Exception('Partner keys are for the owner.');
  }

  /// A new key for [partner] in [env] ("test" for staging, "live" for production). The key is in the answer once and
  /// never again (only its hash is kept): pass it on through a one-time secret link.
  Future<String> issueKey(
    Session session,
    String partner,
    String env,
    String label,
  ) async {
    await _owner(session);
    final (key, row) = await PartnerApi.issueKey(session, partner, env, label);
    return jsonEncode({
      'key': key,
      'prefix': row.prefix,
      'env': row.env,
      'label': row.label,
    });
  }

  /// Revoke the key that starts with [prefix] (as listed by [keys]).
  Future<String> revokeKey(Session session, String prefix) async {
    await _owner(session);
    final k = await PartnerKey.db.findFirstRow(
      session,
      where: (t) => t.prefix.equals(prefix),
    );
    if (k == null) return jsonEncode({'error': 'No such key.'});
    await PartnerKey.db.updateRow(
      session,
      k.copyWith(active: false, revokedAt: DateTime.now().toUtc()),
    );
    return jsonEncode({'revoked': prefix});
  }

  /// Open (or renew) staging for [partner] once it's paid: 2,000 requests for 30 days. [note]: how it was paid.
  Future<String> openStaging(
    Session session,
    String partner,
    String note,
  ) async {
    await _owner(session);
    final a = await PartnerApi.openStaging(session, partner, note: note);
    return jsonEncode({
      'partner': a.partner,
      'allowance': a.allowance,
      'valid_until': a.validUntil?.toIso8601String(),
    });
  }

  /// One real call to the model in the partner API's support shape, with this server's own key: confirms the API works
  /// end to end before a partner uses it. Costs a fraction of a cent. Nothing is stored.
  Future<String> selfTest(Session session) async {
    await _owner(session);
    final t0 = DateTime.now();
    final m = await PartnerModel.call(
      session,
      'You are WYRD, the support assistant for Konnectly. Answer only from the platform data below; never confirm payments or promise refunds.\n'
      'Platform data: {"order":{"id":"KN-TEST-1","status":"out_for_delivery","eta":"2026-10-10T16:00:00Z","refund_eligible":false}}',
      [
        {
          'role': 'user',
          'content': 'Where is my order, and can I get a refund?',
        },
      ],
      PartnerApi.supportSchema,
      800,
    );
    final ms = DateTime.now().difference(t0).inMilliseconds;
    return jsonEncode({
      'ok': m.json != null,
      'model': PartnerModel.model,
      'ms': ms,
      'refused': m.refused,
      'error': m.error,
      'detail': m.detail,
      'answer': m.json,
      'input_tokens': m.inputTokens,
      'output_tokens': m.outputTokens,
      'cost_usd':
          (m.inputTokens * PartnerModel.inPerM +
              m.outputTokens * PartnerModel.outPerM) /
          1e6,
    });
  }

  /// The keys (prefixes only), staging allowances and this month's usage.
  Future<String> keys(Session session, String partner) async {
    await _owner(session);
    final keys = await PartnerKey.db.find(
      session,
      where: (t) => t.partner.equals(partner),
      orderBy: (t) => t.id,
    );
    final accounts = await PartnerAccount.db.find(
      session,
      where: (t) => t.partner.equals(partner),
    );
    return jsonEncode({
      'keys': [
        for (final k in keys)
          {
            'prefix': k.prefix,
            'env': k.env,
            'label': k.label,
            'active': k.active,
            'last_used': k.lastUsedAt?.toIso8601String(),
          },
      ],
      'accounts': [
        for (final a in accounts)
          {
            'env': a.env,
            'allowance': a.allowance,
            'used': a.used,
            'valid_until': a.validUntil?.toIso8601String(),
            'note': a.note,
          },
      ],
    });
  }
}
