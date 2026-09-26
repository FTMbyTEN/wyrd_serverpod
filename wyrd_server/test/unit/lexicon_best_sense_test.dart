import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/lexicon_service.dart';

void main() {
  group('LexiconService.bestSense', () {
    test('prefers an everyday sense over a language code listed first ("got")', () {
      final best = LexiconService.bestSense([
        (partOfSpeech: 'symbol', definition: 'ISO 639-2 & ISO 639-3 language code for Gothic.'),
        (partOfSpeech: 'verb', definition: 'simple past and past participle of get'),
      ]);
      expect(best!.partOfSpeech, 'verb');
    });

    test('prefers current senses over obsolete ones, keeping dictionary order on ties', () {
      final best = LexiconService.bestSense([
        (partOfSpeech: 'noun', definition: '(obsolete) A kind of old armour.'),
        (partOfSpeech: 'noun', definition: 'A place of shelter for ships.'),
        (partOfSpeech: 'noun', definition: 'Any place of shelter.'),
      ]);
      expect(best!.definition, 'A place of shelter for ships.');
    });

    test('returns null when there is nothing to choose from', () {
      expect(LexiconService.bestSense([]), isNull);
    });
  });

  test('isPoorDefinition flags code/symbol senses but not real words', () {
    LexiconEntry e(String pos, String def) =>
        LexiconEntry(word: 'w', understood: true, partOfSpeech: pos, definition: def, learnedAt: DateTime.now());
    expect(LexiconService.isPoorDefinition(e('symbol', 'ISO 639-2 language code for Gothic.')), isTrue);
    expect(LexiconService.isPoorDefinition(e('verb', 'simple past of get')), isFalse);
  });
}
