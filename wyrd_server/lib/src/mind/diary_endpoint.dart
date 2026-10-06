import '../generated/protocol.dart';
import 'diary_service.dart';
import 'rate_limiter.dart';
import 'public_cache.dart';
import 'owner_guard.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/diary and /api/diary/trigger from server.js. Public/unauthenticated, matching
/// Node -- WYRD's diary is a single shared journal, not per-user.
class DiaryEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxEntries = 100;

  Future<List<DiaryEntry>> getEntries(Session session, {int? limit}) async {
    await OwnerGuard.check(session, 'the diary');
    return PublicCache.get(session, 'diary.getEntries:$limit', const Duration(seconds: 60), () => _getEntries(session, limit: limit));
  }

  Future<List<DiaryEntry>> _getEntries(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxEntries);
    final entries = await DiaryEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries.reversed.toList();
  }

  Future<DiaryEntry> trigger(Session session) async {
    await OwnerGuard.check(session, 'the diary');
    PublicCache.clear();
    // public and AI-backed: a few per 10 minutes, so nobody can spend WYRD's budget on demand
    if (RateLimiter.isLimited('trigger:diary', 3, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    return await DiaryService.generateEntry(session);
  }
}
