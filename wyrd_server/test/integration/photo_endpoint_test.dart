import 'dart:convert';

import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Photo endpoint', (sessionBuilder, endpoints) {
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '55555555-5555-4555-8555-555555555555',
        {},
      ),
    );

    test(
      'when no LLM is configured then it falls back to the honest "could not make it out" reply, '
      'still storing a photo memory block and updating Mind',
      () async {
        final fakeJpegBase64 = base64Encode(utf8.encode('not a real jpeg, just test bytes'));
        final result = await endpoints.photo.describe(authed, fakeJpegBase64, caption: 'check my outfit');

        expect(result.reply, contains("couldn't make out"));
        expect(result.mind.lastEvent, 'chat');

        final blocks = await endpoints.memory.getMemory(sessionBuilder);
        expect(blocks, hasLength(1));
        expect(blocks.single.source, 'photo');
        expect(blocks.single.userText, 'check my outfit');

        final history = await endpoints.chat.getHistory(authed);
        expect(history, hasLength(1));
      },
    );

    test(
      'when the image is too large then it throws',
      () async {
        final huge = 'A' * (7 * 1024 * 1024);
        expect(
          () => endpoints.photo.describe(authed, huge),
          throwsException,
        );
      },
    );
  });
}
