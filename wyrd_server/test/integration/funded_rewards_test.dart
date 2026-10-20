import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/rewards/funded_jobs.dart';
import 'package:wyrd_server/src/rewards/reward_admin.dart';
import 'package:wyrd_server/src/rewards/reward_config.dart';
import 'package:wyrd_server/src/rewards/reward_ledger.dart';
import 'package:wyrd_server/src/rewards/reward_math.dart';
import 'package:wyrd_server/src/rewards/reward_seed.dart';
import 'package:wyrd_server/src/rewards/withdrawals.dart';
import 'package:wyrd_server/src/world/bank.dart';
import 'package:wyrd_server/src/world/world_authority.dart';

import 'test_tools/serverpod_test_tools.dart';

/// The funded split-paycheck system against a real PostgreSQL: reservations, races, completions, the hold,
/// withdrawals and provider events. Sandbox settings only; no real money anywhere.
void main() {
  withServerpod('Given the rewards system in the sandbox', rollbackDatabase: RollbackDatabase.disabled, (sessionBuilder, endpoints) {
    late Session s;
    const secret = 'sandbox-secret-for-tests';
    final admin1 = UuidValue.fromString('a0000000-0000-4000-8000-000000000001'), admin2 = UuidValue.fromString('a0000000-0000-4000-8000-000000000002');
    var n = 0;
    UuidValue player() => UuidValue.fromString('b0000000-0000-4000-8000-${(++n).toString().padLeft(12, '0')}');

    setUp(() async {
      s = sessionBuilder.build();
      RewardConfig.overrideWith({
        'FUNDED_JOBS_ENABLED': 'true', 'REWARDS_SANDBOX': 'true', 'REWARDS_PROVIDER_SECRET': secret,
        'FUNDED_JOBS_PER_DAY': '100', 'FUNDED_JOBS_COOLDOWN_MIN': '0', 'PAYOUT_MIN_WITHDRAWAL_KOBO': '10000', 'PAYOUT_FEE_KOBO': '5000', 'PAYOUT_FEE_PAYER': 'house',
      });
      Withdrawals.provider = MockPayoutProvider();
      await s.db.unsafeExecute('DROP TRIGGER IF EXISTS reward_journal_append_only ON "reward_journal"; DROP TRIGGER IF EXISTS reward_entry_append_only ON "reward_entry";');
      await s.db.unsafeExecute('TRUNCATE "reward_entry","reward_journal","reward_account","reward_policy","funded_campaign","job_offer","job_acceptance","reward_earning",'
          '"reward_withdrawal","reward_provider_event","reward_funding","reward_role","reward_audit","reward_switch" RESTART IDENTITY');
      await s.db.unsafeExecute('CREATE OR REPLACE FUNCTION reward_append_only() RETURNS trigger AS \$\$ BEGIN RAISE EXCEPTION \'rewards ledger is append-only\'; END; \$\$ LANGUAGE plpgsql;'
          'CREATE TRIGGER reward_journal_append_only BEFORE UPDATE OR DELETE ON "reward_journal" FOR EACH ROW EXECUTE FUNCTION reward_append_only();'
          'CREATE TRIGGER reward_entry_append_only BEFORE UPDATE OR DELETE ON "reward_entry" FOR EACH ROW EXECUTE FUNCTION reward_append_only();');
      for (final (u, r) in [(admin1, 'operator'), (admin2, 'approver'), (admin2, 'operator')]) {
        await RewardRole.db.insertRow(s, RewardRole(authUserId: u, role: r, grantedBy: admin1, createdAt: DateTime.now().toUtc()));
      }
    });
    tearDown(RewardConfig.clearOverride);

    /// ₦[naira] into the fund and G₦[gn] into the treasury, each proposed by one admin and approved by the other
    Future<void> fund(int naira, {int gn = 10000000}) async {
      await RewardAdmin.decide(s, admin2, (await RewardAdmin.propose(s, admin1, RewardUnit.ngn, naira * 100, 'Sandbox bank line 001')).id!, true);
      await RewardAdmin.decide(s, admin2, (await RewardAdmin.propose(s, admin1, RewardUnit.gn, gn, 'Sandbox issuance for tests')).id!, true);
    }

    Future<JobOffer> offer({int basis = 30000, int fee = 0, int hold = 0, int? places}) async {
      final p = await RewardAdmin.newPolicy(s, admin1, cashShareBp: 167, feeAllowanceKobo: fee, holdHours: hold);
      final c = await FundedCampaign.db.insertRow(s, FundedCampaign(name: 'Test', status: 'active', createdBy: admin1.uuid, createdAt: DateTime.now().toUtc()));
      return FundedJobs.createOffer(s, type: FundedJobs.funded, title: 'Deliver to Marina', basis: basis, closesAt: DateTime.now().add(const Duration(days: 1)),
          campaignId: c.id, policyVersion: p.version, places: places, createdBy: admin1.uuid);
    }

    /// make the server think the job took two minutes (the shortest delivery takes ~20 s)
    Future<void> age(int acceptanceId) => s.db.unsafeExecute('UPDATE "job_acceptance" SET "acceptedAt" = "acceptedAt" - interval \'2 minutes\' WHERE "id" = $acceptanceId');

    Future<void> books() async => expect(await RewardLedger.reconcile(s), isEmpty, reason: 'the books balance');

    test('test 1 and 14: the offer fixes G₦29,499 + ₦501, and a later policy does not change an accepted job', () async {
      await fund(10000);
      final o = await offer();
      expect((o.gameReward, o.cashKobo), (29499, 50100));
      final u = player();
      final a = await FundedJobs.accept(s, u, o.id!, 'k-accept-1-${u.uuid}');
      await RewardAdmin.newPolicy(s, admin1, cashShareBp: 5000, feeAllowanceKobo: 0, holdHours: 0); // a very different policy
      final again = (await JobAcceptance.db.findById(s, a.id!))!;
      expect((again.gameReward, again.cashKobo), (29499, 50100));
      await books();
    });

    test('test 3: ₦50,000 backs 33 rewards of ₦835 + ₦650 fee allowance; the 34th is refused', () async {
      await fund(50000);
      final o = await offer(basis: 50000, fee: 65000);
      expect(o.cashKobo, 83500);
      for (var i = 0; i < 33; i++) {
        final u = player();
        await FundedJobs.accept(s, u, o.id!, 'k3-$i-${u.uuid}');
      }
      final u = player();
      await expectLater(FundedJobs.accept(s, u, o.id!, 'k3-34-${u.uuid}'), throwsA(isA<JobRefused>()));
      expect(await RewardLedger.balance(s, 'ngn:fund:reserved'), 33 * 83500);
      expect(await RewardLedger.balance(s, 'ngn:fund:fee_reserved'), 33 * 65000);
      expect(await RewardLedger.balance(s, 'ngn:fund:uncommitted'), 5000000 - 33 * 148500);
      await books();
    });

    test('test 4: 40 players accepting at once never overfill a fund that backs 10', () async {
      await fund(5010); // ₦5,010 = 10 x ₦501
      final o = await offer();
      final results = await Future.wait([
        for (var i = 0; i < 40; i++)
          () async {
            final u = player();
            try {
              await FundedJobs.accept(sessionBuilder.build(), u, o.id!, 'k4-$i-${u.uuid}');
              return true;
            } on JobRefused {
              return false;
            }
          }(),
      ]);
      expect(results.where((r) => r).length, 10);
      expect(await RewardLedger.balance(s, 'ngn:fund:uncommitted'), 0);
      await books();
    });

    test('a repeated accept with the same key reserves once', () async {
      await fund(10000);
      final o = await offer(), u = player();
      final a1 = await FundedJobs.accept(s, u, o.id!, 'same-key-${u.uuid}'), a2 = await FundedJobs.accept(s, u, o.id!, 'same-key-${u.uuid}');
      expect(a1.id, a2.id);
      expect(await RewardLedger.balance(s, 'ngn:fund:reserved'), 50100);
    });

    test('test 5: a duplicate completion pays once (game and cash)', () async {
      await fund(10000);
      final o = await offer(), u = player();
      await WorldAuthority.citizen(s, u);
      final before = (await Bank.fresh(s, u)).naira;
      final a = await FundedJobs.accept(s, u, o.id!, 'k5-${u.uuid}');
      await age(a.id!);
      await Future.wait([for (var i = 0; i < 5; i++) FundedJobs.complete(sessionBuilder.build(), u, a.id!, delivered: true).catchError((_) => <String, dynamic>{})]);
      await FundedJobs.complete(s, u, a.id!, delivered: true);
      expect((await Bank.fresh(s, u)).naira, before + 29499);
      expect(await RewardEarning.db.count(s, where: (t) => t.acceptanceId.equals(a.id!)), 1);
      expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 50100);
      await books();
    });

    test('a completion faster than possible goes to review, unpaid; confirming it pays once', () async {
      await fund(10000);
      final o = await offer(), u = player();
      final a = await FundedJobs.accept(s, u, o.id!, 'kr-${u.uuid}');
      final r = await FundedJobs.complete(s, u, a.id!, delivered: true); // instantly
      expect(r['status'], 'review');
      expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 0);
      await RewardAdmin.decideReview(s, admin1, a.id!, true, 'GPS trace checked');
      await RewardAdmin.decideReview(s, admin1, a.id!, true, 'again').catchError((_) {});
      expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 50100);
      await books();
    });

    test('test 2 and 6: ordinary jobs and Game Naira movements never create cash earnings', () async {
      await fund(10000);
      final p = await RewardAdmin.newPolicy(s, admin1, cashShareBp: 167, feeAllowanceKobo: 0, holdHours: 0);
      final o = await FundedJobs.createOffer(s, type: FundedJobs.ordinary, title: 'Market stall', basis: 3000, closesAt: DateTime.now().add(const Duration(days: 1)),
          policyVersion: p.version, createdBy: admin1.uuid);
      final u = player();
      await WorldAuthority.citizen(s, u);
      final a = await FundedJobs.accept(s, u, o.id!, 'k2-${u.uuid}');
      await age(a.id!);
      await FundedJobs.complete(s, u, a.id!, delivered: true);
      for (var i = 0; i < 5; i++) {
        await Bank.post(s, u, key: 'test:cycle:$i:${u.uuid}', amount: i.isEven ? 50000 : -50000, kind: 'fee', counter: 'city:market', memo: 'cycling game naira');
      }
      expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 0);
      expect(await RewardLedger.balance(s, RewardLedger.available(u)), 0);
      expect(await RewardEarning.db.count(s, where: (t) => t.authUserId.equals(u)), 0);
    });

    Future<UuidValue> earned({int hold = 0, int jobs = 1}) async {
      final u = player();
      for (var i = 0; i < jobs; i++) {
        final o = await offer(hold: hold, fee: 5000);
        final a = await FundedJobs.accept(s, u, o.id!, 'ke-$i-${u.uuid}');
        await age(a.id!);
        await FundedJobs.complete(s, u, a.id!, delivered: true);
      }
      return u;
    }

    test('test 7: pending earnings cannot be withdrawn', () async {
      await fund(10000);
      final u = await earned(hold: 72);
      expect(await RewardLedger.balance(s, RewardLedger.pending(u)), 50100);
      await expectLater(Withdrawals.request(s, u, 50100, 'Sandbox bank 0000', 'w7-${u.uuid}'), throwsA(isA<JobRefused>()));
    });

    test('test 8: two withdrawals at once cannot spend the same balance', () async {
      await fund(10000);
      final u = await earned();
      final rs = await Future.wait([
        for (var i = 0; i < 2; i++) Withdrawals.request(sessionBuilder.build(), u, 50100, 'Sandbox bank 0000', 'w8-$i-${u.uuid}').then((_) => true).catchError((_) => false),
      ]);
      expect(rs.where((r) => r).length, 1);
      expect(await RewardLedger.balance(s, RewardLedger.available(u)), 0);
      expect(await RewardLedger.balance(s, RewardLedger.inflight(u)), 50100);
      await books();
    });

    test('test 9 and 11: forged, duplicate, out-of-order and returned provider events', () async {
      await fund(10000);
      final u = await earned();
      final w = await Withdrawals.request(s, u, 50100, 'Sandbox bank 0000', 'w9-${u.uuid}');
      expect(w.status, 'submitted');
      Future<String> send(String id, String st, {String sec = secret}) {
        final c = MockPayoutProvider.callback(sec, eventId: id, ref: w.ref, status: st);
        return Withdrawals.onProviderEvent(s, provider: 'mock', body: c['body']!, signature: c['signature']!);
      }

      expect(await send('e1', 'paid', sec: 'wrong-secret'), 'rejected_signature');
      expect(await RewardLedger.balance(s, 'ngn:paid'), 0, reason: 'a forged callback moves nothing');
      expect(await send('e2', 'paid'), 'applied');
      expect(await send('e2', 'paid'), 'ignored_duplicate');
      expect(await send('e3', 'paid'), 'ignored_duplicate');
      expect(await send('e4', 'pending'), 'ignored_out_of_order');
      expect(await RewardLedger.balance(s, 'ngn:paid'), 50100);
      expect(await RewardLedger.balance(s, 'ngn:provider_fees'), 5000, reason: 'the house paid the fee from the allowance set aside with the job');
      expect(await send('e5', 'returned'), 'applied');
      expect(await send('e6', 'returned'), 'ignored_duplicate');
      expect(await RewardLedger.balance(s, RewardLedger.available(u)), 50100, reason: 'restored once');
      expect(await RewardLedger.balance(s, 'ngn:paid'), 0);
      await books();
    });

    test('test 10 and 11: an unknown outcome stays reserved; a later failure restores it once', () async {
      await fund(10000);
      final u = await earned();
      Withdrawals.provider = MockPayoutProvider(answer: SubmitOutcome.unknown);
      final w = await Withdrawals.request(s, u, 50100, 'Sandbox bank 0000', 'w10-${u.uuid}');
      expect(w.status, 'unknown');
      expect(await RewardLedger.balance(s, RewardLedger.inflight(u)), 50100);
      expect(await RewardLedger.balance(s, RewardLedger.available(u)), 0);
      final again = await Withdrawals.request(s, u, 50100, 'Sandbox bank 0000', 'w10-${u.uuid}');
      expect(again.ref, w.ref, reason: 'the same request is not resubmitted under a new reference');
      for (final id in ['f1', 'f2']) {
        final c = MockPayoutProvider.callback(secret, eventId: id, ref: w.ref, status: 'failed');
        await Withdrawals.onProviderEvent(s, provider: 'mock', body: c['body']!, signature: c['signature']!);
      }
      expect(await RewardLedger.balance(s, RewardLedger.available(u)), 50100);
      expect(await RewardLedger.balance(s, RewardLedger.inflight(u)), 0);
      await books();
    });

    test('test 15: with no new money for 90 days, every committed reward is still backed', () async {
      await fund(5010);
      final o = await offer();
      final players = <(UuidValue, int)>[];
      for (var i = 0; i < 10; i++) {
        final u = player();
        players.add((u, (await FundedJobs.accept(s, u, o.id!, 'k15-$i-${u.uuid}')).id!));
      }
      expect(await RewardLedger.balance(s, 'ngn:fund:uncommitted'), 0, reason: 'fully committed, no new funding');
      await s.db.unsafeExecute('UPDATE "job_acceptance" SET "deadline" = "deadline" + interval \'90 days\''); // a long campaign
      for (final (u, id) in players) {
        await age(id);
        await FundedJobs.complete(s, u, id, delivered: true);
      }
      expect(await RewardLedger.balance(s, 'ngn:fund:reserved'), 0);
      expect(((await RewardAdmin.dashboard(s, admin1))['ngnKobo'] as Map)['pendingEarnings'], 10 * 50100);
      await books();
    });

    test('test 16: the existing Game Naira ledger is untouched', () async {
      final u = player();
      await WorldAuthority.citizen(s, u);
      await Bank.post(s, u, key: 'test16:${u.uuid}', amount: 1234, kind: 'job', counter: 'city:market', memo: 'shift');
      final c = await Bank.fresh(s, u), audit = await Bank.audit(s);
      expect(audit.where((r) => r['user'] == u.uuid), isEmpty);
      expect(c.naira, greaterThanOrEqualTo(1234));
    });

    test('the ledger cannot be edited or deleted', () async {
      await fund(100);
      await expectLater(s.db.unsafeExecute('UPDATE "reward_entry" SET "amount" = 1'), throwsA(anything));
      await expectLater(s.db.unsafeExecute('DELETE FROM "reward_journal"'), throwsA(anything));
    });

    test('the first policy is seeded once: 1.67% cash, and a new version never changes it', () async {
      final p = await RewardSeed.ensurePolicy(s);
      expect([p!.version, p.cashShareBp, p.feeAllowanceKobo], [1, 167, 83500]);
      expect(await RewardSeed.ensurePolicy(s), isNull);
      await RewardAdmin.newPolicy(s, admin1, cashShareBp: 167, feeAllowanceKobo: 83500, holdHours: 72);
      expect(await RewardSeed.ensurePolicy(s), isNull);
      expect((await RewardPolicy.db.find(s)).map((r) => r.version).toList()..sort(), [1, 2]);
      expect(RewardMath.split(30000, (await RewardPolicy.db.findFirstRow(s, where: (t) => t.version.equals(1)))!.cashShareBp).toString(), 'G₦29499 + ₦501');
    });

    test('dual approval: the proposer cannot approve their own funding', () async {
      final f = await RewardAdmin.propose(s, admin2, RewardUnit.ngn, 100000, 'Bank line 002 sandbox');
      await expectLater(RewardAdmin.decide(s, admin2, f.id!, true), throwsA(isA<JobRefused>()));
    });
  });
}
