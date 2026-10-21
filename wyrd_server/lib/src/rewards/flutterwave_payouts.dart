import '../island/flutterwave_v4.dart';
import 'reward_math.dart';
import 'withdrawals.dart';

/// Real payouts through Flutterwave v4 transfers, to a player's verified Nigerian bank account.
///
/// - The beneficiary is "flw:BANKCODE:ACCOUNTNUMBER" (from a payout account that passed the name and email checks).
/// - Each transfer carries the withdrawal's ref as Flutterwave's reference and as its idempotency key: a retry can never
///   pay twice. A refusal for an existing reference is "unknown" (it may have gone), never a failure.
/// - Nothing is marked paid from a callback's word: [status] asks Flutterwave for the transfer itself.
/// The credentials are the server's own (never sent to a player); the sandbox moves no real money.
class FlutterwavePayoutProvider implements PayoutProvider {
  FlutterwavePayoutProvider(this._flw);
  final Flw4 _flw;

  @override
  String get name => 'flutterwave';

  @override
  Future<(SubmitOutcome, String?)> submit({required String ref, required int amountKobo, required String beneficiary}) async {
    final p = beneficiary.split(':');
    if (p.length != 3 || p[0] != 'flw' || !RegExp(r'^\d{10}$').hasMatch(p[2])) return (SubmitOutcome.rejected, null);
    final (st, j) = await _flw.call('POST', '/direct-transfers', idem: ref, timeout: const Duration(seconds: 30), body: {
      'action': 'instant',
      'type': 'bank',
      'reference': ref,
      'narration': 'Lagos Island earnings',
      'payment_instruction': {
        'source_currency': 'NGN',
        'destination_currency': 'NGN',
        'amount': {'applies_to': 'destination_currency', 'value': amountKobo / 100},
        'recipient': {'bank': {'account_number': p[2], 'code': p[1]}},
      },
    });
    final d = j['data'] is Map ? j['data'] as Map : j;
    if (st < 300 && st > 0 && d['id'] is String) return (SubmitOutcome.accepted, d['id'] as String);
    if (st == 0 || st >= 500 || st == 409) return (SubmitOutcome.unknown, null);
    final msg = '${j['message'] ?? ''} ${j['error'] ?? ''}'.toLowerCase();
    if (msg.contains('reference') && (msg.contains('exist') || msg.contains('duplicate'))) return (SubmitOutcome.unknown, null);
    return (SubmitOutcome.rejected, null);
  }

  @override
  Future<String?> status({required String ref, String? providerRef}) async {
    Map d;
    if (providerRef != null && providerRef.startsWith('trf_')) {
      final (st, j) = await _flw.call('GET', '/transfers/${Uri.encodeComponent(providerRef)}');
      if (st != 200 || j['data'] is! Map) return null;
      d = j['data'] as Map;
    } else {
      // sent but we never heard its id: find it by our reference
      final (st, j) = await _flw.call('GET', '/transfers?reference=${Uri.encodeQueryComponent(ref)}');
      if (st != 200) return null;
      final raw = j['data'], list = raw is List ? raw : raw is Map && raw['transfers'] is List ? raw['transfers'] as List : const [];
      final hit = list.whereType<Map>().where((t) => t['reference'] == ref).firstOrNull;
      if (hit == null) return null;
      d = hit;
    }
    if (d['reference'] != null && d['reference'] != ref) return null;
    return switch ('${d['status']}'.toUpperCase()) {
      'SUCCESSFUL' => PayoutState.paid,
      'FAILED' || 'CANCELLED' => PayoutState.failed,
      'REVERSED' || 'RETURNED' || 'REFUNDED' => PayoutState.returned,
      'NEW' || 'PENDING' || 'INITIATED' => PayoutState.pending,
      _ => null,
    };
  }
}
