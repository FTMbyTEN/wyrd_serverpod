import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'flutterwave_v4.dart';
import '../world/bank.dart';
import '../rewards/withdrawals.dart';

/// Buying game naira with real money, through Flutterwave's hosted checkout.
///
/// - Off until the Flutterwave secret key is set (passwords: flutterwaveSecretKey). A test key (FLWSECK_TEST-...) runs the
///   sandbox; a live key takes real payments. The key never leaves the server.
/// - Checkout starts here: a pending row, then Flutterwave's payment link for exactly that pack's price.
/// - Nothing is credited from what a browser or a webhook says. Either one only prompts the server to ask Flutterwave
///   itself (verify by reference); the naira land when Flutterwave confirms success, in NGN, for at least the pack's price,
///   and only once (the ledger entry is keyed by the reference).
abstract final class TopUp {
  /// pack -> (real naira paid, game naira received)
  static const packs = {
    'p500': (ngn: 500, naira: 5000),
    'p1000': (ngn: 1000, naira: 11000),
    'p2500': (ngn: 2500, naira: 30000),
    'p5000': (ngn: 5000, naira: 65000),
  };

  /// where checkout may send the player back to (the game's own addresses)
  static final _returnOk = RegExp(r'^(https://play\.lagos-island\.workers\.dev|https://wryd00\.api\.serverpod\.space|http://localhost:\d+)(/[^\s?#]*)?$');

  static final _http = http.Client();
  static DateTime _warmed = DateTime.fromMillisecondsSinceEpoch(0);

  /// open the connection to Flutterwave ahead of a checkout (at most once a minute)
  static void warm() {
    if (DateTime.now().difference(_warmed) < const Duration(minutes: 1)) return;
    _warmed = DateTime.now();
    unawaited(_http.head(Uri.parse(Flw4.base)).timeout(const Duration(seconds: 8)).catchError((_) => http.Response('', 599)));
  }

  // ---- Flutterwave v4 (see Flw4): the server's client credentials, a token kept between calls
  static Flw4? _flw(Session s) => Flw4.from((k) => s.passwords[k]);

  /// off, test or live
  static String mode(Session s) => _flw(s) == null ? 'off' : Flw4.sandbox ? 'test' : 'live';

  /// One call to the v4 API: (HTTP status, JSON body). Refused credentials are logged and refused to the player.
  static Future<(int, Map<String, dynamic>)> _api(Session s, String method, String path, {Map<String, Object?>? body, String? idem}) async {
    final f = _flw(s);
    if (f == null) throw TopUpRefused('Buying naira opens soon.');
    final (st, j) = await f.call(method, path, body: body, idem: idem);
    if (st == 0) {
      s.log('[topup] Flutterwave refused the credentials: ${j['_raw']}', level: LogLevel.warning);
      throw TopUpRefused('Checkout is not available right now. Try again in a moment.');
    }
    return (st, j);
  }

  /// the Flutterwave customer for a player, made once (the same idempotency key returns the same customer)
  static final _customers = <String, String>{};
  static Future<String> _customer(Session s, UuidValue u, String email, String handle) async {
    final have = _customers[u.uuid];
    if (have != null) return have;
    final (st, j) = await _api(s, 'POST', '/customers', body: {'name': {'first': handle, 'last': 'Lagos Island'}, 'email': email}, idem: 'cus-${u.uuid}');
    final id = j['data'] is Map ? (j['data'] as Map)['id'] : null;
    if (st >= 300 || id is! String) {
      s.log('[topup] customer failed $st: ${j['_raw']}', level: LogLevel.warning);
      throw TopUpRefused('Checkout is not available right now. Try again in a moment.');
    }
    return _customers[u.uuid] = id;
  }

  static Map<String, dynamic> info(Session s) {
    if (mode(s) != 'off') warm();
    return {
        'mode': mode(s),
        'packs': [for (final e in packs.entries) {'id': e.key, 'ngn': e.value.ngn, 'naira': e.value.naira}],
      };
  }

