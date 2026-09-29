import '../generated/protocol.dart';
import 'embedding_service.dart';
import 'topic_service.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/memory and /api/concepts from server.js. Public/unauthenticated, matching Node.
/// Node trims memory.json to the last 5000 blocks on every write (MAX_BLOCKS); rather than
/// enforce that at write time here too, both reads below just cap the query to the newest 5000
/// rows, so the trimming behavior is equivalent without needing a separate cleanup job yet.
class MemoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _maxBlocks = 5000;
  static const _maxConceptNodes = 40;
  static const _maxConceptEdges = 120;

  /// WYRD's shared knowledge only -- what it read, worked out or connected. This endpoint is
  /// public, and memory rows don't record whose they are, so chat and photo memories (people's
  /// own words and what WYRD saw of them) are never returned here.
  Future<List<MemoryBlock>> getMemory(Session session) async {
    final blocks = await MemoryBlock.db.find(
      session,
      where: (t) => t.source.inSet(_sharedSources.toSet()),
      orderBy: (t) => t.id.desc(),
      limit: _maxBlocks,
    );
    return blocks.reversed.toList();
  }

  static const _sharedSources = ['net', 'self', 'synthesis', 'feed', 'ingest', 'curriculum', 'library'];
  static final _stoplist = TopicService.noise.toList();

  static const _conceptsTtl = Duration(minutes: 1);
  static ({DateTime at, ConceptGraph graph})? _conceptsCache;

  /// Top topics by how many recent blocks mention them, and how often pairs of those top topics
  /// co-occur. Computed in Postgres: doing it in Dart meant loading 5000 full blocks and counting
  /// every topic pair in each, which blocked the server's single isolate for ~30s -- stalling
  /// every other request while it ran. Cached briefly since the graph changes slowly.
  Future<ConceptGraph> getConcepts(Session session) =>
      PublicCache.get(session, 'memory.getConcepts', const Duration(seconds: 60), () => _getConcepts(session));

  Future<ConceptGraph> _getConcepts(Session session) async {
    final cached = _conceptsCache;
    if (cached != null && DateTime.now().difference(cached.at) < _conceptsTtl) {
      return cached.graph;
    }

    // Shared knowledge only (never chats or photos), and no filler words: those made up most of
    // the old map ("how", "what", "from") and meant nothing to a reader.
    const recentTopics =
        'WITH recent AS (SELECT "id", "topics" FROM "memory_block" WHERE "source" = ANY(@sources::text[]) '
        'ORDER BY "id" DESC LIMIT @maxBlocks), '
        'bt AS (SELECT DISTINCT r."id", t.topic FROM recent r, json_array_elements_text(r."topics") AS t(topic) '
        "WHERE t.topic <> ALL(@stop::text[]) AND length(t.topic) > 2 AND t.topic !~ '^[0-9]+\$'), "
        'top AS (SELECT topic, count(*) AS c FROM bt GROUP BY topic ORDER BY c DESC, topic LIMIT @maxNodes) ';
    // postgres rejects unused parameters, so each query gets exactly the ones it references
    final base = {'maxBlocks': _maxBlocks, 'maxNodes': _maxConceptNodes, 'sources': _sharedSources, 'stop': _stoplist};

    final nodeRows = await session.db.unsafeQuery(
      '${recentTopics}SELECT topic, c FROM top ORDER BY c DESC, topic',
      parameters: QueryParameters.named(base),
    );
    final edgeRows = await session.db.unsafeQuery(
      '${recentTopics}SELECT a.topic, b.topic, count(*) AS w '
      'FROM bt a JOIN bt b ON a."id" = b."id" AND a.topic < b.topic '
      'WHERE a.topic IN (SELECT topic FROM top) AND b.topic IN (SELECT topic FROM top) '
      'GROUP BY a.topic, b.topic ORDER BY w DESC, a.topic, b.topic LIMIT @maxEdges',
      parameters: QueryParameters.named({
        ...base,
        'maxEdges': _maxConceptEdges,
      }),
    );

    final graph = ConceptGraph(
      nodes: [
        for (final r in nodeRows)
          ConceptNode(id: r[0] as String, count: r[1] as int),
      ],
      edges: [
        for (final r in edgeRows)
          ConceptEdge(
            a: r[0] as String,
            b: r[1] as String,
            weight: r[2] as int,
          ),
      ],
    );
    _conceptsCache = (at: DateTime.now(), graph: graph);
    return graph;
  }

  /// Everything the CONCEPT_MAP shows for one concept, in plain terms (see ConceptDetail).
  Future<ConceptDetail> getConceptDetail(Session session, String topic) =>
      PublicCache.get(session, 'memory.getConceptDetail:$topic', const Duration(seconds: 60), () => _getConceptDetail(session, topic));

  Future<ConceptDetail> _getConceptDetail(Session session, String topic) async {
    final t = topic.trim().toLowerCase();
    final params = {'t': t, 'sources': _sharedSources, 'maxBlocks': _maxBlocks};
    const recent =
        'WITH recent AS (SELECT "id", "source", "feedSource", "title", "extract", "question", "answer", "insight", '
        '"url", "timestamp", "topics" FROM "memory_block" WHERE "source" = ANY(@sources::text[]) '
        'ORDER BY "id" DESC LIMIT @maxBlocks), '
        'hit AS (SELECT * FROM recent WHERE "topics"::jsonb ? @t) ';

    final mentions = await session.db.unsafeQuery('${recent}SELECT count(*) FROM hit', parameters: QueryParameters.named(params));
    final related = await session.db.unsafeQuery(
      '${recent}SELECT x AS topic, count(*) AS c FROM hit, json_array_elements_text(hit."topics") AS x '
      'WHERE x <> @t AND x <> ALL(@stop::text[]) AND length(x) > 2 GROUP BY x ORDER BY c DESC, x LIMIT 8',
      parameters: QueryParameters.named({...params, 'stop': _stoplist}),
    );
    final examples = await session.db.unsafeQuery(
      '${recent}SELECT "source", "feedSource", "title", "extract", "question", "answer", "insight", "url", "timestamp" '
      'FROM hit ORDER BY "timestamp" DESC LIMIT 12',
      parameters: QueryParameters.named(params),
    );
    final word = await LexiconEntry.db.findFirstRow(session, where: (e) => e.word.equals(t) & e.understood.equals(true));

    String clip(String? s, int n) {
      final flat = (s ?? '').replaceAll(RegExp(r'\s+'), ' ').trim();
      return flat.length <= n ? flat : '${flat.substring(0, n - 1).trimRight()}…';
    }

    final seen = <String>{};
    final out = <ConceptExample>[];
    for (final r in examples) {
      final source = r[0] as String;
      final String title;
      final String? snippet;
      if (source == 'self') {
        title = clip(r[4] as String?, 140);
        snippet = clip(r[5] as String?, 220);
      } else if (source == 'synthesis') {
        title = 'A connection WYRD made';
        snippet = clip(r[6] as String?, 220);
      } else {
        title = clip(r[2] as String?, 140);
        snippet = r[3] == null ? null : clip(r[3] as String?, 220);
      }
      if (title.isEmpty || !seen.add(title)) continue;
      out.add(ConceptExample(
        source: source == 'net' ? ((r[1] as String?) ?? 'web') : source,
        title: title,
        snippet: (snippet == null || snippet.isEmpty) ? null : snippet,
        url: r[7] as String?,
        timestamp: r[8] as DateTime,
      ));
      if (out.length == 4) break;
    }

    return ConceptDetail(
      topic: t,
      mentions: mentions.first[0] as int,
      definition: word?.definition,
      partOfSpeech: word?.partOfSpeech,
      related: [for (final r in related) ConceptNode(id: r[0] as String, count: r[1] as int)],
      examples: out,
    );
  }

  /// Whether search by meaning is working: key seen, share of memory fingerprinted, last problem.
  Future<String> embeddingStatus(Session session) => EmbeddingService.status(session);
}
