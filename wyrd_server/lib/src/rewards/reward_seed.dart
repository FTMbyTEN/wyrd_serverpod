import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reward_admin.dart';

/// The first reward policy, written once at startup if there is none. Owner decision D9 (2026-10-19): 1.67% cash,
/// rounded down. The fee allowance (₦835) is the brief's test-3 figure; the hold is 0 because no live hold has been
/// published yet (D4) -- an admin sets the real one with a new policy version before anything goes live.
/// Writing a policy moves no money; offers only use it when an admin creates them.
abstract final class RewardSeed {
  static const cashShareBp = 167, feeAllowanceKobo = 83500, holdHours = 0;

  static Future<RewardPolicy?> ensurePolicy(Session s) async {
    if (await RewardPolicy.db.findFirstRow(s) != null) return null;
    try {
      final p = await RewardPolicy.db.insertRow(s, RewardPolicy(version: 1, cashShareBp: cashShareBp, feeAllowanceKobo: feeAllowanceKobo,
          holdHours: holdHours, createdBy: 'system:seed', createdAt: DateTime.now().toUtc()));
      await RewardAdmin.audit(s, null, 'policy_seed', {'version': 1, 'cashShareBp': cashShareBp, 'feeAllowanceKobo': feeAllowanceKobo, 'holdHours': holdHours});
      return p;
    } catch (_) {
      return null; // another instance seeded it first (the version is unique)
    }
  }
}
