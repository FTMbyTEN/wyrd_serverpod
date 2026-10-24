import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../rewards/reward_config.dart';
import '../rewards/reward_ledger.dart';
import '../rewards/reward_math.dart';

/// Island work that pays real money: every paid shift (the Grid, the refinery, the airport, the quick shifts) earns
/// [percent]% of its paycheck in real naira, drawn from the Real Rewards Fund (ngn:fund:uncommitted) into the player's
/// pending cash; the rest of the paycheck is paid in Game Naira as before. The cash waits [RewardConfig.jobShareHoldHours]
/// before it can be withdrawn. When the switch is off, or the fund can't cover it, the share is recorded as unfunded
/// and the player keeps the whole paycheck in Game Naira, so nobody is ever paid less.
abstract final class JobShare {
  static const percent = 2;

  /// the real share of a paycheck of [paycheck] Game Naira, in kobo (2% of the naira amount)
  static int kobo(int paycheck) => paycheck * percent;

  /// the Game Naira part when the share is paid in cash
  static int gameNaira(int paycheck) => paycheck - paycheck * percent ~/ 100;

  /// Credit the real share for the shift keyed [source] (its payroll key, so a repeat changes nothing). Returns the
  /// kobo credited (0 when off or unfunded). Call before paying the Game Naira part; pay [gameNaira] only if it's > 0.
  static Future<int> credit(
    Session s,
    UuidValue u, {
    required String source,
    required String workplace,
    required String title,
    required int paycheck,
  }) async {
    if (paycheck <= 0) return 0;
    final done = await IslandJobShare.db.findFirstRow(
      s,
      where: (t) => t.source.equals(source),
    );
    if (done != null) return done.authUserId == u ? done.cashKobo : 0;
    final cfg = RewardConfig.current,
        k = kobo(paycheck),
        now = DateTime.now().toUtc();
    var status = 'pending', cash = k;
    if (!cfg.jobShareEnabled) {
      status = 'unfunded';
      cash = 0;
    }
    try {
      await s.db.transaction((tx) async {
        if (cash > 0) {
          try {
            await RewardLedger.post(
              s,
              unit: RewardUnit.ngn,
              idemKey: 'share:$source',
              ref:
                  'JS-${now.millisecondsSinceEpoch.toRadixString(36).toUpperCase()}',
              kind: 'earn',
              memo: '$title: $percent% of the paycheck, pending verification',
              actor: 'system',
              linkRef: 'share:$source',
              transaction: tx,
              lines: [
                ('ngn:fund:uncommitted', -cash),
                (RewardLedger.pending(u), cash),
              ],
            );
          } on LedgerRefused {
            status = 'unfunded';
            cash = 0;
          }
        }
        await IslandJobShare.db.insertRow(
          s,
          IslandJobShare(
            authUserId: u,
            source: source,
            workplace: workplace,
            title: title,
            paycheck: paycheck,
            cashKobo: cash,
            status: status,
            availableAt: now.add(Duration(hours: cfg.jobShareHoldHours)),
            createdAt: now,
          ),
          transaction: tx,
        );
      });
    } catch (e) {
      // the same shift handed in twice at once: the first one's record stands
      final again = await IslandJobShare.db.findFirstRow(
        s,
        where: (t) => t.source.equals(source),
      );
      if (again != null) return again.authUserId == u ? again.cashKobo : 0;
      rethrow;
    }
    return cash;
  }

  /// Shares whose hold is over become available to withdraw.
  static Future<int> matureDue(Session s, {UuidValue? only}) async {
    final now = DateTime.now().toUtc();
    final due = await IslandJobShare.db.find(
      s,
      where: (t) => only == null
          ? t.status.equals('pending') & (t.availableAt <= now)
          : t.status.equals('pending') &
                (t.availableAt <= now) &
                t.authUserId.equals(only),
    );
    for (final e in due) {
      await s.db.transaction((tx) async {
        final rows = await s.db.unsafeQuery(
          'SELECT "status" FROM "island_job_share" WHERE "id" = @i FOR UPDATE',
          parameters: QueryParameters.named({'i': e.id}),
          transaction: tx,
        );
        if (rows.isEmpty || rows.first[0] != 'pending') return;
        await RewardLedger.post(
          s,
          unit: RewardUnit.ngn,
          idemKey: 'share-mature:${e.id}',
          ref: 'JS-MAT-${e.id}',
          kind: 'mature',
          memo: '${e.title}: share verified, available',
          actor: 'system',
          linkRef: 'share:${e.source}',
          transaction: tx,
          lines: [
            (RewardLedger.pending(e.authUserId), -e.cashKobo),
            (RewardLedger.available(e.authUserId), e.cashKobo),
          ],
        );
        await s.db.unsafeExecute(
          'UPDATE "island_job_share" SET "status" = \'available\' WHERE "id" = @i',
          parameters: QueryParameters.named({'i': e.id}),
          transaction: tx,
        );
      });
    }
    return due.length;
  }

  /// The player's jobs done and their shares: the latest [limit], and the totals.
  static Future<Map<String, dynamic>> summary(
    Session s,
    UuidValue u, {
    int limit = 40,
  }) async {
    await matureDue(s, only: u);
    final rows = await IslandJobShare.db.find(
      s,
      where: (t) => t.authUserId.equals(u),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
    );
    final tot = await s.db.unsafeQuery(
      'SELECT COUNT(*)::bigint, COALESCE(SUM("paycheck"),0)::bigint, COALESCE(SUM("cashKobo"),0)::bigint FROM "island_job_share" WHERE "authUserId" = CAST(@u AS uuid)',
      parameters: QueryParameters.named({'u': u.uuid}),
    );
    final cfg = RewardConfig.current;
    return {
      'percent': percent,
      'on': cfg.jobShareEnabled,
      'holdHours': cfg.jobShareHoldHours,
      'minWithdrawalKobo': cfg.minWithdrawalKobo,
      'jobs': (tot.first[0] as num).toInt(),
      'paychecks': (tot.first[1] as num).toInt(),
      'earnedKobo': (tot.first[2] as num).toInt(),
      'list': [
        for (final r in rows)
          {
            'title': r.title,
            'workplace': r.workplace,
            'paycheck': r.paycheck,
            'cashKobo': r.cashKobo,
            'gameNaira': r.cashKobo > 0 ? gameNaira(r.paycheck) : r.paycheck,
            'status': r.status,
            'availableAt': r.availableAt.toIso8601String(),
            'at': r.createdAt.toIso8601String(),
          },
      ],
    };
  }
}
