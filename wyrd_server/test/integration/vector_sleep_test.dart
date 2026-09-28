import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/learned_answer_service.dart';
import 'package:wyrd_server/src/mind/memory_recall_service.dart';
import 'package:wyrd_server/src/mind/sleep_service.dart';
import 'package:wyrd_server/src/mind/topic_service.dart';

import 'test_tools/serverpod_test_tools.dart';

/// A unit vector mostly along axis [axis], nudged by [wobble] along the next axis, so the
/// tests can say "about the same meaning" (small wobble) or "unrelated" (another axis).
Vector v(int axis, {double wobble = 0}) {
  final x = List<double>.filled(512, 0);
  x[axis] = 1;
  x[(axis + 1) % 512] = wobble;
  final n = sqrt(1 + wobble * wobble);
  return Vector([for (final e in x) e / n]);
}

void main() {
  withServerpod('Given vector search and sleep', (sessionBuilder, endpoints) {
    final me = UuidValue.fromString('12121212-1212-4121-8121-121212121212');

    test('recall finds memories by meaning even with no words in common', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await MemoryBlock.db.insert(session, [
        MemoryBlock(timestamp: now, source: 'net', title: 'Lift (force)', extract: 'How wings hold aircraft up', topics: ['lift', 'wings'], embedding: v(7, wobble: 0.1)),
        MemoryBlock(timestamp: now, source: 'net', title: 'Sourdough', topics: ['bread'], embedding: v(40)),
        MemoryBlock(timestamp: now, source: 'chat', userText: 'private flying chat', topics: ['planes'], embedding: v(7)), // never recalled
      ]);
      // "how do planes stay up" shares no topic with the article, but is close in meaning
      final r = await MemoryRecallService.recall(session, me, ['planes', 'stay'], meaning: v(7));
      expect(r.knowledge.join(), contains('Lift (force)'));
      expect(r.knowledge.join(), isNot(contains('Sourdough')));
      expect(r.toPromptLines().join(), isNot(contains('private flying chat')));
    });

    test('a rephrased question reuses a learned answer by meaning', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await LearnedAnswer.db.insertRow(session, LearnedAnswer(
        question: 'What keeps aircraft in the air?', intent: 'what', topics: ['aircraft', 'air'],
        answer: 'Lift: wings push air down, and the air pushes the plane up.', score: 1, uses: 0, version: 1,
        retired: false, createdAt: now, updatedAt: now, embedding: v(9),
      ));
      const q = 'What makes planes fly?';
      final hit = await LearnedAnswerService.recall(session, me, q, TopicService.extractTopics(q), meaning: v(9, wobble: 0.2));
      expect(hit?.answer, startsWith('Lift'));
      final miss = await LearnedAnswerService.recall(session, me, q, TopicService.extractTopics(q), meaning: v(60));
      expect(miss, isNull);
    });

    test('sleep merges twin answers, retires stale ones, clears duplicate memories and faint synapses', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      final old = now.subtract(const Duration(days: 90));
      LearnedAnswer a(String q, double score, int uses, Vector e, {DateTime? at}) => LearnedAnswer(
            question: q, intent: 'what', topics: ['x'], answer: 'answer to $q', score: score, uses: uses, version: 1,
            retired: false, createdAt: at ?? now, updatedAt: at ?? now, embedding: e);
      final strong = await LearnedAnswer.db.insertRow(session, a('What is a star?', 2, 5, v(3)));
      final twin = await LearnedAnswer.db.insertRow(session, a('What are stars?', 0.5, 2, v(3, wobble: 0.05)));
      final stale = await LearnedAnswer.db.insertRow(session, a('What is zzz?', 0.3, 0, v(80), at: old));
      await MemoryBlock.db.insert(session, [
        MemoryBlock(timestamp: now, source: 'net', title: 'Same story', url: 'https://x/1', topics: ['s']),
        MemoryBlock(timestamp: now, source: 'net', title: 'Same story', url: 'https://x/1', topics: ['s']),
      ]);
      await Synapse.db.insert(session, [
        Synapse(a: 'a', b: 'b', weight: 0.01, fires: 1, lastFired: now),
        Synapse(a: 'c', b: 'd', weight: 0.6, fires: 5, lastFired: now),
      ]);

      final report = await SleepService.sleep(session, mark: 'sleep:test');

      expect((await LearnedAnswer.db.findById(session, strong.id!))!.retired, isFalse);
      expect((await LearnedAnswer.db.findById(session, strong.id!))!.uses, 7); // the twin's uses folded in
      expect((await LearnedAnswer.db.findById(session, twin.id!))!.retired, isTrue);
      expect((await LearnedAnswer.db.findById(session, stale.id!))!.retired, isTrue);
      expect(await MemoryBlock.db.count(session, where: (t) => t.title.equals('Same story')), 1);
      expect((await Synapse.db.find(session)).map((s) => s.a), ['c']);

      expect(report['mergedAnswers'], 1);
      expect(report['summary'], contains('skipped meaning fingerprints')); // no Voyage key in tests
      final note = (await ReasoningNote.db.find(session)).firstWhere((n) => n.kind == 'sleep');
      expect((jsonDecode(note.content) as Map)['summary'], contains('merged 1 learned answer'));
      expect(await MaintenanceRun.db.findFirstRow(session, where: (t) => t.name.equals('sleep:test')), isNotNull);
    });
  });
}
