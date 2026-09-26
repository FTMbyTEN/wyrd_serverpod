import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

const userId = '55555555-5555-4555-8555-555555555555';

void main() {
  withServerpod('Given a signed-in user', (sessionBuilder, endpoints) {
    test('touchVisit creates the WYRD profile and records the sign-in email', () async {
      final s = sessionBuilder.build();
      await s.db.unsafeExecute(
        'INSERT INTO "serverpod_auth_core_user" ("id", "createdAt", "scopeNames", "blocked") VALUES (@id, now(), \'[]\', false)',
        parameters: QueryParameters.named({'id': userId}),
      );
      await s.db.unsafeExecute(
        'INSERT INTO "serverpod_auth_idp_email_account" ("authUserId", "createdAt", "email", "passwordHash") VALUES (@id, now(), \'ada@example.com\', \'x\')',
        parameters: QueryParameters.named({'id': userId}),
      );
      final authed = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(userId, {}));

      final p = await endpoints.profile.touchVisit(authed);
      expect(p.email, 'ada@example.com');
      expect(p.visitCount, 1);
      expect(await UserProfile.db.count(s), 1);
    });
  });
}
