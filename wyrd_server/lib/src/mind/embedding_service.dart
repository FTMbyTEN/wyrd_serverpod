import 'dart:convert';

import 'package:http/http.dart' as http;

import '../generated/protocol.dart';
import 'llm_budget.dart';
import 'package:serverpod/serverpod.dart';

/// Meaning fingerprints (embeddings) for search by meaning, from Voyage AI -- the embedding
/// provider Anthropic recommends (Anthropic has no embedding model of its own).
///
/// Set the key once with `scloud password set voyageApiKey <key>`. Without it, [enabled] is
/// false and everything that uses embeddings quietly falls back to word matching.
///
/// Costs are tiny (voyage-3.5-lite, about $0.02 per million tokens) and go through [LlmBudget]
/// like every other AI call: a person's question is interactive, the nightly backfill is
/// background.
class EmbeddingService {
  static const model = 'voyage-3.5-lite';
  static const dims = 512;
  static const _batch = 128;
  static const _maxChars = 1500;

  static bool enabled(Session session) => (session.passwords['voyageApiKey'] ?? '').isNotEmpty;

  /// Text that stands for a memory when it's embedded: its title and gist, never chat text.
  static String? textOf(MemoryBlock b) {
    final t = switch (b.source) {
      'self' => [b.question, b.answer].whereType<String>().join(' — '),
      'synthesis' => b.insight,
      _ => [b.title, b.extract].whereType<String>().join('. '),
    };
    if (t == null || t.trim().isEmpty) return null;
    final flat = t.replaceAll(RegExp(r'\s+'), ' ').trim();
    return flat.length > _maxChars ? flat.substring(0, _maxChars) : flat;
  }

  /// One query (a person's message): an interactive call.
  static Future<Vector?> embedQuery(Session session, String text) async {
    final r = await embed(session, [text], query: true, background: false);
    return r?.first;
  }

  /// Embeds [texts] in order. Null if embeddings are off, over budget, or the call failed.
  static Future<List<Vector>?> embed(
    Session session,
    List<String> texts, {
    required bool query,
    required bool background,
  }) async {
    if (texts.isEmpty) return [];
    final key = session.passwords['voyageApiKey'];
    if (key == null || key.isEmpty) return null;
    if (!await LlmBudget.allow(session, background: background)) return null;

    final out = <Vector>[];
    for (var i = 0; i < texts.length; i += _batch) {
      final chunk = texts.sublist(i, i + _batch > texts.length ? texts.length : i + _batch);
      try {
        final res = await http
            .post(
              Uri.parse('https://api.voyageai.com/v1/embeddings'),
              headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $key'},
              body: jsonEncode({
                'input': [for (final t in chunk) t.length > _maxChars ? t.substring(0, _maxChars) : t],
                'model': model,
                'input_type': query ? 'query' : 'document',
                'output_dimension': dims,
              }),
            )
            .timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          session.log('[embed] voyage http ${res.statusCode}: ${res.body.length > 200 ? res.body.substring(0, 200) : res.body}',
              level: LogLevel.warning);
          return null;
        }
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final rows = (data['data'] as List).cast<Map<String, dynamic>>()..sort((a, b) => (a['index'] as int).compareTo(b['index'] as int));
        out.addAll(rows.map((r) => Vector((r['embedding'] as List).map((x) => (x as num).toDouble()).toList())));
        final tokens = (data['usage'] as Map<String, dynamic>?)?['total_tokens'] as num? ?? 0;
        await LlmBudget.record(session, {'input_tokens': tokens, 'output_tokens': 0}, model: model);
      } catch (e) {
        session.log('[embed] voyage call failed: $e', level: LogLevel.warning);
        return null;
      }
    }
    return out;
  }

  static const _sharedSources = {'net', 'self', 'synthesis', 'feed', 'ingest', 'curriculum'};

  /// Embeds up to [limit] shared memories that don't have a fingerprint yet, newest first.
  /// Returns how many were embedded (0 when off or out of budget).
  static Future<int> backfillMemories(Session session, {int limit = 512}) async {
    if (!enabled(session)) return 0;
    final ids = await _idsWithoutEmbedding(session, 'memory_block', limit,
        extra: 'AND "source" = ANY(@sources::text[])', params: {'sources': _sharedSources.toList()});
    final blocks = await MemoryBlock.db.find(session, where: (t) => t.id.inSet(ids), orderBy: (t) => t.id.desc());
    final withText = [for (final b in blocks) if (textOf(b) != null) b];
    if (withText.isEmpty) return 0;
    final vectors = await embed(session, [for (final b in withText) textOf(b)!], query: false, background: true);
    if (vectors == null) return 0;
    for (var i = 0; i < withText.length; i++) {
      await MemoryBlock.db.updateRow(session, withText[i].copyWith(embedding: vectors[i]), columns: (t) => [t.embedding]);
    }
    return withText.length;
  }

  /// Embeds learned answers' questions that don't have a fingerprint yet.
  static Future<int> backfillAnswers(Session session, {int limit = 256}) async {
    if (!enabled(session)) return 0;
    final ids = await _idsWithoutEmbedding(session, 'learned_answer', limit);
    final rows = await LearnedAnswer.db.find(session, where: (t) => t.id.inSet(ids));
    if (rows.isEmpty) return 0;
    final vectors = await embed(session, [for (final a in rows) a.question], query: true, background: true);
    if (vectors == null) return 0;
    for (var i = 0; i < rows.length; i++) {
      await LearnedAnswer.db.updateRow(session, rows[i].copyWith(embedding: vectors[i]), columns: (t) => [t.embedding]);
    }
    return rows.length;
  }

  static Future<Set<int>> _idsWithoutEmbedding(Session session, String table, int limit,
      {String extra = '', Map<String, Object?> params = const {}}) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "id" FROM "$table" WHERE "embedding" IS NULL $extra ORDER BY "id" DESC LIMIT @limit',
      parameters: QueryParameters.named({...params, 'limit': limit}),
    );
    return rows.map((r) => r[0] as int).toSet();
  }
}
