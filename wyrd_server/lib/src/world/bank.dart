import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// What a posting did: the entry (its receipt), the balance after it, or why it couldn't be made.
class BankResult {
  BankResult.ok(this.entry, {this.repeat = false, this.plan = 0, int? after}) : short = null, balance0 = after;
  BankResult.short(this.short, this.balance0) : entry = null, repeat = false, plan = 0;
  final NairaEntry? entry;
  /// how much of this payout went to the player's payment plan (and the plan entry for it)
  final int plan;
  NairaEntry? planEntry;
  /// how much more naira the player would have needed
  final int? short;
  int? balance0;
  /// the same action was already posted (a retry): nothing new happened
  final bool repeat;
  bool get ok => entry != null;
  int get balance => balance0 ?? entry?.balanceAfter ?? 0;
}

/// The naira bank: the only code that changes a player's balance.
///
/// Every movement is one database transaction that (1) locks the player's row, (2) checks the action hasn't been
/// posted already (its [key]), (3) moves the balance -- never below zero for a charge -- and (4) writes the entry the
/// receipt is read from. A retry of the same action finds its entry and changes nothing; two requests at once queue on
/// the row lock instead of both reading the old balance. The first time a player's naira moves, an opening entry
/// records what they already had, so the sum of their entries always equals their balance (see [audit]).
///
/// Payment plans: [owe] puts naira on a player's plan (a fine above the floor, a fare on credit) -- at most [debtCap],
/// no interest -- and every payout after that sends a fifth of itself to the plan, as its own entry, in the same
/// transaction, until it's paid.
///
/// Everything else that saves a citizen goes through [save], which never writes the balance or the plan.
class Bank {
  static const counters = {'city:treasury', 'city:transport', 'city:landlord', 'city:courts', 'city:market', 'city:services'};
  static const debtCap = 10000;
  /// the kinds of entry that are payouts a plan takes its fifth from
  static const _earned = {'job', 'mission', 'guide', 'place', 'story'};

  /// Move [amount] (+ in, - out) for [user], once per [key]. A charge the player can't cover is refused
  /// ([BankResult.short]) and changes nothing; a repeat of an action already posted returns its entry ([BankResult.repeat]).
  static Future<BankResult> post(Session session, UuidValue user, {
    required String key, required int amount, required String kind, required String counter, required String memo,
  }) async {
    assert(counters.contains(counter), 'unknown counter account $counter');
    try {
      return await session.db.transaction((tx) async {
        final row = await session.db.unsafeQuery(
          'SELECT "naira", "debt" FROM "world_citizen" WHERE "authUserId" = CAST(@u AS uuid) FOR UPDATE',
          parameters: QueryParameters.named({'u': user.uuid}), transaction: tx);
        if (row.isEmpty) throw StateError('No citizen for ${user.uuid}');
        final before = (row.first[0] as num).toInt(), debt = (row.first[1] as num).toInt();
        final done = await NairaEntry.db.findFirstRow(session, where: (t) => t.key.equals(key), transaction: tx);
        if (done != null) return BankResult.ok(done, repeat: true);
        if (before + amount < 0) return BankResult.short(-(before + amount), before);
        final now = DateTime.now().toUtc();
        // the first movement: what they had before the ledger, on the books
        final any = await NairaEntry.db.findFirstRow(session, where: (t) => t.authUserId.equals(user), transaction: tx);
        if (any == null) {
          await NairaEntry.db.insertRow(session, NairaEntry(key: 'open:${user.uuid}', authUserId: user, amount: before, balanceAfter: before,
              kind: 'open', counter: 'city:treasury', memo: 'Opening balance', createdAt: now), transaction: tx);
        }
        final after = before + amount;
        await session.db.unsafeExecute('UPDATE "world_citizen" SET "naira" = @n, "updatedAt" = @t WHERE "authUserId" = CAST(@u AS uuid)',
            parameters: QueryParameters.named({'n': after, 't': now, 'u': user.uuid}), transaction: tx);
        final e = await NairaEntry.db.insertRow(session, NairaEntry(key: key, authUserId: user, amount: amount, balanceAfter: after,
            kind: kind, counter: counter, memo: memo, createdAt: now), transaction: tx);
        // a payout while something's owed: a fifth of it to the plan
        if (amount > 0 && debt > 0 && _earned.contains(kind)) {
          final repay = [debt, (amount * 0.2).ceil()].reduce((a, b) => a < b ? a : b), left = debt - repay;
          await session.db.unsafeExecute(
              'UPDATE "world_citizen" SET "naira" = @n, "debt" = @d, "debtSince" = CASE WHEN @d = 0 THEN NULL ELSE "debtSince" END WHERE "authUserId" = CAST(@u AS uuid)',
              parameters: QueryParameters.named({'n': after - repay, 'd': left, 'u': user.uuid}), transaction: tx);
          final p = await NairaEntry.db.insertRow(session, NairaEntry(key: '$key:plan', authUserId: user, amount: -repay, balanceAfter: after - repay,
              kind: 'plan', counter: 'city:courts', memo: left == 0 ? 'Payment plan: paid off' : 'Payment plan (₦$left still owed)', createdAt: now), transaction: tx);
          return BankResult.ok(e, plan: repay, after: after - repay)..planEntry = p;
        }
        return BankResult.ok(e);
      });
    } catch (e) {
      // two requests with the same key at the very same moment: the loser finds the winner's entry
      final done = await NairaEntry.db.findFirstRow(session, where: (t) => t.key.equals(key));
      if (done != null) return BankResult.ok(done, repeat: true);
      rethrow;
    }
  }

