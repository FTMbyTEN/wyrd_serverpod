import '../generated/protocol.dart';
import 'lexicon_service.dart';
import 'wordnet_service.dart';
import 'rate_limiter.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's /api/lexicon/stats, /api/lexicon/word/:word and /api/lexicon/trigger.
/// The learning tick itself lives in lexicon_service.dart. Public/unauthenticated, matching
/// Node.
class LexiconEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Runs one learning tick now instead of waiting for the timer. False if there was nothing new
  /// to learn (or the wordlist isn't loaded yet).
  Future<bool> trigger(Session session) async {
    // public: a few per 10 minutes, so nobody can hammer it (the scheduler runs it anyway)
    if (RateLimiter.isLimited('trigger:lexicon', 6, const Duration(minutes: 10))) {
      throw Exception('slow down — try again in a few minutes');
    }
    return LexiconService.tick(session);
  }

  /// Whether WYRD's own dictionary (WordNet) is loaded, importing, or missing -- and why.
  Future<String> wordnetStatus(Session session) async =>
      await WordNetService.isReady(session) ? 'ready' : WordNetService.status;

  /// Two counts and the five newest understood words -- not the whole lexicon, which grows
  /// every 30s and was being loaded in full on every poll.
  Future<LexiconStats> getStats(Session session) async {
    final learned = await LexiconEntry.db.count(session, where: (t) => t.understood.equals(true));
    final attempted = await LexiconEntry.db.count(session);
    final newest = await LexiconEntry.db.find(
      session,
      where: (t) => t.understood.equals(true),
      orderBy: (t) => t.id.desc(),
      limit: 5,
    );
    return LexiconStats(
      learned: learned,
      attempted: attempted,
      recentWords: [
        for (final e in newest.reversed)
          LexiconWordSummary(word: e.word, definition: e.definition, partOfSpeech: e.partOfSpeech),
      ],
    );
  }


  Future<LexiconEntry?> getWord(Session session, String word) async {
    return await LexiconEntry.db.findFirstRow(
      session,
      where: (t) => t.word.equals(word.toLowerCase()),
    );
  }
}
