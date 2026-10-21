import 'dart:convert';

import 'package:http/http.dart' as http;

import 'reward_math.dart';
import 'withdrawals.dart';

/// Real payouts through Flutterwave Transfers, to a player's verified Nigerian bank account.
///
/// - The beneficiary is "flw:BANKCODE:ACCOUNTNUMBER" (from a payout account that passed the name and email checks).
/// - Each transfer carries the withdrawal's ref as Flutterwave's reference, which Flutterwave refuses to repeat: a
///   retry can never pay twice. A refusal for an existing reference is "unknown" (it may have gone), never a failure.
/// - Nothing is marked paid from a callback's word: [status] asks Flutterwave for the transfer itself.
/// The key is the server's own (never sent to a player); a test key moves no real money.
class FlutterwavePayoutProvider implements PayoutProvider {
  FlutterwavePayoutProvider(this._key);
  final String _key;
  final _http = http.Client();

  @override
  String get name => 'flutterwave';

  Map<String, String> get _auth => {'Authorization': 'Bearer $_key', 'Content-Type': 'application/json'};

  @override
  Future<(SubmitOutcome, String?)> submit({required String ref, required int amountKobo, required String beneficiary}) async {
    final p = beneficiary.split(':');
    if (p.length != 3 || p[0] != 'flw' || !RegExp(r'^\d{10}$').hasMatch(p[2])) return (SubmitOutcome.rejected, null);
    final r = await _http.post(Uri.parse('https://api.flutterwave.com/v3/transfers'), headers: _auth, body: jsonEncode({
      'account_bank': p[1], 'account_number': p[2], 'amount': amountKobo / 100, 'currency': 'NGN', 'debit_currency': 'NGN',
      'narration': 'Lagos Island earnings', 'reference': ref,
    })).timeout(const Duration(seconds: 30));
    final j = _json(r.body), d = j['data'] is Map ? j['data'] as Map : const {};
    if (j['status'] == 'success' && d['id'] != null) return (SubmitOutcome.accepted, '${d['id']}');
    final msg = '${j['message'] ?? ''}'.toLowerCase();
    if (msg.contains('reference') && (msg.contains('exist') || msg.contains('duplicate'))) return (SubmitOutcome.unknown, null);
    if (r.statusCode >= 500) return (SubmitOutcome.unknown, null);
    return (SubmitOutcome.rejected, null);
  }

  @override
  Future<String?> status({required String ref, String? providerRef}) async {
    Map d;
    if (providerRef != null && RegExp(r'^\d+$').hasMatch(providerRef)) {
      final r = await _http.get(Uri.parse('https://api.flutterwave.com/v3/transfers/$providerRef'), headers: _auth).timeout(const Duration(seconds: 20));
      final j = _json(r.body);
      if (r.statusCode != 200 || j['data'] is! Map) return null;
      d = j['data'] as Map;
    } else {
      // sent but we never heard its id: find it by our reference
      final r = await _http.get(Uri.parse('https://api.flutterwave.com/v3/transfers?reference=${Uri.encodeQueryComponent(ref)}'), headers: _auth).timeout(const Duration(seconds: 20));
      final j = _json(r.body);
      if (r.statusCode != 200 || j['data'] is! List) return null;
      final hit = (j['data'] as List).whereType<Map>().where((t) => t['reference'] == ref).firstOrNull;
      if (hit == null) return null;
      d = hit;
    }
    if (d['reference'] != ref) return null;
    return switch ('${d['status']}'.toUpperCase()) {
      'SUCCESSFUL' => PayoutState.paid,
      'FAILED' => PayoutState.failed,
      'NEW' || 'PENDING' => PayoutState.pending,
      _ => null,
    };
  }

  static Map<String, dynamic> _json(String b) {
    try {
      final v = jsonDecode(b);
      return v is Map<String, dynamic> ? v : const {};
    } catch (_) {
      return const {};
    }
  }
}
