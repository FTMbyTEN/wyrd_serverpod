import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/local_brain_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given WYRD\'s own brain (no API)', (sessionBuilder, endpoints) {
    const meId = '12121212-1212-4121-8121-121212121212';
    final me = UuidValue.fromString(meId);
    final authed = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));

    Future<LocalAnswer?> ask(Session s, String text, {List<String> facts = const []}) =>
        LocalBrainService.answer(s, authUserId: me, text: text, thread: null, facts: facts);

    test('word meanings come from its own dictionary', () async {
      final s = sessionBuilder.build();
      await WordSense.db.insertRow(s, WordSense(lemma: 'entropy', pos: 'n', rank: 0, tagCount: 3, definition: 'a measure of the disorder of a system', synonyms: const ['entropy', 'randomness'], hypernym: 'physical_property'));
      final a = await ask(s, 'What is entropy?');
      expect(a?.kind, 'definition');
      expect(a!.text, contains('a measure of the disorder of a system'));
      expect(a.text, contains('physical property'));
      // small talk and unknown words are left for real conversation
      expect(await ask(s, "What's up?"), isNull);
      expect(await ask(s, 'What is your name?'), isNull);
      expect(await ask(s, 'What is flibbertigibbetzz?'), isNull);
      expect(await ask(s, 'How do I fix my bike chain when it keeps slipping?'), isNull);
    });

    test('places, capitals and what it knows about you', () async {
      final s = sessionBuilder.build();
      final kenya = await ask(s, 'Where is Kenya?');
      expect(kenya?.action?.type, 'open_world_map');
      expect(kenya!.text, contains('Nairobi'));
      expect((await ask(s, 'What is the capital of France?'))!.text, 'The capital of France is Paris.');
      expect((await ask(s, "What's my name?", facts: ['Name: Dana']))!.text, "You're Dana.");
      expect((await ask(s, "What's my name?"))!.text, contains("haven't told me"));
    });

    test('continue and the library work without anything read yet', () async {
      final s = sessionBuilder.build();
      expect((await ask(s, 'continue'))!.text, contains("haven't started reading"));
      expect((await ask(s, 'my library'))!.text, contains('empty'));
      final now = DateTime.now().toUtc();
      await ReadingItem.db.insertRow(s, ReadingItem(authUserId: me, url: 'https://www.gutenberg.org/cache/epub/205/pg205.txt', title: 'Walden', kind: 'book', nextOffset: null, total: 100, startedAt: now, updatedAt: now));
      expect((await ask(s, 'my library'))!.text, contains('"Walden" (100%)'));
      expect((await ask(s, 'continue reading Walden'))!.text, contains('reached the end of "Walden"'));
      expect(await endpoints.library.list(authed), hasLength(1));
    });

    test('chat answers from its own brain without an AI, and says so', () async {
      final reply = await endpoints.chat.sendMessage(authed, 'What is the capital of Japan?');
      expect(reply.reply, 'The capital of Japan is Tokyo.');
      expect(reply.fromMemory, isTrue);
      expect(reply.action?.type, 'open_world_map');
    });
  });
}
