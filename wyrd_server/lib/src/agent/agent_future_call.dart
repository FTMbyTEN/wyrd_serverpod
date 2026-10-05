import 'package:serverpod/serverpod.dart';

import '../mind/tick_schedule.dart';
import 'agent_service.dart';

/// Agent tasks run in the background: every tick, a couple of due tasks get a run each.
class AgentFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('agent', TickSchedule.agent)) return;
    await AgentService.tick(session);
  }
}
