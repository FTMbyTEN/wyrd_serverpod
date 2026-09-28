import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/reasoning_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given reply ratings', (sessionBuilder, endpoints) {
    const aliceId = '34343434-3434-4343-8343-343434343434';
    const bobId = '56565656-5656-4565-8565-565656565656';
    final alice = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(aliceId, {}));
    final bob = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(bobId, {}));

    test('a thumbs-down retires the learned answer behind a reply; changing your mind counts the difference', () async {
      final session = sessionBuilder.build();
      await established(session, aliceId);
      final now = DateTime.now().toUtc();
      final a = await LearnedAnswer.db.insertRow(session, LearnedAnswer(
        question: 'What is a comet?', intent: 'what', topics: ['comet'], answer: 'A comet is an icy body that grows a tail near the Sun.',
        score: 0.5, uses: 0, version: 1, retired: false, createdAt: now, updatedAt: now,
      ));
      final reply = await endpoints.chat.sendMessage(alice, 'What is a comet?');
      expect(reply.fromMemory, isTrue);
      expect(reply.turnId, isNotNull);

      await endpoints.chat.rate(alice, reply.turnId!, -1);
      var after = (await LearnedAnswer.db.findById(session, a.id!))!;
      expect(after.score, closeTo(-1.5, 1e-9));
      expect(after.retired, isTrue);
      expect((await ConversationTurn.db.findById(session, reply.turnId!))!.rating, -1);

      await endpoints.chat.rate(alice, reply.turnId!, 1); // changed their mind: -(-2) + 1
      after = (await LearnedAnswer.db.findById(session, a.id!))!;
      expect(after.score, closeTo(1.5, 1e-9));
      expect(after.retired, isFalse);

      await endpoints.chat.rate(alice, reply.turnId!, 0); // cleared
      expect((await LearnedAnswer.db.findById(session, a.id!))!.score, closeTo(0.5, 1e-9));
      expect((await ConversationTurn.db.findById(session, reply.turnId!))!.rating, isNull);

      // nobody can rate someone else's reply
      expect(() => endpoints.chat.rate(bob, reply.turnId!, 1), throwsA(anything));
    });

    test('the same article re-read many times no longer saturates a synapse', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      for (var i = 0; i < 10; i++) {
        await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'net', title: 'Same article', topics: ['motel', 'room']));
      }
      await ReasoningService.tick(session);
      final s = await Synapse.db.findFirstRow(session, where: (t) => t.a.equals('motel') & t.b.equals('room'));
      expect(s!.weight, lessThan(0.1)); // one lesson (+ at most a firing's potentiation), not ten
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
