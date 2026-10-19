/// The rewards system's arithmetic and state rules, with no database: integer minor units only (Game Naira in whole
/// naira, real naira in kobo), never floating point. Everything money-shaped in lib/src/rewards goes through here, so
/// it can be tested on its own.
library;

/// The units the rewards ledger keeps apart. A journal moves exactly one of them.
abstract final class RewardUnit {
  /// Game Naira, in whole naira (scale 0), the same precision as world_citizen.naira.
  static const gn = 'GN';

  /// Real Nigerian naira, in kobo (scale 2).
  static const ngn = 'NGN';
}

/// The split of a funded job's reward basis into Game Naira and real cash.
class RewardSplit {
  const RewardSplit(this.gameReward, this.cashKobo);

  /// Game Naira paid on completion (whole naira)
  final int gameReward;

  /// real cash reward, in kobo
  final int cashKobo;

  int get cashNaira => cashKobo ~/ 100;

  @override
  String toString() => 'G₦$gameReward + ₦$cashNaira';
}

abstract final class RewardMath {
  /// Policy (owner decision D9, 2026-10-19): the cash share is [cashShareBp] basis points of the reward basis, where one
  /// basis unit is one naira; the cash is rounded DOWN to the whole naira, and the game reward is the rest of the basis.
  /// So basis 30,000 at 167 bp: cash = floor(30,000 x 167 / 10,000) = ₦501, game = G₦29,499.
  static RewardSplit split(int basis, int cashShareBp) {
    if (basis <= 0) throw ArgumentError.value(basis, 'basis', 'must be positive');
    if (cashShareBp < 0 || cashShareBp > 10000) throw ArgumentError.value(cashShareBp, 'cashShareBp');
    final cashNaira = (basis * cashShareBp) ~/ 10000;
    return RewardSplit(basis - cashNaira, cashNaira * 100);
  }

  /// An ordinary game job: all Game Naira, no cash, ever.
  static RewardSplit ordinary(int basis) {
    if (basis <= 0) throw ArgumentError.value(basis, 'basis', 'must be positive');
    return RewardSplit(basis, 0);
  }

  /// How many funded acceptances [uncommittedKobo] can still back, each reserving its cash and its fee allowance.
  static int capacity(int uncommittedKobo, int cashKobo, int feeKobo) {
    final per = cashKobo + feeKobo;
    if (per <= 0) return 0;
    return uncommittedKobo <= 0 ? 0 : uncommittedKobo ~/ per;
  }

  /// The optional city levy on an allowlisted commercial Game Naira payment: [bp] basis points of the gross, rounded
  /// down to the whole naira, taken out of the gross (the recipient gets gross - fee). No minimum fee: a payment
  /// small enough to round to zero pays none. Returns (fee, net to the recipient).
  static (int fee, int net) levy(int gross, {int bp = 50}) {
    if (gross <= 0) throw ArgumentError.value(gross, 'gross', 'must be positive');
    final fee = (gross * bp) ~/ 10000;
    return (fee, gross - fee);
  }

  /// "Reward: G₦29,499 game currency + ₦501 cash reward." -- shown before a player accepts.
  static String rewardLine(int gameReward, int cashKobo) =>
      cashKobo > 0 ? 'Reward: G₦${_n(gameReward)} game currency + ₦${_n(cashKobo ~/ 100)}${cashKobo % 100 == 0 ? '' : '.${(cashKobo % 100).toString().padLeft(2, '0')}'} cash reward.' : 'Reward: G₦${_n(gameReward)} game currency.';

  static String _n(int v) => v.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
}

/// The life of a withdrawal. A timeout is never treated as a failure: the payout stays [unknown] (still reserved) until
/// the provider's own report settles it, and it is never resubmitted under a new reference.
abstract final class PayoutState {
  static const requested = 'requested', submitted = 'submitted', pending = 'pending', unknown = 'unknown';
  static const paid = 'paid', failed = 'failed', returned = 'returned';

  static const _next = <String, Set<String>>{
    requested: {submitted, unknown, failed},
    submitted: {pending, paid, failed, unknown},
    pending: {paid, failed, unknown},
    unknown: {pending, paid, failed},
    paid: {returned}, // a bank can send a completed payout back
    failed: {},
    returned: {},
  };

  /// May a payout in [from] move to [to]? (Repeating the current state is a no-op the caller ignores.)
  static bool canMove(String from, String to) => _next[from]?.contains(to) ?? false;

  /// Final states: the money's fate is settled.
  static bool isFinal(String s) => s == failed || s == returned;

  /// States in which the money is still reserved in flight.
  static bool isInFlight(String s) => s == requested || s == submitted || s == pending || s == unknown;
}
