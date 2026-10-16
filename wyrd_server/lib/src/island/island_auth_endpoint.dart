import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// One account for Lagos Island and WYRD: a username, an email and a password, chosen at the door of
/// the island. Registering makes a WYRD account (the same email/password provider the app uses, so
/// "forgot password" works through that email) and the island name; signing in works with the
/// username or the email, on the island and in the WYRD app.
class IslandAuthEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const domain = 'lagosisland.wyrd';
  static String emailOf(String username) => '${username.trim().toLowerCase()}@$domain';
  static final _ok = RegExp(r'^[a-zA-Z0-9_.-]{3,20}$');
  /// a name as an exact (case-blind) ILIKE pattern: _ and % match only themselves
  static String _lit(String s) => s.replaceAll('_', r'\_').replaceAll('%', r'\%');

  static final _recent = <String, List<DateTime>>{};
  static void _throttle(Session s, String key, int perHour) {
    final now = DateTime.now();
    final list = (_recent[key] ??= [])..removeWhere((t) => now.difference(t).inMinutes >= 60);
    if (list.length >= perHour) throw Exception('Too many tries. Wait a while and try again.');
    list.add(now);
  }

  /// Is this username free? (the door asks before making the account)
  Future<bool> available(Session session, String username) async {
    final name = username.trim();
    if (!_ok.hasMatch(name)) return false;
    final taken = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.ilike(_lit(name)));
    return taken == null && await AuthServices.instance.emailIdp.admin.findAccount(session, email: emailOf(name)) == null;
  }

  /// Make an account: a Lagos Island name and a WYRD account in one. Returns the signed-in session.
  Future<AuthSuccess> register(Session session, String username, String email, String password) async {
    final name = username.trim(), mail = email.trim().toLowerCase();
    if (!_ok.hasMatch(name)) throw Exception('A username of 3 to 20 letters, digits, _ . or -.');
    if (!_mail.hasMatch(mail) || mail.endsWith('@$domain')) throw Exception('A real email address.');
    if (!strong(password)) throw Exception('A stronger password.');
    _throttle(session, 'reg', 300);
    final taken = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.ilike(_lit(name)));
    final emailIdp = AuthServices.instance.emailIdp;
    if (taken != null || await emailIdp.admin.findAccount(session, email: emailOf(name)) != null) {
      throw Exception('That username is taken.');
    }
    if (await emailIdp.admin.findAccount(session, email: mail) != null) throw Exception('That email already has an account.');
    await session.db.transaction((tx) async {
      final user = await AuthServices.instance.authUsers.create(session, transaction: tx);
      await emailIdp.admin.createEmailAuthentication(session, authUserId: user.id, email: mail, password: password, transaction: tx);
      await AuthServices.instance.userProfiles.createUserProfile(session, user.id, UserProfileData(userName: name, email: mail), transaction: tx);
      await IslandProfile.db.insertRow(session, IslandProfile(authUserId: user.id, handle: name, createdAt: DateTime.now().toUtc()), transaction: tx);
    });
    return emailIdp.login(session, email: mail, password: password);
  }

  static final _mail = RegExp(r'^[^@\s]{1,64}@[^@\s]+\.[a-z]{2,}$');
  /// 8+ characters with an upper-case letter, a lower-case letter and a digit
  static bool strong(String p) => p.length >= 8 && p.length <= 128 && RegExp(r'[A-Z]').hasMatch(p) && RegExp(r'[a-z]').hasMatch(p) && RegExp(r'[0-9]').hasMatch(p);

  /// Is this email free?
  Future<bool> emailFree(Session session, String email) async =>
      await AuthServices.instance.emailIdp.admin.findAccount(session, email: email.trim().toLowerCase()) == null;

  /// Sign in with a Lagos Island username (or the email of a WYRD account) and password.
  Future<AuthSuccess> login(Session session, String username, String password) async {
    final id = username.trim();
    _throttle(session, 'login:${id.toLowerCase()}', 20);
    final emailIdp = AuthServices.instance.emailIdp;
    if (id.contains('@')) return emailIdp.login(session, email: id.toLowerCase(), password: password);
    // an island name made in the app (with a real email) signs in through that email
    final p = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.ilike(_lit(id)));
    if (p != null) {
      final acct = await EmailAccount.db.findFirstRow(session, where: (t) => t.authUserId.equals(p.authUserId));
      if (acct != null) return emailIdp.login(session, email: acct.email, password: password);
    }
    return emailIdp.login(session, email: emailOf(id), password: password);
  }
}
