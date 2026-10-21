import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:http/http.dart' as http;

/// Flutterwave's v4 API, as the server uses it: OAuth client credentials (passwords flutterwaveClientId and
/// flutterwaveClientSecret) for a 10-minute access token kept here and renewed a minute early, then JSON calls with a
/// trace id (and an idempotency key where a repeat must not act twice). FLUTTERWAVE_ENV=sandbox uses the sandbox,
/// anything else is live; FLUTTERWAVE_BASE_URL overrides the API host if Flutterwave moves it. The credentials never
/// leave the server.
class Flw4 {
  Flw4._(this.clientId, this.clientSecret);
  final String clientId, clientSecret;

  static final _byId = <String, Flw4>{};

  /// The client for these passwords, or null while the credentials aren't set.
  static Flw4? from(String? Function(String) password) {
    final id = (password('flutterwaveClientId') ?? '').trim(), secret = (password('flutterwaveClientSecret') ?? '').trim();
    if (id.isEmpty || secret.isEmpty) return null;
    final have = _byId[id];
    if (have != null && have.clientSecret == secret) return have;
    return _byId[id] = Flw4._(id, secret);
  }

  static bool get sandbox => (Platform.environment['FLUTTERWAVE_ENV'] ?? '').trim().toLowerCase() == 'sandbox';
  static String get base {
    final o = (Platform.environment['FLUTTERWAVE_BASE_URL'] ?? '').trim();
    if (o.isNotEmpty) return o.endsWith('/') ? o.substring(0, o.length - 1) : o;
    return sandbox ? 'https://developersandbox-api.flutterwave.com' : 'https://f4bexperience.flutterwave.com';
  }

  final _http = http.Client();
  String? _tok;
  DateTime _until = DateTime.fromMillisecondsSinceEpoch(0);

  /// The access token, or null (with the reason in [lastError]) if Flutterwave refused the credentials.
  Future<String?> token() async {
    if (_tok != null && DateTime.now().isBefore(_until)) return _tok;
    final r = await _http.post(
      Uri.parse('https://idp.flutterwave.com/realms/flutterwave/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'client_id': clientId, 'client_secret': clientSecret, 'grant_type': 'client_credentials'},
    ).timeout(const Duration(seconds: 20));
    final j = json(r.body), t = j['access_token'];
    if (r.statusCode != 200 || t is! String) {
      lastError = 'token ${r.statusCode}: ${cut(r.body)}';
      return null;
    }
    _tok = t;
    _until = DateTime.now().add(Duration(seconds: max(30, (j['expires_in'] is num ? (j['expires_in'] as num).toInt() : 600) - 60)));
    return t;
  }

  String lastError = '';

  /// One call: (HTTP status, JSON body with the first 300 characters of the raw body under '_raw'). Status 0 means no
  /// token could be had. A 401 fetches a fresh token and tries once more.
  Future<(int, Map<String, dynamic>)> call(String method, String path, {Map<String, Object?>? body, String? idem, Duration timeout = const Duration(seconds: 20)}) async {
    for (var k = 0; k < 2; k++) {
      final t = await token();
      if (t == null) return (0, <String, dynamic>{'_raw': lastError});
      final h = {'Authorization': 'Bearer $t', 'Accept': 'application/json', 'Content-Type': 'application/json', 'X-Trace-Id': rid(), if (idem != null) 'X-Idempotency-Key': idem};
      final uri = Uri.parse('$base$path');
      final r = await (method == 'GET' ? _http.get(uri, headers: h) : _http.post(uri, headers: h, body: jsonEncode(body ?? const {}))).timeout(timeout);
      if (r.statusCode == 401 && k == 0) {
        _tok = null;
        continue;
      }
      return (r.statusCode, json(r.body)..['_raw'] = cut(r.body));
    }
    return (401, <String, dynamic>{});
  }

  static String rid() {
    final r = Random.secure();
    return List.generate(24, (_) => r.nextInt(36).toRadixString(36)).join();
  }

  static String cut(String b) => b.length > 300 ? b.substring(0, 300) : b;

  static Map<String, dynamic> json(String b) {
    try {
      final v = jsonDecode(b);
      return v is Map<String, dynamic> ? Map<String, dynamic>.from(v) : <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }
}
