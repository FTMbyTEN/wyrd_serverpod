import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Memory endpoint', (sessionBuilder, endpoints) {
    test(
      'when no blocks exist then getMemory returns an empty list',
      () async {
        final blocks = await endpoints.memory.getMemory(sessionBuilder);
        expect(blocks, isEmpty);
      },
    );

    test(
      'when blocks with shared topics exist then getConcepts links them by co-occurrence',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'chat',
            topics: ['determinism', 'free-will'],
          ),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            topics: ['determinism', 'physics'],
          ),
        );

        final blocks = await endpoints.memory.getMemory(sessionBuilder);
        expect(blocks, hasLength(2));

        final graph = await endpoints.memory.getConcepts(sessionBuilder);
        final determinism = graph.nodes.firstWhere((n) => n.id == 'determinism');
        expect(determinism.count, 2);
        expect(
          graph.edges.any((e) =>
              (e.a == 'determinism' && e.b == 'free-will') ||
              (e.a == 'free-will' && e.b == 'determinism')),
          isTrue,
        );
      },
    );
  });
}
