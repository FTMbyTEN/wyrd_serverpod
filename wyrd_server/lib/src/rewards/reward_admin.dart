import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import 'funded_jobs.dart';
import 'reward_ledger.dart';
import 'reward_math.dart';

/// Treasury administration: who may do what, dual approval for money in, switches, and the reconciled reports.
/// None of this is reachable by WYRD (the AI): these are admin endpoint calls by a signed-in person with a role, and
/// every one is written to the audit log.
abstract final class RewardAdmin {
  static const viewer = 'viewer', operator = 'operator', approver = 'approver';

  /// The owner (the drone operator) holds every role; others hold what they were granted.
  static Future<bool> has(Session s, UuidValue u, String role) async {
    if (await DroneService.isOperator(s, u)) return true;
    final roles = {for (final r in await RewardRole.db.find(s, where: (t) => t.authUserId.equals(u))) r.role};
    if (roles.contains(role)) return true;
    return role == viewer && (roles.contains(operator) || roles.contains(approver));
  }

  static Future<void> need(Session s, UuidValue u, String role) async {
    if (!await has(s, u, role)) throw JobRefused('Not allowed.');
  }

  static Future<void> audit(Session s, UuidValue? actor, String action, Map<String, dynamic> details) =>
      RewardAudit.db.insertRow(s, RewardAudit(actor: actor, action: action, details: jsonEncode(details), createdAt: DateTime.now().toUtc()));

  /// Grant or revoke a role (the owner only).
  static Future<void> setRole(Session s, UuidValue owner, UuidValue who, String role, bool grant) async {
    if (!await DroneService.isOperator(s, owner)) throw JobRefused('Only the owner manages roles.');
    if (!{viewer, operator, approver}.contains(role)) throw JobRefused('Unknown role.');
    if (grant) {
      if (await RewardRole.db.findFirstRow(s, where: (t) => t.authUserId.equals(who) & t.role.equals(role)) == null) {
        await RewardRole.db.insertRow(s, RewardRole(authUserId: who, role: role, grantedBy: owner, createdAt: DateTime.now().toUtc()));
      }
    } else {
      await RewardRole.db.deleteWhere(s, where: (t) => t.authUserId.equals(who) & t.role.equals(role));
    }
    await audit(s, owner, grant ? 'role_grant' : 'role_revoke', {'who': who.uuid, 'role': role});
  }

  /// Propose money in: NGN received into the Real Rewards Fund (with its bank evidence), or GN issued to the City
  /// Treasury. Nothing posts until a different admin approves it.
  static Future<RewardFunding> propose(Session s, UuidValue by, String unit, int amount, String evidence) async {
    await need(s, by, operator);
    if (unit != RewardUnit.ngn && unit != RewardUnit.gn) throw JobRefused('Unknown unit.');
    if (amount <= 0) throw JobRefused('The amount must be positive.');
    if (evidence.trim().length < 8) throw JobRefused('Say where the money is (e.g. the bank statement line).');
    final f = await RewardFunding.db.insertRow(s, RewardFunding(unit: unit, amount: amount, evidence: evidence.trim(), status: 'proposed', proposedBy: by, createdAt: DateTime.now().toUtc()));
    await audit(s, by, 'funding_propose', {'id': f.id, 'unit': unit, 'amount': amount, 'evidence': evidence});
    return f;
  }

