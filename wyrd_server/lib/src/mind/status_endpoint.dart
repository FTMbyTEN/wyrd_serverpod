import '../generated/protocol.dart';
import 'llm_budget.dart';
import 'llm_service.dart';
import 'tick_schedule.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's /api/turbo, /api/llm/status and /api/datasets/status as one status call.
/// See system_status.spy.yaml for what's fixed (turbo, datasets) on this backend. Node also
/// returned per-process LLM success/error counters; those aren't tracked here. Public, like Node.
class StatusEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<SystemStatus> getStatus(Session session) =>
      PublicCache.get(session, 'status.getStatus', const Duration(seconds: 15), () => _getStatus(session));

  Future<SystemStatus> _getStatus(Session session) async {
    final llmActive = LlmService.isConfigured(session);
    return SystemStatus(
      turboActive: false,
      turboFactor: 1,
      reasoningCycleMs: TickSchedule.reasoning.inMilliseconds,
      selfQuestionCycleMs: TickSchedule.selfQuestion.inMilliseconds,
      feedCycleMs: TickSchedule.feed.inMilliseconds,
      lexiconCycleMs: TickSchedule.lexicon.inMilliseconds,
      llmActive: llmActive,
      llmModel: llmActive ? LlmService.model : null,
      llmSpentTodayUsd: await LlmBudget.spentTodayUsd(session),
      llmDailyCapUsd: LlmBudget.dailyCapUsd(session),
      qaDatasetEntries: 0,
      dialogueDatasetEntries: 0,
    );
  }
}
