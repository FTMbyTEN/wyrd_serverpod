import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports the read side of server.js's /api/lexicon/stats and /api/lexicon/word/:word.
/// /api/lexicon/trigger (the LLM-backed word-learning tick) is not ported yet — it belongs
/// with the rest of the autonomous engine, not this read-only batch. Public/unauthenticated,
/// matching Node.
class LexiconEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<LexiconStats> getStats(Session session) async {
    final all = await LexiconEntry.db.find(session, orderBy: (t) => t.id.asc());
    final understood = all.where((e) => e.understood).toList();
    final recent = understood
        .skip(understood.length > 5 ? understood.length - 5 : 0)
        .map((e) => LexiconWordSummary(word: e.word, definition: e.definition, partOfSpeech: e.partOfSpeech))
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
