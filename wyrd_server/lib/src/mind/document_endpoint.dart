import '../generated/protocol.dart';
import 'document_service.dart';
import 'rate_limiter.dart';
import 'thread_service.dart';
import 'package:serverpod/serverpod.dart';

/// Files shared in Dialogue Link: stored privately for the person who shared them.
class DocumentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  UuidValue _me(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  static const _kinds = {'pdf', 'docx', 'text', 'html', 'csv', 'json', 'code'};

  /// Shares a file's text (extracted in the browser) with WYRD. It becomes the file the
  /// conversation is about, and WYRD's first look at it is added to the conversation.
  Future<DocumentUpload> upload(Session session, String name, String kind, String text, {int? pages}) async {
    final me = _me(session);
    if (RateLimiter.isLimited('doc:${me.uuid}', 12, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    if (!_kinds.contains(kind)) throw Exception('that kind of file is not supported yet');
    if (text.trim().length < 20) throw Exception('I couldn\'t find readable text in that file (a scanned PDF is an image, not text).');
    final doc = await DocumentService.store(session, me, name: name.trim().isEmpty ? 'file' : name.trim(), kind: kind, text: text, pages: pages);

    final thread = await ThreadService.load(session, me);
    final now = DateTime.now().toUtc();
    final next = (thread ?? ChatThread(authUserId: me, subject: const [], updatedAt: now))
        .copyWith(lastDocumentId: doc.id, lastDocumentName: doc.name, documentAt: now, updatedAt: now);
    if (thread == null) {
      await ChatThread.db.insertRow(session, next);
    } else {
      await ChatThread.db.updateRow(session, next);
    }

    final reply = DocumentService.overview(doc);
    final turn = await ConversationTurn.db.insertRow(
      session,
      ConversationTurn(authUserId: me, userText: '📎 ${doc.name}', botText: reply, timestamp: now),
    );
    return DocumentUpload(id: doc.id!, name: doc.name, kind: doc.kind, words: doc.words, pages: doc.pages, reply: reply, turnId: turn.id);
  }

  /// Your shared files, newest first (without their text).
  Future<List<UserDocument>> list(Session session) async {
    final rows = await UserDocument.db.find(
      session,
      where: (t) => t.authUserId.equals(_me(session)),
      orderBy: (t) => t.createdAt.desc(),
      limit: 30,
    );
    return [for (final d in rows) d.copyWith(text: '')];
  }

  Future<void> remove(Session session, int id) async {
    final doc = await UserDocument.db.findById(session, id);
    if (doc == null || doc.authUserId != _me(session)) return;
    await UserDocument.db.deleteRow(session, doc);
  }
}
