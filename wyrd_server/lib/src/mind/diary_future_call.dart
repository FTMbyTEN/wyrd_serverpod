import '../generated/protocol.dart';
import 'diary_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's diaryTickIfNewDay (checked every 10 real minutes): write one diary entry
/// per real calendar day, skipping if today's entry already exists or there's nothing yet to
/// reflect on. Scheduled recurring from server.dart.
class DiaryFutureCall extends FutureCall {
  Future<void> checkAndWrite(Session session) async {
    final blockCount = await MemoryBlock.db.count(session);
    if (blockCount == 0) return;

    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    final latest = await DiaryEntry.db.findFirstRow(
      session,
      orderBy: (t) => t.id.desc(),
    );
    if (latest != null && latest.date == today) return;

    await DiaryService.generateEntry(session);
  }
}
