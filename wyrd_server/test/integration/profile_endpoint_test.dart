import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Profile endpoint', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '11111111-1111-4111-8111-111111111111',
        {},
      ),
    );

    test(
      'when calling `getProfile` for a first-time user then it creates a fresh row with zero visits',
      () async {
        final profile = await endpoints.profile.getProfile(authed);
        expect(profile.visitCount, 0);
        expect(profile.username, isNull);
      },
    );

    test(
      'when calling `touchVisit` then visitCount increments and lastSeen advances',
      () async {
        final before = await endpoints.profile.getProfile(authed);
        final after = await endpoints.profile.touchVisit(authed);
        expect(after.visitCount, before.visitCount + 1);
        expect(after.lastSeen.isAfter(before.lastSeen) || after.lastSeen.isAtSameMomentAs(before.lastSeen), isTrue);
      },
    );

    test(
      'when calling `setUsername` then it persists',
      () async {
        final updated = await endpoints.profile.setUsername(authed, 'wanderer');
        expect(updated.username, 'wanderer');
      },
    );
  });
}
