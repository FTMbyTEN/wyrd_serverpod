import 'dart:math';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's autonomousReasoningTick -- drafts a few candidate pairings of recent
/// memory blocks, scores each by topic-overlap (Jaccard), and lets the strongest pairing pull
/// Mind's confidence. Node also wrote a human-readable .md trace file per tick for a UI reasoning
/// log (GET /api/reasoning); that file-logging side isn't ported -- it's presentation-only, no
/// functional state, and the actual effect (the Mind update) is fully captured here.
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

    double bestScore = -1;
    List<String> bestTopics = [];

    for (var i = 0; i < candidateCount; i++) {
      final a = pool[rand.nextInt(pool.length)];
      final others = pool.where((x) => x.id != a.id).toList();
      final b = others.isNotEmpty ? others[rand.nextInt(others.length)] : null;

      final score = TopicService.jaccardSimilarity(a.topics, b?.topics ?? []) * 10 +
          (b != null ? 1 : 0) +
          rand.nextDouble() * 0.3;

      if (score > bestScore) {
        bestScore = score;
        bestTopics = [...a.topics, ...(b?.topics ?? [])];
      }
    }

    await MindService.recordEvent(
      session,
      eventType: 'reasoning',
      recentTopics: bestTopics,
      scoreGap: bestScore * 2,
    );
    return true;
  }
}
