import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Chat endpoint rate limiting', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '44444444-4444-4444-8444-444444444444',
        {},
      ),
    );

    test(
      'when sending more than 30 messages within a minute then the 31st is rejected',
      () async {
        for (var i = 0; i < 30; i++) {
          await endpoints.chat.sendMessage(authed, 'message $i');
        }
        expect(
          () => endpoints.chat.sendMessage(authed, 'message 31'),
          throwsException,
        );
      },
    );
  });
}
