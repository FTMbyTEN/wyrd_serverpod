import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/prompt_planner.dart';

void main() {
  group('classify', () {
    test('sorts messages into kinds', () {
      expect(PromptPlanner.classify('What is the capital of Ghana?'), Ask.fact);
      expect(PromptPlanner.classify('when did the Berlin wall fall'), Ask.fact);
      expect(PromptPlanner.classify('Why is the sky blue?'), Ask.explain);
      expect(PromptPlanner.classify('Explain how vaccines work'), Ask.explain);
      expect(PromptPlanner.classify('Python vs Dart for a server?'), Ask.compare);
      expect(PromptPlanner.classify("What's the difference between RAM and storage"), Ask.compare);
      expect(PromptPlanner.classify('Should I learn Rust first?'), Ask.advice);
      expect(PromptPlanner.classify('What do you think about remote work?'), Ask.opinion);
      expect(PromptPlanner.classify('Who are you?'), Ask.personal);
      expect(PromptPlanner.classify('Write a poem about the rain'), Ask.creative);
      expect(PromptPlanner.classify('haha nice'), Ask.chat);
      expect(PromptPlanner.classify(''), Ask.chat);
    });
  });

  group('plan', () {
    test('checks only grounded factual answers', () {
      expect(PromptPlanner.plan('What is the capital of Ghana?', hasPassages: true).verify, isTrue);
      expect(PromptPlanner.plan('What is the capital of Ghana?', hasPassages: false).verify, isFalse);
      expect(PromptPlanner.plan('Write a poem about Accra', hasPassages: true).verify, isFalse);
      expect(PromptPlanner.plan('What does the file say?', hasPassages: true, aboutDoc: true).verify, isFalse);
    });

    test('explanations get more room than chat, and chat gets no scaffold', () {
      final explain = PromptPlanner.plan('Why is the sky blue?', hasPassages: false);
      final chat = PromptPlanner.plan('haha nice', hasPassages: false);
      expect(explain.maxTokens, greaterThan(chat.maxTokens));
      expect(explain.lines.any((l) => l.contains('work it out privately')), isTrue);
      expect(chat.lines.any((l) => l.contains('work it out privately')), isFalse);
    });
  });

  group('parseCheck', () {
    const draft = 'Accra is the capital of Ghana, and it has about 2.5 million people in the city proper.';
    test('OK keeps the draft', () {
      expect(PromptPlanner.parseCheck('OK', draft), (text: draft, revised: false));
    });
    test('REVISED replaces it', () {
      final r = PromptPlanner.parseCheck('REVISED: Accra is the capital of Ghana.', draft);
      expect(r.revised, isTrue);
      expect(r.text, 'Accra is the capital of Ghana.');
    });
    test('unclear, empty or ballooning corrections keep the draft', () {
      expect(PromptPlanner.parseCheck(null, draft).revised, isFalse);
      expect(PromptPlanner.parseCheck('Looks fine to me.', draft).revised, isFalse);
      expect(PromptPlanner.parseCheck('REVISED: no', draft).revised, isFalse);
      expect(PromptPlanner.parseCheck('REVISED: ${'x' * 400}', draft).revised, isFalse);
    });
  });
}
