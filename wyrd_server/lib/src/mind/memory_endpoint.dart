import '../generated/protocol.dart';
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

  Future<List<MemoryBlock>> getMemory(Session session) async {
    final blocks = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _maxBlocks,
    );
    return blocks.reversed.toList();
  }

  static const _conceptsTtl = Duration(minutes: 1);
  static ({DateTime at, ConceptGraph graph})? _conceptsCache;

  /// Top topics by how many recent blocks mention them, and how often pairs of those top topics
  /// co-occur. Computed in Postgres: doing it in Dart meant loading 5000 full blocks and counting
  /// every topic pair in each, which blocked the server's single isolate for ~30s -- stalling
  /// every other request while it ran. Cached briefly since the graph changes slowly.
  Future<ConceptGraph> getConcepts(Session session) async {
    final cached = _conceptsCache;
    if (cached != null && DateTime.now().difference(cached.at) < _conceptsTtl) {
      return cached.graph;
    }

    const recentTopics =
        'WITH recent AS (SELECT "id", "topics" FROM "memory_block" ORDER BY "id" DESC LIMIT @maxBlocks), '
        'bt AS (SELECT DISTINCT r."id", t.topic FROM recent r, json_array_elements_text(r."topics") AS t(topic)), '
        'top AS (SELECT topic, count(*) AS c FROM bt GROUP BY topic ORDER BY c DESC, topic LIMIT @maxNodes) ';
    // postgres rejects unused parameters, so each query gets exactly the ones it references
    final base = {'maxBlocks': _maxBlocks, 'maxNodes': _maxConceptNodes};

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
}
