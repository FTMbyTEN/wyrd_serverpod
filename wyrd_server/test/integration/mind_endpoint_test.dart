import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Mind endpoint', (sessionBuilder, endpoints) {
    test(
      'when calling `getMind` for the first time then it creates and returns the default singleton row',
      () async {
        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.id, 1);
        expect(mind.mood, 'dormant');
        expect(mind.curiosity, 0.2);
        expect(mind.confidence, 0.5);
        expect(mind.digest.totalTopics, 0);
        expect(mind.seenTopics, isEmpty);
      },
    );

    test(
      'when calling `getMind` twice then it returns the same persisted row, not a new one',
      () async {
        final first = await endpoints.mind.getMind(sessionBuilder);
        final second = await endpoints.mind.getMind(sessionBuilder);
        expect(second.id, first.id);
      },
    );
  });
}
