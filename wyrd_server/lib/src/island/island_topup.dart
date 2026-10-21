import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import '../world/bank.dart';

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
    unawaited(_http.head(Uri.parse('https://api.flutterwave.com/')).timeout(const Duration(seconds: 8)).catchError((_) => http.Response('', 599)));
  }

  static String _key(Session s) => (s.passwords['flutterwaveSecretKey'] ?? '').trim();

  /// off, test or live
  static String mode(Session s) {
    final k = _key(s);
    if (k.isEmpty) return 'off';
    return k.contains('_TEST') ? 'test' : 'live';
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
    if (recent != null && now.difference(recent.createdAt) < const Duration(seconds: 20) && recent.pack == pack) {
      throw TopUpRefused('Checkout is already opening.');
    }
    await IslandTopUp.db.insertRow(s, IslandTopUp(authUserId: u, txRef: ref, pack: pack, amountNgn: p.ngn, naira: p.naira, status: 'pending', createdAt: now));
    final sep = returnTo.contains('?') ? '&' : '?';
    final r = await _http.post(
      Uri.parse('https://api.flutterwave.com/v3/payments'),
      headers: {'Authorization': 'Bearer ${_key(s)}', 'Content-Type': 'application/json'},
      body: jsonEncode({
        'tx_ref': ref,
        'amount': p.ngn,
        'currency': 'NGN',
        'payment_options': 'card, banktransfer, ussd',
        'redirect_url': '$returnTo${sep}topup=$ref',
        'customer': {'email': email},
        'customizations': {'title': 'Lagos Island', 'description': '${_n(p.naira)} game naira'},
        'meta': {'pack': pack},
      }),
    ).timeout(const Duration(seconds: 20));
    final j = _json(r.body);
    final link = (j['data'] is Map) ? (j['data'] as Map)['link'] : null;
    if (r.statusCode != 200 || j['status'] != 'success' || link is! String) {
      s.log('[topup] checkout failed ${r.statusCode}: ${r.body.length > 300 ? r.body.substring(0, 300) : r.body}', level: LogLevel.warning);
      throw TopUpRefused('Checkout is not available right now. Try again in a moment.');
    }
    return {'link': link, 'ref': ref};
  }

  /// Ask Flutterwave how payment [ref] went, and credit it if it succeeded (once). Returns the row's status.
  static Future<Map<String, dynamic>> settle(Session s, String ref, {UuidValue? onlyFor}) async {
    final row = await IslandTopUp.db.findFirstRow(s, where: (t) => t.txRef.equals(ref));
    if (row == null || (onlyFor != null && row.authUserId != onlyFor)) return {'status': 'unknown'};
    if (row.status == 'paid') return {'status': 'paid', 'naira': row.naira};
    if (mode(s) == 'off') return {'status': row.status};
    final r = await _http.get(
      Uri.parse('https://api.flutterwave.com/v3/transactions/verify_by_reference?tx_ref=${Uri.encodeQueryComponent(ref)}'),
      headers: {'Authorization': 'Bearer ${_key(s)}'},
    ).timeout(const Duration(seconds: 20));
    final j = _json(r.body), d = j['data'] is Map ? j['data'] as Map : const {};
    final ok = r.statusCode == 200 && j['status'] == 'success' && d['status'] == 'successful' && d['tx_ref'] == ref && d['currency'] == 'NGN' && (d['amount'] is num) && (d['amount'] as num) >= row.amountNgn;
    if (!ok) {
      final failed = r.statusCode == 200 && (d['status'] == 'failed' || d['status'] == 'cancelled');
      if (failed) await IslandTopUp.db.updateRow(s, row.copyWith(status: 'failed', flwId: '${d['id'] ?? ''}'));
      return {'status': failed ? 'failed' : 'pending'};
    }
    s.log('[topup] $ref confirmed by Flutterwave: ${d['payment_type']} ${d['amount']} ${d['currency']} id=${d['id']} mode=${mode(s)}', level: LogLevel.info);
    final res = await Bank.post(s, row.authUserId, key: 'topup:$ref', amount: row.naira, kind: 'topup', counter: 'city:treasury', memo: 'Bought ${_n(row.naira)} naira (Flutterwave)');
    if (res.short != null) return {'status': 'pending'};
    await IslandTopUp.db.updateRow(s, row.copyWith(status: 'paid', flwId: '${d['id'] ?? ''}', paidAt: DateTime.now().toUtc()));
    return {'status': 'paid', 'naira': row.naira};
  }

  static const reserveShare = 0.5;

  /// Treasury 2: what players have paid in real naira, and the half of it kept for paychecks.
  static Future<Map<String, dynamic>> treasury2(Session s) async {
    final rows = await s.db.unsafeQuery('SELECT COALESCE(SUM("amountNgn"), 0), COUNT(*) FROM "island_topup" WHERE "status" = \'paid\'');
    final paid = (rows.first[0] as num).toInt(), n = (rows.first[1] as num).toInt();
    return {'mode': mode(s), 'payments': n, 'paidNgn': paid, 'reserveNgn': (paid * reserveShare).floor(), 'share': reserveShare};
  }

  static Map<String, dynamic> _json(String b) {
    try {
      final v = jsonDecode(b);
      return v is Map<String, dynamic> ? v : const {};
    } catch (_) {
      return const {};
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
    final got = request.headers['verif-hash']?.join(',') ?? '';
    if (want.isEmpty || got != want) return _json(401, {'error': 'unauthorized'});
    String body;
    try {
      body = await request.readAsString(maxLength: 64 * 1024);
    } catch (_) {
      return _json(413, {'error': 'too large'});
    }
    final j = TopUp._json(body), d = j['data'] is Map ? j['data'] as Map : j;
    final ref = d['tx_ref'] ?? d['txRef'];
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
