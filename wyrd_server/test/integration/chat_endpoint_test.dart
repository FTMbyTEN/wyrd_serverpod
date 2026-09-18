import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Chat endpoint', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '22222222-2222-4222-8222-222222222222',
        {},
      ),
    );

    test(
      'when sending an empty message then it throws',
      () async {
        expect(
          () => endpoints.chat.sendMessage(authed, '   '),
          throwsException,
        );
      },
    );

    test(
      'when sending a message without an LLM configured then it falls back to a template reply, '
      'persists a memory block, and updates Mind',
      () async {
        final reply = await endpoints.chat.sendMessage(authed, 'I love hiking in the mountains');
        expect(reply.reply, isNotEmpty);
        expect(reply.mind.lastEvent, 'chat');

        final blocks = await endpoints.memory.getMemory(sessionBuilder);
        expect(blocks, hasLength(1));
        expect(blocks.single.source, 'chat');

        final history = await endpoints.chat.getHistory(authed);
        expect(history, hasLength(1));
        expect(history.single.userText, 'I love hiking in the mountains');
      },
    );

    test(
      'when a message states a personal fact then it is extracted onto the profile',
      () async {
        await endpoints.chat.sendMessage(authed, 'my name is Riley');
        final profile = await endpoints.profile.getProfile(authed);
        expect(profile.facts.any((f) => f.text == 'Name: Riley'), isTrue);
      },
    );
  });
}