  /// Start checkout for [pack]: returns Flutterwave's payment link and our reference.
  static Future<Map<String, dynamic>> start(Session s, UuidValue u, String pack, String returnTo) async {
    final p = packs[pack];
    if (p == null) throw TopUpRefused('That pack is not for sale.');
    if (mode(s) == 'off') throw TopUpRefused('Buying naira opens soon.');
    if (!_returnOk.hasMatch(returnTo)) throw TopUpRefused('Open the game from its own address to buy naira.');
    final (acct, recent) = await (
      EmailAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u)),
      // a double tap within 20 s doesn't open a second checkout
      IslandTopUp.db.findFirstRow(s, where: (t) => t.authUserId.equals(u) & t.status.equals('pending'), orderBy: (t) => t.createdAt.desc()),
    ).wait;
    // Flutterwave wants an email for each payment: the player's own if they gave one, otherwise a private address for
    // their account (players sign up with just an island name)
    final email = acct != null && !acct.email.endsWith('@lagosisland.wyrd') ? acct.email : 'player-${u.uuid.substring(0, 8)}@lagos-island.workers.dev';
    final now = DateTime.now().toUtc();
    final rnd = Random.secure();
    final ref = 'LI-${now.millisecondsSinceEpoch}-${List.generate(8, (_) => rnd.nextInt(36).toRadixString(36)).join()}';
    // the same pack asked for again while its account is still open: the same account, not a second one
    if (recent != null && recent.pack == pack && recent.payTo != null) {
      final pay = _json(recent.payTo!), exp = DateTime.tryParse('${pay['expires'] ?? ''}');
      if (exp != null && exp.isAfter(now.add(const Duration(minutes: 5)))) return {'ref': recent.txRef, 'pay': pay};
    }
    if (recent != null && now.difference(recent.createdAt) < const Duration(seconds: 20) && recent.pack == pack) {
      throw TopUpRefused('Checkout is already opening.');
    }
    final prof = await IslandProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    final cus = await _customer(s, u, email, prof?.handle ?? 'Player');
    // Flutterwave v4 pay-with-transfer: a one-time bank account for exactly this pack, open for an hour
    final bankCode = (Platform.environment['FLUTTERWAVE_VA_BANK_CODE'] ?? '').trim();
    final (st, j) = await _api(s, 'POST', '/virtual-accounts', idem: ref, body: {
      'reference': ref, 'customer_id': cus, 'amount': p.ngn, 'currency': 'NGN', 'account_type': 'dynamic', 'expiry': 3600,
      'narration': 'Lagos Island ${_n(p.naira)} naira', if (bankCode.isNotEmpty) 'bank_code': bankCode,
    });
    final d = j['data'] is Map ? j['data'] as Map : const {};
    if (st >= 300 || d['account_number'] == null || d['id'] is! String) {
      s.log('[topup] virtual account failed $st: ${j['_raw']}', level: LogLevel.warning);
      throw TopUpRefused('Checkout is not available right now. Try again in a moment.');
    }
    final pay = {
      'account': '${d['account_number']}', 'bank': '${d['account_bank_name'] ?? 'Bank'}',
      'amount': d['amount'] is num ? d['amount'] : num.tryParse('${d['amount']}') ?? p.ngn,
      'expires': '${d['account_expiration_datetime'] ?? now.add(const Duration(hours: 1)).toIso8601String()}',
    };
    await IslandTopUp.db.insertRow(s, IslandTopUp(authUserId: u, txRef: ref, pack: pack, amountNgn: p.ngn, naira: p.naira, status: 'pending', flwAccount: d['id'] as String, payTo: jsonEncode(pay), createdAt: now));
    return {'ref': ref, 'pay': pay};
  }

  /// Ask Flutterwave how payment [ref] went, and credit it if it succeeded (once). Returns the row's status.
  static Future<Map<String, dynamic>> settle(Session s, String ref, {UuidValue? onlyFor}) async {
    final row = await IslandTopUp.db.findFirstRow(s, where: (t) => t.txRef.equals(ref));
    if (row == null || (onlyFor != null && row.authUserId != onlyFor)) return {'status': 'unknown'};
    if (row.status == 'paid') return {'status': 'paid', 'naira': row.naira};
    if (mode(s) == 'off' || row.flwAccount == null) return {'status': row.status};
    // the payments made into this purchase's own account, as Flutterwave has them
    final (st, j) = await _api(s, 'GET', '/charges?virtual_account_id=${Uri.encodeQueryComponent(row.flwAccount!)}');
    final raw = j['data'], list = raw is List ? raw : raw is Map && raw['charges'] is List ? raw['charges'] as List : const [];
    num amt(Object? v) => v is num ? v : num.tryParse('$v') ?? 0;
    final d = list.whereType<Map>().where((c) => (c['status'] == 'succeeded' || c['status'] == 'successful') && c['currency'] == 'NGN' && amt(c['amount']) >= row.amountNgn).firstOrNull;
    if (d == null) {
      if (st >= 300) s.log('[topup] $ref check failed $st: ${j['_raw']}', level: LogLevel.warning);
      // nothing paid in and the account closed a while ago: the purchase lapsed
      final exp = row.payTo == null ? null : DateTime.tryParse('${_json(row.payTo!)['expires'] ?? ''}');
      final lapsed = st < 300 && list.isEmpty && exp != null && DateTime.now().toUtc().isAfter(exp.toUtc().add(const Duration(minutes: 30)));
      if (lapsed) await IslandTopUp.db.updateRow(s, row.copyWith(status: 'failed'));
      return {'status': lapsed ? 'failed' : 'pending'};
    }
    // one Flutterwave transaction pays for one purchase: if its id already paid another reference, nothing is credited
    final flwId = '${d['id'] ?? ''}';
    if (flwId.isNotEmpty && await IslandTopUp.db.findFirstRow(s, where: (t) => t.flwId.equals(flwId) & t.status.equals('paid') & t.txRef.notEquals(ref)) != null) {
      s.log('[topup] $ref: Flutterwave transaction $flwId already credited to another purchase', level: LogLevel.warning);
      return {'status': 'failed'};
    }
    s.log('[topup] $ref confirmed by Flutterwave: bank transfer ${d['amount']} ${d['currency']} id=${d['id']} mode=${mode(s)}', level: LogLevel.info);
    final res = await Bank.post(s, row.authUserId, key: 'topup:$ref', amount: row.naira, kind: 'topup', counter: 'city:treasury', memo: 'Bought ${_n(row.naira)} naira (Flutterwave)');
    if (res.short != null) return {'status': 'pending'};
    // what reached our balance: the charge less Flutterwave's fee (as it reports it; otherwise its NGN rate, 1.4% up to 2,000)
    num fee0(Object? f) => f is num ? f : f is List ? f.whereType<Map>().fold<num>(0, (n, e) => n + amt(e['amount'])) : f is Map ? amt(f['amount']) : -1;
    final reported = fee0(d['fees']), paidIn = amt(d['amount']);
    final fee = reported >= 0 ? reported : min(2000, (paidIn * 0.014).ceil());
    await IslandTopUp.db.updateRow(s, row.copyWith(status: 'paid', flwId: '${d['id'] ?? ''}', paidAt: DateTime.now().toUtc(), netNgn: max(0, (paidIn - fee).floor())));
    return {'status': 'paid', 'naira': row.naira};
  }

  static const reserveShare = 0.5;

  static int _n0(Object? v) => v is num ? v.toInt() : num.tryParse('$v')?.toInt() ?? 0; // a SUM comes back as text

  /// Treasury 2, in kobo: the real naira that reached our Flutterwave balance after its collection fee (live payments
  /// only: a v4 purchase has its own Flutterwave account; the earlier test checkouts don't count; a payment from before
  /// the net was recorded is counted at Flutterwave's rate, 1.4% up to 2,000), less every payout sent or on its way
  /// (failed and returned ones come back). Payouts come out of it: the same balance players paid into.
  static Future<({int inKobo, int outKobo, int inFlightKobo, int payments})> treasury2Kobo(Session s) async {
    final t = (await s.db.unsafeQuery(r'''SELECT COALESCE(SUM(COALESCE("netNgn", "amountNgn" - LEAST(CEIL("amountNgn" * 0.014), 2000))), 0), COUNT(*) FROM "island_topup" WHERE "status" = 'paid' AND "flwAccount" IS NOT NULL''')).first;
    final w = (await s.db.unsafeQuery('SELECT COALESCE(SUM("amountKobo") FILTER (WHERE "status" = \'paid\'), 0), COALESCE(SUM("amountKobo") FILTER (WHERE "status" IN (\'requested\', \'submitted\', \'pending\', \'unknown\')), 0) FROM "reward_withdrawal"')).first;
    return (inKobo: _n0(t[0]) * 100, outKobo: _n0(w[0]), inFlightKobo: _n0(w[1]), payments: _n0(t[1]));
  }

  /// Can Treasury 2 cover [amountKobo] more, after everything already paid out or on its way?
  static Future<bool> treasury2Covers(Session s, int amountKobo) async {
    final t = await treasury2Kobo(s);
    return t.inKobo - t.outKobo - t.inFlightKobo >= amountKobo;
  }

  /// Treasury 2 for the console: paid in, paid out, on its way, and what's left to pay from.
  static Future<Map<String, dynamic>> treasury2(Session s) async {
    final t = await treasury2Kobo(s), left = t.inKobo - t.outKobo - t.inFlightKobo;
    return {'mode': mode(s), 'payments': t.payments, 'paidNgn': t.inKobo ~/ 100, 'paidOutNgn': t.outKobo ~/ 100, 'inFlightNgn': t.inFlightKobo ~/ 100, 'balanceNgn': left ~/ 100,
      'reserveNgn': left ~/ 100, 'share': 1.0};
  }

  static Map<String, dynamic> _json(String b) {
    try {
      final v = jsonDecode(b);
      return v is Map<String, dynamic> ? Map<String, dynamic>.from(v) : <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  static String _n(int v) => v.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');
}

class TopUpRefused implements Exception {
  TopUpRefused(this.message);
  final String message;
}

/// Flutterwave's webhook: POST /lagos-island/flutterwave. It must carry our secret hash (passwords: flutterwaveWebhookHash)
/// in verif-hash; even then its body is only a prompt: the payment is settled by asking Flutterwave (see TopUp.settle).
class FlutterwaveWebhookRoute extends Route {
  FlutterwaveWebhookRoute() : super(methods: {Method.post});

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    final want = (session.passwords['flutterwaveWebhookHash'] ?? '').trim();
    String body;
    try {
      body = await request.readAsString(maxLength: 64 * 1024);
    } catch (_) {
      return _json(413, {'error': 'too large'});
    }
    // v4 signs the raw body (flutterwave-signature: base64 HMAC-SHA256 with the secret hash); v3 sent the hash itself
    final sig = request.headers['flutterwave-signature']?.join(',') ?? '';
    final v3 = request.headers['verif-hash']?.join(',') ?? '';
    final ok = want.isNotEmpty && (sig.isNotEmpty ? base64.encode(Hmac(sha256, utf8.encode(want)).convert(utf8.encode(body)).bytes) == sig : v3 == want);
    if (!ok) return _json(401, {'error': 'unauthorized'});
    final j = TopUp._json(body), d = j['data'] is Map ? j['data'] as Map : j;
    // a v4 transfer into one of our accounts: check the purchases still waiting (each is asked of Flutterwave itself)
    if (j['type'] == 'charge.completed' && !'${d['reference'] ?? ''}'.startsWith('LI-')) {
      try {
        final open = await IslandTopUp.db.find(session, where: (t) => t.status.equals('pending') & t.flwAccount.notEquals(null) & (t.createdAt > DateTime.now().toUtc().subtract(const Duration(hours: 3))), limit: 30);
        var paid = 0;
        for (final r in open) {
          if ((await TopUp.settle(session, r.txRef))['status'] == 'paid') paid++;
        }
        return _json(200, {'outcome': 'checked', 'paid': paid});
      } catch (e) {
        session.log('[topup] webhook settle failed: $e', level: LogLevel.error);
        return _json(500, {'error': 'retry later'});
      }
    }
    final tref = d['reference'];
    if (tref is String && tref.startsWith('FJW-')) {
      try {
        return _json(200, {'outcome': 'checked', 'moved': await Withdrawals.reconcile(session, onlyRef: tref)});
      } catch (e) {
        session.log('[payout] webhook check failed: $e', level: LogLevel.error);
        return _json(500, {'error': 'retry later'});
      }
    }
    final ref = d['tx_ref'] ?? d['txRef'] ?? d['reference'];
    if (ref is! String || !ref.startsWith('LI-')) return _json(200, {'outcome': 'ignored'});
    try {
      final r = await TopUp.settle(session, ref);
      return _json(200, {'outcome': r['status']});
    } catch (e) {
      session.log('[topup] webhook settle failed: $e', level: LogLevel.error);
      return _json(500, {'error': 'retry later'});
    }
  }

  static Response _json(int status, Map<String, Object?> m) =>
      Response(status, body: Body.fromString(jsonEncode(m), mimeType: MimeType.json), headers: Headers.fromMap({'cache-control': ['no-store']}));
}