  /// Approve (or reject) a proposal: never by the person who proposed it.
  static Future<RewardFunding> decide(Session s, UuidValue by, int fundingId, bool approve) async {
    await need(s, by, approver);
    final f = await RewardFunding.db.findById(s, fundingId);
    if (f == null || f.status != 'proposed') throw JobRefused('Nothing to decide.');
    if (f.proposedBy == by) throw JobRefused('A second person must approve this.');
    var out = f.copyWith(status: approve ? 'approved' : 'rejected', approvedBy: by, decidedAt: DateTime.now().toUtc());
    if (approve) {
      final ref = 'FUND-${f.id}';
      await RewardLedger.post(s, unit: f.unit, idemKey: 'funding:${f.id}', ref: ref, kind: f.unit == RewardUnit.ngn ? 'fund' : 'issue',
          memo: f.unit == RewardUnit.ngn ? 'Real Rewards Fund topped up (approved)' : 'Game Naira issued to the City Treasury (approved)', actor: by.uuid, linkRef: 'funding:${f.id}',
          lines: f.unit == RewardUnit.ngn ? [('ngn:external', -f.amount), ('ngn:fund:uncommitted', f.amount)] : [('gn:issued', -f.amount), ('gn:treasury', f.amount)]);
      out = out.copyWith(journalRef: ref);
    }
    out = await RewardFunding.db.updateRow(s, out);
    await audit(s, by, approve ? 'funding_approve' : 'funding_reject', {'id': f.id});
    return out;
  }

  /// Pause or resume new funded acceptances (funded_jobs_paused) or new payouts (payouts_paused). Liabilities stay.
  static Future<void> setSwitch(Session s, UuidValue by, String key, bool on) async {
    await need(s, by, operator);
    if (!{'funded_jobs_paused', 'payouts_paused'}.contains(key)) throw JobRefused('Unknown switch.');
    final now = DateTime.now().toUtc(), cur = await RewardSwitch.db.findFirstRow(s, where: (t) => t.key.equals(key));
    if (cur == null) {
      await RewardSwitch.db.insertRow(s, RewardSwitch(key: key, enabled: on, updatedBy: by, updatedAt: now));
    } else {
      await RewardSwitch.db.updateRow(s, cur.copyWith(enabled: on, updatedBy: by, updatedAt: now));
    }
    await audit(s, by, 'switch', {'key': key, 'on': on});
  }

  /// A new reward policy version (operators). Existing offers keep the version they were made with.
  static Future<RewardPolicy> newPolicy(Session s, UuidValue by, {required int cashShareBp, required int feeAllowanceKobo, required int holdHours}) async {
    await need(s, by, operator);
    if (cashShareBp < 0 || cashShareBp > 10000 || feeAllowanceKobo < 0 || holdHours < 0) throw JobRefused('Bad policy.');
    final last = await RewardPolicy.db.findFirstRow(s, orderBy: (t) => t.version.desc());
    final p = await RewardPolicy.db.insertRow(s, RewardPolicy(version: (last?.version ?? 0) + 1, cashShareBp: cashShareBp, feeAllowanceKobo: feeAllowanceKobo, holdHours: holdHours, createdBy: by.uuid, createdAt: DateTime.now().toUtc()));
    await audit(s, by, 'policy_new', {'version': p.version, 'cashShareBp': cashShareBp, 'feeAllowanceKobo': feeAllowanceKobo, 'holdHours': holdHours});
    return p;
  }

  static Future<int> _sumLike(Session s, String prefix) async {
    final r = await s.db.unsafeQuery('SELECT COALESCE(SUM("balance"),0) FROM "reward_account" WHERE "code" LIKE @p', parameters: QueryParameters.named({'p': '$prefix%'}));
    return (r.first[0] as num).toInt();
  }

