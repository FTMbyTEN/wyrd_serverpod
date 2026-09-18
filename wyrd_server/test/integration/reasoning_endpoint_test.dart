import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

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
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'chat', topics: ['gravity', 'orbits']),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', topics: ['gravity', 'mass']),
        );

        final ran = await endpoints.reasoning.trigger(sessionBuilder);
        expect(ran, isTrue);

        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.lastEvent, 'reasoning');
      },
    );
  });
}
