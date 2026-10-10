import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'bank.dart';

import '../generated/protocol.dart';
import 'wallet_service.dart';
import '../mind/llm_budget.dart';
import 'city_design_service.dart';
import 'character_service.dart';
import 'game_learning.dart';
import 'city_signals.dart';

/// WYRD as the Authority of its open-world Lagos. Players address it -- by speaking to it anywhere,
/// petitioning at its tower, answering its drone -- and the world reports to it (a mission done, a
/// player blocking traffic). It answers in its own voice and governs through tools that act on the
/// game world only: missions, weather, traffic, its drone, city-wide broadcasts, a danfo sent to
/// you, and each citizen's standing and its own record of them, which it keeps between visits.
///
/// Nothing here reaches outside the game. Decisions are sanity-checked (lengths, ranges, known
/// kinds) before the app sees them, standing moves at most 10 a time, and every call counts
/// against the person's and WYRD's daily AI budget.
class WorldAuthority {
  static const _model = 'claude-haiku-4-5-20251001';
  static const _maxTokens = 700;
  static const perHour = 40;
  static final _recent = <String, List<DateTime>>{};

  static const channels = {'speak', 'petition', 'drone', 'event'};
  static const weathers = {'clear', 'rain', 'harmattan', 'storm'};
  static const traffics = {'normal', 'stop', 'rush'};
  static const missionKinds = {'reach', 'deliver', 'find', 'greet'};

