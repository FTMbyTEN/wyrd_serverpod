import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/ingest_filter.dart';
import 'package:wyrd_server/src/mind/memory_recall_service.dart';
import 'package:wyrd_server/src/mind/topic_service.dart';
import 'package:wyrd_server/src/mind/trust_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Bias 2 (learned trust)', (sessionBuilder, endpoints) {
    const meId = '78787878-7878-4787-8787-787878787878';
    final me = UuidValue.fromString(meId);
    final alice = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));

    test('trust starts neutral and moves only as evidence builds', () {
      expect(TrustService.scoreOf(0, 0), 0.5);
      expect(TrustService.scoreOf(1, 0), closeTo(2 / 3, 1e-9));
      expect(TrustService.scoreOf(8, 0), closeTo(0.9, 1e-9));
      expect(TrustService.scoreOf(0, 3), closeTo(0.2, 1e-9));
      expect(TrustService.sourceKey(url: 'https://www.example.org/a'), 'example.org');
      expect(TrustService.sourceKey(url: 'https://news.ycombinator.com/item?id=1'), 'hackernews');
      expect(TrustService.sourceKey(feedSource: 'wikipedia'), 'wikipedia');
    });

    test('the filter learns to doubt a spammy site, and then its borderline items stop getting in', () async {
      final session = sessionBuilder.build();
      Future<IngestVerdict> judge(String title, String extract, String url) => IngestFilter.judge(session,
          source: 'hackernews', title: title, extract: extract, url: url, topics: TopicService.extractTopics('$title. $extract'));

      // a borderline, title-only item from an unknown site gets in at first
      const borderline = 'Mapping coral reef ecosystems with underwater drones';
      expect((await judge(borderline, '', 'https://spammy.example/1')).keep, isTrue);
      // the same site keeps sending junk
      for (var i = 0; i < 4; i++) {
        await judge('Buy now: limited offer $i', 'Click here for your promo code', 'https://spammy.example/ad$i');
      }
      expect(await TrustService.scoreFor(session, TrustService.source, 'spammy.example'), lessThan(0.3));
      final later = await judge('Charting deep ocean trenches with sonar robots', '', 'https://spammy.example/2');
      expect(later.keep, isFalse);
      expect(later.reasons, contains('from a source WYRD has learned to doubt'));
      // a site with a clean record still gets the same kind of item in
      expect((await judge('Charting deep ocean trenches with sonar robots', '', 'https://good.example/2')).keep, isTrue);
    });

    test('a rating reaches the sources that grounded the reply and the topics asked about', () async {
      final session = sessionBuilder.build();
      await established(session, meId);
      final now = DateTime.now().toUtc();
      await MemoryBlock.db.insertRow(session, MemoryBlock(
        timestamp: now, source: 'net', feedSource: 'hackernews', title: 'Volcanoes: how magma chambers erupt',
        extract: 'Magma rises through the crust and erupts from volcanoes', url: 'https://geo.example/volcano', topics: ['volcanoes', 'magma', 'erupt'],
      ));
      final reply = await endpoints.chat.sendMessage(alice, 'Tell me about volcanoes and magma');
      final turn = (await ConversationTurn.db.findById(session, reply.turnId!))!;
      expect(turn.groundingIds, isNotEmpty);

      await endpoints.chat.rate(alice, reply.turnId!, -1);
      expect(await TrustService.scoreFor(session, TrustService.source, 'geo.example'), closeTo(1 / 3, 1e-9));
      expect(await TrustService.scoreFor(session, TrustService.topic, 'volcanoes'), lessThan(0.5));

      await endpoints.chat.rate(alice, reply.turnId!, 1); // changed their mind: +2 net
      final row = await TrustScore.db.findFirstRow(session, where: (t) => t.key.equals('geo.example'));
      expect(row!.good, 2);
      expect(row.bad, 1);
    });

    test('recall prefers the trusted source when two memories match equally well', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await MemoryBlock.db.insert(session, [
        MemoryBlock(timestamp: now, source: 'net', title: 'Doubted take on glaciers', url: 'https://doubted.example/g', topics: ['glaciers', 'ice']),
        MemoryBlock(timestamp: now, source: 'net', title: 'Trusted take on glaciers', url: 'https://trusted.example/g', topics: ['glaciers', 'ice']),
        MemoryBlock(timestamp: now, source: 'net', title: 'Third glacier piece', url: 'https://neutral.example/g', topics: ['glaciers', 'ice']),
        MemoryBlock(timestamp: now, source: 'net', title: 'Fourth glacier piece', url: 'https://neutral2.example/g', topics: ['glaciers', 'ice']),
      ]);
      await TrustService.record(session, TrustService.source, 'trusted.example', 6);
      await TrustService.record(session, TrustService.source, 'doubted.example', -6);
      final r = await MemoryRecallService.recall(session, me, ['glaciers', 'ice']);
      expect(r.knowledge.first, startsWith('Trusted take'));
      expect(r.knowledge, isNot(contains(startsWith('Doubted take')))); // only the top 3 make it
    });

    test('the report lists what WYRD trusts and doubts, once there is evidence', () async {
      final session = sessionBuilder.build();
      await TrustService.record(session, TrustService.source, 'wikipedia', 5);
      await TrustService.record(session, TrustService.source, 'tabloid.example', -4);
      await TrustService.record(session, TrustService.topic, 'rust', 3);
      await TrustService.record(session, TrustService.source, 'barely.example', 1); // not enough evidence yet
      final r = await endpoints.feed.getTrust(sessionBuilder);
      expect(r.trustedSources.map((s) => s.key), ['wikipedia']);
      expect(r.doubtedSources.map((s) => s.key), ['tabloid.example']);
      expect(r.trustedTopics.map((s) => s.key), ['rust']);
      expect(r.tracked, 4);
    });
  });
}

/// Makes [id] an established account, so its ratings count in full (new ones count half).
Future<void> established(Session s, String id) async {
  final uid = UuidValue.fromString(id);
  final old = DateTime.now().toUtc().subtract(const Duration(days: 10));
  final p = await UserProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(uid));
  if (p == null) {
    await UserProfile.db.insertRow(s, UserProfile(authUserId: uid, facts: const [], visitCount: 1, firstSeen: old, lastSeen: old));
  } else {
    await UserProfile.db.updateRow(s, p.copyWith(firstSeen: old));
  }
}
