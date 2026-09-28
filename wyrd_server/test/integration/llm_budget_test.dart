import 'package:serverpod/serverpod.dart';
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

    test('a call that would push the day past the cap is refused before it is sent', () async {
      final session = sessionBuilder.build();
      final cap = LlmBudget.dailyCapUsd(session);
      // spend all but ~a cent of the cap
      final inputTokens = ((cap - 0.01) * 1000000).round(); // haiku input is  per million
      await LlmBudget.record(session, {'input_tokens': inputTokens, 'output_tokens': 0});
      final small = LlmBudget.estimateUsd(model: 'claude-haiku-4-5', inputChars: 3500, maxOutputTokens: 200); // ~/usr/bin/bash.002
      final huge = LlmBudget.estimateUsd(model: 'claude-haiku-4-5', inputChars: 3500 * 20000, maxOutputTokens: 200); // ~/usr/bin/bash.02
      expect(small, lessThan(0.01));
      expect(huge, greaterThan(0.01));
      expect(await LlmBudget.allow(session, background: false, estimateUsd: small), isTrue);
      expect(await LlmBudget.allow(session, background: false, estimateUsd: huge), isFalse);
    });

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

    test('one signed-in person stops at their allowance while others can still use the cap', () async {
      Session as(String id) => sessionBuilder
          .copyWith(authentication: AuthenticationOverride.authenticationInfo(id, {}))
          .build();
      final heavy = as('44444444-4444-4444-8444-444444444444');
      final other = as('55555555-5555-4555-8555-555555555555');
      final allowance = LlmBudget.userDailyCapUsd(heavy);
      expect(await LlmBudget.allow(heavy, background: false), isTrue);
      await LlmBudget.record(heavy, {'input_tokens': 0, 'output_tokens': (allowance * 1.1 / 5 * 1000000).ceil()});
      expect(await LlmBudget.spentTodayByUsd(heavy, UuidValue.fromString('44444444-4444-4444-8444-444444444444')), greaterThan(allowance));
      expect(await LlmBudget.allow(heavy, background: false), isFalse);
      expect(await LlmBudget.allow(other, background: false), isTrue);
    });
  });
}
