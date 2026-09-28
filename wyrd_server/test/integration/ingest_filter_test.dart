import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/ingest_filter.dart';
import 'package:wyrd_server/src/mind/topic_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the ingest filter', (sessionBuilder, endpoints) {
    Future<IngestVerdict> judge(String title, String extract, {String? url}) => IngestFilter.judge(
          sessionBuilder.build(),
          source: 'hackernews',
          title: title,
          extract: extract,
          url: url,
          topics: TopicService.extractTopics('$title. $extract'),
        );

    test('real articles are kept and sorted; spam, boilerplate and empty items are quarantined', () async {
      final good = await judge('A new Rust compiler backend cuts build times',
          'The team rewrote code generation for the compiler, and developers report faster builds on large projects.');
      expect(good.keep, isTrue);
      expect(good.category, 'tech');
      expect(good.score, greaterThan(0.9));

      final space = await judge('Astronomers map dark matter around distant galaxy clusters',
          'Researchers used gravitational lensing data from a space telescope to chart the dark matter between galaxy clusters.');
      expect(space.keep, isTrue);
      expect(space.category, 'science');

      final spam = await judge('Buy now: limited offer on crypto giveaway', 'Click here to claim your promo code today.');
      expect(spam.keep, isFalse);
      expect(spam.reasons, contains('spam or advertising'));

      final wall = await judge('Just a moment', 'Please enable JavaScript and accept cookies. Verify you are human.');
      expect(wall.keep, isFalse);
      expect(wall.reasons, contains('boilerplate, not content'));

      final empty = await judge('Hmm', '');
      expect(empty.keep, isFalse);
      expect(empty.reasons, contains('no real ideas in it'));

      // a link post with only a meaningful title is kept, just scored lower
      final linkOnly = await judge('Mapping the human brain connectome at synapse resolution', '');
      expect(linkOnly.keep, isTrue);
      expect(linkOnly.score, lessThan(1));
    });

    test('duplicates are recognised by link, title and near-identical title', () async {
      final session = sessionBuilder.build();
      await MemoryBlock.db.insertRow(session, MemoryBlock(
        timestamp: DateTime.now().toUtc(), source: 'net', feedSource: 'hackernews',
        title: 'Show HN: A tiny database in 500 lines', url: 'https://example.com/db', topics: ['database'],
      ));
      expect((await judge('Different title', 'text about databases and storage engines', url: 'https://example.com/db')).duplicate, isTrue);
      expect((await judge('Show HN: A tiny database in 500 lines', 'x', url: 'https://other.example/x')).duplicate, isTrue);
      expect((await judge('Show HN – a tiny database in 500 lines!', 'x')).duplicate, isTrue);
      expect((await judge('A tiny web server in 300 lines of C', 'how the event loop and sockets work')).duplicate, isFalse);
    });

    test('the daily report counts decisions and lists what was kept out, and why', () async {
      await judge('A new Rust compiler backend cuts build times', 'The team rewrote code generation for the compiler for developers.');
      // the feed stores what's kept
      await MemoryBlock.db.insertRow(sessionBuilder.build(), MemoryBlock(timestamp: DateTime.now().toUtc(), source: 'net', title: 'A new Rust compiler backend cuts build times', topics: ['rust']));
      await judge('A new Rust compiler backend cuts build times', 'again');
      await judge('Buy now: limited offer on crypto giveaway', 'Click here to claim your promo code today.');
      final r = await endpoints.feed.getFilterReport(sessionBuilder);
      expect(r.kept, 1);
      expect(r.duplicates, 1);
      expect(r.quarantined, 1);
      expect(r.reasons['spam or advertising'], 1);
      expect(r.categories['tech'], 1);
      expect(r.recent.single.title, startsWith('Buy now'));
    });
  });
}
