import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/dream_future_call.dart';

import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the dream idle check', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    Future<void> seedMemory() async {
      final session = sessionBuilder.build();
      for (final t in ['tides', 'lanterns', 'comets']) {
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            title: t,
            topics: [t],
          ),
        );
      }
    }

    test('when nobody has chatted recently then it dreams', () async {
      await seedMemory();
      await DreamFutureCall().checkIdle(sessionBuilder.build());
      expect(await DreamEntry.db.count(sessionBuilder.build()), 1);
    });

    test(
      'when someone chatted in the last 10 minutes then it does not dream',
      () async {
        await seedMemory();
        final session = sessionBuilder.build();
        await ConversationTurn.db.insertRow(
          session,
          ConversationTurn(
            authUserId: const Uuid().v4obj(),
            userText: 'hi',
            botText: 'hello',
            timestamp: DateTime.now().toUtc().subtract(
              const Duration(minutes: 2),
            ),
          ),
        );
        await DreamFutureCall().checkIdle(session);
        expect(await DreamEntry.db.count(session), 0);
      },
    );

    test(
      'when it dreamed in the last 30 minutes then it does not dream again',
      () async {
        await seedMemory();
        final session = sessionBuilder.build();
        await DreamEntry.db.insertRow(
          session,
          DreamEntry(
            timestamp: DateTime.now().toUtc().subtract(
              const Duration(minutes: 20),
            ),
            content: 'earlier dream',
            sourceBlockIds: [],
          ),
        );
        await DreamFutureCall().checkIdle(session);
        expect(await DreamEntry.db.count(session), 1);
      },
    );
  });
}
