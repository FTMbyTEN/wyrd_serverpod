import 'dart:math';

import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's mind.json state machine (loadMind/saveMind/updateMind/pickMood/
/// computeDigest) onto a real Postgres-backed singleton row. There is exactly one Mind row
/// (id 1); every read/update goes through here so the digest math and mood rules stay in one
/// place instead of being re-derived per endpoint. The seen/resolved topic sets behind the
/// digest live in the mind_topic table, not on the row.
class MindService {
  /// Memory sources that come from people (their chats, their photos) and must never reach
  /// anything public: self-questions, insights, the diary, the focus.
  static const privateSources = {'chat', 'photo'};

  static const _goalTemplates = <String Function(String)>[
    _goalDeepen,
    _goalContradictions,
    _goalConnect,
    _goalStressTest,
    _goalWiden,
  ];

  static String _goalDeepen(String t) => 'deepen the thread around "$t"';
  static String _goalContradictions(String t) => 'look for contradictions near "$t"';
  static String _goalConnect(String t) => 'connect "$t" to something older in memory';
  static String _goalStressTest(String t) => 'stress-test the last inference about "$t"';
  static String _goalWiden(String t) => 'pull in fresh data and widen the topic graph';

  static Future<Mind> load(Session session) async {
    final existing = await Mind.db.findById(session, 1);
    if (existing != null) return existing;
    final created = await Mind.db.insertRow(
      session,
      Mind(
        id: 1,
        mood: 'dormant',
        focusTopic: null,
        activeGoal: null,
        curiosity: 0.2,
        confidence: 0.5,
        digest: DigestInfo(
          totalTopics: 0,
          answeredTopics: 0,
          backlog: 0,
          percent: 0,
          ratePerMin: null,
          etaMinutes: null,
          etaAt: null,
        ),
        lastEvent: null,
        explorationCount: 0,
        updatedAt: DateTime.now().toUtc(),
        selfAnswerTimestamps: [],
      ),
    );
    return created;
  }

  static String pickMood({
    required double curiosity,
    required double confidence,
    required bool recentErrors,
  }) {
    if (recentErrors) return 'unsettled';
    if (curiosity > 0.7 && confidence > 0.8) return 'engaged';
    if (curiosity > 0.7) return 'restless';
    if (confidence > 0.85) return 'self-assured';
    if (confidence > 0.7) return 'assured';
    if (confidence < 0.35) return 'uncertain';
    return 'reflective';
  }

  /// Adds [seen] to the permanent topic set and marks [resolved] as resolved (inserting any
  /// that weren't seen yet). One statement each, in Postgres, instead of rewriting the full sets.
  static Future<void> _recordTopics(Session session, List<String> seen, List<String> resolved) async {
    final seenOnly = seen.toSet().difference(resolved.toSet());
    for (final (topics, isResolved) in [(seenOnly, false), (resolved.toSet(), true)]) {
      if (topics.isEmpty) continue;
      final params = <String, Object>{};
      final values = <String>[];
      var i = 0;
      for (final t in topics) {
        params['t$i'] = t;
        values.add('(@t$i, $isResolved)');
        i++;
      }
      await session.db.unsafeExecute(
        'INSERT INTO "mind_topic" ("topic", "resolved") VALUES ${values.join(', ')} '
        'ON CONFLICT ("topic") DO ${isResolved ? 'UPDATE SET "resolved" = true' : 'NOTHING'}',
        parameters: QueryParameters.named(params),
      );
    }
  }

