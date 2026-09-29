import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'user_fact_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/account/export and /api/account/delete from server.js. Node's delete required
/// re-entering the password and removed the login credential itself, not just app data --
/// with Serverpod's built-in email auth, credential deletion isn't something this project's
/// own endpoints can safely do (that lives inside serverpod_auth_idp_server, with no public
/// self-service delete-account method exposed), so [deleteMyData] wipes everything this app
/// owns about the person (profile, conversations, photos, memories and answers learned from them,
/// the conversation thread) but leaves
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

    final sightings = await Sighting.db.find(session, where: (t) => t.authUserId.equals(authUserId), orderBy: (t) => t.id);
    final learned = await LearnedAnswer.db.find(session, where: (t) => t.authUserId.equals(authUserId), orderBy: (t) => t.id);
    final memories = await MemoryBlock.db.find(session, where: (t) => t.ownerId.equals(authUserId), orderBy: (t) => t.id);
    final thread = await ChatThread.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId));
    final documents = await UserDocument.db.find(session, where: (t) => t.authUserId.equals(authUserId), orderBy: (t) => t.id);
    final reading = await ReadingItem.db.find(session, where: (t) => t.authUserId.equals(authUserId), orderBy: (t) => t.id);

    return AccountExport(
      email: email?.email,
      facts: profile.facts,
      visitCount: profile.visitCount,
      firstSeen: profile.firstSeen,
      lastSeen: profile.lastSeen,
      conversation: conversation,
      sightings: sightings,
      learnedAnswers: learned,
      memories: memories,
      thread: thread,
      readingList: reading,
      documents: documents,
    );
  }

  Future<void> deleteMyData(Session session) async {
    final authUserId = UuidValue.fromString(session.authenticated!.userIdentifier);

    final profile = await UserFactService.loadOrCreateProfile(session, authUserId);
    await UserProfile.db.deleteRow(session, profile);

    // everything that came from them: chats, photos, what WYRD learned or remembered from those,
    // and where their conversation had got to. (Their thumbs' past effect on shared scores is
    // aggregate and anonymous, so it stays.)
    await ConversationTurn.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await Sighting.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await LearnedAnswer.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await MemoryBlock.db.deleteWhere(session, where: (t) => t.ownerId.equals(authUserId));
    await ChatThread.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await ReadingItem.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await UserDocument.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
    await QuizAttempt.db.deleteWhere(session, where: (t) => t.authUserId.equals(authUserId));
  }
}
