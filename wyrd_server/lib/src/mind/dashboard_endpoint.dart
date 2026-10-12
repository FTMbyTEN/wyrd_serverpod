import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import '../world/bank.dart';
import 'claude.dart';
import 'eval_service.dart';
import 'llm_budget.dart';

/// The owner's dashboard (#dashboard in the app): how WYRD is doing in one place -- what the AI
/// cost today and lately, how it scored on its test questions, what's waiting on the owner, and
/// the health of the city (the players, the books, the queues). Owner only. (Sign-up numbers are
/// OwnerEndpoint.userStats.)
class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UuidValue> _owner(Session session) async {
    final user = UuidValue.fromString(session.authenticated!.userIdentifier);
    if (!await DroneService.isOperator(session, user)) throw Exception('The dashboard is for the owner.');
    return user;
  }

  // (a SUM over bigints comes back as Postgres numeric, which the driver hands over as text)
  Future<int> _count(Session session, String sql) async {
    final v = (await session.db.unsafeQuery(sql)).first.first;
    return v is num ? v.toInt() : num.tryParse('$v')?.toInt() ?? 0;
  }

  /// Everything on the dashboard, as JSON.
  Future<String> get(Session session) async {
    await _owner(session);
    final days = await LlmUsageDay.db.find(session, orderBy: (t) => t.day.desc(), limit: 14);
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    final runs = await EvalService.recent(session, limit: 8);
    final unbalanced = await Bank.audit(session);
    return jsonEncode({
      'ai': {
        'model': Claude.core,
        'spentTodayUsd': await LlmBudget.spentTodayUsd(session),
        'capUsd': LlmBudget.dailyCapUsd(session),
        'callsToday': days.where((d) => d.day == today).firstOrNull?.calls ?? 0,
        'days': [for (final d in days.reversed) {'day': d.day, 'usd': d.costMicroUsd / 1000000, 'calls': d.calls}],
      },
      'evals': [
        for (final r in runs)
          {'id': r.id, 'at': r.startedAt.toIso8601String(), 'model': r.model, 'passed': r.passed, 'total': r.total, 'usd': r.costMicroUsd / 1000000, 'ms': r.ms},
      ],
      'agent': {
        'waiting': await _count(session, "SELECT COUNT(*) FROM \"agent_task\" WHERE \"status\" = 'waiting_approval'"),
        'running': await _count(session, "SELECT COUNT(*) FROM \"agent_task\" WHERE \"status\" IN ('queued', 'running')"),
        'scheduled': await _count(session, "SELECT COUNT(*) FROM \"agent_task\" WHERE \"status\" = 'scheduled'"),
        'failedThisWeek': await _count(session, "SELECT COUNT(*) FROM \"agent_task\" WHERE \"status\" = 'failed' AND \"updatedAt\" > now() - interval '7 days'"),
      },
      'city': {
        'players': await _count(session, 'SELECT COUNT(*) FROM "world_citizen"'),
        'activeToday': await _count(session, "SELECT COUNT(*) FROM \"world_citizen\" WHERE \"updatedAt\" > now() - interval '1 day'"),
        'naira': await _count(session, 'SELECT COALESCE(SUM("naira"), 0) FROM "world_citizen"'),
        'debt': await _count(session, 'SELECT COALESCE(SUM("debt"), 0) FROM "world_citizen"'),
        'booksBalance': unbalanced.isEmpty,
        'unbalanced': unbalanced.length,
        'disputesQueued': await _count(session, "SELECT COUNT(*) FROM \"naira_dispute\" WHERE \"status\" = 'queued'"),
        'appealsQueued': await _count(session, "SELECT COUNT(*) FROM \"police_citation\" WHERE \"appealResult\" = 'queued'"),
        'finesPending': await _count(session, "SELECT COUNT(*) FROM \"police_citation\" WHERE \"status\" = 'pending'"),
      },
    });
  }

  /// Run WYRD's test questions now (a fraction of a cent) and return the run, answers included.
  Future<String> runEval(Session session) async {
    final owner = await _owner(session);
    return _run(await EvalService.run(session, owner));
  }

  /// One earlier run, answers included.
  Future<String> evalRun(Session session, int id) async {
    await _owner(session);
    final r = await EvalRun.db.findById(session, id);
    if (r == null) throw Exception('No such run.');
    return _run(r);
  }

  static String _run(EvalRun r) => jsonEncode({
        'id': r.id,
        'at': r.startedAt.toIso8601String(),
        'model': r.model,
        'passed': r.passed,
        'total': r.total,
        'usd': r.costMicroUsd / 1000000,
        'ms': r.ms,
        'results': jsonDecode(r.results),
      });
}
