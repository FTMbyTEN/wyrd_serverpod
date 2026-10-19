import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reward_math.dart';

/// A ledger line: [amount] (in the journal's unit's minor units) into (+) or out of (-) the account [code].
typedef Line = (String code, int amount);

/// Thrown when a posting would break a rule; nothing is written.
class LedgerRefused implements Exception {
  LedgerRefused(this.reason, {this.code, this.short});
  final String reason;
  final String? code;

  /// how much more the account would have needed
  final int? short;
  @override
  String toString() => 'LedgerRefused($reason${code == null ? '' : ' on $code'})';
}

/// The rewards ledger: double-entry, one unit per journal, append-only.
///
/// Accounts (all amounts in minor units; NGN in kobo, GN in whole naira):
///  * NGN, the Real Rewards Fund:
///    - ngn:external            money that came in from outside (a source: negative = funds received)
///    - ngn:fund:uncommitted    funded and not yet promised to anyone
///    - ngn:fund:reserved       cash promised to players who accepted a funded job
///    - ngn:fund:fee_reserved   the payout-cost allowance set aside with each acceptance
///    - ngn:earn:pending:{u}    a player's earned cash, in its verification hold
///    - ngn:earn:available:{u}  a player's earned cash they may withdraw
///    - ngn:payout:inflight:{u} cash on its way out (submitted, pending, or an unknown outcome)
///    - ngn:paid                cash confirmed paid out to players (a sink)
///    - ngn:provider_fees       provider fees confirmed paid (a sink)
///  * GN, the Virtual City Treasury:
///    - gn:issued               Game Naira authorised into existence (a source)
///    - gn:treasury             the City Treasury's Game Naira
///    - gn:reserved             Game Naira set aside for accepted funded jobs
///    - gn:paid_players         Game Naira the treasury paid into players' wallets (a sink; the wallets are world_citizen.naira)
///
/// Real NGN and Game Naira never meet in one journal; a funded job's completion posts one of each, linked by reference.
abstract final class RewardLedger {
  static ({String unit, String kind, bool neg}) meta(String code) {
    if (code.startsWith('ngn:')) {
      if (code == 'ngn:external') return (unit: RewardUnit.ngn, kind: 'source', neg: true);
      if (code.startsWith('ngn:earn:')) return (unit: RewardUnit.ngn, kind: 'earnings', neg: false);
      if (code.startsWith('ngn:payout:')) return (unit: RewardUnit.ngn, kind: 'payout', neg: false);
      if (code == 'ngn:paid' || code == 'ngn:provider_fees') return (unit: RewardUnit.ngn, kind: 'sink', neg: false);
      if (code.startsWith('ngn:fund:')) return (unit: RewardUnit.ngn, kind: 'fund', neg: false);
    } else if (code.startsWith('gn:')) {
      if (code == 'gn:issued') return (unit: RewardUnit.gn, kind: 'source', neg: true);
      if (code == 'gn:treasury') return (unit: RewardUnit.gn, kind: 'treasury', neg: false);
      if (code == 'gn:reserved') return (unit: RewardUnit.gn, kind: 'reserve', neg: false);
      if (code == 'gn:paid_players') return (unit: RewardUnit.gn, kind: 'sink', neg: false);
      if (code == 'gn:levy') return (unit: RewardUnit.gn, kind: 'treasury', neg: false);
    }
    throw ArgumentError.value(code, 'code', 'unknown rewards account');
  }

  /// the player's own accounts
  static String pending(UuidValue u) => 'ngn:earn:pending:${u.uuid}';
  static String available(UuidValue u) => 'ngn:earn:available:${u.uuid}';
  static String inflight(UuidValue u) => 'ngn:payout:inflight:${u.uuid}';

  static UuidValue? _owner(String code) {
    final m = RegExp(r'^ngn:(?:earn:(?:pending|available)|payout:inflight):([0-9a-f-]{36})$').firstMatch(code);
    return m == null ? null : UuidValue.fromString(m.group(1)!);
  }

