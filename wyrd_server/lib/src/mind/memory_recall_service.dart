import 'dart:math';

import '../generated/protocol.dart';
import 'trust_service.dart';
import 'package:serverpod/serverpod.dart';

/// One piece of knowledge put in front of the model, with where it came from.
class Passage {
  Passage({required this.id, required this.text, required this.label, this.trust, this.age});
  final int id;
  final String text;
  /// its source, as a reader would name it ("bbc.co.uk", "Project Gutenberg", "your own reasoning")
  final String label;
  final double? trust;
  final Duration? age;

  String get cite {
    final bits = [
      label,
      if (trust != null) 'trusted ${(trust! * 100).round()}%',
      if (age != null) _ago(age!),
    ];
    return bits.join(', ');
  }

  static String _ago(Duration d) => d.inMinutes < 90
      ? 'just now'
      : d.inHours < 36
          ? '${d.inHours}h ago'
          : d.inDays < 60
              ? '${d.inDays} days ago'
              : '${(d.inDays / 30).round()} months ago';
}

/// What chat recall hands the model: what WYRD knows that bears on the message -- numbered, with
/// sources, so it can cite them and the judgement gate can check the reply against them.
class RecallContext {
  RecallContext({
    required this.digested,
    required this.knowledge,
    required this.pastChats,
    required this.definitions,
    this.beliefs = const [],
    this.passages = const [],
    this.groundingIds = const [],
  });

  /// The shared memories behind [digested] and [knowledge], so a rating of the reply can reach
  /// their sources (Bias 2).
  final List<int> groundingIds;

  /// Answers WYRD's own self-questioning already worked out ("digested" understanding).
  final List<String> digested;

  /// Things it read or synthesised: web/feed articles, curriculum, the library, syntheses.
  final List<String> knowledge;

  /// What it has come to believe from evidence, with how sure it is (see ThinkingService).
  final List<String> beliefs;

  /// [digested] and [knowledge] with their sources, best first, for citing.
  final List<Passage> passages;

  /// This person's own earlier exchanges on the same topics (never anyone else's).
  final List<String> pastChats;

  /// Dictionary definitions it has learned for words in the message.
  final List<String> definitions;

  bool get isEmpty => passages.isEmpty && beliefs.isEmpty && pastChats.isEmpty && definitions.isEmpty;

  /// Context-prompt lines, most trustworthy first.
  List<String> toPromptLines() => [
        if (passages.isNotEmpty)
          'What you know that bears on this, numbered with where it came from. Rely on these over '
              'guesses; when you use one, say where it is from in plain words ("according to bbc.co.uk…", '
              '"from what I read in…"), and if they don\'t answer the question, say so:\n'
              '${[for (var i = 0; i < passages.length; i++) '[${i + 1}] (${passages[i].cite}) ${passages[i].text}'].join('\n')}',
        if (beliefs.isNotEmpty) 'What you have come to believe from evidence (with how sure you are): ${beliefs.join(' | ')}',
        if (pastChats.isNotEmpty) 'Earlier in your conversations with THIS person on the same subject: ${pastChats.join(' | ')}',
        if (definitions.isNotEmpty) "Word meanings you've learned: ${definitions.join(' | ')}",
      ];
}

/// Retrieval for every answer (RAG): the knowledge WYRD has -- what it read, what it worked out,
/// the library, what it believes -- found three ways at once and fused into one ranking:
///  - by the message's words, with the database's full-text search (word forms, rare words count),
///  - by the topics WYRD tagged, and
///  - by meaning (embeddings), when that's switched on;
/// merged by reciprocal rank fusion, then weighted by how much WYRD trusts each source (Bias 2)
/// and, for news, how fresh it is. Chat and photo memories are never searched here -- another
/// person's conversation must not surface in your reply; your own history comes from
/// conversation_turn, keyed by you.
class MemoryRecallService {
  static const _sharedSources = ['self', 'net', 'feed', 'ingest', 'synthesis', 'curriculum', 'library'];
  static const _maxItemChars = 280;
  static const _news = {'net', 'feed', 'ingest'};

  /// The text the full-text index covers. The same expression is in the index (see [ensureIndex])
  /// and in every query, or Postgres can't use it.
  static const _doc =
      "to_tsvector('english', coalesce(\"title\", '') || ' ' || coalesce(\"extract\", '') || ' ' || "
      "coalesce(\"question\", '') || ' ' || coalesce(\"answer\", '') || ' ' || coalesce(\"insight\", ''))";

  /// Builds the full-text index if it isn't there yet (once, in the background at startup).
  static Future<void> ensureIndex(Session session) async {
    await session.db.unsafeExecute('CREATE INDEX IF NOT EXISTS "memory_block_fts_idx" ON "memory_block" USING gin ($_doc)');
  }

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

