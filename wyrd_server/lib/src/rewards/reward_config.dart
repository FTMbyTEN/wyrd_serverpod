import 'dart:io';

/// The rewards system's switches, read from the environment. Every one defaults to off; turning one on in config is
/// not an approval to run it for real money (see docs/funded-split-paycheck).
class RewardConfig {
  RewardConfig._(this._env);

  /// the live process environment
  static RewardConfig get current =>
      _override ?? (_live ??= RewardConfig._(Platform.environment));
  static RewardConfig? _live, _override;

  /// tests (and the sandbox demo) supply their own settings
  static void overrideWith(Map<String, String> env) =>
      _override = RewardConfig._(env);
  static void clearOverride() => _override = null;

  final Map<String, String> _env;
  bool _flag(String k) => (_env[k] ?? '').toLowerCase() == 'true';

  /// players may see and accept funded jobs
  bool get fundedJobsEnabled => _flag('FUNDED_JOBS_ENABLED');

  /// real-money collections (purchases) -- none exist yet
  bool get liveCollectionsEnabled => _flag('LIVE_COLLECTIONS_ENABLED');

  /// real payouts through a live provider (blocked unless every requirement below is configured)
  bool get livePayoutsRequested => _flag('LIVE_PAYOUTS_ENABLED');

  /// the 0.5% levy on allowlisted commercial Game Naira payments
  bool get cityLevyEnabled => _flag('CITY_LEVY_ENABLED');

  /// island work pays 2% of every paycheck in real naira from the Real Rewards Fund (on in the sandbox)
  bool get jobShareEnabled => _flag('JOB_SHARE_ENABLED') || sandbox;

  /// hours a job share waits (for checks) before it can be withdrawn
  int get jobShareHoldHours =>
      int.tryParse(_env['JOB_SHARE_HOLD_HOURS'] ?? '') ?? 24;

  /// the sandbox: the mock payout provider and sandbox funding, never against real money
  bool get sandbox => _flag('REWARDS_SANDBOX');

  /// the shared secret the (mock) provider signs its callbacks with; never logged
  String? get providerSecret => _env['REWARDS_PROVIDER_SECRET'];

  /// What live payouts need before they can be switched on. None of these has a default: the business must supply
  /// them (identity and beneficiary checks, ages, places, limits, fees, timelines, compliance). A missing one blocks.
  static const requiredForLivePayouts = [
    'PAYOUT_PROVIDER',
    'PAYOUT_KYC_PROVIDER',
    'PAYOUT_MIN_AGE',
    'PAYOUT_JURISDICTIONS',
    'PAYOUT_MIN_WITHDRAWAL_KOBO',
    'PAYOUT_MAX_WITHDRAWAL_KOBO',
    'PAYOUT_DAILY_LIMIT_KOBO',
    'PAYOUT_FEE_KOBO',
    'PAYOUT_FEE_PAYER',
    'PAYOUT_REVIEW_HOURS',
    'PAYOUT_TERMS_URL',
    'PAYOUT_APPROVAL_REF',
  ];

  /// the settings live payouts still lack
  List<String> get livePayoutsMissing => [
    for (final k in requiredForLivePayouts)
      if ((_env[k] ?? '').trim().isEmpty) k,
  ];

  /// live payouts are on only when asked for AND fully configured
  bool get livePayoutsEnabled =>
      livePayoutsRequested && livePayoutsMissing.isEmpty;

  /// the sandbox's withdrawal settings (the live ones come from the required settings above)
  /// never below ₦5,000: real cash is only sent once a player has built up that much
  int get minWithdrawalFloorKobo =>
      int.tryParse(_env['PAYOUT_MIN_WITHDRAWAL_FLOOR_KOBO'] ?? '') ?? 500000;
  int get minWithdrawalKobo {
    final v =
        int.tryParse(_env['PAYOUT_MIN_WITHDRAWAL_KOBO'] ?? '') ??
        (sandbox ? minWithdrawalFloorKobo : 1 << 62);
    return v < minWithdrawalFloorKobo ? minWithdrawalFloorKobo : v;
  }

  int get payoutFeeKobo =>
      int.tryParse(_env['PAYOUT_FEE_KOBO'] ?? '') ?? (sandbox ? 5000 : 0);

  /// the most one withdrawal may be, and the most a player may withdraw in 24 hours (kobo)
  int get maxWithdrawalKobo =>
      int.tryParse(_env['PAYOUT_MAX_WITHDRAWAL_KOBO'] ?? '') ??
      (sandbox ? 2500000 : 0);
  int get dailyLimitKobo =>
      int.tryParse(_env['PAYOUT_DAILY_LIMIT_KOBO'] ?? '') ??
      (sandbox ? 5000000 : 0);

  /// hours a withdrawal waits (for review: an operator may stop it) before the money is sent
  /// the most paid out across the whole island in 24 hours; past it, payouts wait (and an operator is told) — 0: no limit
  int get globalDailyKobo =>
      int.tryParse(_env['PAYOUT_GLOBAL_DAILY_KOBO'] ?? '') ?? 0;
  int get reviewHours => int.tryParse(_env['PAYOUT_REVIEW_HOURS'] ?? '') ?? 0;

  /// the youngest a player may be to withdraw
  int get minAge => int.tryParse(_env['PAYOUT_MIN_AGE'] ?? '') ?? 18;

  /// the provider to pay through (flutterwave), and the terms players accept before withdrawing
  String get payoutProvider => (_env['PAYOUT_PROVIDER'] ?? '').trim();
  String get termsUrl => (_env['PAYOUT_TERMS_URL'] ?? '').trim();

  /// who bears the payout fee: house (paid from the reserved fee allowance) or player (deducted from the payout)
  String get feePayer => _env['PAYOUT_FEE_PAYER'] ?? 'house';

  /// funded jobs a player may accept in a day, and the pause between two acceptances (anti-farming)
  int get fundedPerDay => int.tryParse(_env['FUNDED_JOBS_PER_DAY'] ?? '') ?? 3;
  int get fundedCooldownMinutes =>
      int.tryParse(_env['FUNDED_JOBS_COOLDOWN_MIN'] ?? '') ?? 10;
}
