import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given SelfQuestion endpoint', (sessionBuilder, endpoints) {
    test(
      'when fewer than 2 memory blocks exist then `trigger` returns false',
      () async {
        final ran = await endpoints.selfQuestion.trigger(sessionBuilder);
        expect(ran, isFalse);
      },
    );

    test(
      'when at least 2 memory blocks with topics exist then `trigger` asks and answers a '
      'question, storing a new self MemoryBlock and updating Mind',
      () async {
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'chat', userText: 'tell me about entropy', topics: ['entropy']),
        );
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', title: 'Entropy', topics: ['entropy', 'thermodynamics']),
        );

        final ran = await endpoints.selfQuestion.trigger(sessionBuilder);
        expect(ran, isTrue);

        final blocks = await MemoryBlock.db.find(
          session,
          where: (t) => t.source.equals('self'),
        );
        expect(blocks, hasLength(1));
        expect(blocks.single.question, isNotEmpty);
        expect(blocks.single.answer, isNotEmpty);
        expect(blocks.single.answeredTopic, isNotEmpty);

        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.lastEvent, 'self');
        expect(mind.explorationCount, 1);
      },
    );
  });
}
