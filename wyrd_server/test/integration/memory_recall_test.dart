import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/memory_recall_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given MemoryRecallService', (sessionBuilder, endpoints) {
    final me = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
    final someoneElse = UuidValue.fromString('22222222-2222-4222-8222-222222222222');

    test('when memory spans every kind of knowledge then recall ranks and labels it, and never leaks another person\'s chat', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();

      // shared knowledge
      await MemoryBlock.db.insert(session, [
        MemoryBlock(timestamp: now, source: 'self', topics: ['entropy', 'disorder'], question: 'What is entropy?', answer: 'A measure of how many ways a system can be arranged.', answeredTopic: 'entropy'),
        MemoryBlock(timestamp: now, source: 'net', topics: ['entropy', 'thermodynamics'], title: 'Entropy', extract: 'Entropy is a scientific concept associated with disorder.'),
        MemoryBlock(timestamp: now, source: 'synthesis', topics: ['entropy', 'information'], insight: 'Entropy links heat and information.'),
        MemoryBlock(timestamp: now, source: 'net', topics: ['volcano'], title: 'Volcano'), // unrelated
        // private: another person's chat, stored in shared memory without an owner
        MemoryBlock(timestamp: now, source: 'chat', topics: ['entropy'], userText: 'my secret entropy diary', botText: 'noted'),
      ]);

      // conversations: an old one of mine on the subject, then 8 newer ones (already live history)
      await ConversationTurn.db.insertRow(session, ConversationTurn(authUserId: me, userText: 'I was reading about entropy yesterday', botText: 'What caught your eye?', timestamp: now));
      for (var i = 0; i < 8; i++) { // newer than the prompt's live history
        await ConversationTurn.db.insertRow(session, ConversationTurn(authUserId: me, userText: 'entropy again $i', botText: 'ok', timestamp: now));
      }
      await ConversationTurn.db.insertRow(session, ConversationTurn(authUserId: someoneElse, userText: 'entropy is my password', botText: 'hm', timestamp: now));

      await LexiconEntry.db.insertRow(session, LexiconEntry(word: 'entropy', understood: true, definition: 'lack of order or predictability', learnedAt: now));

      final r = await MemoryRecallService.recall(session, me, ['what', 'is', 'entropy']);

      expect(r.digested.single, contains('What is entropy?'));
      expect(r.knowledge, hasLength(2));
      expect(r.knowledge.join(), allOf(contains('Entropy is a scientific concept'), contains('heat and information')));
      expect(r.knowledge.join(), isNot(contains('Volcano')));
      expect(r.pastChats.single, contains('reading about entropy yesterday'));
      expect(r.definitions.single, contains('lack of order'));

      final everything = r.toPromptLines().join('\n');
      expect(everything, isNot(contains('secret entropy diary')));
      expect(everything, isNot(contains('password')));
    });

    test('when the message is only question words then recall is empty rather than random', () async {
      final session = sessionBuilder.build();
      await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', topics: ['what'], title: 'What (song)'));
      final r = await MemoryRecallService.recall(session, me, ['nothing', 'here']);
      expect(r.isEmpty, isTrue);
    });
  });
}
