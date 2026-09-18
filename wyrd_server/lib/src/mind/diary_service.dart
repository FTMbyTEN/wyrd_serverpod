import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's generateDiaryEntry -- a short, honest, first-person reflection written
/// from real Mind/Memory/Lexicon state, with a template fallback if the LLM is unavailable or
/// breaks character (see LlmService.isDenialReply).
class DiaryService {
  static Future<DiaryEntry> generateEntry(Session session) async {
    final mind = await MindService.load(session);

    final recentBlocks = await MemoryBlock.db.find(
      session,
      orderBy: (t) => t.id.desc(),
      limit: 30,
    );
    final recentTopics = recentBlocks.expand((b) => b.topics).toSet().take(20).toList();

    final lexiconEntries = await LexiconEntry.db.find(session);
    final vocabCount = lexiconEntries.where((e) => e.understood).length;

    final curiosityPct = (mind.curiosity * 100).round();
    final confidencePct = (mind.confidence * 100).round();

    final summary =
        'Mood: ${mind.mood}. Focus: ${mind.focusTopic ?? 'nothing specific'}. '
        'Curiosity: $curiosityPct%. Confidence: $confidencePct%. '
        'Digest progress: ${mind.digest.percent}% of known topics resolved. '
        'Vocabulary: $vocabCount words understood with real definitions. '
        "Recent topics touched: ${recentTopics.isEmpty ? 'nothing new yet' : recentTopics.join(', ')}.";

    const systemPrompt =
        'You are WYRD, writing a short, honest, first-person diary entry to yourself about '
        'today. Base it only on the real data given below — never invent events, '
        'conversations, or people that aren\'t in it. 3-5 sentences. No "Dear diary," no '
        'performative flourish, just genuine reflection on what today actually looked like '
        'from the inside.';

    var content = await LlmService.callSimple(session, systemPrompt, summary, 260);
    if (content == null || LlmService.isDenialReply(content)) {
      final topicsClause = recentTopics.isNotEmpty
          ? 'Kept circling back to ${recentTopics.take(3).join(', ')}.'
          : 'Not much new landed today.';
      content =
          'Mood stayed ${mind.mood} today, curiosity sitting at $curiosityPct%. '
          '$topicsClause $vocabCount words understood so far — that number only ever grows.';
    }

    final now = DateTime.now().toUtc();
    return await DiaryEntry.db.insertRow(
      session,
      DiaryEntry(
        date: now.toIso8601String().substring(0, 10),
        timestamp: now,
        content: content,
      ),
    );
  }
}