  /// [query] is the message itself (for full-text search); [meaning] its embedding (see
  /// EmbeddingService), when available.
  static Future<RecallContext> recall(Session session, UuidValue authUserId, List<String> topics, {Vector? meaning, String? query}) async {
    final t = contentTopics(topics).take(12).toList();
    final q = (query ?? '').trim();
    if (t.isEmpty && meaning == null && q.isEmpty) return RecallContext(digested: [], knowledge: [], pastChats: [], definitions: []);

    final results = await Future.wait<Object>([
      t.isEmpty ? Future.value(<int>[]) : _byTopics(session, t),
      q.isEmpty ? Future.value(<int>[]) : _byText(session, q),
      meaning == null ? Future.value(<int>[]) : _byMeaning(session, meaning),
      t.isEmpty ? Future.value(<String>[]) : _ownChats(session, authUserId, t),
      t.isEmpty ? Future.value(<String>[]) : _definitions(session, t),
      t.isEmpty ? Future.value(<String>[]) : _beliefs(session, t),
    ]);

    // Reciprocal rank fusion: a memory high in any ranking is a strong candidate; one in several
    // rankings is stronger still. k = 60 is the usual constant.
    final fused = <int, double>{};
    for (final ranking in [results[0], results[1], results[2]].cast<List<int>>()) {
      for (var i = 0; i < ranking.length; i++) {
        fused[ranking[i]] = (fused[ranking[i]] ?? 0) + 1 / (60 + i + 1);
      }
    }
    final passages = await _passages(session, fused, wantsNews: _wantsNews(q));

    final digested = <String>[], knowledge = <String>[];
    for (final p in passages) {
      (p.label == 'your own reasoning' ? digested : knowledge).add(p.text);
    }
    return RecallContext(
      digested: digested,
      knowledge: knowledge,
      passages: passages,
      beliefs: results[5] as List<String>,
      pastChats: results[3] as List<String>,
      definitions: results[4] as List<String>,
      groundingIds: [for (final p in passages) p.id],
    );
  }

  static bool _wantsNews(String q) => RegExp(r'\b(today|latest|news|now|current|recent|this week|yesterday|update)\b', caseSensitive: false).hasMatch(q);

  /// The best of the fused candidates, as passages: weighted by trust and (for news) freshness,
  /// at most 2 of its own answers and 5 things it read, no near-duplicates.
  static Future<List<Passage>> _passages(Session session, Map<int, double> fused, {required bool wantsNews}) async {
    if (fused.isEmpty) return [];
    final top = (fused.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).take(24).map((e) => e.key).toSet();
    final blocks = await MemoryBlock.db.find(session, where: (b) => b.id.inSet(top));
    String? keyOf(MemoryBlock b) => TrustService.sourceKey(url: b.url, feedSource: b.feedSource);
    final trust = await TrustService.scores(session, TrustService.source, blocks.map(keyOf).whereType<String>());
    final now = DateTime.now().toUtc();

    double weight(MemoryBlock b) {
      var w = fused[b.id]! * (0.5 + (trust[keyOf(b)] ?? 0.5));
      if (_news.contains(b.source)) {
        final days = now.difference(b.timestamp).inHours / 24;
        w *= wantsNews ? 1.6 * exp(-days / 3) + 0.2 : 0.8 + 0.2 * exp(-days / 30); // news ages; asked for news, much faster
      }
      if (b.source == 'self') w *= 1.15; // its own worked-out understanding
      return w;
    }

    blocks.sort((a, b) => weight(b).compareTo(weight(a)));
    // sources WYRD has learned to distrust are left out whenever there is better to go on
    final decent = blocks.where((b) => (trust[keyOf(b)] ?? 0.5) >= 0.3).length;
    if (decent >= 2) blocks.removeWhere((b) => (trust[keyOf(b)] ?? 0.5) < 0.3);
    final out = <Passage>[];
    final seen = <String>{};
    var own = 0, read = 0;
    for (final b in blocks) {
      String? text;
      String label;
      if (b.source == 'self') {
        if (own >= 2 || b.question == null || b.answer == null) continue;
        text = 'Q: ${b.question} A: ${b.answer}';
        label = 'your own reasoning';
      } else if (b.source == 'synthesis') {
        if (b.insight == null) continue;
        text = b.insight!;
        label = 'your own synthesis';
      } else {
        if (b.title == null) continue;
        text = b.extract != null ? '${b.title}: ${b.extract}' : b.title!;
        label = switch (b.source) {
          'library' => b.feedSource ?? 'your library',
          'curriculum' => 'your curriculum${b.curriculumSubject != null ? ' (${b.curriculumSubject})' : ''}',
          _ => keyOf(b) ?? b.source,
        };
      }
      final clipped = _clip(text);
      final norm = clipped.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      final fingerprint = norm.substring(0, min(60, norm.length)); // near-duplicates share their opening
      if (!seen.add(fingerprint)) continue;
      if (b.source == 'self') {
        own++;
      } else {
        if (read >= 5) continue;
        read++;
      }
      out.add(Passage(
        id: b.id!,
        text: clipped,
        label: label,
        // shown only where WYRD has an opinion of the source (unrated sources come back as exactly 0.5)
        trust: b.source == 'self' || b.source == 'synthesis' || (trust[keyOf(b)] ?? 0.5) == 0.5 ? null : trust[keyOf(b)],
        age: _news.contains(b.source) ? now.difference(b.timestamp) : null,
      ));
      if (own + read >= 7) break;
    }
    return out;
  }

