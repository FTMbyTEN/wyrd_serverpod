import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the concept map and growth panels', (sessionBuilder, endpoints) {
    test('concepts skip filler words and private chats, and a concept explains itself with real examples', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await LexiconEntry.db.insertRow(session, LexiconEntry(word: 'volcano', understood: true, definition: 'a mountain that erupts', partOfSpeech: 'noun', learnedAt: now));
      for (var i = 0; i < 3; i++) {
        await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'net', feedSource: 'wikipedia', title: 'Volcano $i', extract: 'Lava and ash', url: 'https://example.org/$i', topics: ['volcano', 'lava', 'what', 'from']));
      }
      await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'chat', userText: 'my secret volcano plan', topics: ['volcano', 'secret']));

      final graph = await endpoints.memory.getConcepts(sessionBuilder);
      final ids = graph.nodes.map((n) => n.id).toSet();
      expect(ids, containsAll(['volcano', 'lava']));
      expect(ids, isNot(anyOf(contains('what'), contains('from'), contains('secret'))));
      expect(graph.nodes.firstWhere((n) => n.id == 'volcano').count, 3); // chat block not counted

      final d = await endpoints.memory.getConceptDetail(sessionBuilder, 'Volcano');
      expect(d.mentions, 3);
      expect(d.definition, 'a mountain that erupts');
      expect(d.related.map((r) => r.id), contains('lava'));
      expect(d.related.map((r) => r.id), isNot(contains('what')));
      expect(d.examples, hasLength(3));
      expect(d.examples.first.source, 'wikipedia');
      expect(d.examples.map((e) => e.title).join(), isNot(contains('secret')));
    });

    test('growth history downsamples to readable points for each range', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      for (var i = 0; i < 300; i++) {
        await GrowthSnapshot.db.insertRow(session, GrowthSnapshot(
          timestamp: now.subtract(Duration(minutes: 5 * i)), vocabCount: 1000 - i, blockCount: 5000 - i,
          digestPercent: 2, curiosity: 0.5, confidence: 0.4));
      }
      final day = await endpoints.growth.getHistory(sessionBuilder, 'day');
      expect(day.length, inInclusiveRange(2, 121));
      expect(day.last.vocabCount, 1000);
      expect(day.first.timestamp.isBefore(day.last.timestamp), isTrue);
      final all = await endpoints.growth.getHistory(sessionBuilder, 'all');
      expect(all.length, lessThanOrEqualTo(121));
      expect(all.first.curiosity, closeTo(0.5, 1e-9));
    });
  });
}
