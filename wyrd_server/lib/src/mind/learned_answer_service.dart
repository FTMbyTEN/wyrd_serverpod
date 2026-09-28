import 'dart:math';

import '../generated/protocol.dart';
import 'memory_recall_service.dart';
import 'topic_service.dart';
import 'trust_service.dart';
import 'wordnet_service.dart';
import 'package:serverpod/serverpod.dart';

/// Recycle as learning: WYRD's own answers, kept and reused, getting better with feedback.
///
///  1. **Recall first** -- before calling the AI, look for a learned answer to the same kind of
///     question about the same things. If one has held up, answer from it: no API call.
///  2. **Learn** -- every fresh AI answer to a general question is kept (or replaces a weaker
///     version of itself).
///  3. **Feedback** -- the person's next message judges the last recalled answer: carrying on
///     raises its score, a correction lowers it; below zero it's retired, so the next time the
///     question comes up the AI answers again and the new answer replaces it (version + 1).
///  4. **Fallback** -- when the AI isn't available (budget spent, no key), learned answers are
///     used more readily, so WYRD still says something real.
///
/// Only general questions are learned: not personal ones ("my ..."), time-sensitive ones
/// ("today", "latest") or follow-ups that lean on the conversation ("what about it?"). An answer
/// that mentions something personal about the asker is kept for them only, never shared.
class LearnedAnswerService {
  static const _matchNormal = 0.8; // topic overlap needed to reuse an answer
  static const _matchFallback = 0.5; // ...when the AI isn't available
  static const _minScore = 0.0;
  static const _rewardCarryOn = 0.2;
  static const _penaltyCorrection = 1.0;

  static final _personal = RegExp(r"\b(i|i'm|im|me|my|mine|myself|we|our|us)\b", caseSensitive: false);
  static final _timely = RegExp(
    r'\b(today|tonight|now|currently|current|latest|recent|recently|yesterday|tomorrow|this (week|month|year)|news|weather|price|score)\b',
    caseSensitive: false,
  );
  static final _followUp = RegExp(r'\b(it|its|that|this|they|them|those|these|he|she|him|her|there)\b', caseSensitive: false);
  static final _correction = RegExp(
    r"^\s*(no\b|nope|wrong|that'?s (not|wrong|incorrect)|not (quite|right|true|correct)|incorrect|actually\b|you'?re wrong|false\b)",
    caseSensitive: false,
  );
  static final _unsure = RegExp(r"\b(i('m| am) not sure|i don'?t know|can'?t (tell|say)|no idea)\b", caseSensitive: false);

  static const _intents = ['what', 'how', 'why', 'who', 'when', 'where', 'which', 'can', 'does', 'is', 'are', 'should', 'define', 'explain'];

  /// The kind of question: "what is X" and "how does X work" about the same X aren't the same.
  static String intentOf(String text) {
    final words = text.toLowerCase().replaceAll(RegExp(r"[^a-z' ]"), ' ').split(RegExp(r'\s+'));
    for (final w in words) {
      final base = w.replaceAll(RegExp(r"'s$"), '');
      if (_intents.contains(base)) return base;
      if (w == 'tell' || w == 'describe') return 'explain';
    }
    return 'statement';
  }

  static List<String> _ideas(List<String> topics) =>
      MemoryRecallService.contentTopics(topics).where(TopicService.isIdea).toSet().toList()..sort();

  /// True if [text] is a general question worth learning an answer to.
  static bool isLearnable(String text, List<String> topics) {
    if (!text.contains('?') && intentOf(text) == 'statement') return false;
    if (_personal.hasMatch(text) || _timely.hasMatch(text) || _followUp.hasMatch(text)) return false;
    final ideas = _ideas(topics);
    return ideas.isNotEmpty && ideas.length <= 6;
  }

  static double _overlap(List<String> a, List<String> b) {
    final sa = a.toSet(), sb = b.toSet();
    if (sa.isEmpty || sb.isEmpty) return 0;
    final inter = sa.intersection(sb).length;
    return inter / (sa.length + sb.length - inter);
  }

