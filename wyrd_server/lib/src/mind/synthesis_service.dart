import 'dart:math';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's synthesisTick -- picks a handful of memory fragments from genuinely
/// different domains (non-overlapping topics, biased toward substantive net/synthesis/
/// conversation blocks over abstract self-question musings) and asks the LLM whether there's
/// a real, non-obvious connection between them. Most ticks find nothing, by design -- a
/// synthesis only gets stored when the model finds a genuine bridge, not a superficial one.
class SynthesisService {
  static const _minBlocksRequired = 20;
  static const _poolSize = 600;
  static const _fragmentCount = 4;

  static final _declinePattern = RegExp(
    r"^nothing\b|\bcan'?t find\b|\bno (genuine|real|surprising|non-obvious)?\s*(connection|link|thread)\b|\bno true connection\b|\bnone that (aren'?t|isn'?t) forced\b",
    caseSensitive: false,
  );

  static String? _summarize(MemoryBlock b) {
    if (b.source == 'net') return '[from the web] ${b.title}: ${(b.extract ?? '').substring(0, min(220, (b.extract ?? '').length))}';
    if (b.source == 'self') return '[self-question] Q: ${b.question} A: ${b.answer}';
    if (b.source == 'synthesis') return '[earlier insight] ${b.insight}';
    if (b.userText != null) {
      final bot = (b.botText ?? '');
      return '[conversation] someone said "${b.userText}" and I replied "${bot.substring(0, min(150, bot.length))}"';
    }
    return null;
  }

  static int _sourceWeight(MemoryBlock b) {
    if (b.source == 'net' || b.source == 'synthesis') return 3;
    if (b.userText != null) return 2;
    return 1;
  }

  static List<(MemoryBlock, String)> _pickDiverseFragments(List<MemoryBlock> pool, int count, Random rand) {
    final picked = <(MemoryBlock, String)>[];
    final usedTopics = <String>{};
    final scored = pool.map((b) => (b, _sourceWeight(b) + (rand.nextDouble() - 0.5) * 1.5)).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));
    final weighted = scored.map((s) => s.$1).toList();

    for (final b in weighted) {
      if (picked.length >= count) break;
      if (b.topics.isEmpty) continue;
      final overlap = b.topics.any(usedTopics.contains);
      if (overlap) continue;
      final summary = _summarize(b);
      if (summary == null) continue;
      picked.add((b, summary));
      usedTopics.addAll(b.topics);
    }
    return picked;
  }

  static Future<String?> _callSynthesisLlm(Session session, List<(MemoryBlock, String)> fragments) async {
    final list = fragments.asMap().entries.map((e) => '${e.key + 1}. ${e.value.$2}').join('\n\n');
    final prompt =
        "Here are several unrelated things I've picked up recently:\n\n$list\n\n"
        'Is there a genuinely surprising, non-obvious connection between any of these — the '
        'kind of thing that would make someone say "huh, I hadn\'t thought of it that way"? '
        'Not a superficial word-overlap link, an actual conceptual bridge. If there really '
        'isn\'t one, just say "NOTHING" and nothing else. If there is, write 2-3 sentences '
        'making the connection concretely, in first person, like a real realization rather '
        'than a report.';

    final text = await LlmService.callSimple(session, '', prompt, 200);
    if (text == null || _declinePattern.hasMatch(text)) return null;
    return text;
  }

  /// Returns true if a genuine synthesis was found and stored (false in the far more common
  /// case that there isn't enough memory yet, no LLM is configured, too few diverse fragments
  /// could be picked, or the model found nothing worth connecting).
  static Future<bool> tick(Session session) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) return false;

    final blockCount = await MemoryBlock.db.count(session);
    if (blockCount < _minBlocksRequired) return false;

    final pool = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _poolSize,
    );

    final fragments = _pickDiverseFragments(pool, _fragmentCount, Random());
    if (fragments.length < 2) return false;

    final insight = await _callSynthesisLlm(session, fragments);
    if (insight == null) return false;

    final sourceTopics = fragments.expand((f) => f.$1.topics).toSet().toList();
    final topics = TopicService.extractTopics(insight);

    await MemoryBlock.db.insertRow(
      session,
      MemoryBlock(
        timestamp: DateTime.now().toUtc(),
        source: 'synthesis',
        insight: insight,
        sourceBlockIds: fragments.map((f) => f.$1.id!).toList(),
        sourceTopics: sourceTopics,
        topics: topics,
      ),
    );

    await MindService.recordEvent(
      session,
      eventType: 'synthesis',
      recentTopics: topics,
      scoreGap: 15,
    );

    return true;
  }
}
