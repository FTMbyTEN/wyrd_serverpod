import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/llm_budget.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the LLM daily budget', (sessionBuilder, endpoints) {
    test(
      'usage is priced from real token counts and accumulates across calls',
      () async {
        final session = sessionBuilder.build();
        // 1000 in ($0.001) + 200 out ($0.001) = $0.002 per call
        await LlmBudget.record(session, {
          'input_tokens': 1000,
          'output_tokens': 200,
        });
        await LlmBudget.record(session, {
          'input_tokens': 1000,
          'output_tokens': 200,
        });
        expect(await LlmBudget.spentTodayUsd(session), closeTo(0.004, 1e-9));
      },
    );

    test(
      'background calls stop at half the cap while interactive calls continue to the full cap',
      () async {
        final session = sessionBuilder.build();
        final cap = LlmBudget.dailyCapUsd(session);
        expect(await LlmBudget.allow(session, background: true), isTrue);

        // spend just past half the cap
        final outputTokens = (cap * 0.55 / 5 * 1000000).ceil();
        await LlmBudget.record(session, {
          'input_tokens': 0,
          'output_tokens': outputTokens,
        });
        expect(await LlmBudget.allow(session, background: true), isFalse);
        expect(await LlmBudget.allow(session, background: false), isTrue);

        // and past the full cap
        await LlmBudget.record(session, {
          'input_tokens': 0,
          'output_tokens': outputTokens,
        });
        expect(await LlmBudget.allow(session, background: false), isFalse);
      },
    );

    test('the status endpoint reports today\'s spend and the cap', () async {
      final session = sessionBuilder.build();
      await LlmBudget.record(session, {
        'input_tokens': 2000,
        'output_tokens': 0,
      });
      final status = await endpoints.status.getStatus(sessionBuilder);
      expect(status.llmSpentTodayUsd, closeTo(0.002, 1e-9));
      expect(status.llmDailyCapUsd, LlmBudget.dailyCapUsd(session));
    });
  });
}
