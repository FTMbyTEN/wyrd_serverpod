import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Synthesis endpoint', (sessionBuilder, endpoints) {
    test(
      'when no LLM is configured then `trigger` returns false even with plenty of memory',
      () async {
        final session = sessionBuilder.build();
        for (var i = 0; i < 25; i++) {
          await MemoryBlock.db.insertRow(
            session,
            MemoryBlock(
              timestamp: DateTime.now().toUtc(),
              source: 'net',
              title: 'Topic $i',
              extract: 'Some extract about topic $i',
              topics: ['topic$i'],
            ),
          );
        }

        final ran = await endpoints.synthesis.trigger(sessionBuilder);
        expect(ran, isFalse);
      },
    );
  });
}