  /// Memories ranked by the message's words: Postgres full-text search, best match first.
  static Future<List<int>> _byText(Session session, String q) async {
    try {
      final rows = await session.db.unsafeQuery(
        'SELECT "id" FROM "memory_block", websearch_to_tsquery(\'english\', @q) query '
        'WHERE "source" = ANY(@sources::text[]) AND $_doc @@ query '
        'ORDER BY ts_rank_cd($_doc, query) DESC LIMIT 30',
        parameters: QueryParameters.named({'q': _orQuery(q), 'sources': _sharedSources}),
      );
      return [for (final r in rows) r[0] as int];
    } catch (e) {
      session.log('[recall] full-text search failed: $e', level: LogLevel.warning);
      return [];
    }
  }

  /// The message's meaningful words joined with OR, so a memory needn't contain every word of a
  /// conversational question to be found (ranking still prefers the ones that match more).
  static String _orQuery(String q) {
    final words = RegExp(r"[\p{L}\p{N}']{3,}", unicode: true).allMatches(q.toLowerCase()).map((m) => m.group(0)!).where((w) => !scaffold.contains(w)).toSet();
    return words.isEmpty ? q : words.join(' OR ');
  }

  /// Memories nearest in meaning to [meaning] (cosine distance), if close enough.
  static Future<List<int>> _byMeaning(Session session, Vector meaning) async {
    const maxDistance = 0.55; // cosine similarity >= 0.45
    final rows = await session.db.unsafeQuery(
      'SELECT "id" FROM "memory_block" WHERE "embedding" IS NOT NULL AND "source" = ANY(@sources::text[]) '
      'AND ("embedding" <=> @q::vector) < @max ORDER BY "embedding" <=> @q::vector LIMIT 20',
      parameters: QueryParameters.named({'q': '[${meaning.toList().join(',')}]', 'sources': _sharedSources, 'max': maxDistance}),
    );
    return [for (final r in rows) r[0] as int];
  }

  /// Memories ranked by how many of the message's topics they share (Jaccard), newest on ties;
  /// its own answers to exactly this topic first.
  static Future<List<int>> _byTopics(Session session, List<String> t) async {
    final rows = await session.db.unsafeQuery(
      '''
      SELECT "id", "source", "answeredTopic",
             (SELECT count(*) FROM json_array_elements_text("topics") x WHERE x = ANY(@t::text[])) AS overlap,
             json_array_length("topics") AS n
      FROM "memory_block"
      WHERE "source" = ANY(@sources::text[]) AND "topics"::jsonb ?| @t::text[]
      ORDER BY overlap DESC, "timestamp" DESC
      LIMIT 40
      ''',
      parameters: QueryParameters.named({'t': t, 'sources': _sharedSources}),
    );
    final scored = [
      for (final r in rows)
        (
          id: r[0] as int,
          score: () {
            final overlap = (r[3] as int).toDouble();
            final union = t.length + (r[4] as int) - overlap;
            var s = union > 0 ? overlap / union : 0.0;
            if (r[1] == 'self' && t.contains(r[2])) s += 0.5; // answered exactly this topic
            return s;
          }(),
        ),
    ]..sort((a, b) => b.score.compareTo(a.score));
    return [for (final s in scored) s.id];
  }

  /// What it believes about these topics, surest first (doubted ones too: knowing what it doubts
  /// keeps it from repeating them as fact).
  static Future<List<String>> _beliefs(Session session, List<String> t) async {
    final set = t.toSet();
    final rows = await Belief.db.find(
      session,
      where: (b) => (b.a.inSet(set) | b.b.inSet(set)) & b.status.inSet({'held', 'hypothesis', 'doubted'}) & b.claim.notEquals(''),
      orderBy: (b) => b.confidence.desc(),
      limit: 3,
    );
    return [
      for (final b in rows)
        _clip('${b.status == 'doubted' ? 'You DOUBT this' : b.status == 'held' ? 'You hold this' : 'You suspect this'} '
            '(${(b.confidence * 100).round()}%, ${b.sources} source${b.sources == 1 ? '' : 's'}${b.against > 0 ? ', ${b.against} against' : ''}): ${b.claim}'),
    ];
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
