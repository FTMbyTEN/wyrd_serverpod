import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Account endpoint', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '33333333-3333-4333-8333-333333333333',
        {},
      ),
    );

    test(
      'when exporting data for a first-time user then it returns an empty-but-real profile '
      'and conversation',
      () async {
        final export = await endpoints.account.exportData(authed);
        expect(export.visitCount, 0);
        expect(export.facts, isEmpty);
        expect(export.conversation, isEmpty);
        expect(export.email, isNull);
      },
    );

    test(
      'when sending a chat message then exporting includes it, and deleting wipes it',
      () async {
        await endpoints.chat.sendMessage(authed, 'my name is Dana');

        final export = await endpoints.account.exportData(authed);
        expect(export.conversation, hasLength(1));
        expect(export.facts.any((f) => f.text == 'Name: Dana'), isTrue);

        await endpoints.account.deleteMyData(authed);

        final afterDelete = await endpoints.account.exportData(authed);
        expect(afterDelete.conversation, isEmpty);
        expect(afterDelete.facts, isEmpty);
        expect(afterDelete.visitCount, 0);
      },
    );

    test('when deleting then photos, their memories, learned answers and the thread go too', () async {
      final session = authed.build();
      final me = UuidValue.fromString('33333333-3333-4333-8333-333333333333');
      final now = DateTime.now().toUtc();
      await Sighting.db.insertRow(session, Sighting(authUserId: me, timestamp: now, description: 'a red mug'));
      await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'chat', userText: 'hi', botText: 'hello', topics: const ['greeting'], ownerId: me));
      await ChatThread.db.insertRow(session, ChatThread(authUserId: me, subject: const ['mugs'], updatedAt: now));
      await LearnedAnswer.db.insertRow(session, LearnedAnswer(authUserId: me, question: 'q', intent: 'i', topics: const [], answer: 'a', score: 0, uses: 0, version: 1, retired: false, createdAt: now, updatedAt: now));

      final export = await endpoints.account.exportData(authed);
      expect(export.sightings, hasLength(1));
      expect(export.memories, hasLength(1));
      expect(export.learnedAnswers, hasLength(1));
      expect(export.thread, isNotNull);

      await endpoints.account.deleteMyData(authed);
      expect(await Sighting.db.count(session, where: (t) => t.authUserId.equals(me)), 0);
      expect(await MemoryBlock.db.count(session, where: (t) => t.ownerId.equals(me)), 0);
      expect(await LearnedAnswer.db.count(session, where: (t) => t.authUserId.equals(me)), 0);
      expect(await ChatThread.db.count(session, where: (t) => t.authUserId.equals(me)), 0);
    });
  });
}
