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
    'player_character',
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
    // sign-ups per day over the last 14 days, oldest first (days with none included as 0)
    final days = await session.db.unsafeQuery(
      r'''SELECT to_char(date_trunc('day', "createdAt"), 'YYYY-MM-DD'), count(*) FROM "serverpod_auth_idp_email_account"
         WHERE "createdAt" > now() - interval '14 days' GROUP BY 1''',
    );
    final byDay = {for (final r in days) r[0] as String: r[1] as int};
    final today = DateTime.now().toUtc();
    final daily = [
      for (var i = 13; i >= 0; i--)
        () {
          final d = today.subtract(Duration(days: i)).toIso8601String().substring(0, 10);
          return {'day': d, 'n': byDay[d] ?? 0};
        }(),
    ];
    return jsonEncode({
      'daily': daily,
      'counts': counts,
      'recent': [for (final r in recent) {'name': r[0], 'at': (r[1] as DateTime).toIso8601String()}],
    });
  }
}
