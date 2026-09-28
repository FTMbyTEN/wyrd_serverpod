import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/page_reader_service.dart';
import 'package:wyrd_server/src/mind/thread_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given conversation continuity', (sessionBuilder, endpoints) {
    const meId = '90909090-9090-4909-8909-909090909090';
    final me = UuidValue.fromString(meId);
    final alice = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));

    test('follow-ups are recognised; standalone questions are not', () {
      expect(ThreadService.isFollowUp('What is entropy?'), isFalse); // short, but names its subject
      for (final t in ['Tell me more', 'and its population?', 'continue', 'What about the second one?', 'why?', 'Is it safe?', 'go on']) {
        expect(ThreadService.isFollowUp(t), isTrue, reason: t);
      }
      for (final t in ['What is the population of Lagos, Nigeria?', 'Explain how photosynthesis converts light into sugar']) {
        expect(ThreadService.isFollowUp(t), isFalse, reason: t);
      }
      expect(ThreadService.isFollowUp('Tell me more', hasHistory: false), isFalse); // nothing to continue
    });

    test('the thread subject favours the latest exchange and what the person asked', () {
      final now = DateTime.now().toUtc();
      final turns = [
        ConversationTurn(authUserId: me, userText: 'Tell me about volcanoes in Iceland', botText: 'Iceland sits on a rift, so magma rises easily.', timestamp: now),
        ConversationTurn(authUserId: me, userText: 'I like pizza', botText: 'Pizza is great', timestamp: now),
      ];
      final t = ThreadService.threadTopics(turns);
      expect(t.first, anyOf('volcanoes', 'iceland'));
      expect(t.indexOf('pizza'), greaterThan(t.indexOf('volcanoes')));
    });

    test('"tell me more about it" recalls what the conversation was about, and never uses a learned answer', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await MemoryBlock.db.insertRow(session, MemoryBlock(
        timestamp: now, source: 'net', feedSource: 'wikipedia', title: 'Eyjafjallajokull',
        extract: 'The 2010 eruption of the Icelandic volcano grounded flights across Europe', url: 'https://w.example/e', topics: ['volcano', 'iceland', 'eruption'],
      ));
      // a learned answer that would wrongly match the bare follow-up "and the eruption?"
      await LearnedAnswer.db.insertRow(session, LearnedAnswer(
        question: 'What is an eruption?', intent: 'what', topics: ['eruption'], answer: 'An eruption is a generic release of material.',
        score: 3, uses: 0, version: 1, retired: false, createdAt: now, updatedAt: now,
      ));
      await ConversationTurn.db.insertRow(session, ConversationTurn(
        authUserId: me, userText: 'Tell me about the volcano in Iceland', botText: 'Iceland has many volcanoes.', timestamp: now));

      final r = await endpoints.chat.sendMessage(alice, 'and what was the eruption like?');
      expect(r.fromMemory, isNot(isTrue)); // not the context-free learned answer
      final turn = (await ConversationTurn.db.findById(session, r.turnId!))!;
      final grounded = await MemoryBlock.db.find(session, where: (t) => t.id.inSet((turn.groundingIds ?? []).toSet()));
      expect(grounded.map((b) => b.title), contains('Eyjafjallajokull'));
    });

    test('what WYRD was reading carries over, so "continue" knows where to pick up', () async {
      final session = sessionBuilder.build();
      await ThreadService.update(session, me, subject: ['frankenstein'],
          lastRead: PageSlice(url: 'https://www.gutenberg.org/cache/epub/84/pg84.txt', title: 'Frankenstein', text: 'x' * 6000, offset: 0, total: 400000));
      final thread = await ThreadService.load(session, me);
      expect(thread!.nextOffset, 6000);
      final lines = ThreadService.promptLines(thread, followUp: true, threadTopics: const []);
      expect(lines.join(' '), contains('frankenstein'));
      expect(lines.join(' '), contains('offset 6000'));

      // a later message about something else keeps the reading position
      await ThreadService.update(session, me, subject: ['weather']);
      expect((await ThreadService.load(session, me))!.nextOffset, 6000);
    });
  });
}
