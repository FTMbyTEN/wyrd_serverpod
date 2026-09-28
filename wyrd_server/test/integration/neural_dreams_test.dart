import 'dart:convert';

import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/dream_service.dart';
import 'package:wyrd_server/src/mind/reasoning_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the neural network and dreams', (sessionBuilder, endpoints) {
    test('ideas that appear together wire together, a firing crosses the strongest synapse and strengthens it', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      for (var i = 0; i < 5; i++) {
        await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'net', title: 'Rust $i', topics: ['rust', 'ownership', 'safety', 'what']));
      }
      await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'chat', userText: 'private', topics: ['rust', 'secret']));

      expect(await ReasoningService.tick(session), isTrue);

      final synapses = await Synapse.db.find(session);
      final pairs = synapses.map((s) => '${s.a}-${s.b}').toSet();
      expect(pairs, containsAll(['ownership-rust', 'ownership-safety', 'rust-safety']));
      expect(pairs.where((p) => p.contains('what') || p.contains('secret')), isEmpty); // filler and chats never wire
      final rustOwnership = synapses.firstWhere((s) => s.a == 'ownership' && s.b == 'rust');
      expect(rustOwnership.weight, greaterThan(0.05)); // co-occurrences count at most twice per batch

      final notes = await endpoints.reasoning.getNotes(sessionBuilder, limit: 5);
      final firing = notes.firstWhere((n) => n.kind == 'firing');
      final json = jsonDecode(firing.content) as Map<String, dynamic>;
      expect((json['path'] as List).length, greaterThanOrEqualTo(2));
      expect(json['summary'], contains('fired'));
      final crossed = (json['synapses'] as List).first as Map<String, dynamic>;
      expect(crossed['after'] as num, greaterThan(crossed['before'] as num)); // potentiation

      final net = await endpoints.reasoning.getNetwork(sessionBuilder, limit: 10);
      expect(net.totalSynapses, 3);
      expect(net.neurons.map((n) => n.id), containsAll(['rust', 'ownership', 'safety']));
    });

    test('dreams are made of shared memories only, list their stars, and public triggers respect the gap', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await MemoryBlock.db.insert(session, [
        MemoryBlock(timestamp: now, source: 'net', feedSource: 'wikipedia', title: 'Saturn', topics: ['saturn']),
        MemoryBlock(timestamp: now, source: 'net', feedSource: 'hackernews', title: 'A new compiler', topics: ['compiler']),
        MemoryBlock(timestamp: now, source: 'self', question: 'What is gravity?', answer: 'A pull between masses.', topics: ['gravity']),
        MemoryBlock(timestamp: now, source: 'synthesis', insight: 'Orbits and loops rhyme.', topics: ['orbits']),
        for (var i = 0; i < 20; i++) MemoryBlock(timestamp: now, source: 'chat', userText: 'my private message $i', topics: ['private']),
      ]);

      final dream = await DreamService.generateDream(session);
      expect(dream, isNotNull);
      expect(dream!.content, isNot(contains('private message')));
      final stars = await endpoints.dream.getStars(sessionBuilder, dream.id!);
      expect(stars.length, dream.sourceBlockIds.length);
      expect(stars.map((s) => s.source).toSet().difference({'wikipedia', 'hackernews', 'self', 'synthesis'}), isEmpty);

      // a dream exists from just now, so the public trigger declines
      expect(await endpoints.dream.trigger(sessionBuilder), isNull);
    });
  });
}
