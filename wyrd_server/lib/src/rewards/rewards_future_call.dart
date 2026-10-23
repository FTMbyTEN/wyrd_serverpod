import 'package:serverpod/serverpod.dart';

import '../island/island_job_share.dart';
import '../mind/tick_schedule.dart';
import 'funded_jobs.dart';
import 'withdrawals.dart';

/// The rewards housekeeping, every few minutes: cash past its hold becomes available, taken gigs past their deadline
/// give their reservation back, and any completed gig whose game pay didn't land is paid. Each step is idempotent
/// (journals and game pay carry fixed keys), so a duplicate tick changes nothing. Moves no money that isn't already owed.
class RewardsFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('rewards', TickSchedule.rewards)) return;
    for (final (name, step) in [
      ('mature', () => FundedJobs.matureDue(session)),
      ('shares', () => JobShare.matureDue(session)),
      ('expire', () => FundedJobs.expireDue(session)),
      ('repair', () => FundedJobs.repairGameRewards(session)),
      ('submit', () => Withdrawals.submitDue(session)),
      ('reconcile', () => Withdrawals.reconcile(session)),
    ]) {
      try {
        final n = await step();
        if (n > 0) session.log('[rewards] $name: $n');
      } catch (e) {
        session.log('[rewards] $name failed: $e', level: LogLevel.warning);
      }
    }
  }
}
