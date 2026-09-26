import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/reasoning_log_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Reasoning endpoint', (sessionBuilder, endpoints) {
    test(
      'when there is no memory yet then `trigger` returns false',
      () async {
        final ran = await endpoints.reasoning.trigger(sessionBuilder);
        expect(ran, isFalse);
      },
    );

    test(
      'when memory blocks exist then `trigger` runs a reasoning pass and updates Mind',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'chat',
            topics: ['gravity', 'orbits'],
          ),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            topics: ['gravity', 'mass'],
          ),
        );

        final ran = await endpoints.reasoning.trigger(sessionBuilder);
        expect(ran, isTrue);

        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.lastEvent, 'reasoning');

        final notes = await endpoints.reasoning.getNotes(sessionBuilder);
        expect(notes, hasLength(1));
        expect(notes.first.kind, 'reasoning');
        expect(notes.first.content, startsWith('# Autonomous reasoning'));
        expect(notes.first.content, contains('-> pairing['));
      },
    );

    test(
      'when there are more notes than the log keeps then only the newest 200 remain, newest first',
      () async {
        final session = sessionBuilder.build();
        for (var i = 0; i < 205; i++) {
          await ReasoningLogService.record(
            session,
            kind: 'reasoning',
            content: 'note $i',
          );
        }
        expect(await ReasoningNote.db.count(session), 200);

        final notes = await endpoints.reasoning.getNotes(
          sessionBuilder,
          limit: 3,
        );
        expect(notes.map((n) => n.content), [
          'note 204',
          'note 203',
          'note 202',
        ]);
      },
    );
  });
}
