import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'funded_jobs.dart';
import 'reward_config.dart';
import 'reward_ledger.dart';
import 'reward_math.dart';

/// What a payout provider said when a payout was submitted. A timeout is [unknown], never a failure.
enum SubmitOutcome { accepted, rejected, unknown }

/// A payout provider. Live providers are added behind this; only [MockPayoutProvider] exists, for the sandbox.
abstract class PayoutProvider {
  String get name;

  /// Submit a payout, idempotently by [ref]: the provider must treat a repeat of the same ref as the same payout.
  Future<(SubmitOutcome, String? providerRef)> submit({required String ref, required int amountKobo, required String beneficiary});
}

/// The sandbox provider: pays nobody. The test can choose what it answers (accept, reject, or time out).
class MockPayoutProvider implements PayoutProvider {
  MockPayoutProvider({this.answer = SubmitOutcome.accepted});
  SubmitOutcome answer;
  final submitted = <String, int>{};
  @override
  String get name => 'mock';
  @override
  Future<(SubmitOutcome, String?)> submit({required String ref, required int amountKobo, required String beneficiary}) async {
    submitted[ref] = amountKobo; // the same ref twice is the same payout
    return (answer, answer == SubmitOutcome.rejected ? null : 'MOCK-$ref');
  }

  /// A callback the mock provider would send, signed with [secret].
  static Map<String, String> callback(String secret, {required String eventId, required String ref, required String status}) {
    final body = jsonEncode({'eventId': eventId, 'ref': ref, 'status': status});
    return {'body': body, 'signature': Withdrawals.sign(secret, body)};
  }
}

abstract final class Withdrawals {
  /// the provider in use (the sandbox's mock unless a live one is approved and configured)
  static PayoutProvider provider = MockPayoutProvider();

