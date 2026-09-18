import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/profile + the getProfile/touchProfileVisit pair from server.js. Node touched the
/// visit counter server-side at register/login; here that hook doesn't exist (the built-in email
/// IDP endpoints aren't ours to modify), so the Flutter client calls [touchVisit] right after a
/// successful sign-in instead.
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserProfile> _loadOrCreate(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final existing = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    return await UserProfile.db.insertRow(
      session,
      UserProfile(
        authUserId: authUserId,
        username: null,
        facts: [],
        visitCount: 0,
        firstSeen: now,
        lastSeen: now,
      ),
    );
  }

  Future<UserProfile> getProfile(Session session) async {
    return await _loadOrCreate(session);
  }

  Future<UserProfile> touchVisit(Session session) async {
    final profile = await _loadOrCreate(session);
    final updated = profile.copyWith(
      visitCount: profile.visitCount + 1,
      lastSeen: DateTime.now().toUtc(),
    );
    return await UserProfile.db.updateRow(session, updated);
  }

  Future<UserProfile> setUsername(Session session, String username) async {
    final profile = await _loadOrCreate(session);
    final updated = profile.copyWith(username: username);
    return await UserProfile.db.updateRow(session, updated);
  }
}
