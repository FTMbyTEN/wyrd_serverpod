import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../world/bank.dart';
import '../world/world_authority.dart';
import 'reward_config.dart';
import 'reward_ledger.dart';
import 'reward_math.dart';

/// A refusal the player reads.
class JobRefused implements Exception {
  JobRefused(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Funded split-paycheck jobs and ordinary game jobs, with offers, acceptances, completion and the verification hold.
///
/// A FUNDED_SPLIT_JOB, on acceptance, reserves in one database transaction: its cash reward and payout-cost allowance
/// from the Real Rewards Fund (NGN), and its Game Naira from the City Treasury (GN). Nothing is accepted that the
/// funds can't cover, and the agreed rewards are copied onto the acceptance, so no later policy changes them.
/// On completion (server-timed, once per acceptance) the cash becomes the player's pending earnings and the Game
/// Naira is paid into their wallet. After the hold, pending earnings become available to withdraw.
abstract final class FundedJobs {
  static const funded = 'FUNDED_SPLIT_JOB', ordinary = 'ORDINARY_GAME_JOB';
  static final _rnd = Random.secure();

  static Future<RewardPolicy> policy(Session s, int version) async =>
      (await RewardPolicy.db.findFirstRow(s, where: (t) => t.version.equals(version))) ?? (throw JobRefused('No such reward policy.'));

  /// Make an offer (an operator). The split is worked out now, from the policy, and kept on the offer.
  static Future<JobOffer> createOffer(
    Session s, {
    required String type,
    required String title,
    required int basis,
    required DateTime closesAt,
    int? campaignId,
    int? policyVersion,
    int? places,
    int completeMinutes = 30,
    required String createdBy,
  }) async {
    if (type != funded && type != ordinary) throw JobRefused('Unknown job type.');
    late RewardSplit split;
    var fee = 0;
    if (type == funded) {
      if (campaignId == null || policyVersion == null) throw JobRefused('A funded job needs a campaign and a policy.');
      final c = await FundedCampaign.db.findById(s, campaignId);
      if (c == null) throw JobRefused('No such campaign.');
      final p = await policy(s, policyVersion);
      split = RewardMath.split(basis, p.cashShareBp);
      fee = p.feeAllowanceKobo;
    } else {
      split = RewardMath.ordinary(basis);
    }
    return JobOffer.db.insertRow(
      s,
      JobOffer(
        type: type,
        campaignId: campaignId,
        title: title,
        task: 'delivery',
        basis: basis,
        gameReward: split.gameReward,
        cashKobo: split.cashKobo,
        feeKobo: type == funded ? fee : 0,
        policyVersion: policyVersion,
        places: places,
        closesAt: closesAt.toUtc(),
        completeMinutes: completeMinutes,
        status: 'open',
        createdBy: createdBy,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  static Future<bool> _switch(Session s, String key) async => (await RewardSwitch.db.findFirstRow(s, where: (t) => t.key.equals(key)))?.enabled ?? false;

  /// The offers a player can see, with how many funded places the fund can still back.
  static Future<List<Map<String, dynamic>>> board(Session s, UuidValue u) async {
    await expireDue(s);
    final now = DateTime.now().toUtc(), cfg = RewardConfig.current;
    final offers = await JobOffer.db.find(s, where: (t) => t.status.equals('open') & (t.closesAt > now), orderBy: (t) => t.createdAt.desc(), limit: 50);
    final unc = await RewardLedger.balance(s, 'ngn:fund:uncommitted'), paused = await _switch(s, 'funded_jobs_paused');
    final mine = {for (final a in await JobAcceptance.db.find(s, where: (t) => t.authUserId.equals(u))) a.offerId: a};
    return [
      for (final o in offers)
        if (o.type == ordinary || cfg.fundedJobsEnabled)
          {
            'id': o.id, 'type': o.type, 'title': o.title, 'gameReward': o.gameReward, 'cashKobo': o.cashKobo,
            'line': RewardMath.rewardLine(o.gameReward, o.cashKobo), 'completeMinutes': o.completeMinutes, 'closesAt': o.closesAt.toIso8601String(),
            if (o.type == funded) 'funding': paused ? 'paused' : (RewardMath.capacity(unc, o.cashKobo, o.feeKobo) > 0 ? 'available' : 'exhausted'),
            if (mine[o.id] != null) ...{'mine': mine[o.id]!.status, 'acceptanceId': mine[o.id]!.id, 'deadline': mine[o.id]!.deadline.toIso8601String()},
          },
    ];
  }

  /// Accept an offer, once per [idemKey]. Returns the acceptance (its rewards are the agreed ones).
  static Future<JobAcceptance> accept(Session s, UuidValue u, int offerId, String idemKey) async {
    if (idemKey.length < 8 || idemKey.length > 80) throw JobRefused('Bad request key.');
    final again = await JobAcceptance.db.findFirstRow(s, where: (t) => t.idemKey.equals(idemKey));
    if (again != null) {
      if (again.authUserId != u) throw JobRefused('Bad request key.');
      return again; // the same request again: nothing new
    }
    final o = await JobOffer.db.findById(s, offerId);
    final now = DateTime.now().toUtc(), cfg = RewardConfig.current;
    if (o == null || o.status != 'open' || !o.closesAt.isAfter(now)) throw JobRefused('That job is no longer offered.');
    await WorldAuthority.citizen(s, u); // a player with a wallet
    final already = await JobAcceptance.db.findFirstRow(s, where: (t) => t.offerId.equals(offerId) & t.authUserId.equals(u));
    if (already != null) throw JobRefused('You have already taken this job.');
    if (o.type == funded) {
      if (!cfg.fundedJobsEnabled) throw JobRefused('Funded jobs are not open.');
      if (await _switch(s, 'funded_jobs_paused')) throw JobRefused('New funded places are paused. Jobs you already took are not affected.');
      final camp = o.campaignId == null ? null : await FundedCampaign.db.findById(s, o.campaignId!);
      if (camp == null || camp.status != 'active') throw JobRefused('This campaign is not taking new players.');
      final today = now.subtract(const Duration(hours: 24));
      final recent = await JobAcceptance.db.find(s, where: (t) => t.authUserId.equals(u) & (t.acceptedAt > today), orderBy: (t) => t.acceptedAt.desc());
      final fundedRecent = <JobAcceptance>[];
      for (final a in recent) {
        final ao = await JobOffer.db.findById(s, a.offerId);
        if (ao?.type == funded) fundedRecent.add(a);
      }
      if (fundedRecent.length >= cfg.fundedPerDay) throw JobRefused('That is your limit of funded jobs for today.');
      if (fundedRecent.isNotEmpty && now.difference(fundedRecent.first.acceptedAt).inMinutes < cfg.fundedCooldownMinutes) {
        throw JobRefused('Take a short break before the next funded job.');
      }
    }
    final p = o.policyVersion == null ? null : await policy(s, o.policyVersion!);
    final dist = 800 + _rnd.nextInt(1700), limitS = (dist / 4).round() + 120; // a delivery the server sets
    final spec = jsonEncode({'task': o.task, 'dist': dist, 'limitS': limitS});
    try {
      return await s.db.transaction((tx) async {
        if (o.places != null) {
          await s.db.unsafeQuery('SELECT "id" FROM "job_offer" WHERE "id" = @i FOR UPDATE', parameters: QueryParameters.named({'i': o.id}), transaction: tx);
          final taken = await JobAcceptance.db.count(s, where: (t) => t.offerId.equals(o.id!) & t.status.notInSet({'expired', 'cancelled'}), transaction: tx);
          if (taken >= o.places!) throw JobRefused('All the places on this job are taken.');
        }
        final acc = await JobAcceptance.db.insertRow(
          s,
          JobAcceptance(
            offerId: o.id!, authUserId: u, idemKey: idemKey, status: 'accepted', taskSpec: spec,
            gameReward: o.gameReward, cashKobo: o.cashKobo, feeKobo: o.feeKobo, holdHours: p?.holdHours ?? 0,
            acceptedAt: now, deadline: now.add(Duration(minutes: o.completeMinutes)),
          ),
          transaction: tx,
        );
        if (o.type == funded) {
          final ref = 'FJ-RES-${acc.id}';
          // the cash and its fee allowance, from what is funded and not yet promised; refused if it can't cover them
          await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'reserve:${acc.id}', ref: ref, kind: 'reserve', memo: 'Funded job ${o.id}: cash and fee allowance reserved',
              actor: u.uuid, linkRef: 'acc:${acc.id}', transaction: tx, lines: [
            ('ngn:fund:uncommitted', -(o.cashKobo + o.feeKobo)),
            ('ngn:fund:reserved', o.cashKobo),
            if (o.feeKobo > 0) ('ngn:fund:fee_reserved', o.feeKobo),
          ]);
          // the Game Naira, from the City Treasury
          await RewardLedger.post(s, unit: RewardUnit.gn, idemKey: 'reserve-gn:${acc.id}', ref: 'FJ-RESG-${acc.id}', kind: 'reserve', memo: 'Funded job ${o.id}: game reward reserved',
              actor: u.uuid, linkRef: 'acc:${acc.id}', transaction: tx, lines: [('gn:treasury', -o.gameReward), ('gn:reserved', o.gameReward)]);
          return JobAcceptance.db.updateRow(s, acc.copyWith(reserveRef: ref), transaction: tx);
        }
        return acc;
      });
    } on LedgerRefused catch (e) {
      throw JobRefused(e.code == 'gn:treasury' ? 'The City Treasury cannot cover this job right now.' : 'The rewards fund has no places left on this job.');
    } catch (e) {
      final raced = await JobAcceptance.db.findFirstRow(s, where: (t) => t.idemKey.equals(idemKey));
      if (raced != null && raced.authUserId == u) return raced;
      if (e is JobRefused) rethrow;
      final dup = await JobAcceptance.db.findFirstRow(s, where: (t) => t.offerId.equals(offerId) & t.authUserId.equals(u));
      if (dup != null) throw JobRefused('You have already taken this job.');
      rethrow;
    }
  }

  /// Complete an accepted job with the game's report ([seconds] is ignored: the server times it from acceptance).
  /// The delivery must be possible in the time taken and inside the deadline. Paid once per acceptance.
  static Future<Map<String, dynamic>> complete(Session s, UuidValue u, int acceptanceId, {required bool delivered}) async {
    final a0 = await JobAcceptance.db.findById(s, acceptanceId);
    if (a0 == null || a0.authUserId != u) throw JobRefused('No such job.');
    if (a0.status == 'completed') return _paid(s, a0); // already done: the same answer, nothing new
    if (a0.status != 'accepted') throw JobRefused('This job is ${a0.status}.');
    final now = DateTime.now().toUtc(), spec = jsonDecode(a0.taskSpec) as Map<String, dynamic>;
    final secs = now.difference(a0.acceptedAt).inMilliseconds / 1000, dist = spec['dist'] as int;
    if (!delivered) throw JobRefused('The delivery was not made.');
    if (now.isAfter(a0.deadline)) throw JobRefused('Too late: the job expired.');
    final tooFast = secs < dist / 45; // faster than anything in the game can go
    // nothing is paid on the player's word: every completion waits for an operator to confirm it (decideReview)
    if (!tooFast) {
      await JobAcceptance.db.updateRow(s, a0.copyWith(status: 'review', note: 'Completed in ${secs.toStringAsFixed(0)} s: waiting for an operator to confirm.'));
      return {'status': 'review', 'note': 'Done! An operator checks every paid gig before the cash reward is released. You\'ll be told when it\'s confirmed.'};
    }
    final offer = (await JobOffer.db.findById(s, a0.offerId))!;
    if (tooFast) {
      // not paid, not refused outright: an operator looks at it (the player can appeal)
      await JobAcceptance.db.updateRow(s, a0.copyWith(status: 'review', note: 'Completed faster than possible (${secs.toStringAsFixed(0)} s for $dist m).'));
      return {'status': 'review', 'note': 'This completion is being checked. You keep your place; the reward is paid if it is confirmed.'};
    }
    await _settle(s, a0, offer, actor: u.uuid);
    return _paid(s, (await JobAcceptance.db.findById(s, acceptanceId))!);
  }

  /// Pay a completion (the player's own, or one an operator confirmed after review): once per acceptance.
  static Future<void> _settle(Session s, JobAcceptance a0, JobOffer offer, {required String actor}) async {
    final now = DateTime.now().toUtc();
    await s.db.transaction((tx) async {
      final rows = await s.db.unsafeQuery('SELECT "status" FROM "job_acceptance" WHERE "id" = @i FOR UPDATE', parameters: QueryParameters.named({'i': a0.id}), transaction: tx);
      if (rows.isEmpty || !{'accepted', 'review'}.contains(rows.first[0])) return; // already settled (or no longer payable)
      if (offer.type == funded) {
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'earn:${a0.id}', ref: 'FJ-ERN-${a0.id}', kind: 'earn', memo: 'Funded job completed: cash reward pending verification',
            actor: actor, linkRef: 'acc:${a0.id}', transaction: tx, lines: [('ngn:fund:reserved', -a0.cashKobo), (RewardLedger.pending(a0.authUserId), a0.cashKobo)]);
        await RewardLedger.post(s, unit: RewardUnit.gn, idemKey: 'game:${a0.id}', ref: 'FJ-GAM-${a0.id}', kind: 'game_reward', memo: 'Funded job completed: game reward paid from the City Treasury',
            actor: actor, linkRef: 'acc:${a0.id}', transaction: tx, lines: [('gn:reserved', -a0.gameReward), ('gn:paid_players', a0.gameReward)]);
        await RewardEarning.db.insertRow(s, RewardEarning(acceptanceId: a0.id!, authUserId: a0.authUserId, cashKobo: a0.cashKobo, status: 'pending', availableAt: now.add(Duration(hours: a0.holdHours)), createdAt: now), transaction: tx);
      }
      await s.db.unsafeExecute('UPDATE "job_acceptance" SET "status" = \'completed\', "completedAt" = @t WHERE "id" = @i', parameters: QueryParameters.named({'t': now, 'i': a0.id}), transaction: tx);
    });
    await _payGame(s, a0);
  }

  /// The Game Naira into the player's wallet (idempotent: retried safely, see [repairGameRewards]).
  static Future<void> _payGame(Session s, JobAcceptance a) async {
    await Bank.post(s, a.authUserId, key: 'funded:${a.id}:game', amount: a.gameReward, kind: 'job', counter: 'city:treasury', memo: 'Job reward (game currency)');
  }

  static Future<Map<String, dynamic>> _paid(Session s, JobAcceptance a) async {
    await _payGame(s, a);
    final e = await RewardEarning.db.findFirstRow(s, where: (t) => t.acceptanceId.equals(a.id!));
    return {
      'status': 'completed', 'gameReward': a.gameReward, 'cashKobo': a.cashKobo,
      if (e != null) 'cash': {'status': e.status, 'availableAt': e.availableAt.toIso8601String()},
      'line': a.cashKobo > 0
          ? 'Paid G₦${a.gameReward} game currency. ₦${a.cashKobo ~/ 100} cash reward pending verification until ${e?.availableAt.toIso8601String() ?? '-'}.'
          : 'Paid G₦${a.gameReward} game currency.',
    };
  }

  /// Completed acceptances whose Game Naira didn't reach the wallet (a crash between the two writes): paid now.
  static Future<int> repairGameRewards(Session s) async {
    var n = 0;
    for (final a in await JobAcceptance.db.find(s, where: (t) => t.status.equals('completed'))) {
      final paid = await NairaEntry.db.findFirstRow(s, where: (t) => t.key.equals('funded:${a.id}:game'));
      if (paid == null) {
        await _payGame(s, a);
        n++;
      }
    }
    return n;
  }

  /// Pending earnings whose hold is over become available (never one held for review).
  static Future<int> matureDue(Session s, {UuidValue? only}) async {
    final now = DateTime.now().toUtc();
    final due = only == null
        ? await RewardEarning.db.find(s, where: (t) => t.status.equals('pending') & (t.availableAt <= now))
        : await RewardEarning.db.find(s, where: (t) => t.status.equals('pending') & (t.availableAt <= now) & t.authUserId.equals(only));
    for (final e in due) {
      await s.db.transaction((tx) async {
        final rows = await s.db.unsafeQuery('SELECT "status" FROM "reward_earning" WHERE "id" = @i FOR UPDATE', parameters: QueryParameters.named({'i': e.id}), transaction: tx);
        if (rows.isEmpty || rows.first[0] != 'pending') return;
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'mature:${e.id}', ref: 'FJ-MAT-${e.id}', kind: 'mature', memo: 'Verification complete: cash reward available',
            actor: 'system', linkRef: 'acc:${e.acceptanceId}', transaction: tx, lines: [(RewardLedger.pending(e.authUserId), -e.cashKobo), (RewardLedger.available(e.authUserId), e.cashKobo)]);
        await s.db.unsafeExecute('UPDATE "reward_earning" SET "status" = \'available\' WHERE "id" = @i', parameters: QueryParameters.named({'i': e.id}), transaction: tx);
      });
    }
    return due.length;
  }

  /// Accepted jobs past their deadline: the reservation goes back to the fund. Never one in review (it's still being
  /// decided), never one completed (its rewards are earned).
  static Future<int> expireDue(Session s) async {
    final now = DateTime.now().toUtc();
    final due = await JobAcceptance.db.find(s, where: (t) => t.status.equals('accepted') & (t.deadline < now), limit: 200);
    for (final a in due) {
      await release(s, a, 'expired', 'The time to complete it ran out.', actor: 'system');
    }
    return due.length;
  }

  /// Cancel an accepted job (the player, or an operator): the reservation goes back to the fund.
  static Future<void> cancel(Session s, UuidValue by, int acceptanceId, {bool admin = false, String reason = 'Cancelled by the player.'}) async {
    final a = await JobAcceptance.db.findById(s, acceptanceId);
    if (a == null || (!admin && a.authUserId != by)) throw JobRefused('No such job.');
    if (a.status != 'accepted' && !(admin && a.status == 'review')) throw JobRefused('This job can no longer be cancelled.');
    await release(s, a, admin ? 'cancelled' : 'cancelled', reason, actor: by.uuid);
  }

  /// Put an acceptance's reservation back (once) and close it with [status].
  static Future<void> release(Session s, JobAcceptance a, String status, String note, {required String actor}) async {
    await s.db.transaction((tx) async {
      final rows = await s.db.unsafeQuery('SELECT "status" FROM "job_acceptance" WHERE "id" = @i FOR UPDATE', parameters: QueryParameters.named({'i': a.id}), transaction: tx);
      if (rows.isEmpty || !{'accepted', 'review'}.contains(rows.first[0])) return;
      if (a.reserveRef != null) {
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'release:${a.id}', ref: 'FJ-REL-${a.id}', kind: 'release', memo: 'Funded job $status: reservation released',
            actor: actor, linkRef: 'acc:${a.id}', transaction: tx, lines: [
          ('ngn:fund:reserved', -a.cashKobo),
          if (a.feeKobo > 0) ('ngn:fund:fee_reserved', -a.feeKobo),
          ('ngn:fund:uncommitted', a.cashKobo + a.feeKobo),
        ]);
        await RewardLedger.post(s, unit: RewardUnit.gn, idemKey: 'release-gn:${a.id}', ref: 'FJ-RELG-${a.id}', kind: 'release', memo: 'Funded job $status: game reward released',
            actor: actor, linkRef: 'acc:${a.id}', transaction: tx, lines: [('gn:reserved', -a.gameReward), ('gn:treasury', a.gameReward)]);
      }
      await s.db.unsafeExecute('UPDATE "job_acceptance" SET "status" = @st, "note" = @n WHERE "id" = @i', parameters: QueryParameters.named({'st': status, 'n': note, 'i': a.id}), transaction: tx);
    });
  }

  /// An operator decides a completion in review: confirm (paid as normal) or reject (reservation released). The
  /// player may appeal a rejection to support with the acceptance's reference.
  static Future<void> decideReview(Session s, UuidValue operator, int acceptanceId, {required bool confirm, required String note}) async {
    final a = await JobAcceptance.db.findById(s, acceptanceId);
    if (a == null || a.status != 'review') throw JobRefused('Nothing to decide.');
    final offer = (await JobOffer.db.findById(s, a.offerId))!;
    if (confirm) {
      await _settle(s, a, offer, actor: operator.uuid);
    } else {
      await release(s, a, 'rejected', note, actor: operator.uuid);
    }
  }
}
