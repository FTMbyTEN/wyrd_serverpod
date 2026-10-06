import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Dream endpoint', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    test(
      'when fewer than 2 memory blocks exist then `trigger` returns null',
      () async {
        final entry = await endpoints.dream.trigger(sessionBuilder);
        expect(entry, isNull);
      },
    );

    test(
      'when at least 3 shared memories exist then `trigger` dreams them as a constellation',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'self',
            question: 'What is time?',
            answer: 'A measure of change.',
            topics: ['time'],
          ),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', title: 'Comets', topics: ['comets']),
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
        expect(entry!.sourceBlockIds.length, inInclusiveRange(2, 3));

        final entries = await endpoints.dream.getEntries(sessionBuilder);
        expect(entries, hasLength(1));
      },
    );
  });
}
