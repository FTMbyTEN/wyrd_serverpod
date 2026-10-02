import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';

/// For WYRD's owner (the operator accounts) only: where its people actually are. Accounts made
/// through sign-up live in Serverpod's auth tables (serverpod_auth_core_user and
/// serverpod_auth_idp_email_account, auth module v4) -- not in the older serverpod_user_info table
/// some tools still show -- and WYRD's own profile row (user_profile) is made on first sign-in.
class OwnerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _tables = [
    'serverpod_auth_core_user',
    'serverpod_auth_idp_email_account',
    'serverpod_auth_idp_email_account_request',
    'serverpod_user_info',
    'user_profile',
  ];

  /// Rows per table (null where a table doesn't exist), plus the newest sign-ups, as JSON.
  Future<String> userStats(Session session) async {
    final who = session.authenticated?.userIdentifier;
    if (who == null || !await DroneService.isOperator(session, UuidValue.fromString(who))) {
      throw Exception('Only the owner can see this.');
    }
    final counts = <String, int?>{};
    for (final t in _tables) {
      final exists = await session.db.unsafeQuery(
        'SELECT 1 FROM information_schema.tables WHERE table_name = @t',
        parameters: QueryParameters.named({'t': t}),
      );
      if (exists.isEmpty) {
        counts[t] = null;
        continue;
      }
      final rows = await session.db.unsafeQuery('SELECT count(*) FROM "$t"');
      counts[t] = rows.first.first as int;
    }
    // the newest accounts, by sign-up time: only the part of the email before the @
    final recent = await session.db.unsafeQuery(
      'SELECT split_part("email", \'@\', 1), "createdAt" FROM "serverpod_auth_idp_email_account" ORDER BY "createdAt" DESC LIMIT 10',
    );
    return jsonEncode({
      'counts': counts,
      'recent': [for (final r in recent) {'name': r[0], 'at': (r[1] as DateTime).toIso8601String()}],
    });
  }
}
