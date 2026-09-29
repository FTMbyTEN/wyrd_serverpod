import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/concept_filter.dart';
import 'package:wyrd_server/src/mind/lexicon_service.dart';
import 'package:wyrd_server/src/mind/wordnet_service.dart';

import 'test_tools/serverpod_test_tools.dart';

// The real WordNet lines for these words (as built into web/data/wordnet.tsv.gz).
const _lines = [
  'code	noun	2	2	(computer science) the symbolic arrangement of data or instructions in a computer program or the set of such instructions			coding system',
  'software	noun	0	0	(computer science) written programs or procedures or rules and associated documentation pertaining to the operation of a computer system and that are stored in read/write memory	the market for software is expected to expand	package	code',
  'llm	noun	0	0	an advanced law degree			law degree',
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

    test('extended Lesk: the meanings of the surrounding words decide, and an unrelated rare sense is rejected', () async {
      final session = sessionBuilder.build();
      await WordNetService.importLines(session, _lines);
      // none of these context words appear in either sense of programming; their meanings do
      final p = await WordNetService.define(session, 'programming', context: ['code', 'software', 'rust', 'languages']);
      expect(p!.definition, startsWith('Creating a sequence of instructions'));
      final ai = ['model', 'language', 'software', 'code', 'agents', 'token', 'inference', 'openai', 'benchmark', 'training', 'prompt', 'compute'];
      expect(await WordNetService.define(session, 'llms', context: ai), isNull);
      expect(await WordNetService.define(session, 'llms'), isNotNull); // with no context, the only sense stands
    });

    test('once WordNet is loaded, the lexicon learns locally and relearns old words with the right sense', () async {
      final session = sessionBuilder.build();
      await WordNetService.importLines(session, _lines);
      await MaintenanceRun.db.insertRow(session, MaintenanceRun(name: 'wordnet-3.1-s4', ranAt: DateTime.now().toUtc()));
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
      final lines = const LineSplitter().convert(utf8.decode(gzip.decode(File('web/data/wordnet.tsv.gz').readAsBytesSync())));
      final n = await WordNetService.importLines(session, lines);
      expect(n, greaterThan(100000));
      expect(await WordSense.db.count(session), n);
      // with the real data, context picks the everyday meaning WYRD actually meets
      final p = await WordNetService.define(session, 'programming', context: ['code', 'software', 'languages', 'rust']);
      expect(p!.definition, contains('computer'));
      final bank = await WordNetService.define(session, 'bank', context: ['river', 'water', 'fishing']);
      expect(bank!.definition.toLowerCase(), contains('slop'));
      // and WYRD's concept filter sees the real nouns, names, and what isn't a concept
      await ConceptFilter.load(session);
      for (final w in ['language', 'coral', 'temperature', 'motel', 'nvidia']) {
        expect(ConceptFilter.isConcept(w), isTrue, reason: w);
      }
      for (final w in ['feared', 'toward', 'behaviorally', 'seemed', 'weird']) {
        expect(ConceptFilter.isConcept(w), isFalse, reason: w);
      }
    }, timeout: const Timeout(Duration(minutes: 5)));
  });
}
