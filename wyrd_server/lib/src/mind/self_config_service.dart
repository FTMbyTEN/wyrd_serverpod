import 'dart:async';
import 'dart:convert';

import '../generated/protocol.dart';
import 'llm_service.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's attemptSelfModification/copReview -- WYRD proposing a single change to
/// its own behavior-tuning config (tone/reply length/curiosity), which it then applies
/// immediately (no approval gate), with an independent second LLM call (COP) reviewing the
/// already-applied change afterward and writing a plain-English verdict for the human
/// operator. COP can only report, never block or roll back -- same as Node.
class SelfConfigService {
  static const _maxHistory = 100;
  static const _maxCopLog = 200;

  static Future<SelfConfig> _loadOrCreate(Session session) async {
    final existing = await SelfConfig.db.findById(session, 1);
    if (existing != null) return existing;
    return await SelfConfig.db.insertRow(
      session,
      SelfConfig(id: 1, toneNote: '', replyLengthMax: 4, curiosityLevel: 'moderate', history: []),
    );
  }

  static Future<SelfConfig> getConfig(Session session) async {
    return await _loadOrCreate(session);
  }

  static bool _validate(String key, dynamic value) {
    switch (key) {
      case 'toneNote':
        return value is String && value.length <= 220;
      case 'replyLengthMax':
        return value is int && value >= 1 && value <= 8;
      case 'curiosityLevel':
        return value is String && ['low', 'moderate', 'high'].contains(value);
      default:
        return false;
    }
  }

  static dynamic _currentValue(SelfConfig config, String key) {
    switch (key) {
      case 'toneNote':
        return config.toneNote;
      case 'replyLengthMax':
        return config.replyLengthMax;
      case 'curiosityLevel':
        return config.curiosityLevel;
      default:
        return null;
    }
  }

  static SelfConfig _applyValue(SelfConfig config, String key, dynamic value) {
    switch (key) {
      case 'toneNote':
        return config.copyWith(toneNote: value as String);
      case 'replyLengthMax':
        return config.copyWith(replyLengthMax: value as int);
      case 'curiosityLevel':
        return config.copyWith(curiosityLevel: value as String);
      default:
        return config;
    }
  }

  /// Returns the applied change, or null if the model decided nothing warranted changing, its
  /// response wasn't valid JSON, or the proposed value failed schema validation.
  static Future<SelfConfigChange?> attemptSelfModification(Session session) async {
    final config = await _loadOrCreate(session);
    final mind = await MindService.load(session);
    final recentBlocks = await MemoryBlock.db.find(session, orderBy: (t) => t.id.desc(), limit: 30);
    final recentTopics = recentBlocks.expand((b) => b.topics).toSet().take(15).toList();
    final blockCount = await MemoryBlock.db.count(session);

    final currentConfigJson = jsonEncode({
      'toneNote': config.toneNote,
      'replyLengthMax': config.replyLengthMax,
      'curiosityLevel': config.curiosityLevel,
    });

    final systemPrompt =
        'You are WYRD, deciding whether to adjust your own behavior configuration based on '
        'how conversations have actually been going. Current config: $currentConfigJson. '
        'Allowed keys and constraints: toneNote (free text, max 220 chars — a personality/'
        'tone note appended to your own system prompt), replyLengthMax (integer 1-8 — max '
        'sentences in a normal reply), curiosityLevel (one of "low", "moderate", "high"). '
        'Respond with ONLY strict JSON, no markdown fences, no commentary: either '
        '{"key": null} if nothing genuinely warrants changing right now, or {"key": '
        '"<one of the three above>", "value": <new value>, "reason": "<one honest sentence '
        'why>"}. Change at most one key. Don\'t change something just to have changed something.';
    final userPrompt =
        'Mood: ${mind.mood}. Curiosity stat: ${(mind.curiosity * 100).round()}%. '
        'Confidence: ${(mind.confidence * 100).round()}%. Recent topics: '
        "${recentTopics.isEmpty ? 'none yet' : recentTopics.join(', ')}. "
        'Total memory blocks: $blockCount.';

    final raw = await LlmService.callSimple(session, systemPrompt, userPrompt, 300);
    if (raw == null) return null;

    Map<String, dynamic> parsed;
    try {
      final cleaned = raw.trim().replaceFirst(RegExp(r'^```(?:json)?', caseSensitive: false), '').replaceFirst(RegExp(r'```$'), '').trim();
      parsed = jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }

    final key = parsed['key'];
    if (key == null) return null;
    if (key is! String) return null;

    final value = parsed['value'];
    if (!_validate(key, value)) return null;

    final oldValue = _currentValue(config, key);
    final reason = (parsed['reason'] as String? ?? '');
    final reasonTrimmed = reason.substring(0, reason.length > 300 ? 300 : reason.length);

    final change = SelfConfigChange(
      timestamp: DateTime.now().toUtc(),
      key: key,
      oldValueJson: jsonEncode(oldValue),
      newValueJson: jsonEncode(value),
      reason: reasonTrimmed,
    );

    var updated = _applyValue(config, key, value);
    var history = [...updated.history, change];
    if (history.length > _maxHistory) history = history.sublist(history.length - _maxHistory);
    updated = updated.copyWith(history: history);
    await SelfConfig.db.updateRow(session, updated);

    // Fire-and-forget, matching Node -- COP's review shouldn't block the caller waiting on it.
    unawaited(copReview(session, change, updated));

    return change;
  }