  static Future<DigestInfo> _computeDigest(Session session, Mind mind) async {
    final counts = await session.db.unsafeQuery(
      'SELECT count(*), count(*) FILTER (WHERE "resolved") FROM "mind_topic"',
    );
    final total = counts.first[0] as int;
    final answered = counts.first[1] as int;
    final backlog = max(0, total - answered);
    final percent = total > 0 ? (answered / total * 100).round().toDouble() : 0.0;

    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final timestamps = mind.selfAnswerTimestamps
        .where((t) => now - t < 10 * 60 * 1000)
        .toList();

    double? ratePerMin;
    if (timestamps.length >= 2) {
      final spanMin = (now - timestamps.reduce(min)) / 60000;
      ratePerMin = spanMin > 0 ? timestamps.length / spanMin : null;
    }

    double? etaMinutes;
    if (backlog == 0) {
      etaMinutes = 0;
    } else if (ratePerMin != null && ratePerMin > 0) {
      etaMinutes = ((backlog / ratePerMin) * 10).round() / 10;
    }

    final etaAt = etaMinutes != null
        ? DateTime.now().toUtc().add(Duration(seconds: (etaMinutes * 60).round()))
        : null;

    return DigestInfo(
      totalTopics: total,
      answeredTopics: answered,
      backlog: backlog,
      percent: percent,
      ratePerMin: ratePerMin != null ? (ratePerMin * 100).round() / 100 : null,
      etaMinutes: etaMinutes,
      etaAt: etaAt,
    );
  }

  /// Mirrors updateMind(mem, event) from server.js. [recentTopics] should be the topic set
  /// drawn from the last ~15 memory blocks (the caller owns memory access); [scoreGap], when
  /// present, drives the confidence update the same way a reasoning/self-question score would.
  static Future<Mind> recordEvent(
    Session session, {
    required String eventType,
    required List<String> recentTopics,
    List<String> newSeenTopics = const [],
    List<String> newResolvedTopics = const [],
    double? scoreGap,
    bool recentErrors = false,
    bool private = false,
  }) async {
    final mind = await load(session);

    final freq = <String, int>{};
    for (final t in recentTopics) {
      freq[t] = (freq[t] ?? 0) + 1;
    }
    final ranked = freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    // the focus is shown publicly, so a private event (a chat, a photo) never sets it
    final focusTopic = ranked.isNotEmpty && !private ? ranked.first.key : mind.focusTopic;

    final uniqueTopics = recentTopics.toSet().length;
    final curiosityRaw = min(1.0, uniqueTopics / 20);
    final curiosity = ((mind.curiosity * 0.5 + curiosityRaw * 0.5) * 100).round() / 100;

    var confidence = mind.confidence;
    if (scoreGap != null) {
      final confidenceSignal = max(0.0, min(1.0, scoreGap / 10));
      final pull = eventType == 'self' ? 0.3 : 0.4;
      final cap = eventType == 'self' ? 0.98 : 0.9;
      confidence = min(cap, ((confidence * (1 - pull) + confidenceSignal * pull) * 100).round() / 100);
    }

    var explorationCount = mind.explorationCount;
    var selfAnswerTimestamps = mind.selfAnswerTimestamps;
    if (eventType == 'self') {
      explorationCount += 1;
      final now = DateTime.now().toUtc().millisecondsSinceEpoch;
      selfAnswerTimestamps = [...selfAnswerTimestamps, now];
      if (selfAnswerTimestamps.length > 20) {
        selfAnswerTimestamps = selfAnswerTimestamps.sublist(selfAnswerTimestamps.length - 20);
      }
    }

    final mood = pickMood(curiosity: curiosity, confidence: confidence, recentErrors: eventType == 'error');

    final rand = Random();
    final goalFn = _goalTemplates[rand.nextInt(_goalTemplates.length)];
    final activeGoal = goalFn(focusTopic ?? 'the unknown');

    await _recordTopics(session, newSeenTopics, newResolvedTopics);

    var updated = mind.copyWith(
      curiosity: curiosity,
      confidence: confidence,
      mood: mood,
      focusTopic: focusTopic,
      activeGoal: activeGoal,
      lastEvent: eventType,
      explorationCount: explorationCount,
      selfAnswerTimestamps: selfAnswerTimestamps,
      updatedAt: DateTime.now().toUtc(),
    );
    updated = updated.copyWith(digest: await _computeDigest(session, updated));

    return await Mind.db.updateRow(session, updated);
  }
}
