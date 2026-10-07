import 'package:wyrd_server/src/mind/owner_guard.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/lexicon_service.dart';

import 'test_tools/serverpod_test_tools.dart';

// Only the paths that stop before the dictionary API is called -- the tests stay offline.
void main() {
  withServerpod('Given the lexicon tick', (sessionBuilder, endpoints) {
    setUpAll(() => OwnerGuard.openForTesting = true);
    tearDownAll(() => OwnerGuard.openForTesting = false);
    tearDown(() => LexiconService.dictionaryForTesting = null);

    test(
      'when no recent topic is a dictionary word then nothing is learned',
      () async {
        LexiconService.dictionaryForTesting = {'harbor'};
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            topics: ['xqzv', 'blorp'],
          ),
        );
        expect(await endpoints.lexicon.trigger(sessionBuilder), isFalse);
        expect(await LexiconEntry.db.count(session), 0);
      },
    );

    test(
      'when every candidate word is already in the lexicon then nothing is learned',
      () async {
        LexiconService.dictionaryForTesting = {'harbor'};
        final session = sessionBuilder.build();
        await MemoryBlock.db.insertRow(
          session,
          MemoryBlock(
            timestamp: DateTime.now().toUtc(),
            source: 'net',
            topics: ['harbor'],
          ),
        );
        await LexiconEntry.db.insertRow(
          session,
          LexiconEntry(
            word: 'harbor',
            understood: true,
            learnedAt: DateTime.now().toUtc(),
          ),
        );
        expect(await endpoints.lexicon.trigger(sessionBuilder), isFalse);
        expect(await LexiconEntry.db.count(session), 1);
      },
    );
  });
}
