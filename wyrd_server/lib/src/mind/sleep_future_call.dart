import 'sleep_service.dart';
import 'tick_schedule.dart';
import 'package:serverpod/serverpod.dart';

/// Every 10 minutes: fingerprint new memories, and once a night run WYRD's sleep
/// (see SleepService).
class SleepFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('sleepCheck', TickSchedule.sleepCheck)) return;
    await SleepService.tick(session);
  }
}
