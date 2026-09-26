import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/mind_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Mind endpoint', (sessionBuilder, endpoints) {
    test(
      'when calling `getMind` for the first time then it creates and returns the default singleton row',
      () async {
        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.id, 1);
        expect(mind.mood, 'dormant');
        expect(mind.curiosity, 0.2);
        expect(mind.confidence, 0.5);
        expect(mind.digest.totalTopics, 0);
      },
    );

    test(
      'when calling `getMind` twice then it returns the same persisted row, not a new one',
      () async {
        final first = await endpoints.mind.getMind(sessionBuilder);
        final second = await endpoints.mind.getMind(sessionBuilder);
        expect(second.id, first.id);
      },
    );

    test(
      'when events see and resolve topics then the digest counts each once, and resolving is permanent',
      () async {
        final session = sessionBuilder.build();
        await MindService.recordEvent(
          session,
          eventType: 'chat',
          recentTopics: ['tides', 'moon'],
          newSeenTopics: ['tides', 'moon', 'tides'],
        );
        await MindService.recordEvent(
          session,
          eventType: 'self',
          recentTopics: ['moon'],
          newSeenTopics: ['moon', 'orbit'],
          newResolvedTopics: ['moon'],
          scoreGap: 3,
        );
        // seeing an already-resolved topic again must not un-resolve it
        final mind = await MindService.recordEvent(
          session,
          eventType: 'chat',
          recentTopics: ['moon'],
          newSeenTopics: ['moon'],
        );

        expect(mind.digest.totalTopics, 3);
        expect(mind.digest.answeredTopics, 1);
        expect(mind.digest.backlog, 2);
        expect(mind.digest.percent, 33);
        expect(await MindTopic.db.count(session), 3);
      },
    );
  });
}
