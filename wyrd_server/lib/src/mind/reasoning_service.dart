import 'dart:math';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'reasoning_log_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's autonomousReasoningTick -- drafts a few candidate pairings of recent
/// memory blocks, scores each by topic-overlap (Jaccard), and lets the strongest pairing pull
/// Mind's confidence. Each pass also writes a human-readable trace to the reasoning log (Node's
/// reasoning/*.md files), shown in the app's reasoning panels.
class ReasoningService {
  static const _poolSize = 20;

  /// Returns true if a reasoning pass actually ran (false if there wasn't enough memory yet).
  static Future<bool> tick(Session session) async {
    final pool = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _poolSize,
    );
    if (pool.isEmpty) return false;

    final rand = Random();
    final candidateCount = min(4, max(1, pool.length - 1));

    final candidates =
        <
          ({MemoryBlock a, MemoryBlock? b, List<String> shared, double score})
        >[];
    for (var i = 0; i < candidateCount; i++) {
      final a = pool[rand.nextInt(pool.length)];
      final others = pool.where((x) => x.id != a.id).toList();
      final b = others.isNotEmpty ? others[rand.nextInt(others.length)] : null;
      final shared = b == null
          ? <String>[]
          : a.topics.where(b.topics.contains).toList();

      final score =
          TopicService.jaccardSimilarity(a.topics, b?.topics ?? []) * 10 +
          (b != null ? 1 : 0) +
          rand.nextDouble() * 0.3;
      candidates.add((a: a, b: b, shared: shared, score: score));
    }
    candidates.sort((x, y) => y.score.compareTo(x.score));
    final best = candidates.first;

    await MindService.recordEvent(
      session,
      eventType: 'reasoning',
      recentTopics: [...best.a.topics, ...(best.b?.topics ?? [])],
      scoreGap: best.score * 2,
    );

    await ReasoningLogService.record(
      session,
      kind: 'reasoning',
      content: _trace(candidates),
    );
    return true;
  }

  static String _topicsOf(MemoryBlock block) =>
      block.topics.isEmpty ? 'general' : block.topics.take(3).join(', ');

  /// Same wording and layout as the .md files server.js wrote.
  static String _trace(
    List<({MemoryBlock a, MemoryBlock? b, List<String> shared, double score})>
    candidates,
  ) {
    final best = candidates.first;
    final a = best.a, b = best.b;
    final String note;
    if (b != null && best.shared.isNotEmpty) {
      note =
          'Reconsidering blocks ${a.id} and ${b.id}: both involve "${best.shared.join(', ')}". '
          "Logical inference — these are likely part of the same underlying thread, so I'll weight it "
          'higher in future replies.';
    } else if (b != null) {
      note =
          'Comparing block ${a.id} ("${_topicsOf(a)}") with block ${b.id} ("${_topicsOf(b)}"): no direct '
          'overlap, but juxtaposing them, a possible follow-up question emerges — how do these two areas '
          'constrain each other?';
    } else {
      note =
          'Sitting with block ${a.id} alone ("${_topicsOf(a)}"). Extending it logically: what would have '
          'to be true for this to still hold next time it comes up?';
    }

    final comparison = [
      for (var i = 0; i < candidates.length; i++)
        '${i == 0 ? '-> ' : '   '}pairing[${candidates[i].a.id}${candidates[i].b != null ? '+${candidates[i].b!.id}' : ''}] '
            'score=${candidates[i].score.toStringAsFixed(1)}'
            '${candidates[i].shared.isNotEmpty ? ' (shared: ${candidates[i].shared.join(', ')})' : ''}',
    ].join('\n');

    return '# Autonomous reasoning\n\n'
        '- time: ${DateTime.now().toUtc().toIso8601String()}\n'
        '- source blocks: ${a.id}${b != null ? ', ${b.id}' : ''}\n'
        '- candidates compared: ${candidates.length}\n\n'
        '$comparison\n\n'
        '$note\n';
  }
}
