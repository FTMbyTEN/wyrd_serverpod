import '../generated/protocol.dart';
import 'diary_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/diary and /api/diary/trigger from server.js. Public/unauthenticated, matching
/// Node -- WYRD's diary is a single shared journal, not per-user.
class DiaryEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxEntries = 100;

  Future<List<DiaryEntry>> getEntries(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxEntries);
    final entries = await DiaryEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries.reversed.toList();
  }

  Future<DiaryEntry> trigger(Session session) async {
    return await DiaryService.generateEntry(session);
  }
}