  /// The best learned answer for this question, or null. [aiAvailable] false loosens the match.
  static Future<LearnedAnswer?> recall(
    Session session,
    UuidValue authUserId,
    String text,
    List<String> topics, {
    bool aiAvailable = true,
    Vector? meaning,
  }) async {
    if (!isLearnable(text, topics)) return null;
    final ideas = _ideas(topics);
    final intent = intentOf(text);

    // By meaning first: a rephrasing of a learned question ("what keeps planes in the air" /
    // "how do aircraft stay up") is the same question even with no words in common.
    if (meaning != null) {
      final maxDistance = aiAvailable ? 0.12 : 0.2; // cosine similarity >= 0.88 (0.8 as a fallback)
      final near = await session.db.unsafeQuery(
        'SELECT "id" FROM "learned_answer" WHERE "retired" = false AND "embedding" IS NOT NULL '
        'AND "intent" = @intent AND ("authUserId" IS NULL OR "authUserId" = @me) AND "score" >= @min '
        'AND ("embedding" <=> @q::vector) < @max ORDER BY "embedding" <=> @q::vector LIMIT 1',
        parameters: QueryParameters.named({
          'intent': intent, 'me': authUserId.uuid, 'min': _minScore, 'max': maxDistance,
          'q': '[${meaning.toList().join(',')}]',
        }),
      );
      if (near.isNotEmpty) {
        final hit = await LearnedAnswer.db.findById(session, near.first[0] as int);
        if (hit != null) {
          return LearnedAnswer.db.updateRow(session, hit.copyWith(uses: hit.uses + 1, updatedAt: DateTime.now().toUtc()));
        }
      }
    }
    final rows = await session.db.unsafeQuery(
      'SELECT "id" FROM "learned_answer" WHERE "retired" = false AND "intent" = @intent '
      'AND ("authUserId" IS NULL OR "authUserId" = @me) AND "topics"::jsonb ?| @t::text[] '
      'ORDER BY "score" DESC, "updatedAt" DESC LIMIT 40',
      parameters: QueryParameters.named({'intent': intent, 'me': authUserId.uuid, 't': ideas}),
    );
    if (rows.isEmpty) return null;
    final candidates = await LearnedAnswer.db.find(session, where: (t) => t.id.inSet(rows.map((r) => r[0] as int).toSet()));
    final need = aiAvailable ? _matchNormal : _matchFallback;
    LearnedAnswer? best;
    var bestFit = 0.0;
    for (final c in candidates) {
      if (c.score < _minScore) continue;
      final fit = _overlap(ideas, c.topics) + min(c.score, 3) * 0.02; // proven answers edge ahead
      if (_overlap(ideas, c.topics) >= need && fit > bestFit) {
        best = c;
        bestFit = fit;
      }
    }
    if (best == null) return null;
    return LearnedAnswer.db.updateRow(session, best.copyWith(uses: best.uses + 1, updatedAt: DateTime.now().toUtc()));
  }

