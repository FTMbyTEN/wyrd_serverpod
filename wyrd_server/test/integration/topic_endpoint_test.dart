import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Topic endpoint', (sessionBuilder, endpoints) {
    test('when the topic is unknown then everything is empty', () async {
      final info = await endpoints.topic.getTopic(sessionBuilder, 'nebula');
      expect(info.seenCount, 0);
      expect(info.definition, isNull);
      expect(info.selfAnswer, isNull);
      expect(info.chatMentions, 0);
    });

    test(
      'when memory and lexicon mention the topic then the latest of each kind is returned',
      () async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();
        Future<void> block(MemoryBlock b) =>
            MemoryBlock.db.insertRow(session, b).then((_) {});
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'net',
            title: 'Old',
            extract: 'old',
            topics: ['nebula'],
          ),
        );
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'net',
            title: 'New',
            extract: 'new',
            topics: ['nebula', 'gas'],
          ),
        );
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'chat',
            userText: 'tell me about nebula',
            topics: ['nebula'],
          ),
        );
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'self',
            question: 'Q?',
            answer: 'A.',
            topics: ['nebula'],
          ),
        );
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'synthesis',
            insight: 'I.',
            topics: ['nebula'],
          ),
        );
        await block(
          MemoryBlock(
            timestamp: now,
            source: 'net',
            title: 'Other',
            topics: ['galaxy'],
          ),
        );
        await LexiconEntry.db.insertRow(
          session,
          LexiconEntry(
            word: 'nebula',
            understood: true,
            definition: 'a cloud',
            partOfSpeech: 'noun',
            learnedAt: now,
          ),
        );

        final info = await endpoints.topic.getTopic(sessionBuilder, ' Nebula ');
        expect(info.topic, 'nebula');
        expect(info.seenCount, 5);
        expect(info.netFactTitle, 'New');
        expect(info.selfQuestion, 'Q?');
        expect(info.selfAnswer, 'A.');
        expect(info.synthesis, 'I.');
        expect(info.definition, 'a cloud');
        expect(info.definitionPartOfSpeech, 'noun');
        expect(info.chatMentions, 0); // kept private on the public endpoint
      },
    );
  });
}
