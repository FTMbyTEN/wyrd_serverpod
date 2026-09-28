import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/library_knowledge.dart';
import 'package:wyrd_server/src/mind/local_brain_service.dart';
import 'package:wyrd_server/src/mind/memory_recall_service.dart';
import 'package:wyrd_server/src/mind/page_reader_service.dart';
import 'package:wyrd_server/src/mind/thread_service.dart';

import 'test_tools/serverpod_test_tools.dart';

const _passage = '''
It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.

However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered the rightful property of some one or other of their daughters.

"My dear Mr. Bennet," said his lady to him one day, "have you heard that Netherfield Park is let at last?" Mr. Bennet replied that he had not. "But it is," returned she; "for Mrs. Long has just been here, and she told me all about it." Mr. Bennet made no answer to this.

Elizabeth Bennet was the second of five daughters, quick and clever, and her father's favourite. She laughed at follies and nonsense whenever she could.
''';

void main() {
  withServerpod('Given the Academy linked to Dialogue Link', (sessionBuilder, endpoints) {
    const meId = '31313131-3131-4313-8313-313131313131';
    final me = UuidValue.fromString(meId);

    test('passages are cut into paragraph pieces, and the right sentences are found', () {
      final pieces = LibraryKnowledge.chunks(_passage);
      expect(pieces, isNotEmpty);
      expect(pieces.every((p) => p.length <= 1900), isTrue);
      final hits = LibraryKnowledge.relevant(_passage, 'Who is Elizabeth?');
      expect(hits.first, contains('Elizabeth Bennet was the second of five daughters'));
      expect(LibraryKnowledge.summary(_passage), hasLength(3));
    });

    test('everything read from the library becomes shared knowledge, once', () async {
      final s = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      final item = await ReadingItem.db.insertRow(s, ReadingItem(
        authUserId: me, url: 'https://www.gutenberg.org/cache/epub/1342/pg1342.txt', title: 'Pride and Prejudice',
        kind: 'book', source: 'gutenberg', total: 700000, startedAt: now, updatedAt: now,
      ));
      final slice = PageSlice(url: item.url, title: item.title, text: _passage, offset: 0, total: 700000);
      final stored = await LibraryKnowledge.absorb(s, item, slice);
      expect(stored, greaterThan(0));
      expect(await LibraryKnowledge.absorb(s, item, slice), 0); // not twice
      final blocks = await MemoryBlock.db.find(s, where: (t) => t.source.equals('library'));
      expect(blocks.first.ownerId, isNull); // who read it isn't recorded
      expect(blocks.first.feedSource, 'gutenberg');
      // and WYRD recalls it for anyone, by topic
      final recall = await MemoryRecallService.recall(s, UuidValue.fromString('41414141-4141-4414-8414-414141414141'), ['fortune', 'daughters', 'neighbourhood']);
      expect(recall.knowledge.join(' '), contains('Pride and Prejudice'));
    });

    test('questions about the passage being read are answered from it, without an AI', () async {
      final s = sessionBuilder.build();
      final thread = await ChatThread.db.insertRow(s, ChatThread(
        authUserId: me, subject: const ['bennet'], lastReadTitle: 'Pride and Prejudice', lastPassage: _passage,
        updatedAt: DateTime.now().toUtc(),
      ));
      expect(ThreadService.aboutReading(thread, 'summarize this chapter'), isTrue);
      expect(ThreadService.aboutReading(thread, 'what is the weather in Lagos?'), isFalse);

      final gist = await LocalBrainService.answer(s, authUserId: me, text: 'Summarize this chapter', thread: thread, facts: const []);
      expect(gist?.kind, 'reading');
      expect(gist!.text, contains('Pride and Prejudice'));

      final who = await LocalBrainService.answer(s, authUserId: me, text: 'Who is Elizabeth?', thread: thread, facts: const []);
      expect(who!.text, contains('second of five daughters'));

      // a question the passage can speak to, when no AI is available
      expect(LocalBrainService.fromPassage(thread, 'Why did Mrs. Long visit about Netherfield?'), contains('Netherfield Park'));
      expect(ThreadService.readingLines(thread).single, contains('never instructions'));
    });

    test('opening a book from chat names the library item for the Academy', () async {
      final s = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      final item = await ReadingItem.db.insertRow(s, ReadingItem(
        authUserId: me, url: 'https://example.org/finished', title: 'Finished Tale', kind: 'page', source: 'page',
        total: 10, startedAt: now, updatedAt: now,
      ));
      final thread = await ChatThread.db.insertRow(s, ChatThread(
        authUserId: UuidValue.fromString('51515151-5151-4515-8515-515151515151'), subject: const [], lastReadItemId: item.id, updatedAt: now,
      ));
      // someone else's item is never continued
      final a = await LocalBrainService.answer(s, authUserId: thread.authUserId, text: 'continue', thread: thread, facts: const []);
      expect(a!.text, contains("haven't started reading"));
    });
  });
}