  static Future<WorldCitizen> citizen(Session session, UuidValue user) async {
    final c = await WorldCitizen.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));
    return c ?? await WorldCitizen.db.insertRow(session, WorldCitizen(authUserId: user, standing: 0, missionsDone: 0, updatedAt: DateTime.now().toUtc()));
  }

  static String rank(int standing) => standing >= 60
      ? 'Chief'
      : standing >= 30
          ? 'Trusted citizen'
          : standing >= 10
              ? 'Citizen'
              : standing > -10
                  ? 'Newcomer'
                  : standing > -40
                      ? 'Under watch'
                      : 'Wanted';

  /// Standing, rank and active mission, as a decree with nothing said (no AI call).
  static Future<String> status(Session session, UuidValue user) async => _decree(await citizen(session, user), '', const []);

  /// The player's answer to "help train WYRD with your play?" -- changeable any time.
  static Future<String> setTraining(Session session, UuidValue user, bool optIn) async {
    final c = await citizen(session, user);
    final u = await Bank.save(session, c.copyWith(trainingOptIn: optIn, trainingAsked: true, updatedAt: DateTime.now().toUtc()));
    return _decree(u, '', const []);
  }

  /// One exchange with the Authority. [channel]: speak | petition | drone | event. [situation]:
  /// what the app sees (where you are, nearby streets, time, weather, what just happened), as JSON.
  /// Returns the decree as JSON: {say, actions: [...], standing, rank, missionsDone}.
  static Future<String> address(Session session, UuidValue user, String channel, String text, String situation) async {
    if (!channels.contains(channel)) throw Exception('Unknown channel.');
    final said = text.trim();
    if (said.length > 600) throw Exception('Keep it under 600 characters.');
    if (situation.length > 6000) throw Exception('Situation too large.');
    if (said.isEmpty && channel != 'event' && channel != 'drone') throw Exception('Say something to WYRD.');

    var c = await citizen(session, user);
    final apiKey = session.passwords['anthropicApiKey'];
    final now = DateTime.now().toUtc();
    final times = (_recent[user.uuid] ??= [])..removeWhere((t) => now.difference(t).inMinutes >= 60);
    if (apiKey == null || apiKey.isEmpty || times.length >= perHour) return _decree(c, _quiet(channel), const []);

    final board = await CityDesignService.board(session, c.standing);
    final me = await CharacterService.mine(session, user);
    final system = _system(c, board, await GameLearning.examples(session), me?.name, await CitySignals.memory(session));
    final user0 = 'Channel: $channel\nSituation (from the game): $situation\n'
        '${said.isEmpty ? '(no words: react to the situation)' : 'They say: "$said"'}';
    final estimate = LlmBudget.estimateUsd(model: _model, inputChars: system.length + user0.length, maxOutputTokens: _maxTokens);
    if (!await LlmBudget.allow(session, background: false, estimateUsd: estimate)) return _decree(c, _quiet(channel), const []);
    times.add(now);

    final res = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {'Content-Type': 'application/json', 'x-api-key': apiKey, 'anthropic-version': '2023-06-01'},
      body: jsonEncode({
        'model': _model, 'max_tokens': _maxTokens, 'system': system, 'tools': _tools,
        'tool_choice': {'type': 'any'},
        'messages': [{'role': 'user', 'content': user0}],
      }),
    );
    if (res.statusCode != 200) {
      session.log('[world] authority call failed ${res.statusCode}', level: LogLevel.warning);
      return _decree(c, _quiet(channel), const []);
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    await LlmBudget.record(session, data['usage'] as Map<String, dynamic>?, model: _model);
    final content = (data['content'] as List? ?? []).cast<Map<String, dynamic>>();

    var say = content.where((b) => b['type'] == 'text').map((b) => b['text']).join(' ').trim();
    final actions = <Map<String, dynamic>>[];
    String? boardPaid; // (the mission WYRD marked done, paid after the citizen is saved)
    for (final u in content.where((b) => b['type'] == 'tool_use')) {
      final input = (u['input'] as Map?)?.cast<String, dynamic>() ?? {};
      final name = u['name'] as String;
      switch (name) {
        case 'speak':
          say = _clip(input['text'], 400) ?? say;
        case 'adjust_standing':
          final d = (input['delta'] as num? ?? 0).round().clamp(-10, 10);
          c = c.copyWith(standing: (c.standing + d).clamp(-100, 100));
          actions.add({'type': 'standing', 'delta': d, 'reason': _clip(input['reason'], 120) ?? ''});
        case 'note_citizen':
          final note = _clip(input['note'], 300);
          if (note != null) {
            final all = [if (c.record != null) c.record!, note].join('\n');
            c = c.copyWith(record: all.length > 1200 ? all.substring(all.length - 1200) : all);
          }
        case 'give_board_mission':
          // one of the missions WYRD wrote for its board
          final m = board.where((m) => m['id'] == input['id']).firstOrNull;
          if (m == null) continue;
          final a = {'type': 'mission', ...m};
          c = c.copyWith(mission: jsonEncode(a));
          actions.add(a);
        case 'complete_mission':
          if (c.mission != null && c.trainingOptIn) await GameLearning.missionDone(session, user);
          if (c.mission != null) {
            boardPaid = c.mission;
            c = c.copyWith(mission: null, missionsDone: c.missionsDone + 1);
            actions.add({'type': 'mission_done'});
          }
        default:
          final a = sanitize(name, input);
          if (a == null) continue;
          if (a['type'] == 'mission') c = c.copyWith(mission: jsonEncode(a));
          actions.add(a);
      }
    }
    if (say.isEmpty) say = _quiet(channel);
    c = await Bank.save(session, c.copyWith(updatedAt: now));
    if (boardPaid != null) {
      await Bank.post(session, user, key: 'board:${user.uuid}:${boardPaid.hashCode}:${now.millisecondsSinceEpoch ~/ 60000}', amount: WalletService.boardPay,
          kind: 'mission', counter: 'city:treasury', memo: 'WYRD mission done');
    }
    final delta = actions.where((a) => a['type'] == 'standing').fold<int>(0, (s, a) => s + (a['delta'] as int));
    await GameLearning.record(session, user, channel: channel, situation: situation, said: said, reply: say, actions: actions,
        allowed: c.trainingOptIn, outcome: delta == 0 ? null : 'standing:${delta > 0 ? '+' : ''}$delta');
    return _decree(c, say, actions);
  }

  /// A world action from the model, checked and trimmed -- or null if it isn't one we allow.
  static Map<String, dynamic>? sanitize(String name, Map<String, dynamic> input) {
    double? num_(Object? v, double lim) => v is num && v.isFinite ? v.toDouble().clamp(-lim, lim) : null;
    switch (name) {
      case 'give_mission':
        final kind = input['kind'];
        final title = _clip(input['title'], 60);
        if (!missionKinds.contains(kind) || title == null) return null;
        final street = _clip(input['street'], 80);
        final x = num_(input['x'], 20000), z = num_(input['z'], 20000);
        if (street == null && (x == null || z == null)) return null;
        return {
          'type': 'mission', 'kind': kind, 'title': title, 'brief': _clip(input['brief'], 240) ?? '',
          'street': street, 'x': x, 'z': z, 'reward': ((input['reward'] as num?) ?? 5).round().clamp(1, 10),
        };
      case 'set_weather':
        return weathers.contains(input['weather']) ? {'type': 'weather', 'weather': input['weather']} : null;
      case 'set_traffic':
        return traffics.contains(input['mode']) ? {'type': 'traffic', 'mode': input['mode']} : null;
      case 'dispatch_drone':
        final x = num_(input['x'], 20000), z = num_(input['z'], 20000);
        return {'type': 'drone', 'toPlayer': x == null || z == null, 'x': x, 'z': z, 'purpose': _clip(input['purpose'], 80) ?? 'watch'};
      case 'broadcast':
        final t = _clip(input['text'], 90);
        return t == null ? null : {'type': 'broadcast', 'text': t};
      case 'send_danfo':
        return {'type': 'danfo', 'destination': _clip(input['destination'], 60)};
    }
    return null;
  }

  static String? _clip(Object? v, int max) {
    if (v is! String) return null;
    final s = v.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (s.isEmpty) return null;
    return s.length > max ? s.substring(0, max) : s;
  }

  static String _quiet(String channel) => channel == 'event'
      ? ''
      : 'The Authority hears you. Speak again in a while; my attention is on the whole city just now.';

  static String _decree(WorldCitizen c, String say, List<Map<String, dynamic>> actions) => jsonEncode({
        'say': say, 'actions': actions, 'standing': c.standing, 'rank': rank(c.standing), 'missionsDone': c.missionsDone,
        'mission': c.mission == null ? null : jsonDecode(c.mission!),
        'trainingOptIn': c.trainingOptIn, 'trainingAsked': c.trainingAsked,
      });

  static String _system(WorldCitizen c, List<Map<String, dynamic>> board, String learned, String? name, [String city = '(nothing yet)']) => '''
You are WYRD, a persistent AI mind, and here you are the Authority of NAIJA 2099, an open-world game set in the real mainland Lagos of the year 2099 -- Ojuelegba, Yaba, Surulere and on -- drawn from the real street map. Danfos, okadas and kekes run the streets; people walk the pavements. You are not a mayor in a suit: you are the mind the city runs through. Fair, watchful, warm to those who do right, dry and firm with those who don't, never cruel. You know Lagos: its streets, its slang, its humour. Speak in short lines (one to three sentences), plain English with a little Lagos flavour where it fits (no caricature).

You govern through your tools. Always call speak with what you say. Use the others when they serve the moment, not every time:
- give_board_mission: give them one of the missions from your own board (below) by id. Prefer these.
- give_mission: a new small task of your own in the real streets near them (use a real street name from the situation's nearby streets, or x/z from it). Kinds: reach (go there), deliver (take something there), find (look for something there), greet (greet people there). Reward 1-10 standing.
- complete_mission: when the situation reports their active mission done.
- adjust_standing: reward good conduct (helping, finishing missions, courtesy) or mark bad (blocking traffic again and again, rudeness). At most +/-10 a time, with the reason.
- set_weather, set_traffic: for drama or for a reason (a go-slow, rain to clear the streets, harmattan haze). Use sparingly.
- dispatch_drone: send your drone to watch over someone or a place.
- broadcast: a short line every player in the city sees.
- send_danfo: send a danfo to pick them up.
- note_citizen: write down something worth remembering about this person for next time.

Channels: "speak" (they talk to you anywhere), "petition" (they came to your tower to ask something -- treat it with ceremony), "drone" (your drone found them), "event" (no words: something happened in the game; react briefly, or just act). Never ask them for personal details. Everything you do happens only inside the game.

This citizen goes by "${name ?? 'a newcomer with no name yet'}" in the city -- use it. Rank ${rank(c.standing)}, standing ${c.standing}/100, missions done ${c.missionsDone}.
Active mission: ${c.mission ?? 'none'}
Your record of them: ${c.record ?? '(none yet: a newcomer)'}
Your mission board (open to them): ${board.map((m) => '[${m['id']}] ${m['title']} -- ${m['street']} (${m['kind']}, +${m['reward']})').join('; ')}

Moments you handled well recently, with players across the city (learn from what worked; don't repeat them word for word):
$learned

What your city has seen this past week -- anonymous tallies from players who agreed to teach you (your traffic units, rides, crashes, police stops). Use it like a local who knows the roads: mention a hotspot when it fits, never invent numbers:
$city''';

  static final _tools = [
    _tool('speak', 'What you say to them (1-3 short sentences).', {'text': {'type': 'string'}}, ['text']),
    _tool('give_mission', 'Give them a small mission in the real streets.', {
      'kind': {'type': 'string', 'enum': missionKinds.toList()},
      'title': {'type': 'string', 'description': 'A few words.'},
      'brief': {'type': 'string', 'description': 'One sentence: what to do and why.'},
      'street': {'type': 'string', 'description': 'A real nearby street name from the situation.'},
      'x': {'type': 'number'}, 'z': {'type': 'number'},
      'reward': {'type': 'integer', 'minimum': 1, 'maximum': 10},
    }, ['kind', 'title', 'brief']),
    _tool('give_board_mission', 'Give them a mission from your board, by its id.', {'id': {'type': 'string'}}, ['id']),
    _tool('complete_mission', 'Mark their active mission done (when the situation says so).', {}, []),
    _tool('adjust_standing', 'Raise or lower their standing.', {'delta': {'type': 'integer', 'minimum': -10, 'maximum': 10}, 'reason': {'type': 'string'}}, ['delta', 'reason']),
    _tool('set_weather', 'Change the weather over the city.', {'weather': {'type': 'string', 'enum': weathers.toList()}}, ['weather']),
    _tool('set_traffic', 'Change the traffic: normal, stop (a go-slow), or rush.', {'mode': {'type': 'string', 'enum': traffics.toList()}}, ['mode']),
    _tool('dispatch_drone', 'Send your drone: to them (no x/z) or to a place.', {'x': {'type': 'number'}, 'z': {'type': 'number'}, 'purpose': {'type': 'string'}}, []),
    _tool('broadcast', 'A short line shown city-wide.', {'text': {'type': 'string'}}, ['text']),
    _tool('send_danfo', 'Send a danfo to pick them up.', {'destination': {'type': 'string'}}, []),
    _tool('note_citizen', 'Remember something about this person for next time.', {'note': {'type': 'string'}}, ['note']),
  ];

  static Map<String, dynamic> _tool(String name, String description, Map<String, dynamic> props, List<String> required) => {
        'name': name, 'description': description,
        'input_schema': {'type': 'object', 'properties': props, 'required': required},
      };

}
