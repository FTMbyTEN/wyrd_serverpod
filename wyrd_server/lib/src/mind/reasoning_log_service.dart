import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Replaces server.js's reasoning/*.md trace files with rows in reasoning_note. Written by the
/// reasoning and self-question ticks, read by ReasoningEndpoint.getNotes.
class ReasoningLogService {
  /// Node rotated old trace files into an archive folder; this keeps just the newest notes, which
  /// is all the UI ever shows.
  static const _keep = 200;

  static Future<void> record(
    Session session, {
    required String kind,
    required String content,
  }) async {
    await ReasoningNote.db.insertRow(
      session,
      ReasoningNote(
        timestamp: DateTime.now().toUtc(),
        kind: kind,
        content: content,
      ),
    );
    final cutoff = await ReasoningNote.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      offset: _keep,
      limit: 1,
    );
    if (cutoff.isNotEmpty) {
      await ReasoningNote.db.deleteWhere(
        session,
        where: (t) => t.id <= cutoff.first.id!,
      );
    }
  }

  static Future<List<ReasoningNote>> recent(Session session, int limit) =>
      ReasoningNote.db.find(
        session,
        orderBy: (t) => t.id.desc(),
        limit: limit.clamp(1, _keep),
      );
}
