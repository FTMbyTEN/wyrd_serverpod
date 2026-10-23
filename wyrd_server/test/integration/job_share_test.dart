import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/island/island_job_share.dart';
import 'package:wyrd_server/src/rewards/reward_config.dart';
import 'package:wyrd_server/src/rewards/reward_ledger.dart';
import 'package:wyrd_server/src/rewards/reward_math.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Island work's real share: 2% of every paycheck, from the Real Rewards Fund into the player's pending cash, once per
/// shift, maturing to available after the hold; and never paid when the switch is off or the fund is empty.
void main() {
  withServerpod(
    'Given island jobs that pay a real share',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      late Session s;
      var n = 0;
      UuidValue player() => UuidValue.fromString(
        'c0000000-0000-4000-8000-${(++n).toString().padLeft(12, '0')}',
      );
      Future<void> fund(int kobo) => RewardLedger.post(
        s,
        unit: RewardUnit.ngn,
        idemKey: 'test-fund-${DateTime.now().microsecondsSinceEpoch}',
        ref: 'TEST-FUND',
        kind: 'fund',
        memo: 'test funding',
        actor: 'test',
        lines: [('ngn:external', -kobo), ('ngn:fund:uncommitted', kobo)],
      );

      setUp(() async {
        s = sessionBuilder.build();
        RewardConfig.overrideWith({
          'REWARDS_SANDBOX': 'true',
          'JOB_SHARE_HOLD_HOURS': '0',
        });
        await s.db.unsafeExecute(
          'DROP TRIGGER IF EXISTS reward_journal_append_only ON "reward_journal"; DROP TRIGGER IF EXISTS reward_entry_append_only ON "reward_entry";',
        );
        await s.db.unsafeExecute(
          'TRUNCATE "reward_entry","reward_journal","reward_account","island_job_share" RESTART IDENTITY',
        );
      });
      tearDown(RewardConfig.clearOverride);

      test('the split: 2% of the paycheck in kobo, the rest in Game Naira', () {
        expect(JobShare.kobo(12000), 24000); // ₦240
        expect(JobShare.gameNaira(12000), 11760);
        expect(JobShare.gameNaira(34000) + JobShare.kobo(34000) ~/ 100, 34000);
      });

      test(
        'an empty fund pays no share, and the shift is recorded as paid in Game Naira',
        () async {
          final u = player();
          final k = await JobShare.credit(
            s,
            u,
            source: 'shift-a',
            workplace: 'grid',
            title: 'Grid shift',
            paycheck: 12000,
          );
          expect(k, 0);
          expect(
            (await IslandJobShare.db.findFirstRow(
              s,
              where: (t) => t.source.equals('shift-a'),
            ))!.status,
            'unfunded',
          );
          expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 0);
        },
      );

      test(
        'a funded share lands in pending once, however often the shift is handed in',
        () async {
          await fund(1000000);
          final u = player();
          for (var i = 0; i < 3; i++) {
            expect(
              await JobShare.credit(
                s,
                u,
                source: 'shift-b',
                workplace: 'refinery',
                title: 'Refinery shift',
                paycheck: 12000,
              ),
              24000,
            );
          }
          expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 24000);
          expect(
            await RewardLedger.balance(s, 'ngn:fund:uncommitted'),
            1000000 - 24000,
          );
          expect(
            await IslandJobShare.db.count(
              s,
              where: (t) => t.authUserId.equals(u),
            ),
            1,
          );
        },
      );

      test(
        'after the hold the share is available to withdraw, and the summary adds it up',
        () async {
          await fund(1000000);
          final u = player();
          await JobShare.credit(
            s,
            u,
            source: 'shift-c',
            workplace: 'airport',
            title: 'Airport shift',
            paycheck: 21000,
          );
          await JobShare.credit(
            s,
            u,
            source: 'shift-d',
            workplace: 'market',
            title: 'Market stall',
            paycheck: 2500,
          );
          final sum = await JobShare.summary(s, u);
          expect(
            await RewardLedger.balance(s, RewardLedger.available(u)),
            42000 + 5000,
          );
          expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 0);
          expect(
            (sum['jobs'], sum['paychecks'], sum['earnedKobo']),
            (2, 23500, 47000),
          );
          expect(
            (sum['list'] as List).every((r) => r['status'] == 'available'),
            isTrue,
          );
          expect(await RewardLedger.reconcile(s), isEmpty);
        },
      );

      test(
        'with the switch off, nothing real is paid even with money in the fund',
        () async {
          RewardConfig.overrideWith({'JOB_SHARE_HOLD_HOURS': '0'});
          await fund(1000000);
          final u = player();
          expect(
            await JobShare.credit(
              s,
              u,
              source: 'shift-e',
              workplace: 'club',
              title: 'Club shift',
              paycheck: 4000,
            ),
            0,
          );
          expect(
            await RewardLedger.balance(s, 'ngn:fund:uncommitted'),
            1000000,
          );
        },
      );

      test('a payout needs at least ₦5,000 available', () {
        RewardConfig.overrideWith({
          'REWARDS_SANDBOX': 'true',
          'PAYOUT_MIN_WITHDRAWAL_KOBO': '10000',
        });
        expect(RewardConfig.current.minWithdrawalKobo, 500000);
      });
    },
  );
}