  static String sign(String secret, String body) => Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(body)).toString();

  static bool _sameSig(String a, String b) {
    if (a.length != b.length) return false;
    var d = 0;
    for (var i = 0; i < a.length; i++) {
      d |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return d == 0;
  }

  static final _rnd = Random.secure();

  /// A player's real earnings: pending (in the hold), available, and in flight; plus their withdrawals.
  static Future<Map<String, dynamic>> summary(Session s, UuidValue u) async {
    await FundedJobs.matureDue(s, only: u);
    final pending = await RewardLedger.balance(s, RewardLedger.pending(u)), available = await RewardLedger.balance(s, RewardLedger.available(u));
    final inflight = await RewardLedger.balance(s, RewardLedger.inflight(u)), cfg = RewardConfig.current;
    final next = await RewardEarning.db.findFirstRow(s, where: (t) => t.authUserId.equals(u) & t.status.equals('pending'), orderBy: (t) => t.availableAt);
    final ws = await RewardWithdrawal.db.find(s, where: (t) => t.authUserId.equals(u), orderBy: (t) => t.createdAt.desc(), limit: 20);
    return {
      'pendingKobo': pending, 'availableKobo': available, 'inFlightKobo': inflight,
      if (next != null) 'nextAvailableAt': next.availableAt.toIso8601String(),
      'withdrawals': [for (final w in ws) {'ref': w.ref, 'amountKobo': w.amountKobo, 'feeKobo': w.feeKobo, 'feePayer': w.feePayer, 'status': w.status, 'at': w.createdAt.toIso8601String()}],
      'canWithdraw': (cfg.livePayoutsEnabled || cfg.sandbox) && available >= cfg.minWithdrawalKobo,
      'minWithdrawalKobo': cfg.livePayoutsEnabled || cfg.sandbox ? cfg.minWithdrawalKobo : null,
      'feeKobo': cfg.payoutFeeKobo, 'feePayer': cfg.feePayer,
      'mode': cfg.livePayoutsEnabled ? 'live' : (cfg.sandbox ? 'sandbox' : 'off'),
    };
  }

  /// Withdraw [amountKobo] of available earnings to [beneficiary], once per [idemKey]. The amount is moved to "in
  /// flight" in the same transaction that creates the withdrawal, so two requests can never spend the same money.
  static Future<RewardWithdrawal> request(Session s, UuidValue u, int amountKobo, String beneficiary, String idemKey) async {
    final cfg = RewardConfig.current;
    if (!cfg.livePayoutsEnabled && !cfg.sandbox) {
      throw JobRefused(cfg.livePayoutsRequested ? 'Withdrawals are not available yet (setup incomplete).' : 'Withdrawals are not available yet.');
    }
    if ((await RewardSwitch.db.findFirstRow(s, where: (t) => t.key.equals('payouts_paused')))?.enabled ?? false) {
      throw JobRefused('Withdrawals are paused for a short while. Your earnings are safe.');
    }
    if (amountKobo < cfg.minWithdrawalKobo) throw JobRefused('The least you can withdraw is ₦${cfg.minWithdrawalKobo ~/ 100}.');
    if (beneficiary.trim().isEmpty) throw JobRefused('Add a verified account to withdraw to.');
    final again = await RewardWithdrawal.db.findFirstRow(s, where: (t) => t.idemKey.equals(idemKey));
    if (again != null) return again.authUserId == u ? again : (throw JobRefused('Bad request key.'));
    await FundedJobs.matureDue(s, only: u);
    final ref = 'FJW-${DateTime.now().toUtc().millisecondsSinceEpoch.toRadixString(36).toUpperCase()}-${_rnd.nextInt(1 << 30).toRadixString(36).toUpperCase()}';
    final fee = cfg.payoutFeeKobo, payer = cfg.feePayer;
    if (payer == 'player' && fee >= amountKobo) throw JobRefused('The amount must be more than the fee.');
    late RewardWithdrawal w;
    try {
      await s.db.transaction((tx) async {
        final now = DateTime.now().toUtc();
        w = await RewardWithdrawal.db.insertRow(
          s,
          RewardWithdrawal(authUserId: u, amountKobo: amountKobo, feeKobo: fee, feePayer: payer, ref: ref, idemKey: idemKey, status: PayoutState.requested,
              provider: provider.name, beneficiary: beneficiary, createdAt: now, updatedAt: now),
          transaction: tx,
        );
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'withdraw:$ref', ref: '$ref-OUT', kind: 'withdraw', memo: 'Withdrawal $ref requested',
            actor: u.uuid, linkRef: 'wd:$ref', transaction: tx, lines: [(RewardLedger.available(u), -amountKobo), (RewardLedger.inflight(u), amountKobo)]);
      });
    } on LedgerRefused {
      throw JobRefused('You do not have that much available to withdraw.');
    } catch (e) {
      final raced = await RewardWithdrawal.db.findFirstRow(s, where: (t) => t.idemKey.equals(idemKey));
      if (raced != null && raced.authUserId == u) return raced;
      rethrow;
    }
    // submit (idempotent by ref); a timeout leaves it unknown and in flight, to be settled by the provider's report
    SubmitOutcome out;
    String? pref;
    try {
      (out, pref) = await provider.submit(ref: ref, amountKobo: payer == 'player' ? amountKobo - fee : amountKobo, beneficiary: beneficiary);
    } catch (_) {
      out = SubmitOutcome.unknown;
    }
    final to = switch (out) { SubmitOutcome.accepted => PayoutState.submitted, SubmitOutcome.rejected => PayoutState.failed, SubmitOutcome.unknown => PayoutState.unknown };
    await _move(s, w, to, providerRef: pref, actor: 'system');
    return (await RewardWithdrawal.db.findById(s, w.id!))!;
  }

  /// A provider callback: verified, recorded once, applied only if the move is allowed (a late or out-of-order event
  /// is kept but changes nothing).
  static Future<String> onProviderEvent(Session s, {required String provider, required String body, required String signature}) async {
    final secret = RewardConfig.current.providerSecret;
    final ok = secret != null && secret.isNotEmpty && _sameSig(sign(secret, body), signature);
    Map<String, dynamic> m;
    try {
      m = jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return 'rejected_signature';
    }
    final eventId = '${m['eventId'] ?? ''}', ref = '${m['ref'] ?? ''}', status = '${m['status'] ?? ''}';
    if (eventId.isEmpty) return 'rejected_signature';
    final seen = await RewardProviderEvent.db.findFirstRow(s, where: (t) => t.provider.equals(provider) & t.eventId.equals(eventId));
    if (seen != null) return 'ignored_duplicate';
    String outcome;
    final w = await RewardWithdrawal.db.findFirstRow(s, where: (t) => t.ref.equals(ref));
    if (!ok) {
      outcome = 'rejected_signature';
    } else if (w == null) {
      outcome = 'unknown_payout';
    } else if (w.status == status) {
      outcome = 'ignored_duplicate';
    } else if (!PayoutState.canMove(w.status, status)) {
      outcome = 'ignored_out_of_order';
    } else {
      await _move(s, w, status, actor: 'provider:$provider');
      outcome = 'applied';
    }
    try {
      await RewardProviderEvent.db.insertRow(s, RewardProviderEvent(provider: provider, eventId: eventId, payoutRef: ref, status: status, signatureOk: ok, outcome: outcome, receivedAt: DateTime.now().toUtc()));
    } catch (_) {
      return 'ignored_duplicate'; // the same event arrived twice at once
    }
    return outcome;
  }

  /// Move a withdrawal to [to] and post what that means, once:
  ///  * paid: in flight -> paid out (and the fee: from the fee allowance if the house pays, out of the payout if the player does)
  ///  * failed: in flight -> back to available
  ///  * returned (after paid): paid out -> back to available
  static Future<void> _move(Session s, RewardWithdrawal w0, String to, {String? providerRef, required String actor}) async {
    await s.db.transaction((tx) async {
      final rows = await s.db.unsafeQuery('SELECT "status" FROM "reward_withdrawal" WHERE "id" = @i FOR UPDATE', parameters: QueryParameters.named({'i': w0.id}), transaction: tx);
      final from = rows.first[0] as String;
      if (from == to || !PayoutState.canMove(from, to)) return;
      final u = w0.authUserId, ref = w0.ref;
      if (to == PayoutState.paid) {
        final net = w0.feePayer == 'player' ? w0.amountKobo - w0.feeKobo : w0.amountKobo;
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'paid:$ref', ref: '$ref-PAID', kind: 'payout_paid', memo: 'Withdrawal $ref confirmed paid',
            actor: actor, linkRef: 'wd:$ref', transaction: tx, lines: [
          (RewardLedger.inflight(u), -w0.amountKobo),
          ('ngn:paid', net),
          if (w0.feePayer == 'player' && w0.feeKobo > 0) ('ngn:provider_fees', w0.feeKobo),
        ]);
        if (w0.feePayer == 'house' && w0.feeKobo > 0) {
          await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'fee:$ref', ref: '$ref-FEE', kind: 'payout_fee', memo: 'Provider fee for $ref, from the fee allowance',
              actor: actor, linkRef: 'wd:$ref', transaction: tx, lines: [('ngn:fund:fee_reserved', -w0.feeKobo), ('ngn:provider_fees', w0.feeKobo)]);
        }
      } else if (to == PayoutState.failed) {
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'failed:$ref', ref: '$ref-FAIL', kind: 'payout_failed', memo: 'Withdrawal $ref failed: earnings restored',
            actor: actor, linkRef: 'wd:$ref', transaction: tx, lines: [(RewardLedger.inflight(u), -w0.amountKobo), (RewardLedger.available(u), w0.amountKobo)]);
      } else if (to == PayoutState.returned) {
        final net = w0.feePayer == 'player' ? w0.amountKobo - w0.feeKobo : w0.amountKobo;
        // the money came back: the payout is undone; the fee the provider kept stays spent
        await RewardLedger.post(s, unit: RewardUnit.ngn, idemKey: 'returned:$ref', ref: '$ref-RET', kind: 'payout_returned', memo: 'Withdrawal $ref returned by the bank: earnings restored',
            actor: actor, linkRef: 'wd:$ref', transaction: tx, lines: [('ngn:paid', -net), (RewardLedger.available(u), net)]);
      }
      await s.db.unsafeExecute('UPDATE "reward_withdrawal" SET "status" = @st, "updatedAt" = @t${providerRef == null ? '' : ', "providerRef" = @p'} WHERE "id" = @i',
          parameters: QueryParameters.named({'st': to, 't': DateTime.now().toUtc(), 'i': w0.id, if (providerRef != null) 'p': providerRef}), transaction: tx);
    });
  }
}
