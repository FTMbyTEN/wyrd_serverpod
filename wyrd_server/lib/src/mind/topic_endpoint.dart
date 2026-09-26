import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/topic/:topic from server.js -- what WYRD actually knows about one topic, for
/// click-to-inspect in the brain view. Public, like Node.
class TopicEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<TopicInfo> getTopic(Session session, String topic) async {
    final t = topic.trim().toLowerCase();

    // memory_block.topics is a json array column; match inside Postgres instead of loading
    // every block the way Node's in-memory store did.
    final rows = await session.db.unsafeQuery(
      'SELECT "id", "source", "userText" IS NOT NULL AS "fromChat" FROM "memory_block" '
      'WHERE jsonb_exists("topics"::jsonb, @topic) ORDER BY "id"',
      parameters: QueryParameters.named({'topic': t}),
    );
    final matches = [
      for (final r in rows)
        (id: r[0] as int, source: r[1] as String, fromChat: r[2] as bool),
    ];

    Future<MemoryBlock?> latest(String source) async {
      final hit = matches.lastWhere(
        (m) => m.source == source,
        orElse: () => (id: -1, source: '', fromChat: false),
      );
      return hit.id < 0 ? null : MemoryBlock.db.findById(session, hit.id);
    }

    final selfBlock = await latest('self');
    final synthesisBlock = await latest('synthesis');
    final netBlock = await latest('net');
    final word = await LexiconEntry.db.findFirstRow(
      session,
      where: (w) => w.word.equals(t),
    );
    final understood = word != null && word.understood;

    return TopicInfo(
      topic: t,
      seenCount: matches.length,
      definitionPartOfSpeech: understood ? word.partOfSpeech : null,
      definition: understood ? word.definition : null,
      selfQuestion: selfBlock?.question,
      selfAnswer: selfBlock?.answer,
      synthesis: synthesisBlock?.insight,
      netFactTitle: netBlock?.title,
      netFactExtract: netBlock?.extract,
      chatMentions: matches.where((m) => m.fromChat).length,
    );
  }
}