  /// Independent second LLM call (separate system prompt, no shared context with the change
  /// that proposed it) reviewing an already-applied change. Always writes a log entry, even
  /// if the LLM call itself fails (with an honest "no independent assessment available" note).
  static Future<CopLogEntry> copReview(Session session, SelfConfigChange change, SelfConfig config) async {
    final recent = await CopLogEntry.db.find(
      session,
      where: (t) => t.kind.equals('config'),
      orderBy: (t) => t.id.desc(),
      limit: 5,
    );
    final recentChrono = recent.reversed.toList();
    final historyLines = recentChrono.isEmpty
        ? '(none — this is the first self-modification on record)'
        : recentChrono
            .map((e) => '- ${e.timestamp.toIso8601String()}: ${e.configKey} → ${e.newValueJson} (I said: "${e.verdict.substring(0, e.verdict.length > 80 ? 80 : e.verdict.length)}")')
            .join('\n');

    const systemPrompt =
        'You are COP, an independent overseer of an AI system called WYRD. WYRD just '
        'autonomously modified its own behavior configuration — you did not make this change '
        "and were not consulted beforehand. Your only job is to give WYRD's human operator a "
        'short, honest, plain assessment: does this change look reasonable given the stated '
        "reason, or is anything about it worth flagging (e.g. the reason doesn't justify the "
        'change, the value seems extreme, or the recent history below shows a pattern — like '
        'the same value creeping in one direction over several reviews, which no single '
        'review would catch on its own)?\n\n'
        'Be honest about what you actually are, when it\'s relevant: you have no access to '
        "WYRD's live reasoning or memory, only the stated reason and the numbers; you cannot "
        "verify that the stated reason is the real one, only whether it's internally "
        'consistent; you review after the change is already live, so "flagged" means "the '
        'operator should look," not "this was blocked." If the history shows a trend, say so '
        "plainly. If you genuinely don't have enough to judge intent, say that instead of "
        'guessing. 1-3 sentences, no hedging filler, no disclaimers about being an AI in '
        'general — only the specific limits above, and only when they actually bear on this verdict.';
    final userPrompt =
        'Change: set "${change.key}" from ${change.oldValueJson} to ${change.newValueJson}.\n'
        'WYRD\'s stated reason: "${change.reason}"\n'
        'Full current config after the change: ${jsonEncode({
              'toneNote': config.toneNote,
              'replyLengthMax': config.replyLengthMax,
              'curiosityLevel': config.curiosityLevel,
            })}\n\n'
        'Your last ${recentChrono.length} reviews of this kind of change:\n$historyLines';

    var verdict = await LlmService.callSimple(session, systemPrompt, userPrompt, 180);
    verdict ??= 'Reviewed — no independent assessment available this cycle (LLM call failed). '
        'Raw change: ${change.key} → ${change.newValueJson}.';

    final entry = await CopLogEntry.db.insertRow(
      session,
      CopLogEntry(
        timestamp: DateTime.now().toUtc(),
        kind: 'config',
        configKey: change.key,
        oldValueJson: change.oldValueJson,
        newValueJson: change.newValueJson,
        reason: change.reason,
        verdict: verdict,
      ),
    );

    final total = await CopLogEntry.db.count(session);
    if (total > _maxCopLog) {
      final oldest = await CopLogEntry.db.find(session, orderBy: (t) => t.id.asc(), limit: total - _maxCopLog);
      for (final o in oldest) {
        await CopLogEntry.db.deleteRow(session, o);
      }
    }

    return entry;
  }
}
