import '../generated/protocol.dart';
import 'curriculum_data.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's loadCurriculum/nextCurriculumEntry/advanceCurriculum against a real
/// persisted singleton row instead of curriculum.json.
class CurriculumService {
  static const _maxCompletedTitles = 500;

  static Future<CurriculumProgress> _loadOrCreate(Session session) async {
    final existing = await CurriculumProgress.db.findById(session, 1);
    if (existing != null) return existing;
    return await CurriculumProgress.db.insertRow(
      session,
      CurriculumProgress(id: 1, index: 0, completedTitles: []),
    );
  }

  static Future<(CurriculumEntry, int lap)> nextEntry(Session session) async {
    final progress = await _loadOrCreate(session);
    final entries = CurriculumData.entries;
    final entry = entries[progress.index % entries.length];
    final lap = progress.index ~/ entries.length;
    return (entry, lap);
  }

  static Future<void> advance(Session session, String title) async {
    final progress = await _loadOrCreate(session);
    final completed = [...progress.completedTitles, title];
    final trimmed = completed.length > _maxCompletedTitles
        ? completed.sublist(completed.length - _maxCompletedTitles)
        : completed;
    await CurriculumProgress.db.updateRow(
      session,
      progress.copyWith(index: progress.index + 1, completedTitles: trimmed),
    );
  }

  static Future<CurriculumStatus> status(Session session) async {
    final progress = await _loadOrCreate(session);
    final entries = CurriculumData.entries;
    final (entry, lap) = await nextEntry(session);
    return CurriculumStatus(
      subject: entry.subject,
      level: entry.level,
      title: entry.title,
      position: (progress.index % entries.length) + 1,
      total: entries.length,
      lap: lap,
      recentlyCompleted: progress.completedTitles.reversed.take(10).toList(),
    );
  }
}