  /// Keeps a fresh AI [answer] to [text]: a new learned answer, or a better version of an
  /// existing one for the same question. Returns the learned answer's id (null if not kept), so
  /// ratings and corrections of this reply reach it.
  static Future<int?> learn(
    Session session,
    UuidValue authUserId,
    String text,
    List<String> topics,
    String answer, {
    required List<String> userFacts,
    Vector? meaning,
  }) async {
    if (!isLearnable(text, topics) || _unsure.hasMatch(answer) || answer.trim().length < 20) return null;
    final ideas = _ideas(topics);
    final intent = intentOf(text);
    final now = DateTime.now().toUtc();
    final private = await _mentionsThePerson(session, answer, userFacts);

    final same = await LearnedAnswer.db.find(
      session,
      where: (t) => t.intent.equals(intent) & (t.authUserId.equals(null) | t.authUserId.equals(authUserId)),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 200,
    );
    final existing = same.where((a) => _overlap(ideas, a.topics) >= 0.999).firstOrNull;
    if (existing != null) {
      // relearning a retired or weak answer: the new one replaces it, as a new version
      if (existing.retired || existing.score < 1) {
        await LearnedAnswer.db.updateRow(
          session,
          existing.copyWith(
            answer: answer,
            question: text,
            score: 0.5,
            retired: false,
            version: existing.version + 1,
            authUserId: private ? authUserId : existing.authUserId,
            embedding: meaning ?? existing.embedding,
            updatedAt: now,
          ),
        );
        return existing.id;
      }
      return null; // a proven answer already stands; this reply isn't kept
    }
    final row = await LearnedAnswer.db.insertRow(
      session,
      LearnedAnswer(
        authUserId: private ? authUserId : null,
        question: text,
        intent: intent,
        topics: ideas,
        answer: answer,
        score: 0.5,
        uses: 0,
        version: 1,
        retired: false,
        createdAt: now,
        updatedAt: now,
        embedding: meaning,
      ),
    );
    return row.id;
  }

  // what a thumb is worth to a learned answer's score
  static double _thumb(int? rating) => rating == 1 ? 1.0 : rating == -1 ? -2.0 : 0.0;

  /// A person's explicit 👍 (1) / 👎 (-1) / cleared (0) on one of WYRD's replies. Moves the
  /// learned answer behind it (a thumbs-down can retire it at once, so it's relearned); a
  /// changed mind only counts the difference.
  static Future<void> rate(Session session, ConversationTurn turn, int rating) async {
    final id = turn.learnedAnswerId;
    if (id == null) return;
    final a = await LearnedAnswer.db.findById(session, id);
    if (a == null) return;
    final score = a.score + _thumb(rating) - _thumb(turn.rating);
    await LearnedAnswer.db.updateRow(
      session,
      a.copyWith(score: score, retired: score < _minScore, updatedAt: DateTime.now().toUtc()),
    );
  }

  /// The person's new message judges the learned answer WYRD gave them last, if any.
  static Future<void> feedback(Session session, ConversationTurn? previous, String text) async {
    final id = previous?.learnedAnswerId;
    if (id == null) return;
    final a = await LearnedAnswer.db.findById(session, id);
    if (a == null) return;
    final corrected = _correction.hasMatch(text);
    if (corrected) {
      for (final t in a.topics.take(6)) {
        await TrustService.record(session, TrustService.topic, t, -0.5); // Bias 2
      }
    }
    final score = corrected ? a.score - _penaltyCorrection : a.score + _rewardCarryOn;
    await LearnedAnswer.db.updateRow(
      session,
      a.copyWith(score: score, retired: score < _minScore, updatedAt: DateTime.now().toUtc()),
    );
  }

  /// Does [answer] mention something personal about the asker? Words from what WYRD knows
  /// about them that aren't ordinary dictionary words (names, places, projects) are the tell.
  static Future<bool> _mentionsThePerson(Session session, String answer, List<String> userFacts) async {
    final factWords = userFacts
        .expand((f) => RegExp(r'[A-Za-z][A-Za-z-]{3,}').allMatches(f).map((m) => m.group(0)!.toLowerCase()))
        .toSet();
    if (factWords.isEmpty) return false;
    final known = await WordNetService.known(session, factWords);
    final personal = factWords.difference(known.keys.toSet());
    final lower = answer.toLowerCase();
    return personal.any((w) => RegExp('\\b${RegExp.escape(w)}\\b').hasMatch(lower));
  }

  static Future<LearningStats> stats(Session session) async {
    final rows = await session.db.unsafeQuery(
      'SELECT count(*), count(*) FILTER (WHERE "authUserId" IS NULL), coalesce(sum("uses"), 0)::bigint, '
      'count(*) FILTER (WHERE "version" > 1) FROM "learned_answer" WHERE "retired" = false',
    );
    final r = rows.first;
    return LearningStats(answers: r[0] as int, shared: r[1] as int, reuses: (r[2] as num).toInt(), improved: r[3] as int);
  }
}
