import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given SelfConfig endpoint', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    test(
      'when calling `getConfig` for the first time then it creates the default row',
      () async {
        final config = await endpoints.selfConfig.getConfig(sessionBuilder);
        expect(config.toneNote, '');
        expect(config.replyLengthMax, 4);
        expect(config.curiosityLevel, 'moderate');
        expect(config.history, isEmpty);
      },
    );

    test(
      'when no LLM is configured then `trigger` returns null and no cop-log entry is written',
      () async {
        final change = await endpoints.selfConfig.trigger(sessionBuilder);
        expect(change, isNull);

        final log = await endpoints.selfConfig.getCopLog(sessionBuilder);
        expect(log, isEmpty);
      },
    );
  });
}
