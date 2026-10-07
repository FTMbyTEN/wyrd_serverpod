import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given SelfQuestion endpoint', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    test(
      'when fewer than 2 memory blocks exist then `trigger` returns false',
      () async {
        final ran = await endpoints.selfQuestion.trigger(sessionBuilder);
        expect(ran, isFalse);
      },
    );

    test(
      'when at least 2 memory blocks with topics exist and no model is configured then `trigger` '
      'muses on a question without storing its canned answer as memory',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', title: 'Heat death', topics: ['entropy']), // public memories only: chats never feed self-questions
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', title: 'Entropy', topics: ['entropy', 'thermodynamics']),
        );

        final ran = await endpoints.selfQuestion.trigger(sessionBuilder);
        expect(ran, isTrue);

        // a template answer is not knowledge -- storing it is what caused the self-echo loop
        final blocks = await MemoryBlock.db.find(session, where: (t) => t.source.equals('self'));
        expect(blocks, isEmpty);

        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.lastEvent, 'musing');
        expect(mind.explorationCount, 0);
      },

    );
  });
}
