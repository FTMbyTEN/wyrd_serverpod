import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the owner\'s journal', (sessionBuilder, endpoints) {
    final stranger = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('00000000-0000-4000-8000-0000000000f1', {}),
    );

    test('a stranger, signed in or not, cannot read the diary or the dreams', () async {
      await expectLater(endpoints.diary.getEntries(sessionBuilder), throwsException);
      await expectLater(endpoints.diary.getEntries(stranger), throwsException);
      await expectLater(endpoints.dream.getEntries(stranger), throwsException);
      await expectLater(endpoints.dream.trigger(stranger), throwsException);
      await expectLater(endpoints.diary.trigger(stranger), throwsException);
    });
  });
}
