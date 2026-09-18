import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Curriculum endpoint', (sessionBuilder, endpoints) {
    test(
      'when calling `getStatus` for the first time then it starts at position 1, lap 0',
      () async {
        final status = await endpoints.curriculum.getStatus(sessionBuilder);
        expect(status.position, 1);
        expect(status.lap, 0);
        expect(status.subject, isNotEmpty);
        expect(status.title, isNotEmpty);
        expect(status.recentlyCompleted, isEmpty);
      },
    );
  });
}
