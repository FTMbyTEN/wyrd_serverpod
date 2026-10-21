import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// A player's payout bank account: the bank list and account lookup come from Flutterwave (with the server's own key);
/// the account counts as verified only when the bank's name for it matches the legal name the player gives, and the
/// player's email has answered a code. Nothing here moves money.
abstract final class Payout {
  static final _http = http.Client();
  static List<Map<String, String>>? _banks;
  static DateTime _banksAt = DateTime.fromMillisecondsSinceEpoch(0);

  static String _key(Session s) => (s.passwords['flutterwaveSecretKey'] ?? '').trim();
  static Map<String, String> _auth(Session s) => {'Authorization': 'Bearer ${_key(s)}', 'Content-Type': 'application/json'};

  /// Nigerian banks (code and name), from Flutterwave, kept a day.
  static Future<List<Map<String, String>>> banks(Session s) async {
    if (_banks != null && DateTime.now().difference(_banksAt) < const Duration(hours: 24)) return _banks!;
    if (_key(s).isEmpty) throw PayoutRefused('Bank accounts open soon.');
    final r = await _http.get(Uri.parse('https://api.flutterwave.com/v3/banks/NG'), headers: _auth(s)).timeout(const Duration(seconds: 20));
    final j = _json(r.body);
    if (r.statusCode != 200 || j['data'] is! List) throw PayoutRefused('The bank list is not available right now. Try again in a moment.');
    _banks = [for (final b in j['data'] as List) if (b is Map && b['code'] != null && b['name'] != null) {'code': '${b['code']}', 'name': '${b['name']}'}]
      ..sort((a, b) => a['name']!.compareTo(b['name']!));
    _banksAt = DateTime.now();
    return _banks!;
  }

  /// The account as the player sees it (the number masked).
  static Map<String, dynamic>? view(IslandPayoutAccount? a) => a == null
      ? null
      : {
          'bankName': a.bankName, 'last4': a.accountNumber.substring(a.accountNumber.length - 4), 'accountName': a.accountName,
          'legalName': a.legalName, 'nameMatch': a.nameMatch, 'email': _maskEmail(a.email), 'emailVerified': a.emailVerified, 'status': a.status,
        };

  /// Add (or replace) my payout account: look the account up at the bank, compare names, email a code.
  static Future<Map<String, dynamic>> set(Session s, UuidValue u, String bankCode, String accountNumber, String legalName, String email) async {
    final num = accountNumber.replaceAll(RegExp(r'\s'), ''), name = legalName.trim().replaceAll(RegExp(r'\s+'), ' '), mail = email.trim().toLowerCase();
    if (!RegExp(r'^\d{10}$').hasMatch(num)) throw PayoutRefused('Account numbers are 10 digits.');
    if (name.split(' ').length < 2 || name.length > 80) throw PayoutRefused('Your full name, as your bank has it (first and last name).');
    if (!RegExp(r'^[^@\s]{1,64}@[^@\s]+\.[a-z]{2,}$').hasMatch(mail)) throw PayoutRefused('Enter a real email address.');
    final bank = (await banks(s)).where((b) => b['code'] == bankCode).firstOrNull;
    if (bank == null) throw PayoutRefused('Choose your bank from the list.');
    final r = await _http.post(Uri.parse('https://api.flutterwave.com/v3/accounts/resolve'), headers: _auth(s), body: jsonEncode({'account_number': num, 'account_bank': bankCode})).timeout(const Duration(seconds: 20));
    final j = _json(r.body), d = j['data'] is Map ? j['data'] as Map : const {};
    final acctName = '${d['account_name'] ?? ''}'.trim();
    if (r.statusCode != 200 || acctName.isEmpty) throw PayoutRefused('That account number wasn\'t found at ${bank['name']}. Check it and try again.');
    final match = namesMatch(name, acctName);
    final code = _code(), now = DateTime.now().toUtc();
    final had = await IslandPayoutAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    final row = IslandPayoutAccount(
      id: had?.id, authUserId: u, bankCode: bankCode, bankName: bank['name']!, accountNumber: num, accountName: acctName, legalName: name, nameMatch: match,
      email: mail, emailVerified: false, emailCode: code, codeExpires: now.add(const Duration(minutes: 20)), codeTries: 0, status: 'unverified',
      createdAt: had?.createdAt ?? now, updatedAt: now,
    );
    final saved = had == null ? await IslandPayoutAccount.db.insertRow(s, row) : await IslandPayoutAccount.db.updateRow(s, row);
    await _sendCode(s, mail, code);
    return {'account': view(saved)};
  }

