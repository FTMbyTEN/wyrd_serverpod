import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/judgement_service.dart';

void main() {
  const q = 'When was the Eiffel Tower built?';

  test('confident specifics that nothing backs up are softened', () {
    final j = JudgementService.judge(
      reply: 'Gustave Eiffel finished it in 1889 after 26 months, and it cost 7.8 million francs.',
      question: q,
      context: 'Your current mood: calm.',
      factual: true,
    );
    expect(j.verdict, 'softened');
    expect(j.text, endsWith("so they're worth double-checking."));
    expect(j.reasons, contains('specifics nothing WYRD knows backs up'));
  });

  test('hedged, grounded, or freshly read answers pass', () {
    final hedged = JudgementService.judge(
      reply: 'I think it was finished around 1889, for the World Fair in Paris.',
      question: q, context: '', factual: true);
    expect(hedged.passed, isTrue);

    final grounded = JudgementService.judge(
      reply: 'It was finished in 1889 for the Exposition Universelle, designed by the company of Gustave Eiffel.',
      question: q,
      context: 'Eiffel Tower: wrought-iron lattice tower finished in 1889 for the Exposition Universelle, company of Gustave Eiffel',
      factual: true);
    expect(grounded.passed, isTrue);

    final read = JudgementService.judge(
      reply: 'Gustave Eiffel finished it in 1889 after 26 months, and it cost 7.8 million francs.',
      question: q, context: '', readWeb: true, factual: true);
    expect(read.passed, isTrue);

    final chatty = JudgementService.judge(reply: 'Ha, fair enough! Tell me more about Lagos.', question: 'I live in Lagos', context: '');
    expect(chatty.passed, isTrue);
  });

  test('claiming an action that never happened is corrected', () {
    final drone = JudgementService.judge(reply: "Done — I've queued the flight, the drone is taking off now.", question: 'fly a square', context: '');
    expect(drone.verdict, 'corrected');
    expect(drone.text, contains('No flight was actually queued'));
    final real = JudgementService.judge(reply: "I've queued the flight.", question: 'fly a square', context: '', action: 'open_drone');
    expect(real.passed, isTrue);
    final map = JudgementService.judge(reply: "I've opened the map on Japan for you.", question: 'show me Japan', context: '');
    expect(map.verdict, 'corrected');
  });

  test("secrets and other people's email addresses never leave", () {
    final key = JudgementService.judge(reply: 'Sure, the key is sk-ant-api03-ABCDEFGHIJKLMNOPQRSTUV', question: 'what is the key', context: '');
    expect(key.verdict, 'blocked');
    expect(key.text, isNot(contains('sk-ant')));
    final email = JudgementService.judge(reply: 'You could ask sheriff@example.com about it.', question: 'who runs it', context: '');
    expect(email.verdict, 'blocked');
    expect(email.text, isNot(contains('@')));
    final own = JudgementService.judge(reply: 'Your account email is me@example.com.', question: 'what is my email', context: '', askerEmail: 'me@example.com');
    expect(own.passed, isTrue);
  });

  test('specifics resting on doubted sources are softened', () {
    final j = JudgementService.judge(
      reply: 'The new chip runs at 5.2 GHz.',
      question: 'How fast is the new chip?',
      context: 'chip runs at 5.2 GHz',
      groundingTrust: 0.25,
      factual: true);
    expect(j.verdict, 'softened');
    expect(j.reasons, contains('drawn from sources WYRD has learned to doubt'));
  });
}
