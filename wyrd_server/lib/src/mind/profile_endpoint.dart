import '../generated/protocol.dart';
import 'user_fact_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/profile + the getProfile/touchProfileVisit pair from server.js. Node touched the
/// visit counter server-side at register/login; here that hook doesn't exist (the built-in email
/// IDP endpoints aren't ours to modify), so the Flutter client calls [touchVisit] right after a
/// successful sign-in instead.
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserProfile> getProfile(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return await UserFactService.loadOrCreateProfile(session, authUserId);
  }

  Future<UserProfile> touchVisit(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final profile = await UserFactService.loadOrCreateProfile(session, authUserId);
    final updated = profile.copyWith(
      visitCount: profile.visitCount + 1,
      lastSeen: DateTime.now().toUtc(),
    );
    return await UserProfile.db.updateRow(session, updated);
  }

  Future<UserProfile> setUsername(Session session, String username) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final profile = await UserFactService.loadOrCreateProfile(session, authUserId);
    final updated = profile.copyWith(username: username);
    return await UserProfile.db.updateRow(session, updated);
  }
}
