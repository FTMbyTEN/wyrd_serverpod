import 'dart:math';

import '../drone/drone_service.dart';
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

  /// Each signed-in person's share of the day, so one account can't spend everyone's cap.
  /// Override with the `llmUserDailyUsd` password. The drone operator (the owner) has no
  /// allowance of their own, only the whole cap.
  static const _defaultUserDailyUsd = 0.03;

  static double userDailyCapUsd(Session session) =>
      double.tryParse(session.passwords['llmUserDailyUsd'] ?? '') ?? _defaultUserDailyUsd;

  static UuidValue? _person(Session session) {
    final id = session.authenticated?.userIdentifier;
    return id == null ? null : UuidValue.fromString(id);
  }

  static Future<double> spentTodayByUsd(Session session, UuidValue authUserId) async {
    final row = await LlmUsageUser.db.findFirstRow(
      session,
      where: (t) => t.day.equals(_today()) & t.authUserId.equals(authUserId),
    );
    return (row?.costMicroUsd ?? 0) / 1000000;
  }

  /// True when the person making this request has used their allowance for today.
  static Future<bool> personOverAllowance(Session session, {double estimateUsd = 0}) async {
    final person = _person(session);
    if (person == null || await DroneService.isOperator(session, person)) return false;
    final spent = await spentTodayByUsd(session, person);
    return spent + estimateUsd > userDailyCapUsd(session);
  }

  // List prices per million tokens (input, output). Unknown models are priced like the most
  // expensive listed one, so an estimate never undercounts.
  static const _prices = <String, (double, double)>{
    'voyage': (0.02, 0.0),
    'haiku': (1.0, 5.0),
    'sonnet': (3.0, 15.0),
    'opus': (15.0, 75.0),
  };

  static (double, double) _priceFor(String? model) {
    final m = (model ?? 'haiku').toLowerCase();
    for (final e in _prices.entries) {
      if (m.contains(e.key)) return e.value;
    }
    return _prices['opus']!;
  }

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

  /// Rough cost of a call before it's made: [inputChars] of prompt text (~3.5 chars a token),
  /// [images] attached, up to [maxOutputTokens] back.
  static double estimateUsd({required String model, required int inputChars, int images = 0, required int maxOutputTokens}) {
    final (inPerM, outPerM) = _priceFor(model);
    final inputTokens = inputChars / 3.5 + images * 1600;
    return (inputTokens * inPerM + maxOutputTokens * outPerM) / 1000000;
  }

  /// [estimateUsd], when given, must also fit under the cap: one big call (a long page, several
  /// book slices) can't push the day past it.
  static Future<bool> allow(Session session, {required bool background, double estimateUsd = 0}) async {
    // Background thinking is paced across the day: by hour h it may have used (h+1)/24 of its
    // share. Unpaced, the 30-second ticks spent the whole share in the first hour of each day and
    // WYRD thought on templates for the other 23.
    final now = DateTime.now().toUtc();
    final dayFraction = min(1.0, (now.hour + now.minute / 60 + 1) / 24);
    final cap = dailyCapUsd(session) * (background ? _backgroundShare * dayFraction : 1);
    if (!background && await personOverAllowance(session, estimateUsd: estimateUsd)) {
      session.log('[llm-budget] interactive call skipped: this person has used their daily allowance', level: LogLevel.info);
      return false;
    }
    final spent = await spentTodayUsd(session);
    if (spent + estimateUsd <= cap) return true;
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
    Map<String, dynamic>? usage, {
    String? model,
  }) async {
    if (usage == null) return;
    final input =
        (usage['input_tokens'] as num? ?? 0) +
        (usage['cache_creation_input_tokens'] as num? ?? 0) +
        (usage['cache_read_input_tokens'] as num? ?? 0);
    final output = usage['output_tokens'] as num? ?? 0;
    final (inPerM, outPerM) = _priceFor(model);
    final micro = (input * inPerM + output * outPerM).ceil(); // per-million prices -> micro-USD
    await session.db.unsafeExecute(
      'INSERT INTO "llm_usage_day" ("day", "costMicroUsd", "calls") VALUES (@day, @micro, 1) '
      'ON CONFLICT ("day") DO UPDATE SET "costMicroUsd" = "llm_usage_day"."costMicroUsd" + @micro, '
      '"calls" = "llm_usage_day"."calls" + 1',
      parameters: QueryParameters.named({'day': _today(), 'micro': micro}),
    );
    final person = _person(session);
    if (person != null) {
      await session.db.unsafeExecute(
        'INSERT INTO "llm_usage_user" ("day", "authUserId", "costMicroUsd") VALUES (@day, @user::uuid, @micro) '
        'ON CONFLICT ("day", "authUserId") DO UPDATE SET "costMicroUsd" = "llm_usage_user"."costMicroUsd" + @micro',
        parameters: QueryParameters.named({'day': _today(), 'user': person.uuid, 'micro': micro}),
      );
    }
  }
}
