import 'dart:convert';

import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/diary_service.dart';
import 'package:wyrd_server/src/mind/dream_service.dart';
import 'package:wyrd_server/src/mind/thinking_service.dart';

import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given things WYRD has read', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    Future<void> read(String source, String url, String title, String extract, List<String> topics) async {
      await MemoryBlock.db.insertRow(
        sessionBuilder.build(),
        MemoryBlock(timestamp: DateTime.now().toUtc(), source: source, url: url, title: title, extract: extract, topics: topics),
      );
    }

    Future<void> wire(String a, String b, double w) => Synapse.db.insertRow(
          sessionBuilder.build(),
          Synapse(a: a, b: b, weight: w, fires: 3, lastFired: DateTime.now().toUtc()),
        );

    test('two concepts wired together and backed by two sources become a held belief', () async {
      await read('net', 'https://www.nature.com/a', 'Coral bleaching', 'Rising ocean temperature causes coral bleaching across reefs.', ['coral', 'temperature']);
      await read('feed', 'https://www.bbc.co.uk/b', 'Reefs', 'Scientists say higher water temperature drives coral to expel its algae.', ['coral', 'temperature']);
      await wire('coral', 'temperature', 0.9);

      final session = sessionBuilder.build();
      expect(await ThinkingService.think(session), isTrue);

      final belief = await Belief.db.findFirstRow(session, where: (t) => t.a.equals('coral'));
      expect(belief, isNotNull);
      expect(belief!.b, 'temperature');
      expect(belief.sources, 2);
      expect(belief.status, 'held');
      expect(belief.claim, contains('coral'));

      final note = await ReasoningNote.db.findFirstRow(session, where: (t) => t.kind.equals('thought'));
      final j = jsonDecode(note!.content) as Map<String, dynamic>;
      expect(j['op'], 'connect');
      expect(j['summary'], contains('coral'));
      expect((j['evidence'] as List).length, 2);
    });

    test('a pair nothing explains becomes an open question and its goal', () async {
      await wire('lagos', 'volcano', 0.8);
      final session = sessionBuilder.build();
      expect(await ThinkingService.think(session), isTrue);
      final note = await ReasoningNote.db.findFirstRow(session, where: (t) => t.kind.equals('thought'));
      expect(jsonDecode(note!.content)['op'], 'question');
      final mind = await Mind.db.findById(session, 1);
      expect(mind!.activeGoal, 'find out how "lagos" relates to "volcano"');

      // asked once, not every tick
      await ThinkingService.think(session);
      final asked = await ReasoningNote.db.count(session, where: (t) => t.kind.equals('thought') & t.content.like('%"op":"question"%'));
      expect(asked, 1);
    });

    test('a dream wanders its own synapses somewhere far and leaves a guess to test; the diary tells its day', () async {
      final chain = ['coral', 'algae', 'sunlight', 'solar', 'battery'];
      for (var i = 0; i + 1 < chain.length; i++) {
        await wire(chain[i], chain[i + 1], 0.5);
        await read('net', 'https://ex$i.org', '${chain[i]} and ${chain[i + 1]}', 'How ${chain[i]} meets ${chain[i + 1]}.', [chain[i], chain[i + 1]]);
      }
      final session = sessionBuilder.build();
      final dream = await DreamService.generateDream(session);
      expect(dream, isNotNull);
      expect(dream!.content, startsWith('I start at "'));
      expect(dream.sourceBlockIds.length, greaterThanOrEqualTo(2));
      final guess = await Belief.db.findFirstRow(session, where: (t) => t.origin.equals('dream'));
      expect(guess, isNotNull);
      expect(guess!.status, 'dream');

      final diary = await DiaryService.generateEntry(session);
      expect(diary.content, contains('coral'));
      expect(diary.content, isNot(contains('Curiosity')));
    });

    test('contradicting evidence weighs against a claim', () {
      final ev = [
        Evidence(1, 'Coffee causes dehydration.', 'a.com', 0.6, false),
        Evidence(2, 'Coffee does not cause dehydration, a myth.', 'b.com', 0.8, true),
      ];
      final (c, sources, against) = ThinkingService.weigh(ev);
      expect(sources, 1);
      expect(against, 1);
      expect(ThinkingService.status(c, sources, against, ev), 'doubted');
    });
  });
}
