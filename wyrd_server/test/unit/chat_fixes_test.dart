import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/local_brain_service.dart';
import 'package:wyrd_server/src/mind/prompt_planner.dart';

void main() {
  test('a message that brings its own text is not about the last page read', () {
    expect(
      LocalBrainService.carriesText(
        'Summarise this note from a website for me: "Lagos traffic peaks between 5pm and 8pm on weekdays."',
      ),
      isTrue,
    );
    expect(
      LocalBrainService.carriesText(
        'summarise this:\nThe board met on Monday and agreed the new budget for next year.',
      ),
      isTrue,
    );
    expect(LocalBrainService.carriesText('summarise it'), isFalse);
    expect(LocalBrainService.carriesText('what happens next?'), isFalse);
  });

  test(
    'a check that "corrects" an answer into talk about its evidence is thrown away',
    () {
      const draft =
          'Your sister Adaeze turns 30 on 4 November, so that is when to plan something.';
      final out = PromptPlanner.parseCheck(
        "REVISED: I don't have any evidence about your sister's birthday, so I can't confirm it.",
        draft,
      );
      expect(out.revised, isFalse);
      expect(out.text, draft);
      // a real correction of a wrong fact still goes through
      final fixed = PromptPlanner.parseCheck(
        'REVISED: The capital of Australia is Canberra, not Sydney -- a common mix-up.',
        'The capital of Australia is Sydney, its biggest city by far.',
      );
      expect(fixed.revised, isTrue);
    },
  );
}
