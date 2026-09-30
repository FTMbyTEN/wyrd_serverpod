import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/memory_recall_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given retrieval for answers (RAG)', (sessionBuilder, endpoints) {
    final me = UuidValue.fromString('33333333-3333-4333-8333-333333333333');
    final now = DateTime.now().toUtc();

    test('full-text search finds what the words mean even when no topic tag matches', () async {
      final s = sessionBuilder.build();
      await MemoryRecallService.ensureIndex(s);
      await MemoryBlock.db.insert(s, [
        // tagged with other topics: only the text can find it; "flying" must match "flies"
        MemoryBlock(timestamp: now, source: 'library', feedSource: 'Project Gutenberg', topics: ['birds'], title: 'On the flight of birds', extract: 'A bird flies because its wings push air downward, and the air pushes the wing up: lift.'),
        MemoryBlock(timestamp: now, source: 'net', url: 'https://example.org/cooking', topics: ['cooking'], title: 'Bread', extract: 'Yeast makes the dough rise.'),
      ]);
      final r = await MemoryRecallService.recall(s, me, ['aeroplanes'], query: 'How does flying actually work for a bird?');
      expect(r.knowledge.join(), contains('wings push air downward'));
      expect(r.knowledge.join(), isNot(contains('Yeast')));
      final prompt = r.toPromptLines().join('\n');
      expect(prompt, contains('[1] (Project Gutenberg)'));
    });

    test('a trusted source outranks a distrusted one saying the same, and sources are named', () async {
      final s = sessionBuilder.build();
      await TrustScore.db.insert(s, [
        TrustScore(kind: 'source', key: 'reliable.org', good: 9, bad: 0, score: 0.9, updatedAt: now),
        TrustScore(kind: 'source', key: 'rumours.biz', good: 0, bad: 9, score: 0.1, updatedAt: now),
      ]);
      await MemoryBlock.db.insert(s, [
        MemoryBlock(timestamp: now, source: 'net', url: 'https://rumours.biz/x', topics: ['comet'], title: 'Comet', extract: 'The comet will hit the moon next week.'),
        MemoryBlock(timestamp: now, source: 'net', url: 'https://reliable.org/y', topics: ['comet'], title: 'Comet', extract: 'The comet passes safely at four million kilometres.'),
      ]);
      final r = await MemoryRecallService.recall(s, me, ['comet'], query: 'what will the comet do');
      expect(r.passages.first.label, 'reliable.org');
      expect(r.passages.first.cite, contains('trusted 90%'));
    });

    test('asking for the latest puts fresh news first', () async {
      final s = sessionBuilder.build();
      await MemoryBlock.db.insert(s, [
        MemoryBlock(timestamp: now.subtract(const Duration(days: 40)), source: 'feed', feedSource: 'reuters', topics: ['election'], title: 'Election', extract: 'Old polls show a close race.'),
        MemoryBlock(timestamp: now.subtract(const Duration(hours: 3)), source: 'feed', feedSource: 'reuters', topics: ['election'], title: 'Election', extract: 'Results are in: turnout was record high.'),
      ]);
      final r = await MemoryRecallService.recall(s, me, ['election'], query: "what's the latest on the election");
      expect(r.passages.first.text, contains('Results are in'));
      expect(r.passages.first.cite, contains('h ago'));
    });

    test('its beliefs come with how sure it is, doubts included', () async {
      final s = sessionBuilder.build();
      await Belief.db.insert(s, [
        Belief(a: 'coffee', b: 'dehydration', claim: 'Coffee does not really dehydrate you.', evidenceIds: [], sources: 3, against: 0, confidence: 0.7, status: 'held', origin: 'reason', tests: 2, createdAt: now, updatedAt: now, testedAt: now),
        Belief(a: 'coffee', b: 'cancer', claim: 'Coffee causes cancer.', evidenceIds: [], sources: 1, against: 2, confidence: 0.1, status: 'doubted', origin: 'reason', tests: 1, createdAt: now, updatedAt: now, testedAt: now),
      ]);
      final r = await MemoryRecallService.recall(s, me, ['coffee'], query: 'is coffee bad for me');
      expect(r.beliefs.first, allOf(contains('You hold this'), contains('70%'), contains('3 sources')));
      expect(r.beliefs.join(), contains('You DOUBT this'));
    });
  });
}
