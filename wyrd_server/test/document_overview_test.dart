import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/document_service.dart';

UserDocument _doc(String name, String kind, String text) => UserDocument(
      authUserId: UuidValue.fromString('81818181-8181-4818-8818-818181818181'),
      name: name,
      kind: kind,
      text: text,
      chars: text.length,
      words: DocumentService.words(text),
      createdAt: DateTime.now(),
    );

const _report = '''
## Annual Water Report 2025

The city supplied 41.2 million litres of drinking water per day in 2025, up from 38.9 million in 2024. Demand grew fastest in the eastern districts, where new housing estates were connected to the network.

## Quality

All 1,240 samples met the national standard for lead and nitrates. Chlorine levels averaged 0.6 mg/L, within the safe range for drinking water.

## Costs

Treatment cost rose to 0.82 naira per litre because of higher electricity prices at the Iju pumping station. The water board expects costs to ease once the solar array at Iju is finished.

## Outlook

A new reservoir at Adiyan will add 70 million litres per day of capacity by 2027. The water board will also replace 40 km of old pipes to cut leakage in the eastern districts.
''';

const _account = '''
What's the worst thing you've ever done? I suppose I have to start with Daniel. My daughter Clara met him at university, and for two years I watched him wear her down with small cruelties that left no bruises. He was too careful for that.

When did you find out you were capable of something frightening? It was a Tuesday in September, at the train station in Leeds. I saw Daniel on the platform and something in me went very still and very cold. I followed him to the end of the carriage and I told him exactly what I could do to him.

What happened next? Nothing happened. He looked at me and I watched him understand that I meant it. He got off at the next stop and Clara never heard from him again.

Do you regret it? I'd like to tell you I was frightened of what I might do. The truth is that I was calm, and that is what frightens me now. I had always thought of myself as a gentle person, the kind of parent who bakes bread and remembers birthdays.

What did it teach you? That gentleness can be a habit rather than a nature. I still bake the bread. But I know now what is underneath, and so does Daniel, and I think about that train carriage more than I think about almost anything else.
''';

void main() {
  test('a report: its kind, sections, figures and gist', () {
    final o = DocumentService.overview(_doc('water-report-2025.pdf', 'pdf', _report));
    expect(o, contains('a report'));
    expect(o, contains('Sections: Annual Water Report 2025 · Quality · Costs · Outlook'));
    expect(o, contains('Key figures'));
  });

  test('a personal account told as answers: its people, the questions, and how it runs', () {
    final o = DocumentService.overview(_doc('story-answers.md', 'text', _account));
    expect(o, contains('personal account'));
    expect(o, contains('Daniel'));
    expect(o, contains('questions like'));
    expect(o, isNot(contains('september')));
  });
}
