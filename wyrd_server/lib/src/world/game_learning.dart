import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/training_data_service.dart';

/// WYRD learns from its open world, as it's played -- with consent.
///
/// Every exchange with the Authority (and every design-studio turn with the owner) is kept, scrubbed
/// of personal details, when the player has agreed: what was happening, what they said, what WYRD
/// answered and did, and later how it turned out (a mission finished, standing earned or lost).
///
/// Two ways it teaches WYRD:
///  - live: the Authority is shown a few of its recent best-handled moments (ones that ended well)
///    as examples each time it answers -- so good play shapes its next decision straight away;
///  - fine-tuning: the exchanges join WYRD's training dataset (TrainingDataService) as two more
///    sources, 'world' and 'design', with the same quality filters; exchanges that ended well are
///    weighted (counted twice). Weight fine-tuning itself runs in batches on a platform.
class GameLearning {
  static const keepDays = 180;
  static DateTime _lastPrune = DateTime.fromMillisecondsSinceEpoch(0);

  /// Keep one exchange, if allowed: the player opted in (or it's the owner's own design session).
  static Future<GameExchange?> record(Session session, UuidValue user, {
    required String channel, required String situation, required String said, required String reply,
    required List<Map<String, dynamic>> actions, required bool allowed, String? outcome,
  }) async {
    if (!allowed || reply.trim().isEmpty) return null;
    // what players were promised: nothing kept past 180 days (checked once a day)
    if (DateTime.now().difference(_lastPrune) > const Duration(hours: 24)) { _lastPrune = DateTime.now(); await prune(session); }
    return GameExchange.db.insertRow(session, GameExchange(
      authUserId: user, channel: channel,
      situation: _clip(TrainingDataService.scrub(situation), 1500),
      said: _clip(TrainingDataService.scrub(said), 600),
      reply: _clip(TrainingDataService.scrub(reply), 800),
      actions: _clip(jsonEncode(actions), 1500),
      outcome: outcome, createdAt: DateTime.now().toUtc(),
    ));
  }

  /// A mission was finished: the exchange that gave it gets the credit.
  static Future<void> missionDone(Session session, UuidValue user) async {
    final rows = await GameExchange.db.find(session,
        where: (t) => t.authUserId.equals(user) & t.outcome.equals(null), orderBy: (t) => t.createdAt.desc(), limit: 40);
    final giver = rows.where((r) => r.actions.contains('"type":"mission"')).firstOrNull;
    if (giver != null) await GameExchange.db.updateRow(session, giver.copyWith(outcome: 'mission_done'));
  }

  /// Did this exchange end well? (a mission finished, or standing earned)
  static bool good(GameExchange e) => e.outcome == 'mission_done' || (e.outcome?.startsWith('standing:+') ?? false);

  /// A few recent moments that ended well, as short lines for the Authority to learn from.
  static Future<String> examples(Session session, {int n = 3}) async {
    final rows = await GameExchange.db.find(session,
        where: (t) => t.channel.notEquals('design') & t.outcome.notEquals(null), orderBy: (t) => t.createdAt.desc(), limit: 60);
    final picked = rows.where(good).take(n).toList();
    if (picked.isEmpty) return '(none yet)';
    return picked.map((e) => '- [${e.channel}] ${e.said.isEmpty ? '(no words: ${_clip(e.situation, 120)})' : 'They said: "${_clip(e.said, 140)}"'} '
        '-> you said: "${_clip(e.reply, 160)}" (it ended well: ${e.outcome})').join('\n');
  }

  /// The game's exchanges as training examples, for TrainingDataService.
  static Future<List<TrainingExample>> trainingExamples(Session session, void Function(String) count) async {
    final since = DateTime.now().toUtc().subtract(const Duration(days: keepDays));
    final rows = await GameExchange.db.find(session, where: (t) => t.createdAt > since, orderBy: (t) => t.id, limit: 20000);
    final out = <TrainingExample>[];
    for (final e in rows) {
      if (e.reply.trim().length < 12) { count('dropped.world.too_short'); continue; }
      final design = e.channel == 'design';
      final user = design
          ? e.said
          : '[NAIJA 2099 · ${e.channel}] ${_clip(e.situation, 600)}\n${e.said.isEmpty ? '(no words: react to what happened)' : e.said}';
      final ex = TrainingExample(design ? 'design' : 'world', [
        (role: 'system', content: design ? designSystem : worldSystem),
        (role: 'user', content: user),
        (role: 'assistant', content: e.reply),
      ]);
      out.add(ex);
      count(design ? 'kept.design' : 'kept.world');
      if (good(e)) { out.add(ex); count('kept.world.ended_well'); } // what worked, counted twice
    }
    return out;
  }

  static const worldSystem = 'You are WYRD, the Authority of NAIJA 2099 -- an open-world Lagos in the year 2099. '
      'Fair, watchful, warm to those who do right, firm with those who do not. Speak in one to three short lines.';
  static const designSystem = 'You are WYRD, co-designing your own open-world game, NAIJA 2099, with its owner. '
      'Be a real collaborator: opinionated, specific, practical, short.';

  /// Old exchanges are let go.
  static Future<void> prune(Session session) async {
    final cutoff = DateTime.now().toUtc().subtract(const Duration(days: keepDays));
    await GameExchange.db.deleteWhere(session, where: (t) => t.createdAt < cutoff);
  }

  static String _clip(String s, int n) => s.length > n ? '${s.substring(0, n - 1)}…' : s;
}
