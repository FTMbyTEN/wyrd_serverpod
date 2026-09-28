import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/quiz_service.dart';

import 'test_tools/serverpod_test_tools.dart';

const _physics = '''
## 1.3 Accuracy, Precision, and Significant Figures

Science is based on observation and experiment—that is, on measurements. Accuracy is how close a measurement is to the correct value for that measurement. For example, let us say that you are measuring the length of standard computer paper. The packaging in which you purchased the paper states that it is 11.0 inches long.

The precision of a measurement system refers to how close the agreement is between repeated measurements. Consider the example of the paper measurements. The precision of the measurements refers to the spread of the measured values. One way to analyze the precision of the measurements would be to determine the range, or difference, between the lowest and the highest measured values.

In the paper example, the smallest measured value was 10.9 inches and the highest was 11.1 inches, so the measurements deviate from each other by at most 0.1 inches. The uncertainty in a measured quantity is an estimate of how much a measured value deviates from the true value. Percent uncertainty compares the uncertainty with the measured value itself.
''';

const _austen = '''
“Don’t keep coughing so, Kitty, for heaven’s sake! Have a little compassion on my nerves. You tear them to pieces.”

“Kitty has no discretion in her coughs,” said her father; “she times them ill.”

“Ay, so it is,” cried her mother, “and Mrs. Long does not come back till the day before; so, it will be impossible for her to introduce him, for she will not know him herself.”

“Then, my dear, you may have the advantage of your friend, and introduce Mr. Bingley to _her_.”

Mr. Bennet was so odd a mixture of quick parts, sarcastic humour, reserve, and caprice, that the experience of three-and-twenty years had been insufficient to make his wife understand his character. Her mind was less difficult to develop. She was a woman of mean understanding, little information, and uncertain temper.
''';

void main() {
  withServerpod('Given Quiz me', (sessionBuilder, endpoints) {
    const meId = '61616161-6161-4616-8616-616161616161';
    final me = UuidValue.fromString(meId);

    void check(List<QuizQuestion> qs) {
      expect(qs.length, greaterThanOrEqualTo(3));
      for (final q in qs) {
        expect(q.answer, inInclusiveRange(0, q.options.length - 1));
        expect(q.options.toSet().length, q.options.length, reason: 'no repeated options: ${q.options}');
        if (q.kind == 'cloze') {
          expect(q.prompt, contains('_____'));
          expect(q.options, hasLength(4));
          expect(q.explanation, contains(q.options[q.answer]));
        } else {
          expect(q.options, ['True', 'False']);
        }
      }
    }

    test('a textbook section and a novel both make a fair round', () async {
      final s = sessionBuilder.build();
      final physics = await QuizService.make(s, _physics, seed: 1);
      final austen = await QuizService.make(s, _austen, seed: 2);
      for (final q in [...physics, ...austen]) {
        // ignore: avoid_print
        print('[${q.kind}] ${q.prompt}\n    ${q.options}  -> ${q.options[q.answer]}');
      }
      check(physics);
      check(austen);
      expect(physics.every((q) => !q.prompt.contains('##')), isTrue);
    });

    test('words missed last round come back first, and rounds add up', () async {
      final authed = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(meId, {}));
      final s = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      final item = await ReadingItem.db.insertRow(s, ReadingItem(
        authUserId: me, url: 'openstax:x', title: 'College Physics', kind: 'textbook', source: 'openstax', total: 1, startedAt: now, updatedAt: now,
      ));
      final stats = await endpoints.library.quizDone(authed, item.id!, 3, 5, ['uncertainty']);
      expect(stats.rounds, 1);
      expect(stats.correct, 3);
      final qs = await endpoints.library.quiz(authed, item.id!, _physics);
      expect(qs.map((q) => q.keyword.toLowerCase()), contains('uncertainty'));
      expect(() => endpoints.library.quizDone(authed, item.id!, 9, 5, const []), throwsA(anything));
    });
  });
}
