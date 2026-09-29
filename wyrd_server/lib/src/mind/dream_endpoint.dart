import '../generated/protocol.dart';
import 'dream_service.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Dreams: read them, see what they were made of, or (rate-limited) ask for one. Public, like Node.
class DreamEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxEntries = 100;

  Future<List<DreamEntry>> getEntries(Session session, {int? limit}) =>
      PublicCache.get(session, 'dream.getEntries:$limit', const Duration(seconds: 60), () => _getEntries(session, limit: limit));

  Future<List<DreamEntry>> _getEntries(Session session, {int? limit}) async {
    final take = (limit ?? 20).clamp(1, _maxEntries);
    final entries = await DreamEntry.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: take,
    );
    return entries.reversed.toList();
  }

  Future<DreamEntry?> trigger(Session session) async {
    PublicCache.clear();
    // public trigger: at most one dream per DreamService.minGap, so it can't spend the AI budget on demand
    return await DreamService.generateDream(session, respectGap: true);
  }

  /// The memories a dream was made of (its stars), shared knowledge only.
  Future<List<ConceptExample>> getStars(Session session, int dreamId) => DreamService.stars(session, dreamId);
}