  /// The treasury report: every figure read from the ledger, each obligation counted in exactly one state.
  static Future<Map<String, dynamic>> dashboard(Session s, UuidValue by) async {
    await need(s, by, viewer);
    final b = (String c) => RewardLedger.balance(s, c);
    final received = -(await b('ngn:external'));
    final ngn = {
      'fundedTotal': received,
      'uncommitted': await b('ngn:fund:uncommitted'),
      'reservedAcceptedJobs': await b('ngn:fund:reserved'),
      'feeAllowanceReserved': await b('ngn:fund:fee_reserved'),
      'pendingEarnings': await _sumLike(s, 'ngn:earn:pending:'),
      'availableUnpaidEarnings': await _sumLike(s, 'ngn:earn:available:'),
      'inFlightPayouts': await _sumLike(s, 'ngn:payout:inflight:'),
      'confirmedPaid': await b('ngn:paid'),
      'providerFees': await b('ngn:provider_fees'),
    };
    // every naira received is in exactly one place
    final placed = ngn['uncommitted']! + ngn['reservedAcceptedJobs']! + ngn['feeAllowanceReserved']! + ngn['pendingEarnings']! + ngn['availableUnpaidEarnings']! +
        ngn['inFlightPayouts']! + ngn['confirmedPaid']! + ngn['providerFees']!;
    final gn = {'issued': -(await b('gn:issued')), 'treasury': await b('gn:treasury'), 'reserved': await b('gn:reserved'), 'paidToPlayers': await b('gn:paid_players')};
    final review = await JobAcceptance.db.count(s, where: (t) => t.status.equals('review'));
    final switches = {for (final w in await RewardSwitch.db.find(s)) w.key: w.enabled};
    return {
      'ngnKobo': ngn,
      'ngnBalanced': placed == received,
      'gn': gn,
      'gnBalanced': gn['treasury']! + gn['reserved']! + gn['paidToPlayers']! == gn['issued']!,
      'flaggedCompletions': review,
      'switches': switches,
      'reconciliation': await RewardLedger.reconcile(s),
      'gameRewardsUnpaid': await _gameUnpaid(s),
      'note': 'Internal figures. "fundedTotal" is what admins recorded as received; it must still be matched against the bank and provider statements.',
    };
  }

  static Future<int> _gameUnpaid(Session s) async {
    final r = await s.db.unsafeQuery(
      'SELECT COUNT(*) FROM "job_acceptance" a WHERE a."status" = \'completed\' AND NOT EXISTS (SELECT 1 FROM "naira_entry" n WHERE n."key" = \'funded:\' || a."id" || \':game\')',
    );
    return (r.first[0] as num).toInt();
  }

  /// The audit log and the journals, as CSV, for export.
  static Future<String> exportCsv(Session s, UuidValue by) async {
    await need(s, by, viewer);
    await audit(s, by, 'export', {});
    final q = (String v) => '"${v.replaceAll('"', '""')}"';
    final out = StringBuffer('type,at,ref_or_action,unit,kind,actor,details\n');
    for (final a in await RewardAudit.db.find(s, orderBy: (t) => t.createdAt)) {
      out.writeln(['audit', a.createdAt.toIso8601String(), a.action, '', '', a.actor?.uuid ?? '', a.details].map(q).join(','));
    }
    for (final j in await RewardJournal.db.find(s, orderBy: (t) => t.createdAt)) {
      final lines = await RewardEntry.db.find(s, where: (t) => t.journalId.equals(j.id!));
      final ids = {for (final a in await RewardAccount.db.find(s, where: (t) => t.id.inSet(lines.map((l) => l.accountId).toSet()))) a.id: a.code};
      out.writeln(['journal', j.createdAt.toIso8601String(), j.ref, j.unit, j.kind, j.actor, lines.map((l) => '${ids[l.accountId]}:${l.amount}').join(' ')].map(q).join(','));
    }
    return out.toString();
  }

  /// Completions waiting for an operator.
  static Future<List<Map<String, dynamic>>> reviews(Session s, UuidValue by) async {
    await need(s, by, operator);
    return [
      for (final a in await JobAcceptance.db.find(s, where: (t) => t.status.equals('review'), orderBy: (t) => t.acceptedAt))
        {'id': a.id, 'user': a.authUserId.uuid, 'offerId': a.offerId, 'cashKobo': a.cashKobo, 'gameReward': a.gameReward, 'note': a.note, 'acceptedAt': a.acceptedAt.toIso8601String()},
    ];
  }

  static Future<void> decideReview(Session s, UuidValue by, int acceptanceId, bool confirm, String note) async {
    await need(s, by, operator);
    await FundedJobs.decideReview(s, by, acceptanceId, confirm: confirm, note: note);
    await audit(s, by, confirm ? 'review_confirm' : 'review_reject', {'acceptance': acceptanceId, 'note': note});
  }
}
