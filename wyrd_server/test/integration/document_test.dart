import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/document_service.dart';

import 'test_tools/serverpod_test_tools.dart';

const _report = '''
## Annual Water Report 2025

The city supplied 41.2 million litres of drinking water per day in 2025, up from 38.9 million in 2024.

## Quality

All 1,240 samples met the national standard for lead and nitrates. Chlorine levels averaged 0.6 mg/L.

## Costs

Treatment cost rose to 0.82 naira per litre because of higher electricity prices at the Iju pumping station.

## Outlook

A new reservoir at Adiyan will add 70 million litres per day of capacity by 2027.
''';

void main() {
  withServerpod('Given shared documents', (sessionBuilder, endpoints) {
    const meId = '81818181-8181-4818-8818-818181818181';
    final me = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));

    test('uploading keeps it privately, gives a first look, and makes it the subject', () async {
      final up = await endpoints.document.upload(me, 'water-report-2025.pdf', 'pdf', _report, pages: 2);
      expect(up.words, greaterThan(50));
      expect(up.reply, contains('water-report-2025.pdf'));
      final s = sessionBuilder.build();
      final thread = await ChatThread.db.findFirstRow(s, where: (t) => t.authUserId.equals(UuidValue.fromString(meId)));
      expect(thread!.lastDocumentId, up.id);
      expect((await endpoints.document.list(me)).single.text, isEmpty); // listing never sends the text
      expect(() => endpoints.document.upload(me, 'x.pdf', 'pdf', '   '), throwsA(anything));
    });

    test('questions find the right part of the file, and it answers without an AI', () async {
      final s = sessionBuilder.build();
      final doc = await DocumentService.store(s, UuidValue.fromString(meId), name: 'water.txt', kind: 'text', text: _report);
      expect(DocumentService.relevant(doc, 'Why did treatment cost rise?'), contains('electricity prices'));
      expect(DocumentService.relevant(doc, 'reservoir capacity'), contains('Adiyan'));
      expect(DocumentService.answerLocally(doc, 'how many samples met the standard?'), contains('1,240 samples'));
      expect(DocumentService.isAbout(doc, 'summarize this file', followUp: false, aboutReading: false), isTrue);
      expect(DocumentService.isAbout(doc, 'what is the capital of France?', followUp: false, aboutReading: false), isFalse);
    });

    test('chat answers about the file from the file when no AI is configured', () async {
      await endpoints.document.upload(me, 'water.txt', 'text', _report);
      final reply = await endpoints.chat.sendMessage(me, 'What does the file say about chlorine levels?');
      expect(reply.reply, contains('0.6 mg/L'));
    });
  });
}
