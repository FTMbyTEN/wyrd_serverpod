import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Diary endpoint', (sessionBuilder, endpoints) {
    test(
      'when no entries exist then getEntries returns an empty list',
      () async {
        final entries = await endpoints.diary.getEntries(sessionBuilder);
        expect(entries, isEmpty);
      },
    );

    test(
      'when calling `trigger` without an LLM configured then it falls back to the template entry',
      () async {
        final entry = await endpoints.diary.trigger(sessionBuilder);
        expect(entry.content, isNotEmpty);
        expect(entry.date, DateTime.now().toUtc().toIso8601String().substring(0, 10));

        final entries = await endpoints.diary.getEntries(sessionBuilder);
        expect(entries, hasLength(1));
      },
    );
  });
}
