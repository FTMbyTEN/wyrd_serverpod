import '../generated/protocol.dart';
import 'trust_service.dart';
import 'package:serverpod/serverpod.dart';

/// What chat recall hands the model: short, labelled lines of things WYRD actually knows.
class RecallContext {
  RecallContext({required this.digested, required this.knowledge, required this.pastChats, required this.definitions, this.groundingIds = const []});

  /// The shared memories behind [digested] and [knowledge], so a rating of the reply can reach
  /// their sources (Bias 2).
  final List<int> groundingIds;

  /// Answers WYRD's own self-questioning already worked out ("digested" understanding).
  final List<String> digested;

  /// Things it read or synthesised: web/feed articles, curriculum, syntheses.
  final List<String> knowledge;

  /// This person's own earlier exchanges on the same topics (never anyone else's).
  final List<String> pastChats;

  /// Dictionary definitions it has learned for words in the message.
  final List<String> definitions;

  bool get isEmpty => digested.isEmpty && knowledge.isEmpty && pastChats.isEmpty && definitions.isEmpty;

  /// Context-prompt lines, most trustworthy first.
  List<String> toPromptLines() => [
        if (digested.isNotEmpty) 'Things you already worked out yourself: ${digested.join(' | ')}',
        if (knowledge.isNotEmpty) "Things you've read or connected before that bear on this: ${knowledge.join(' | ')}",
        if (pastChats.isNotEmpty) 'Earlier in your conversations with THIS person on the same subject: ${pastChats.join(' | ')}',
        if (definitions.isNotEmpty) "Word meanings you've learned: ${definitions.join(' | ')}",
      ];
}

/// Ports server.js's recall paths (recallRelated + findDigested, plus lexicon grounding) over the
/// whole memory, not just the newest rows. Memory rows don't record who they came from, so chat
/// and photo blocks are never recalled here -- another person's conversation must not surface
/// in your reply. Your own history comes from conversation_turn, which is keyed by user.
/// Recalled lines plus the memories they came from.
class _Found {
  _Found(this.digested, this.knowledge, this.ids);
  static final empty = _Found(const [], const [], const []);
  final List<String> digested;
  final List<String> knowledge;
  final List<int> ids;
}

class MemoryRecallService {
  static const _sharedSources = ['self', 'net', 'feed', 'ingest', 'synthesis', 'curriculum', 'library'];
  static const _maxItemChars = 240;

  /// Words that shape a question but aren't its subject (Node's QUESTION_SCAFFOLD).
  static const scaffold = {
    'what', 'how', 'why', 'who', 'when', 'where', 'explain', 'tell', 'describe', 'give', 'know',
    'think', 'say', 'does', 'is', 'are', 'can', 'could', 'would', 'should', "what's", "who's",
    "how's", "where's", "when's", "that's", "it's", 'up', 'good', 'going',
  };

  static List<String> contentTopics(List<String> topics) {
    final content = topics.where((t) => !scaffold.contains(t)).toList();
    return content.isNotEmpty ? content : topics;
  }

  static String _clip(String s) {
    final flat = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return flat.length <= _maxItemChars ? flat : '${flat.substring(0, _maxItemChars - 1).trimRight()}…';
  }

  /// [meaning] is the message's embedding (see EmbeddingService), when available: the memories
  /// closest in meaning come first, so "how do planes stay up" finds an article about lift.
  static Future<RecallContext> recall(Session session, UuidValue authUserId, List<String> topics, {Vector? meaning}) async {
    final t = contentTopics(topics).take(12).toList();
    if (t.isEmpty && meaning == null) return RecallContext(digested: [], knowledge: [], pastChats: [], definitions: []);

    final results = await Future.wait([
      t.isEmpty ? Future.value(_Found.empty) : _sharedMemory(session, t),
      t.isEmpty ? Future.value(<String>[]) : _ownChats(session, authUserId, t),
      t.isEmpty ? Future.value(<String>[]) : _definitions(session, t),
      meaning == null ? Future.value(_Found.empty) : _byMeaning(session, meaning),
    ]);
    final words = results[0] as _Found;
    final near = results[3] as _Found;
    List<String> merge(List<String> a, List<String> b, int n) => {...a, ...b}.take(n).toList();
    return RecallContext(
      digested: merge(near.digested, words.digested, 2),
      knowledge: merge(near.knowledge, words.knowledge, 4),
      pastChats: results[1] as List<String>,
      definitions: results[2] as List<String>,
      groundingIds: {...near.ids, ...words.ids}.toList(),
    );
  }

