import 'synthesis_service.dart';
import 'tick_schedule.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's SYNTHESIS_CYCLE_MS interval (Node: max(20s, 90s/TURBO_FACTOR)). Node's
/// TURBO_FACTOR speed-scaling isn't ported; this uses a fixed, real-time interval instead.
class SynthesisFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('synthesis', TickSchedule.synthesis)) return;
    await SynthesisService.tick(session);
  }
}
