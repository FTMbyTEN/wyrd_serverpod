import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/claude.dart';
import 'package:wyrd_server/src/mind/llm_budget.dart';

void main() {
  test(
    'Haiku 5.5 is priced at a tenth of 4.5, with cache reads and writes',
    () {
      const usage = {'input_tokens': 100000, 'output_tokens': 100000};
      expect(
        LlmBudget.costMicroUsd(usage, model: Claude.core),
        60000,
      ); // $0.01 in + $0.05 out
      expect(
        LlmBudget.costMicroUsd(usage),
        600000,
      ); // unnamed: priced as Haiku 4.5, never undercounted
      // a cached step: 90K tokens read back at a tenth, 10K plain
      expect(
        LlmBudget.costMicroUsd({
          'input_tokens': 10000,
          'cache_read_input_tokens': 90000,
          'output_tokens': 0,
        }, model: Claude.core),
        1900,
      );
      // writing the cache costs a quarter more
      expect(
        LlmBudget.costMicroUsd({
          'cache_creation_input_tokens': 80000,
          'output_tokens': 0,
        }, model: Claude.core),
        10000,
      );
      // a prompt over 100K tokens is charged five times the rates
      expect(
        LlmBudget.costMicroUsd({
          'input_tokens': 200000,
          'output_tokens': 0,
        }, model: Claude.core),
        100000,
      );
    },
  );

  test(
    'requests: thinking off, room for the new tokenizer, only the steady system part cached',
    () {
      final plain = Claude.body(
        system: 'Be brief.',
        messages: [
          {'role': 'user', 'content': 'Hi'},
        ],
        maxTokens: 100,
      );
      expect(plain['model'], 'claude-haiku-5-5');
      expect(plain['max_tokens'], 130);
      expect(plain['thinking'], {'type': 'disabled'});
      expect(plain['system'], 'Be brief.');
      expect(plain.containsKey('tools'), isFalse);
      for (final k in ['temperature', 'top_p', 'top_k']) {
        expect(
          plain.containsKey(k),
          isFalse,
        ); // (Haiku 5.5 rejects non-default sampling)
      }

      final step = Claude.body(
        cachedSystem: 'THE TASK: x',
        system: '3 steps left',
        messages: const [],
        maxTokens: 10,
        tools: const [
          {'name': 't'},
        ],
      );
      final system = step['system'] as List;
      expect(system.first['cache_control'], {'type': 'ephemeral'});
      expect(system.last['text'], '3 steps left');
      expect((system.last as Map).containsKey('cache_control'), isFalse);
    },
  );
}