  /// The shared memories nearest in meaning to [meaning] (cosine distance), if close enough.
  static Future<_Found> _byMeaning(Session session, Vector meaning) async {
    const maxDistance = 0.55; // cosine similarity >= 0.45
    final rows = await session.db.unsafeQuery(
      'SELECT "id", ("embedding" <=> @q::vector) FROM "memory_block" WHERE "embedding" IS NOT NULL AND "source" = ANY(@sources::text[]) '
      'AND ("embedding" <=> @q::vector) < @max ORDER BY "embedding" <=> @q::vector LIMIT 12',
      parameters: QueryParameters.named({'q': '[${meaning.toList().join(',')}]', 'sources': _sharedSources, 'max': maxDistance}),
    );
    if (rows.isEmpty) return _Found.empty;
    final distance = {for (final r in rows) r[0] as int: (r[1] as num).toDouble()};
    final blocks = await MemoryBlock.db.find(session, where: (t) => t.id.inSet(distance.keys.toSet()));
    // Bias 2: closeness in meaning, weighted by how much WYRD trusts where each memory came from
    final trust = await TrustService.scores(session, TrustService.source,
        blocks.map((b) => TrustService.sourceKey(url: b.url, feedSource: b.feedSource)).whereType<String>());
    double weight(MemoryBlock b) =>
        (1 - distance[b.id]!) * (0.5 + (trust[TrustService.sourceKey(url: b.url, feedSource: b.feedSource)] ?? 0.5));
    blocks.sort((a, b) => weight(b).compareTo(weight(a)));
    final digested = <String>[], knowledge = <String>[], ids = <int>[];
    for (final b in blocks.take(6)) {
      ids.add(b.id!);
      if (b.source == 'self' && b.question != null && b.answer != null) {
        digested.add(_clip('Q: ${b.question} A: ${b.answer}'));
      } else if (b.source == 'synthesis' && b.insight != null) {
        knowledge.add(_clip(b.insight!));
      } else if (b.title != null) {
        knowledge.add(_clip(b.extract != null ? '${b.title}: ${b.extract}' : b.title!));
      }
    }
    return _Found(digested, knowledge, ids);
  }

  /// Ranks shared memory by topic overlap (Jaccard, like Node), newest first on ties.
  static Future<_Found> _sharedMemory(Session session, List<String> t) async {
    final rows = await session.db.unsafeQuery(
      '''
      SELECT "source", "title", "extract", "question", "answer", "answeredTopic", "insight", "topics"::text,
             "id", "url", "feedSource",
             (SELECT count(*) FROM json_array_elements_text("topics") x WHERE x = ANY(@t::text[])) AS overlap,
             json_array_length("topics") AS n
      FROM "memory_block"
      WHERE "source" = ANY(@sources::text[]) AND "topics"::jsonb ?| @t::text[]
      ORDER BY overlap DESC, "timestamp" DESC
      LIMIT 60
      ''',
      parameters: QueryParameters.named({'t': t, 'sources': _sharedSources}),
    );

    // columns: 0 source .. 7 topics, 8 id, 9 url, 10 feedSource, 11 overlap, 12 n
    final trust = await TrustService.scores(session, TrustService.source,
        rows.map((r) => TrustService.sourceKey(url: r[9] as String?, feedSource: r[10] as String?)).whereType<String>());
    final scored = <({String source, double score, List<dynamic> r})>[];
    for (final r in rows) {
      final overlap = (r[11] as int).toDouble();
      final union = t.length + (r[12] as int) - overlap;
      var score = union > 0 ? overlap / union : 0.0;
      if (r[0] == 'self' && t.contains(r[5])) score += 0.5; // answered exactly this topic
      // Bias 2: weighted by how much WYRD trusts where it came from
      score *= 0.5 + (trust[TrustService.sourceKey(url: r[9] as String?, feedSource: r[10] as String?)] ?? 0.5);
      scored.add((source: r[0] as String, score: score, r: r));
    }
    scored.sort((a, b) => b.score.compareTo(a.score));

    final digested = <String>[];
    final knowledge = <String>[];
    final ids = <int>[];
    final seen = <String>{};
    for (final s in scored) {
      final r = s.r;
      String? line;
      if (s.source == 'self') {
        if (digested.length >= 2 || r[3] == null || r[4] == null) continue;
        line = _clip('Q: ${r[3]} A: ${r[4]}');
        if (seen.add(line)) {
          digested.add(line);
          ids.add(r[8] as int);
        }
        continue;
      }
      if (knowledge.length >= 3) continue;
      if (s.source == 'synthesis' && r[6] != null) {
        line = _clip(r[6] as String);
      } else if (r[1] != null) {
        line = _clip(r[2] != null ? '${r[1]}: ${r[2]}' : r[1] as String);
      }
      if (line != null && seen.add(line)) {
        knowledge.add(line);
        ids.add(r[8] as int);
      }
    }
    return _Found(digested, knowledge, ids);
  }

  /// This person's own earlier turns that share the message's topics.
  static Future<List<String>> _ownChats(Session session, UuidValue authUserId, List<String> t) async {
    final pattern = t.map(RegExp.escape).join('|');
    final rows = await session.db.unsafeQuery(
      '''
      SELECT "userText", "botText" FROM "conversation_turn"
      WHERE "authUserId" = @id AND "userText" ~* @re
      ORDER BY "id" DESC
      OFFSET 8 LIMIT 3
      ''',
      // the 8 newest turns are already in the prompt as live history (ChatService._historyTurns)
      parameters: QueryParameters.named({'id': authUserId.uuid, 're': '\\m($pattern)\\M'}),
    );
    return rows.map((r) => _clip('they said "${r[0]}" and you said "${r[1]}"')).toList();
  }

  static Future<List<String>> _definitions(Session session, List<String> t) async {
    final entries = await LexiconEntry.db.find(
      session,
      where: (e) => e.word.inSet(t.toSet()) & e.understood.equals(true),
      limit: 3,
    );
    return entries.where((e) => e.definition != null).map((e) => _clip('${e.word}: ${e.definition}')).toList();
  }
}
