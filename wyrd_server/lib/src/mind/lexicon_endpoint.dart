import '../generated/protocol.dart';
import 'lexicon_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's /api/lexicon/stats, /api/lexicon/word/:word and /api/lexicon/trigger.
/// The learning tick itself lives in lexicon_service.dart. Public/unauthenticated, matching
/// Node.
class LexiconEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Runs one learning tick now instead of waiting for the timer. False if there was nothing new
  /// to learn (or the wordlist isn't loaded yet).
  Future<bool> trigger(Session session) => LexiconService.tick(session);

  Future<LexiconStats> getStats(Session session) async {
    final all = await LexiconEntry.db.find(session, orderBy: (t) => t.id.asc());
    final understood = all.where((e) => e.understood).toList();
    final recent = understood
        .skip(understood.length > 5 ? understood.length - 5 : 0)
        .map(
          (e) => LexiconWordSummary(
            word: e.word,
            definition: e.definition,
            partOfSpeech: e.partOfSpeech,
          ),
        )
        .toList();

    return LexiconStats(
      learned: understood.length,
      attempted: all.length,
      recentWords: recent,
    );
  }

  Future<LexiconEntry?> getWord(Session session, String word) async {
    return await LexiconEntry.db.findFirstRow(
      session,
      where: (t) => t.word.equals(word.toLowerCase()),
    );
  }
}
