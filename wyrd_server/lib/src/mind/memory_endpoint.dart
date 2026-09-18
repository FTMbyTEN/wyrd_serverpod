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

  Future<ConceptGraph> getConcepts(Session session) async {
    final blocks = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _maxBlocks,
    );

    final freq = <String, int>{};
    final cooccur = <String, int>{};

    for (final block in blocks) {
      final topics = block.topics.toSet().toList();
      for (final t in topics) {
        freq[t] = (freq[t] ?? 0) + 1;
      }
      for (var i = 0; i < topics.length; i++) {
        for (var j = i + 1; j < topics.length; j++) {
          final pair = [topics[i], topics[j]]..sort();
          final key = '${pair[0]}|||${pair[1]}';
          cooccur[key] = (cooccur[key] ?? 0) + 1;
        }
      }
    }

    final topTopics = (freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
        .take(_maxConceptNodes)
        .map((e) => e.key)
        .toList();
    final topSet = topTopics.toSet();

    final nodes = topTopics.map((t) => ConceptNode(id: t, count: freq[t]!)).toList();

    final edges = cooccur.entries
        .map((e) {
          final parts = e.key.split('|||');
          return ConceptEdge(a: parts[0], b: parts[1], weight: e.value);
        })
        .where((e) => topSet.contains(e.a) && topSet.contains(e.b))
        .toList()
      ..sort((a, b) => b.weight.compareTo(a.weight));

    return ConceptGraph(
      nodes: nodes,
      edges: edges.take(_maxConceptEdges).toList(),
    );
  }
}
