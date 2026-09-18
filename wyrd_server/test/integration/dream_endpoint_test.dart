import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Dream endpoint', (sessionBuilder, endpoints) {
    test(
      'when fewer than 2 memory blocks exist then `trigger` returns null',
      () async {
        final entry = await endpoints.dream.trigger(sessionBuilder);
        expect(entry, isNull);
      },
    );

    test(
      'when at least 2 memory blocks exist then `trigger` blends two of them into a dream entry',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'chat',
            userText: 'what is time',
            topics: ['time'],
          ),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            title: 'Entropy',
            topics: ['entropy'],
          ),
        );

        final entry = await endpoints.dream.trigger(sessionBuilder);
        expect(entry, isNotNull);
        expect(entry!.sourceBlockIds, hasLength(2));

        final entries = await endpoints.dream.getEntries(sessionBuilder);
        expect(entries, hasLength(1));
      },
    );
  });
}
