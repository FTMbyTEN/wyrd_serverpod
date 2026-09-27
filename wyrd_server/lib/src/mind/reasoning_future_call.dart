import 'reasoning_service.dart';
import 'tick_schedule.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's CYCLE_MS autonomous reasoning interval. Node scales this by a runtime
/// TURBO_FACTOR (not ported); this uses a fixed, real-time interval instead.
class ReasoningFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('reasoning', TickSchedule.reasoning)) return;
    await ReasoningService.tick(session);
  }
}
