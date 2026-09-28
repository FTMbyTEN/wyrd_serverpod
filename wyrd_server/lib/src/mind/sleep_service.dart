import 'dart:convert';

import '../generated/protocol.dart';
import 'embedding_service.dart';
import 'reasoning_log_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's sleep: a quiet nightly consolidation, like memory consolidation in sleep, that makes it
/// a little better every morning without any extra AI calls beyond cheap embeddings.
///
/// Every 10 minutes ([tick]): new memories get their meaning fingerprints, so today's reading
/// is searchable by meaning the same day. Once a night, between [_nightStartHour] and
/// [_nightEndHour] UTC ([sleep]):
///  1. backfill fingerprints for older memories and learned answers
///  2. merge learned answers that say the same thing, keeping the stronger one
///  3. retire learned answers that were never reused and never proved themselves
///  4. remove duplicate copies of the same article
///  5. prune the faintest synapses
/// and write a plain-English sleep report into the reasoning log.
class SleepService {
  static const _nightStartHour = 2, _nightEndHour = 5; // UTC: early morning in Lagos, when WYRD is quiet
  static const _awakeBatch = 64;
  static const _nightBatches = 8; // x 512 memories
  static const _staleAfter = Duration(days: 60);
  static const _sameAnswer = 0.05; // cosine distance: two learned answers to the same question

  static Future<void> tick(Session session) async {
    await EmbeddingService.backfillMemories(session, limit: _awakeBatch);
    final now = DateTime.now().toUtc();
    if (now.hour < _nightStartHour || now.hour >= _nightEndHour) return;
    final mark = 'sleep:${now.toIso8601String().substring(0, 10)}';
    if (await MaintenanceRun.db.findFirstRow(session, where: (t) => t.name.equals(mark)) != null) return;
    await sleep(session, mark: mark);
  }

  /// One night's consolidation. Returns the report it wrote.
  static Future<Map<String, Object?>> sleep(Session session, {String? mark}) async {
    final started = DateTime.now().toUtc();

    // 1. meaning fingerprints for what's missing them
    var embedded = 0;
    for (var i = 0; i < _nightBatches; i++) {
      final n = await EmbeddingService.backfillMemories(session, limit: 512);
      embedded += n;
      if (n < 512) break;
    }
    final answersEmbedded = await EmbeddingService.backfillAnswers(session);

    // 2. learned answers that say the same thing: keep the stronger, fold the weaker in
    final pairs = await session.db.unsafeQuery(
      'SELECT a."id", b."id" FROM "learned_answer" a JOIN "learned_answer" b ON a."id" < b."id" '
      'AND a."intent" = b."intent" AND a."retired" = false AND b."retired" = false '
      'AND a."embedding" IS NOT NULL AND b."embedding" IS NOT NULL '
      'AND a."authUserId" IS NOT DISTINCT FROM b."authUserId" AND (a."embedding" <=> b."embedding") < @d LIMIT 200',
      parameters: QueryParameters.named({'d': _sameAnswer}),
    );
    var merged = 0;
    final gone = <int>{};
    for (final p in pairs) {
      final ia = p[0] as int, ib = p[1] as int;
      if (gone.contains(ia) || gone.contains(ib)) continue;
      final a = await LearnedAnswer.db.findById(session, ia), b = await LearnedAnswer.db.findById(session, ib);
      if (a == null || b == null) continue;
      final keep = (a.score, a.uses) == (b.score, b.uses) ? (a.updatedAt.isAfter(b.updatedAt) ? a : b) : (a.score >= b.score ? a : b);
      final drop = identical(keep, a) ? b : a;
      await LearnedAnswer.db.updateRow(session, keep.copyWith(uses: keep.uses + drop.uses));
      await LearnedAnswer.db.updateRow(session, drop.copyWith(retired: true));
      gone.add(drop.id!);
      merged++;
    }

    // 3. answers that never proved themselves
    final stale = await session.db.unsafeQuery(
      'UPDATE "learned_answer" SET "retired" = true WHERE "retired" = false AND "uses" = 0 AND "score" < 0.5 '
      'AND "createdAt" < @cut RETURNING "id"',
      parameters: QueryParameters.named({'cut': started.subtract(_staleAfter)}),
    );

    // 4. the same article stored twice (feeds re-reading it)
    // numbered within each article (window function, not a self-join: one story stored a
    // thousand times would otherwise mean a million comparisons), keeping the first copy
    final dupes = await session.db.unsafeQuery(
      'DELETE FROM "memory_block" WHERE "id" IN (SELECT "id" FROM (SELECT "id", row_number() OVER '
      '(PARTITION BY lower("title"), "url" ORDER BY "id") AS n FROM "memory_block" '
      'WHERE "source" = \'net\' AND "title" IS NOT NULL) x WHERE n > 1) RETURNING "id"',
    );

    // 5. the faintest synapses
    final pruned = await session.db.unsafeQuery('DELETE FROM "synapse" WHERE "weight" < 0.05 RETURNING "id"');

    final report = <String, Object?>{
      'embedded': embedded,
      'answersEmbedded': answersEmbedded,
      'mergedAnswers': merged,
      'retiredAnswers': stale.length,
      'duplicateMemories': dupes.length,
      'prunedSynapses': pruned.length,
      'minutes': DateTime.now().toUtc().difference(started).inSeconds / 60,
    };
    report['summary'] = _summary(report, EmbeddingService.enabled(session));
    await ReasoningLogService.record(session, kind: 'sleep', content: jsonEncode(report));
    if (mark != null) {
      await session.db.unsafeExecute(
        'INSERT INTO "maintenance_run" ("name", "ranAt", "note") VALUES (@n, @t, @note) ON CONFLICT ("name") DO NOTHING',
        parameters: QueryParameters.named({'n': mark, 't': DateTime.now().toUtc(), 'note': report['summary']}),
      );
    }
    return report;
  }

  static String _summary(Map<String, Object?> r, bool embeddings) {
    final parts = <String>[
      if (embeddings) 'gave ${r['embedded']} memories a meaning fingerprint'
      else 'skipped meaning fingerprints (no embedding key set)',
      if ((r['mergedAnswers'] as int) > 0) 'merged ${r['mergedAnswers']} learned answers that said the same thing',
      if ((r['retiredAnswers'] as int) > 0) 'retired ${r['retiredAnswers']} answers that never proved useful',
      if ((r['duplicateMemories'] as int) > 0) 'cleared ${r['duplicateMemories']} duplicate memories',
      if ((r['prunedSynapses'] as int) > 0) 'pruned ${r['prunedSynapses']} faint synapses',
    ];
    return 'While it slept, WYRD ${parts.join(', ')}.';
  }
}
