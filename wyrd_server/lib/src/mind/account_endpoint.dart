import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'user_fact_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/account/export and /api/account/delete from server.js. Node's delete required
/// re-entering the password and removed the login credential itself, not just app data --
/// with Serverpod's built-in email auth, credential deletion isn't something this project's
/// own endpoints can safely do (that lives inside serverpod_auth_idp_server, with no public
/// self-service delete-account method exposed), so [deleteMyData] wipes everything this app
/// owns about the person (profile facts, visit history, conversation history) but leaves
/// their login credential intact -- a real, documented gap versus Node's full account wipe.
class AccountEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AccountExport> exportData(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final profile = await UserFactService.loadOrCreateProfile(session, authUserId);
    final email = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final conversation = await ConversationTurn.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.id.asc(),
    );

    return AccountExport(
      email: email?.email,
      facts: profile.facts,
      visitCount: profile.visitCount,
      firstSeen: profile.firstSeen,
      lastSeen: profile.lastSeen,
      conversation: conversation,
    );
  }

  Future<void> deleteMyData(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);

    final profile = await UserFactService.loadOrCreateProfile(session, authUserId);
    await UserProfile.db.deleteRow(session, profile);

    final turns = await ConversationTurn.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    for (final turn in turns) {
      await ConversationTurn.db.deleteRow(session, turn);
    }
  }
}
