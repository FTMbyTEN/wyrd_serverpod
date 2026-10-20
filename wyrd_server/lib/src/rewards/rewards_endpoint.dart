import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import 'funded_jobs.dart';
import 'reward_admin.dart';
import 'withdrawals.dart';

String _err(Object e) => jsonEncode({'error': e is JobRefused ? e.message : 'Something went wrong. Nothing was changed.'});
UuidValue _user(Session s) => UuidValue.fromString(s.authenticated!.userIdentifier);

/// The player's side of jobs and real earnings. Every amount comes from the server; the client only chooses.
class RewardsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The job board: ordinary and (when open) funded jobs, each with its reward line and funding availability.
  Future<String> jobs(Session session) async {
    try {
      return jsonEncode(await FundedJobs.board(session, _user(session)));
    } catch (e) {
      return _err(e);
    }
  }

  /// Accept a job; [requestKey] makes a repeat of the same tap harmless.
  Future<String> accept(Session session, int offerId, String requestKey) async {
    try {
      final a = await FundedJobs.accept(session, _user(session), offerId, requestKey);
      return jsonEncode({'id': a.id, 'status': a.status, 'gameReward': a.gameReward, 'cashKobo': a.cashKobo, 'deadline': a.deadline.toIso8601String(), 'task': jsonDecode(a.taskSpec)});
    } catch (e) {
      return _err(e);
    }
  }

  /// Report a job done. The server times it and checks it; it pays once.
  Future<String> complete(Session session, int acceptanceId, bool delivered) async {
    try {
      return jsonEncode(await FundedJobs.complete(session, _user(session), acceptanceId, delivered: delivered));
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> cancel(Session session, int acceptanceId) async {
    try {
      await FundedJobs.cancel(session, _user(session), acceptanceId);
      return jsonEncode({'cancelled': acceptanceId});
    } catch (e) {
      return _err(e);
    }
  }

  /// Real earnings: pending, available, in flight, withdrawals, and whether a withdrawal is possible.
  Future<String> earnings(Session session) async {
    try {
      return jsonEncode(await Withdrawals.summary(session, _user(session)));
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> withdraw(Session session, int amountKobo, String beneficiary, String requestKey) async {
    try {
      final w = await Withdrawals.request(session, _user(session), amountKobo, beneficiary, requestKey);
      return jsonEncode({'ref': w.ref, 'status': w.status, 'amountKobo': w.amountKobo, 'feeKobo': w.feeKobo, 'feePayer': w.feePayer});
    } catch (e) {
      return _err(e);
    }
  }
}

/// The treasury's side: roles, funding, switches, policies, offers, reviews, reports. Admins only, all audited.
class RewardsAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String> dashboard(Session session) async {
    try {
      return jsonEncode(await RewardAdmin.dashboard(session, _user(session)));
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> setRole(Session session, String userId, String role, bool grant) async {
    try {
      await RewardAdmin.setRole(session, _user(session), UuidValue.fromString(userId), role, grant);
      return jsonEncode({'ok': true});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> proposeFunding(Session session, String unit, int amount, String evidence) async {
    try {
      final f = await RewardAdmin.propose(session, _user(session), unit, amount, evidence);
      return jsonEncode({'id': f.id, 'status': f.status});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> decideFunding(Session session, int fundingId, bool approve) async {
    try {
      final f = await RewardAdmin.decide(session, _user(session), fundingId, approve);
      return jsonEncode({'id': f.id, 'status': f.status, 'journal': f.journalRef});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> setSwitch(Session session, String key, bool on) async {
    try {
      await RewardAdmin.setSwitch(session, _user(session), key, on);
      return jsonEncode({'key': key, 'on': on});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> newPolicy(Session session, int cashShareBp, int feeAllowanceKobo, int holdHours) async {
    try {
      final p = await RewardAdmin.newPolicy(session, _user(session), cashShareBp: cashShareBp, feeAllowanceKobo: feeAllowanceKobo, holdHours: holdHours);
      return jsonEncode({'version': p.version});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> createOffer(Session session, String type, String title, int basis, int closesInHours, int? campaignId, int? policyVersion, int? places) async {
    try {
      final by = _user(session);
      await RewardAdmin.need(session, by, RewardAdmin.operator);
      final o = await FundedJobs.createOffer(session, type: type, title: title, basis: basis, closesAt: DateTime.now().toUtc().add(Duration(hours: closesInHours)),
          campaignId: campaignId, policyVersion: policyVersion, places: places, createdBy: by.uuid);
      await RewardAdmin.audit(session, by, 'offer_create', {'id': o.id, 'type': type, 'basis': basis, 'gameReward': o.gameReward, 'cashKobo': o.cashKobo});
      return jsonEncode({'id': o.id, 'gameReward': o.gameReward, 'cashKobo': o.cashKobo});
    } catch (e) {
      return _err(e);
    }
  }

  /// Pay the game half of any completed gig that is missing it (safe to run twice: each pays once).
  Future<String> repairGameRewards(Session session) async {
    try {
      final by = _user(session);
      await RewardAdmin.need(session, by, RewardAdmin.operator);
      final n = await FundedJobs.repairGameRewards(session);
      await RewardAdmin.audit(session, by, 'repair_game_rewards', {'paid': n});
      return jsonEncode({'paid': n});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> reviews(Session session) async {
    try {
      return jsonEncode(await RewardAdmin.reviews(session, _user(session)));
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> decideReview(Session session, int acceptanceId, bool confirm, String note) async {
    try {
      await RewardAdmin.decideReview(session, _user(session), acceptanceId, confirm, note);
      return jsonEncode({'ok': true});
    } catch (e) {
      return _err(e);
    }
  }

  Future<String> exportCsv(Session session) async {
    try {
      return await RewardAdmin.exportCsv(session, _user(session));
    } catch (e) {
      return _err(e);
    }
  }
}
