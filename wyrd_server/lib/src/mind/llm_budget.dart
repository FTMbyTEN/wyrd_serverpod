import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// A hard daily cap on estimated Anthropic spend, so a small API balance lasts the month.
///
/// Every call records its real token usage (from the response's `usage` field) into
/// llm_usage_day. Before a call, [allow] checks today's total: interactive calls (chat, code,
/// photos -- a person is waiting) may use the whole daily cap; background calls (self-questions,
/// synthesis, dreams, diary, self-config, gate shapes) only [_backgroundShare] of it, so WYRD's
/// own thinking can never starve conversations. Over the cap, callers get null and fall back to
/// their existing template/no-op paths.
///
/// The cap defaults to [_defaultDailyUsd] and can be overridden with the `llmDailyBudgetUsd`
/// password (e.g. `scloud password set llmDailyBudgetUsd 0.25`).
class LlmBudget {
  /// $3/month ≈ $0.10/day; leave a little headroom for estimate error.
  static const _defaultDailyUsd = 0.09;
  static const _backgroundShare = 0.5;

  // claude-haiku-4-5 list prices, per token.
  static const _inputUsdPerToken = 1.0 / 1000000;
  static const _outputUsdPerToken = 5.0 / 1000000;

  static String _today() =>
      DateTime.now().toUtc().toIso8601String().substring(0, 10);

  static double dailyCapUsd(Session session) =>
      double.tryParse(session.passwords['llmDailyBudgetUsd'] ?? '') ??
      _defaultDailyUsd;

  static Future<double> spentTodayUsd(Session session) async {
    final row = await LlmUsageDay.db.findFirstRow(
      session,
      where: (t) => t.day.equals(_today()),
    );
    return (row?.costMicroUsd ?? 0) / 1000000;
  }

  static Future<bool> allow(Session session, {required bool background}) async {
    final cap = dailyCapUsd(session) * (background ? _backgroundShare : 1);
    final spent = await spentTodayUsd(session);
    if (spent < cap) return true;
    session.log(
      '[llm-budget] ${background ? 'background' : 'interactive'} call skipped: '
      '\$${spent.toStringAsFixed(4)} spent today, cap \$${cap.toStringAsFixed(4)}',
      level: LogLevel.info,
    );
    return false;
  }

  /// [usage] is the `usage` object from an Anthropic Messages API response.
  static Future<void> record(
    Session session,
    Map<String, dynamic>? usage,
  ) async {
    if (usage == null) return;
    final input =
        (usage['input_tokens'] as num? ?? 0) +
        (usage['cache_creation_input_tokens'] as num? ?? 0) +
        (usage['cache_read_input_tokens'] as num? ?? 0);
    final output = usage['output_tokens'] as num? ?? 0;
    final micro =
        ((input * _inputUsdPerToken + output * _outputUsdPerToken) * 1000000)
            .ceil();
    await session.db.unsafeExecute(
      'INSERT INTO "llm_usage_day" ("day", "costMicroUsd", "calls") VALUES (@day, @micro, 1) '
      'ON CONFLICT ("day") DO UPDATE SET "costMicroUsd" = "llm_usage_day"."costMicroUsd" + @micro, '
      '"calls" = "llm_usage_day"."calls" + 1',
      parameters: QueryParameters.named({'day': _today(), 'micro': micro}),
    );
  }
}
