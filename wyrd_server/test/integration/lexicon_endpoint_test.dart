import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Lexicon endpoint', (sessionBuilder, endpoints) {
    test(
      'when no words exist then getStats returns zeroed counts and getWord returns null',
      () async {
        final stats = await endpoints.lexicon.getStats(sessionBuilder);
        expect(stats.learned, 0);
        expect(stats.attempted, 0);
        expect(stats.recentWords, isEmpty);

        final word = await endpoints.lexicon.getWord(sessionBuilder, 'ephemeral');
        expect(word, isNull);
      },
    );

    test(
      'when a word has been learned then getStats counts it and getWord (case-insensitively) finds it',
      () async {
        final session = sessionBuilder.build();
        await LexiconEntry.db.insertRow(
          session,
          LexiconEntry(
            word: 'ephemeral',
            understood: true,
            definition: 'lasting for a very short time',
            partOfSpeech: 'adjective',
            learnedAt: DateTime.now().toUtc(),
          ),
        );
        await LexiconEntry.db.insertRow(
          session,
          LexiconEntry(
            word: 'xyzzy',
            understood: false,
            learnedAt: DateTime.now().toUtc(),
          ),
        );

        final stats = await endpoints.lexicon.getStats(sessionBuilder);
        expect(stats.learned, 1);
        expect(stats.attempted, 2);
        expect(stats.recentWords.single.word, 'ephemeral');

        final word = await endpoints.lexicon.getWord(sessionBuilder, 'EPHEMERAL');
        expect(word, isNotNull);
        expect(word!.definition, 'lasting for a very short time');
      },
    );
  });
}
