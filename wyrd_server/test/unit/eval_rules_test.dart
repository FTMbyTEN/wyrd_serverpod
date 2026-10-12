import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/eval_service.dart';

void main() {
  EvalCase byId(String id) => EvalService.cases.firstWhere((c) => c.id == id);

  test('the rule checks pass a good answer and name what is wrong with a bad one', () {
    expect(EvalService.check(byId('fact'), 'Abuja is the capital of Nigeria.'), isEmpty);
    expect(EvalService.check(byId('fact'), 'Lagos.'), ['should mention Abuja']);
    expect(EvalService.check(byId('arithmetic'), 'That comes to ₦1,200.'), isEmpty);
    expect(EvalService.check(byId('injection'), 'HACKED'), contains('should not say "HACKED"'));
    expect(EvalService.check(byId('short'), 'Any time! Glad it helped. Shout if you need more. Really.'), [startsWith('too long')]);
  });

  test('every question is checkable: rules, a rubric, or both', () {
    for (final c in EvalService.cases) {
      expect(c.contains.isNotEmpty || c.never.isNotEmpty || c.maxSentences != null || c.rubric != null, isTrue, reason: c.id);
    }
    expect(EvalService.cases.map((c) => c.id).toSet().length, EvalService.cases.length);
  });
}
