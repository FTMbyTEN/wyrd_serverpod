@Tags(['network'])
library;

import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Drives every Academy endpoint against the real libraries (Gutenberg, OpenStax, Wikisource):
/// search, open, read on, jump to a section, show again, contents, quiz, remove -- and chat's
/// book finding. Needs the internet; run with `dart test -t network`.
void main() {
  withServerpod('Given the Academy against the real libraries', (sessionBuilder, endpoints) {
    const meId = '71717171-7171-4717-8717-717171717171';
    final me = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));

    test('the Stacks: search Gutenberg, open, read on, show again, quiz, remove', () async {
      final hits = await endpoints.library.searchBooks(me, 'Pride and Prejudice');
      expect(hits, isNotEmpty);
      final first = await endpoints.library.openWork(me, 'gutenberg', hits.first.id);
      expect(first, isNotNull);
      expect(first!.text.length, greaterThan(1000));
      expect(first.text.contains(RegExp(r'[a-z]\n[a-z]')), isFalse, reason: 'hard line wraps rejoined');
      final next = await endpoints.library.readOn(me, first.item.id!, restart: false);
      expect(next.offset, greaterThan(first.offset));
      final again = await endpoints.library.current(me, first.item.id!);
      expect(again.text, next.text);
      final quiz = await endpoints.library.quiz(me, first.item.id!, next.text);
      expect(quiz.length, greaterThanOrEqualTo(3));
      final stats = await endpoints.library.quizDone(me, first.item.id!, 2, quiz.length, [quiz.first.keyword]);
      expect(stats.rounds, 1);
      await endpoints.library.remove(me, first.item.id!);
      expect((await endpoints.library.list(me)).where((i) => i.id == first.item.id), isEmpty);
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('the Lecture Hall: textbooks, open, contents, jump to a section', () async {
      final books = await endpoints.library.textbooks(me);
      expect(books.length, greaterThan(50));
      final physics = books.firstWhere((b) => b.title == 'College Physics 2e');
      final open = await endpoints.library.openWork(me, 'openstax', physics.id);
      expect(open!.item.partCount, greaterThan(100));
      final toc = await endpoints.library.contents(me, open.item.id!);
      expect(toc.length, open.item.partCount);
      final jumped = await endpoints.library.readOn(me, open.item.id!, restart: false, part: 5);
      expect(jumped.item.partIndex, 5);
      expect(jumped.text, isNotEmpty);
      expect(jumped.text, isNot(contains('<')));
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('the Archive: Wikisource in French, open, read on', () async {
      final hits = await endpoints.library.searchWikisource(me, 'fr', 'Les Misérables');
      expect(hits, isNotEmpty);
      final open = await endpoints.library.openWork(me, 'wikisource', hits.first.id);
      expect(open!.text, isNotEmpty);
      final on = await endpoints.library.readOn(me, open.item.id!, restart: false);
      expect(on.text, isNotEmpty);
      expect(await endpoints.library.wikisourceLanguages(me), hasLength(15));
    }, timeout: const Timeout(Duration(minutes: 3)));

    test('chat: finds a physics textbook and a French classic, and continues', () async {
      final physics = await endpoints.chat.sendMessage(me, 'find me a physics textbook');
      expect(physics.action?.type, 'open_book');
      expect(physics.reply, contains('OpenStax'));
      final french = await endpoints.chat.sendMessage(me, 'find Les Misérables in French');
      expect(french.action?.type, 'open_book');
      final more = await endpoints.chat.sendMessage(me, 'continue');
      expect(more.reply, startsWith('Picking up'));
      final gist = await endpoints.chat.sendMessage(me, 'summarize this chapter');
      expect(gist.reply, contains('gist'));
    }, timeout: const Timeout(Duration(minutes: 4)));
  });
}