  /// Put [amount] on [user]'s payment plan (or, negative, take it off: forgiven), once per [key]. Nothing moves in
  /// their wallet; an entry of ₦0 records it for the receipts. Refused (short) if it would take the plan past
  /// [debtCap] -- the caller decides what happens then.
  static Future<BankResult> owe(Session session, UuidValue user, {required String key, required int amount, required String memo}) async {
    try {
      return await session.db.transaction((tx) async {
        final row = await session.db.unsafeQuery('SELECT "naira", "debt" FROM "world_citizen" WHERE "authUserId" = CAST(@u AS uuid) FOR UPDATE',
            parameters: QueryParameters.named({'u': user.uuid}), transaction: tx);
        if (row.isEmpty) throw StateError('No citizen for ${user.uuid}');
        final naira = (row.first[0] as num).toInt(), debt = (row.first[1] as num).toInt();
        final done = await NairaEntry.db.findFirstRow(session, where: (t) => t.key.equals(key), transaction: tx);
        if (done != null) return BankResult.ok(done, repeat: true);
        final next = debt + amount < 0 ? 0 : debt + amount;
        if (next > debtCap) return BankResult.short(next - debtCap, naira);
        final now = DateTime.now().toUtc();
        await session.db.unsafeExecute(
            'UPDATE "world_citizen" SET "debt" = @d, "debtSince" = CASE WHEN @d = 0 THEN NULL ELSE COALESCE("debtSince", @t) END WHERE "authUserId" = CAST(@u AS uuid)',
            parameters: QueryParameters.named({'d': next, 't': now, 'u': user.uuid}), transaction: tx);
        final e = await NairaEntry.db.insertRow(session, NairaEntry(key: key, authUserId: user, amount: 0, balanceAfter: naira,
            kind: amount >= 0 ? 'credit' : 'forgiven', counter: 'city:courts', memo: memo, createdAt: now), transaction: tx);
        return BankResult.ok(e);
      });
    } catch (e) {
      final done = await NairaEntry.db.findFirstRow(session, where: (t) => t.key.equals(key));
      if (done != null) return BankResult.ok(done, repeat: true);
      rethrow;
    }
  }

  /// Put an entry right: the opposite movement, linked to it, with its own receipt. Refunds of charges always go
  /// through; taking back a payout can't take a player below zero (it takes what's there).
  static Future<BankResult> reverse(Session session, int entryId, String memo) async {
    final e = await NairaEntry.db.findById(session, entryId);
    if (e == null || e.status == 'reversed' || e.kind == 'open') throw StateError('Nothing to reverse.');
    var amount = -e.amount;
    if (amount < 0) {
      final c = await WorldCitizen.db.findFirstRow(session, where: (t) => t.authUserId.equals(e.authUserId));
      amount = -[(-amount), c?.naira ?? 0].reduce((a, b) => a < b ? a : b);
    }
    final r = await post(session, e.authUserId, key: 'rev:${e.id}', amount: amount, kind: e.amount < 0 ? 'refund' : e.kind, counter: e.counter, memo: memo);
    if (r.ok && !r.repeat) {
      await NairaEntry.db.updateRow(session, e.copyWith(status: 'reversed'));
      await NairaEntry.db.updateRow(session, r.entry!.copyWith(reverses: e.id));
    }
    return r;
  }

  /// A citizen saved without its money: everything but naira and the plan (and the row id) is written. Only [post] and [owe] move money.
  static Future<WorldCitizen> save(Session session, WorldCitizen c) => WorldCitizen.db.updateRow(session, c,
      columns: (t) => [for (final col in t.columns) if (col != t.id && col != t.naira && col != t.debt && col != t.debtSince) col]);

  /// The citizen with their real balance (after a posting, the copy in hand may be behind).
  static Future<WorldCitizen> fresh(Session session, UuidValue user) async =>
      (await WorldCitizen.db.findFirstRow(session, where: (t) => t.authUserId.equals(user)))!;

  /// The receipt the phone shows for an entry.
  static Map<String, dynamic> receipt(NairaEntry e) => {
        'ref': 'R-${e.id!.toRadixString(36).toUpperCase().padLeft(4, '0')}', 'kind': e.kind, 'memo': e.memo,
        'amount': e.amount, 'balance': e.balanceAfter, 'at': e.createdAt.toIso8601String(), 'reversed': e.status == 'reversed',
      };

  /// A player's latest receipts (the opening balance left out).
  static Future<List<Map<String, dynamic>>> receipts(Session session, UuidValue user, {int limit = 40}) async {
    final rows = await NairaEntry.db.find(session, where: (t) => t.authUserId.equals(user) & t.kind.notEquals('open'),
        orderBy: (t) => t.id.desc(), limit: limit);
    return rows.map(receipt).toList();
  }

  /// The books checked: for every player on the ledger, the sum of their entries against their balance.
  /// Returns the ones that don't match (none, when all is well).
  static Future<List<Map<String, dynamic>>> audit(Session session) async {
    final r = await session.db.unsafeQuery(
        'SELECT e."authUserId", SUM(e."amount") AS total, c."naira" FROM "naira_entry" e '
        'JOIN "world_citizen" c ON c."authUserId" = e."authUserId" GROUP BY e."authUserId", c."naira" HAVING SUM(e."amount") <> c."naira"');
    return [for (final row in r) {'user': '${row[0]}', 'ledger': (row[1] as num).toInt(), 'balance': (row[2] as num).toInt()}];
  }
}
