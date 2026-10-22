import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import '../world/world_authority.dart';

/// One account for Lagos Island and WYRD: a username and a password, chosen at the door of the island (the email is
/// added on the phone the first time it's opened; until then the account carries a placeholder, username@$domain). Registering makes a WYRD account (the same email/password provider the app uses, so
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
    return taken == null && !await lookalike(session, name) && await AuthServices.instance.emailIdp.admin.findAccount(session, email: emailOf(name)) == null;
  }

  /// names no new player may take, or look like
  static const _reserved = ['wyrd', 'admin', 'government', 'governor', 'lagosisland', 'support', 'treasury'];

  /// Is [name] too close to a name already on the island (or a reserved one)? Case, 0/o, 1/i/l, 3/e, 4/a, 5/s and the
  /// separators _ . - are ignored, so nobody can pass themselves off as someone else.
  static Future<bool> lookalike(Session s, String name) async {
    String skel(String v) => v.toLowerCase().replaceAll(RegExp(r'[_.\-]'), '').replaceAll('0', 'o').replaceAll(RegExp('[i1]'), 'l').replaceAll('3', 'e').replaceAll('4', 'a').replaceAll('5', 's');
    if (_reserved.contains(skel(name))) return true;
    final r = await s.db.unsafeQuery('SELECT 1 FROM "island_profile" WHERE translate(lower("handle"), \'0i1345_.-\', \'olleas\') = @n LIMIT 1', parameters: QueryParameters.named({'n': skel(name)}));
    return r.isNotEmpty;
  }

  /// Make an account: a Lagos Island name and a WYRD account in one. Returns the signed-in session.
  static final _signups = <String, List<DateTime>>{};
  /// The network address a request came from (Serverpod Cloud's proxy passes it along).
  static String clientAddress(Session s) {
    if (s is! MethodCallSession) return '';
    final f = s.request.headers['x-forwarded-for']?.join(',') ?? '';
    return f.split(',').first.trim();
  }

  Future<AuthSuccess> register(Session session, String username, String email, String password) async {
    final ip = clientAddress(session);
    if (ip.isNotEmpty) {
      final now = DateTime.now(), list = (_signups[ip] ??= [])..removeWhere((t) => now.difference(t) > const Duration(hours: 24));
      if (list.length >= 3) throw Exception('Too many new accounts from this network today. Try again tomorrow.');
      list.add(now);
    }
    final name = username.trim(), given = email.trim().toLowerCase(), mail = given.isEmpty ? emailOf(name) : given; // no email yet: the placeholder
    if (!_ok.hasMatch(name)) throw Exception('A username of 3 to 20 letters, digits, _ . or -.');
    if (given.isNotEmpty && (!_mail.hasMatch(given) || given.endsWith('@$domain'))) throw Exception('A real email address.');
    if (!strong(password)) throw Exception('A stronger password.');
    _throttle(session, 'reg', 300);
    final taken = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.ilike(_lit(name)));
    final emailIdp = AuthServices.instance.emailIdp;
    if (taken != null || await emailIdp.admin.findAccount(session, email: emailOf(name)) != null) {
      throw Exception('That username is taken.');
    }
    if (await lookalike(session, name)) throw Exception('That username is too close to someone else\'s. Pick one that\'s clearly yours.');
    if (given.isNotEmpty && await emailIdp.admin.findAccount(session, email: mail) != null) throw Exception('That email already has an account.');
    await session.db.transaction((tx) async {
      final user = await AuthServices.instance.authUsers.create(session, transaction: tx);
      await emailIdp.admin.createEmailAuthentication(session, authUserId: user.id, email: mail, password: password, transaction: tx);
      await AuthServices.instance.userProfiles.createUserProfile(session, user.id, UserProfileData(userName: name, email: given.isEmpty ? null : mail), transaction: tx);
      await IslandProfile.db.insertRow(session, IslandProfile(authUserId: user.id, handle: name, createdAt: DateTime.now().toUtc()), transaction: tx);
    });
    final auth = await emailIdp.login(session, email: mail, password: password);
    try {
      final made = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals(name));
      if (made != null) await WorldAuthority.citizen(session, made.authUserId); // their wallet, from the start
    } catch (e) {
      session.log('[island] wallet at sign-up failed for $name: $e', level: LogLevel.warning);
    }
    return auth;
  }

  static final _mail = RegExp(r'^[^@\s]{1,64}@[^@\s]+\.[a-z]{2,}$');
  /// 8+ characters with an upper-case letter, a lower-case letter and a digit
  static bool strong(String p) => p.length >= 8 && p.length <= 128 && RegExp(r'[A-Z]').hasMatch(p) && RegExp(r'[a-z]').hasMatch(p) && RegExp(r'[0-9]').hasMatch(p);

  /// Has this account a real email yet (not the placeholder it got at sign-up)?
  static Future<bool> hasEmail(Session s, UuidValue u) async {
    final a = await EmailAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    return a != null && !a.email.endsWith('@$domain');
  }

  /// Give an account that signed up with only a username its real email (asked for the first time the phone opens).
  /// The email becomes the account's sign-in email too (and where a password reset goes); the password stays the same.
  static Future<String?> setEmail(Session s, UuidValue u, String email) async {
    final mail = email.trim().toLowerCase();
    if (!_mail.hasMatch(mail) || mail.endsWith('@$domain')) return 'Enter a real email address.';
    final a = await EmailAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    if (a == null) return 'This account can\'t take an email.';
    if (a.email == mail) return null;
    if (await EmailAccount.db.findFirstRow(s, where: (t) => t.email.equals(mail)) != null) return 'That email already has an account.';
    await EmailAccount.db.updateRow(s, a.copyWith(email: mail));
    return null;
  }

  /// Opening the phone: the player confirms their game ID with their email and their game password. Checked against
  /// the account's own password hash (no new sign-in is made). An account still on the placeholder gets this email.
  static Future<String?> confirmPhone(Session s, UuidValue u, String email, String password) async {
    final mail = email.trim().toLowerCase();
    _throttle(s, 'phone:${u.uuid}', 12);
    final a = await EmailAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    if (a == null) return "This account can't open a phone.";
    final placeholder = a.email.endsWith('@$domain');
    if (!placeholder && a.email != mail) return "That email doesn't match this game ID.";
    try {
      final who = await AuthServices.instance.emailIdp.utils.authentication.authenticate(s, email: a.email, password: password, transaction: null);
      if (who != u) return "That password doesn't match this game ID.";
    } on EmailAuthenticationTooManyAttemptsException {
      return 'Too many tries. Wait a while and try again.';
    } catch (_) {
      return "That password doesn't match this game ID.";
    }
    if (placeholder) return setEmail(s, u, mail);
    return null;
  }

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
