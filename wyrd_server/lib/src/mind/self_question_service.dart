import 'dart:math';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's selfQuestionTick -- WYRD interrogates its own accumulated memory,
/// unprompted: picks an under-explored topic (weighted toward what the person actually
/// engaged with, not just ambient ingestion), asks itself one of a few question templates
/// about it, and answers using an LLM grounded in related memory when one's configured
/// (rate-limited to one real call per 20s so ticks don't burn tokens/latency on every pass),
/// falling back to an honest, non-fabricated placeholder otherwise. The answer becomes a new
/// 'self' MemoryBlock with answeredTopic set, which is what backs chat's "digested-recall"
/// path once that's ported.
class SelfQuestionService {
  static const _poolSize = 40;
  static const _llmMinGap = Duration(seconds: 20);
  static DateTime? _lastLlmCallAt;

  static const _questionTemplates = <String Function(String)>[
    _qImplies,
    _qContradiction,
    _qFollows,
    _qMissing,
    _qChanges,
  ];

  static String _qImplies(String t) => 'What does "$t" actually imply, based on everything I\'ve gathered so far?';
  static String _qContradiction(String t) => 'Is there a contradiction hiding near "$t" that I haven\'t noticed yet?';
  static String _qFollows(String t) => 'If "$t" is true, what else should follow from it?';
  static String _qMissing(String t) => 'What am I still missing about "$t"?';
  static String _qChanges(String t) => 'How does "$t" change what I thought I knew before?';

  static Future<List<MemoryBlock>> _recallRelated(Session session, String topic, List<MemoryBlock> pool) async {
    final scored = <(MemoryBlock, int)>[];
    for (final block in pool) {
      if (block.topics.contains(topic)) scored.add((block, 1));
    }
    return scored.map((s) => s.$1).take(3).toList();
  }

  /// Returns true if a question was actually asked (false if there wasn't enough memory, or
  /// nothing left to explore).
  static Future<bool> tick(Session session) async {
    final pool = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: _poolSize,
    );
    if (pool.length < 2) return false;

    final topicFreq = <String, int>{};
    for (final b in pool) {
      for (final t in b.topics) {
        topicFreq[t] = (topicFreq[t] ?? 0) + 1;
      }
    }
    if (topicFreq.isEmpty) return false;

    final answeredTopics = pool
        .where((b) => b.source == 'self' && b.answeredTopic != null)
        .map((b) => b.answeredTopic!)
        .toSet();

    final rand = Random();
    final unanswered = topicFreq.keys.where((t) => !answeredTopics.contains(t)).toList();
    final explorePool = unanswered.isNotEmpty && rand.nextDouble() > 0.15 ? unanswered : topicFreq.keys.toList();
    if (explorePool.isEmpty) return false;

    final userEngagedTopics = pool
        .where((b) => b.userText != null)
        .expand((b) => b.topics)
        .toSet();
    final engagedSlice = explorePool.where(userEngagedTopics.contains).toList();
    final biasedPool = engagedSlice.isNotEmpty && rand.nextDouble() < 0.6 ? engagedSlice : explorePool;

    final topic = biasedPool[rand.nextInt(biasedPool.length)];
    final question = _questionTemplates[rand.nextInt(_questionTemplates.length)](topic);

    final related = await _recallRelated(session, topic, pool);

    String? answer;
    final now = DateTime.now().toUtc();
    if (_lastLlmCallAt == null || now.difference(_lastLlmCallAt!) >= _llmMinGap) {
      _lastLlmCallAt = now;
      final context = related.isEmpty
          ? '(nothing directly related in memory yet)'
          : related
              .take(5)
              .map((r) => '- ${(r.userText ?? r.title ?? r.botText ?? '').substring(0, min(160, (r.userText ?? r.title ?? r.botText ?? '').length))}')
              .join('\n');
      const systemPrompt =
          'You are WYRD, privately reasoning to yourself about something in your own memory — '
          "no one is reading this except you. Answer your own question below in 1-2 sentences, "
          "actually using the related memory given, not restating the question. If the related "
          "memory is empty, say plainly that you don't have enough yet and what you'd need — "
          "don't fake a connection.";
      final userPrompt = 'Question: $question\n\nRelated memory:\n$context';
      final llmAnswer = await LlmService.callSimple(session, systemPrompt, userPrompt, 150);
      if (llmAnswer != null && !LlmService.isDenialReply(llmAnswer)) answer = llmAnswer;
    }

    answer ??= related.isNotEmpty
        ? (related.length > 1
            ? '"$topic" ties back to a few things I\'ve run into before — feels like a real thread, not just a guess.'
            : '"$topic" connects to something I\'ve seen before, so I\'ve got at least a little to go on here.')
        : 'I don\'t have much on "$topic" yet — keeping it as an open question until more comes in.';

    final topics = TopicService.extractTopics('$topic $answer');

    await MemoryBlock.db.insertRow(
      session,
      MemoryBlock(
        timestamp: now,
        source: 'self',
        question: question,
        answer: answer,
        answeredTopic: topic,
        topics: topics,
      ),
    );

    final scoreGap = (related.length + 1) * 3.0;
    await MindService.recordEvent(
      session,
      eventType: 'self',
      recentTopics: topics,
      newSeenTopics: [topic],
      newResolvedTopics: [topic],
      scoreGap: scoreGap,
    );

    return true;
  }
}
