import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/lexicon_service.dart';
import 'package:wyrd_server/src/mind/wordnet_service.dart';

import 'test_tools/serverpod_test_tools.dart';

// The real WordNet lines for these words (as built into data/wordnet.tsv.gz).
const _lines = [
  'programming\tnoun\t0\t1\tsetting an order and time for planned events\t\tscheduling,programing\tplanning',
  'programming\tnoun\t1\t1\tcreating a sequence of instructions to enable the computer to do something\t\tprograming\tcreating by mental acts',
  'language\tnoun\t0\t5\ta systematic means of communicating by the use of sounds or conventional symbols\the taught foreign languages\t\tcommunication',
  'bank\tnoun\t0\t20\tsloping land (especially the slope beside a body of water)\tthey pulled the canoe up on the bank\t\tslope',
  'bank\tnoun\t1\t20\ta financial institution that accepts deposits and channels the money into lending activities\the cashed a check at the bank\tdepository financial institution,banking company\tfinancial institution',
];

void main() {
  withServerpod('Given WordNet', (sessionBuilder, endpoints) {
    test('base forms find the dictionary word', () {
      expect(WordNetService.baseForms('languages'), contains('language'));
      expect(WordNetService.baseForms('studies'), contains('study'));
      expect(WordNetService.baseForms('coding'), containsAll(['code', 'cod']));
    });

    test('Lesk picks the sense that fits what WYRD read around the word', () async {
      final session = sessionBuilder.build();
      await WordNetService.importLines(session, _lines);

      final code = await WordNetService.define(session, 'programming', context: ['computer', 'languages', 'code', 'instructions']);
      expect(code!.definition, startsWith('Creating a sequence of instructions'));

      final river = await WordNetService.define(session, 'bank', context: ['river', 'water', 'canoe']);
      expect(river!.definition, startsWith('Sloping land'));
      final money = await WordNetService.define(session, 'banks', context: ['money', 'deposits', 'lending']);
      expect(money!.definition, startsWith('A financial institution'));
      expect(money.lemma, 'bank');

      expect(await WordNetService.define(session, 'zzqx'), isNull);
    });

    test('once WordNet is loaded, the lexicon learns locally and relearns old words with the right sense', () async {
      final session = sessionBuilder.build();
      await WordNetService.importLines(session, _lines);
      await MaintenanceRun.db.insertRow(session, MaintenanceRun(name: 'wordnet-3.1', ranAt: DateTime.now().toUtc()));
      final now = DateTime.now().toUtc();
      // learned earlier from the web with the wrong sense
      await LexiconEntry.db.insertRow(session, LexiconEntry(word: 'programming', understood: true, definition: 'The designing of a radio or television programme.', partOfSpeech: 'noun', learnedAt: now));
      await MemoryBlock.db.insertRow(session, MemoryBlock(timestamp: now, source: 'net', title: 'Rust', topics: ['programming', 'languages', 'computer', 'instructions']));

      expect(await LexiconService.tick(session), isTrue); // relearn pass
      final fixed = await LexiconEntry.db.findFirstRow(session, where: (t) => t.word.equals('programming'));
      expect(fixed!.definition, startsWith('Creating a sequence of instructions'));

      while (await LexiconService.tick(session)) {} // relearn finishes, then learning from memory
      final learned = await LexiconEntry.db.findFirstRow(session, where: (t) => t.word.equals('languages'));
      expect(learned!.understood, isTrue);
      expect(learned.definition, contains('communicating'));
    });

    test('the shipped data file imports completely', () async {
      final session = sessionBuilder.build();
      final lines = const LineSplitter().convert(utf8.decode(gzip.decode(File('data/wordnet.tsv.gz').readAsBytesSync())));
      final n = await WordNetService.importLines(session, lines);
      expect(n, greaterThan(100000));
      expect(await WordSense.db.count(session), n);
    }, timeout: const Timeout(Duration(minutes: 5)));
  });
}