  /// The emailed code: right once and the email is confirmed; the account is verified if the names matched too.
  static Future<Map<String, dynamic>> verify(Session s, UuidValue u, String code) async {
    final a = await IslandPayoutAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    if (a == null) throw PayoutRefused('Add your bank account first.');
    if (a.emailVerified) return {'account': view(a)};
    if (a.codeTries >= 5) throw PayoutRefused('Too many wrong codes. Add the account again for a new code.');
    if (a.codeExpires == null || DateTime.now().toUtc().isAfter(a.codeExpires!)) throw PayoutRefused('That code has expired. Send a new one.');
    if (code.trim().toLowerCase() != a.emailCode) {
      await IslandPayoutAccount.db.updateRow(s, a.copyWith(codeTries: a.codeTries + 1));
      throw PayoutRefused('That code isn\'t right. Check the email and try again.');
    }
    final done = await IslandPayoutAccount.db.updateRow(s, a.copyWith(emailVerified: true, emailCode: null, codeExpires: null, status: a.nameMatch ? 'verified' : 'review', updatedAt: DateTime.now().toUtc()));
    return {'account': view(done)};
  }

  /// A new code to the same email.
  static Future<Map<String, dynamic>> resend(Session s, UuidValue u) async {
    final a = await IslandPayoutAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    if (a == null) throw PayoutRefused('Add your bank account first.');
    if (a.emailVerified) return {'account': view(a)};
    if (a.codeExpires != null && a.codeExpires!.difference(DateTime.now().toUtc()) > const Duration(minutes: 19)) throw PayoutRefused('A code was just sent. Give it a minute.');
    final code = _code();
    await IslandPayoutAccount.db.updateRow(s, a.copyWith(emailCode: code, codeExpires: DateTime.now().toUtc().add(const Duration(minutes: 20)), codeTries: 0));
    await _sendCode(s, a.email, code);
    return {'account': view(a)};
  }

  /// The names match when every word of the shorter one appears in the other (any order, any case, ignoring
  /// punctuation): "Awele Onokwai" matches "ONOKWAI AWELE MARY".
  static bool namesMatch(String given, String bank) {
    List<String> words(String v) => v.toLowerCase().replaceAll(RegExp(r'[^a-z\s]'), ' ').split(RegExp(r'\s+')).where((w) => w.length > 1).toList();
    final a = words(given), b = words(bank);
    if (a.length < 2 || b.isEmpty) return false;
    final (short, long) = a.length <= b.length ? (a, b.toSet()) : (b, a.toSet());
    return short.every(long.contains);
  }

  static String _code() { final r = Random.secure(); return List.generate(6, (_) => r.nextInt(10)).join(); }

  static Future<void> _sendCode(Session s, String email, String code) async {
    final token = s.passwords['scloudAuthEmailKey'];
    if (token == null || token.isEmpty) { s.log('[payout] email code for $email: $code', level: LogLevel.info); return; } // development: the code is in the log
    try {
      await ServerpodCloudEmailClient().sendEmail(token: token, emailType: ServerpodCloudEmailType.signup, email: email, projectName: 'Lagos Island', authCode: code);
    } catch (e) {
      s.log('[payout] email to $email failed: $e', level: LogLevel.warning);
      throw PayoutRefused('The code email could not be sent. Try again in a moment.');
    }
  }

  static String _maskEmail(String e) { final at = e.indexOf('@'); return at < 2 ? e : '${e.substring(0, 2)}${'•' * (at - 2).clamp(1, 6)}${e.substring(at)}'; }

  static Map<String, dynamic> _json(String b) { try { final v = jsonDecode(b); return v is Map<String, dynamic> ? v : const {}; } catch (_) { return const {}; } }
}

class PayoutRefused implements Exception {
  PayoutRefused(this.message);
  final String message;
}