  /// Post one journal, once per [idemKey]. In one database transaction: every account is created if new and locked
  /// in code order (so two postings can't deadlock), the journal's lines must sum to zero in a single unit, no
  /// account may go below zero unless it's a source, and balances move with the entries. A repeat of [idemKey]
  /// returns the journal already posted and changes nothing. Pass [transaction] to post inside a larger one.
  static Future<RewardJournal> post(
    Session session, {
    required String unit,
    required String idemKey,
    required String ref,
    required String kind,
    required String memo,
    required String actor,
    required List<Line> lines,
    String? linkRef,
    Transaction? transaction,
  }) async {
    if (lines.isEmpty) throw LedgerRefused('a journal needs lines');
    if (lines.fold<int>(0, (a, l) => a + l.$2) != 0) throw LedgerRefused('a journal must sum to zero');
    for (final l in lines) {
      if (meta(l.$1).unit != unit) throw LedgerRefused('a journal moves one unit only', code: l.$1);
      if (l.$2 == 0) throw LedgerRefused('a line must move something', code: l.$1);
    }
    Future<RewardJournal> run(Transaction tx) async {
      final done = await RewardJournal.db.findFirstRow(session, where: (t) => t.idemKey.equals(idemKey), transaction: tx);
      if (done != null) return done;
      final codes = {for (final l in lines) l.$1}.toList()..sort();
      final now = DateTime.now().toUtc();
      for (final c in codes) {
        final m = meta(c), owner = _owner(c);
        await session.db.unsafeExecute(
          'INSERT INTO "reward_account" ("code","unit","kind","ownerUserId","balance","mayGoNegative","updatedAt") '
          'VALUES (@c,@u,@k,${owner == null ? 'NULL' : 'CAST(@o AS uuid)'},0,@n,@t) ON CONFLICT ("code") DO NOTHING',
          parameters: QueryParameters.named({'c': c, 'u': m.unit, 'k': m.kind, if (owner != null) 'o': owner.uuid, 'n': m.neg, 't': now}),
          transaction: tx,
        );
      }
      final rows = await session.db.unsafeQuery(
        'SELECT "id","code","balance","mayGoNegative","unit" FROM "reward_account" WHERE "code" = ANY(@cs) ORDER BY "code" FOR UPDATE',
        parameters: QueryParameters.named({'cs': codes}),
        transaction: tx,
      );
      final acct = {for (final r in rows) r[1] as String: (id: r[0] as int, bal: (r[2] as num).toInt(), neg: r[3] as bool, unit: r[4] as String)};
      // a second request with the same key may have posted while we waited for the locks
      final raced = await RewardJournal.db.findFirstRow(session, where: (t) => t.idemKey.equals(idemKey), transaction: tx);
      if (raced != null) return raced;
      final delta = <String, int>{};
      for (final l in lines) delta[l.$1] = (delta[l.$1] ?? 0) + l.$2;
      for (final e in delta.entries) {
        final a = acct[e.key]!;
        if (a.unit != unit) throw LedgerRefused('account unit mismatch', code: e.key);
        if (!a.neg && a.bal + e.value < 0) throw LedgerRefused('not enough in the account', code: e.key, short: -(a.bal + e.value));
      }
      final j = await RewardJournal.db.insertRow(
        session,
        RewardJournal(ref: ref, idemKey: idemKey, unit: unit, kind: kind, memo: memo, linkRef: linkRef, actor: actor, createdAt: now),
        transaction: tx,
      );
      for (final l in lines) {
        await RewardEntry.db.insertRow(session, RewardEntry(journalId: j.id!, accountId: acct[l.$1]!.id, amount: l.$2, createdAt: now), transaction: tx);
      }
      for (final e in delta.entries) {
        await session.db.unsafeExecute(
          'UPDATE "reward_account" SET "balance" = "balance" + @d, "updatedAt" = @t WHERE "id" = @i',
          parameters: QueryParameters.named({'d': e.value, 't': now, 'i': acct[e.key]!.id}),
          transaction: tx,
        );
      }
      return j;
    }

    if (transaction != null) return run(transaction);
    try {
      return await session.db.transaction(run);
    } catch (e) {
      // two identical requests at the very same moment: the loser finds the winner's journal
      if (e is LedgerRefused) rethrow;
      final done = await RewardJournal.db.findFirstRow(session, where: (t) => t.idemKey.equals(idemKey));
      if (done != null) return done;
      rethrow;
    }
  }

  /// An account's balance (0 if it has never moved).
  static Future<int> balance(Session session, String code, {Transaction? transaction}) async {
    final a = await RewardAccount.db.findFirstRow(session, where: (t) => t.code.equals(code), transaction: transaction);
    return a?.balance ?? 0;
  }

  /// The books checked: every account's cached balance against the sum of its entries, and every journal summing to
  /// zero. Returns the problems (none, when all is well).
  static Future<List<String>> reconcile(Session session) async {
    final out = <String>[];
    final bad = await session.db.unsafeQuery(
      'SELECT a."code", a."balance", COALESCE(SUM(e."amount"),0) FROM "reward_account" a LEFT JOIN "reward_entry" e ON e."accountId" = a."id" '
      'GROUP BY a."id", a."code", a."balance" HAVING a."balance" <> COALESCE(SUM(e."amount"),0)',
    );
    for (final r in bad) out.add('account ${r[0]}: cached ${r[1]} but entries sum to ${r[2]}');
    final unbalanced = await session.db.unsafeQuery(
      'SELECT j."ref", SUM(e."amount") FROM "reward_journal" j JOIN "reward_entry" e ON e."journalId" = j."id" GROUP BY j."id", j."ref" HAVING SUM(e."amount") <> 0',
    );
    for (final r in unbalanced) out.add('journal ${r[0]} sums to ${r[1]}');
    final mixed = await session.db.unsafeQuery(
      'SELECT j."ref" FROM "reward_journal" j JOIN "reward_entry" e ON e."journalId" = j."id" JOIN "reward_account" a ON a."id" = e."accountId" '
      'WHERE a."unit" <> j."unit" GROUP BY j."ref"',
    );
    for (final r in mixed) out.add('journal ${r[0]} mixes units');
    return out;
  }
}
