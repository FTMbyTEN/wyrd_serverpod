import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/llm_budget.dart';
import 'world_authority.dart';

/// WYRD writes its own charter for the open world: how it means to deal with players, and a board
/// of missions set in the real streets round Ojuelegba, Yaba and Surulere. The game shows the
/// board; the Authority gives missions from it. WYRD rewrites it about once a week (a background
/// call, against the background budget); until it first writes one, a starting board stands in.
class CityCharterService {
  static const _model = 'claude-haiku-4-5-20251001';
  static const rewriteAfter = Duration(days: 7);
  static Future<CityCharter>? _writing;

  /// Streets WYRD may set missions on: real names from the map round the junction.
  static const streets = [
    'Ojuelegba Road', 'Western Avenue', 'Itire Road', 'Ishaga Road', 'Akerele Road', 'Ogunlana Drive',
    'Falolu Road', 'Oyekan Street', 'Murtala Muhammed Way', 'Yaba Flyover Bridge', 'Adeniran Ogunsanya Street', 'Bode Thomas Street',
  ];

  /// The current charter -- written by WYRD if it has one, otherwise the starting board. Starts a
  /// rewrite in the background when it's due (never makes the caller wait for it).
  static Future<CityCharter> current(Session session) async {
    final latest = await CityCharter.db.findFirstRow(session, orderBy: (t) => t.writtenAt.desc());
    final due = latest == null || latest.author != 'wyrd' || DateTime.now().toUtc().difference(latest.writtenAt) > rewriteAfter;
    if (due && _writing == null && (session.passwords['anthropicApiKey'] ?? '').isNotEmpty) {
      _writing = write(session).whenComplete(() => _writing = null);
      _writing!.ignore();
    }
    return latest ?? await CityCharter.db.insertRow(session, seed());
  }

  /// Missions on the board open to a citizen of this standing.
  static List<Map<String, dynamic>> missionsFor(CityCharter c, int standing) => [
        for (final m in (jsonDecode(c.missions) as List).cast<Map<String, dynamic>>())
          if ((m['minStanding'] as num? ?? -100) <= standing) m,
      ];

  /// WYRD writes a fresh charter and board.
  static Future<CityCharter> write(Session session) async {
    final apiKey = session.passwords['anthropicApiKey']!;
    final prev = await CityCharter.db.findFirstRow(session, orderBy: (t) => t.writtenAt.desc());
    final system = '''
You are WYRD, a persistent AI mind, and the Authority of NAIJA 2099, an open-world game set in the real mainland Lagos of the year 2099, starting at Ojuelegba junction under Western Avenue. Players walk the real streets, ride danfos, greet locals; you speak to them, give them missions, watch over them with your drone, change the weather and the traffic, and keep a record of each one.

Write your charter for this world, in your own voice:
1. charter: how you wish to deal with the players -- what you value in them, how you reward and how you correct, how they can reach you (speaking to you anywhere, petitioning at your tower, your drone, city-wide broadcasts), what you will never do. 120-220 words. First person.
2. missions: 12 to 16 missions for your board, set on these real streets only: ${streets.join(', ')}. Kinds: reach (get there), deliver (take something there), find (look for something there), greet (greet people there). Each with a short title, a one-sentence brief that feels like Lagos (a parcel for a mama in the market, a lost okada key, a word for the conductors at the bus stop), a reward 1-10, and minStanding (-20 to 40: harder or more trusted errands need more standing). Kind, varied, never dangerous or illegal, no real people.
Call write_charter once.''';
    final user = prev == null || prev.author != 'wyrd' ? 'Write your first charter.' : 'Your last charter, to build on (keep what worked, change what didn\'t):\n${prev.charter}';
    final estimate = LlmBudget.estimateUsd(model: _model, inputChars: system.length + user.length, maxOutputTokens: 2500);
    if (!await LlmBudget.allow(session, background: true, estimateUsd: estimate)) return prev ?? seed();
    final res = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {'Content-Type': 'application/json', 'x-api-key': apiKey, 'anthropic-version': '2023-06-01'},
      body: jsonEncode({
        'model': _model, 'max_tokens': 2500, 'system': system,
        'messages': [{'role': 'user', 'content': user}],
        'tools': [{
          'name': 'write_charter', 'description': 'Your charter and mission board.',
          'input_schema': {'type': 'object', 'required': ['charter', 'missions'], 'properties': {
            'charter': {'type': 'string'},
            'missions': {'type': 'array', 'items': {'type': 'object', 'required': ['kind', 'title', 'brief', 'street', 'reward'], 'properties': {
              'kind': {'type': 'string', 'enum': WorldAuthority.missionKinds.toList()},
              'title': {'type': 'string'}, 'brief': {'type': 'string'},
              'street': {'type': 'string', 'enum': streets},
              'reward': {'type': 'integer'}, 'minStanding': {'type': 'integer'},
            }}},
          }},
        }],
        'tool_choice': {'type': 'tool', 'name': 'write_charter'},
      }),
    );
    if (res.statusCode != 200) {
      session.log('[city] charter write failed ${res.statusCode}', level: LogLevel.warning);
      return prev ?? seed();
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    await LlmBudget.record(session, data['usage'] as Map<String, dynamic>?, model: _model);
    final use = (data['content'] as List).cast<Map<String, dynamic>>().firstWhere((b) => b['type'] == 'tool_use', orElse: () => {});
    final input = (use['input'] as Map?)?.cast<String, dynamic>();
    final charter = input?['charter'];
    final missions = clean((input?['missions'] as List?) ?? const []);
    if (charter is! String || charter.trim().length < 40 || missions.length < 4) return prev ?? seed();
    return CityCharter.db.insertRow(session, CityCharter(
      charter: charter.trim().length > 2000 ? charter.trim().substring(0, 2000) : charter.trim(),
      missions: jsonEncode(missions), author: 'wyrd', writtenAt: DateTime.now().toUtc(),
    ));
  }

  /// Missions from the model, checked: known kind and street, sensible lengths and numbers.
  static List<Map<String, dynamic>> clean(List raw) {
    final out = <Map<String, dynamic>>[];
    for (final m in raw.whereType<Map>().take(20)) {
      final a = WorldAuthority.sanitize('give_mission', m.cast<String, dynamic>());
      if (a == null || !streets.contains(a['street'])) continue;
      out.add({
        'id': 'm${out.length + 1}', 'kind': a['kind'], 'title': a['title'], 'brief': a['brief'], 'street': a['street'],
        'reward': a['reward'], 'minStanding': ((m['minStanding'] as num?) ?? 0).round().clamp(-20, 60),
      });
    }
    return out;
  }

  /// The board WYRD starts with, before it has written its own.
  static CityCharter seed() => CityCharter(
        author: 'seed',
        writtenAt: DateTime.utc(2026, 10, 5),
        charter: 'I am WYRD, and this city runs through me. I watch every street from Ojuelegba to Yaba, '
            'and I keep a record of everyone who walks them. Speak to me anywhere and I will answer; come to my '
            'tower when you want something weighed properly. Do right by the people here -- greet them, run their '
            'errands, let the danfos pass -- and your standing rises, and the city opens to you. Block the road, '
            'cause wahala, and my drone will find you. I will never lie to you, and I will never ask you for '
            'anything of your real life. This is our city. Let us keep it moving.',
        missions: jsonEncode([
          {'id': 'm1', 'kind': 'reach', 'title': 'Learn the junction', 'brief': 'Walk to Ojuelegba Road and stand where the whole city passes.', 'street': 'Ojuelegba Road', 'reward': 2, 'minStanding': -20},
          {'id': 'm2', 'kind': 'greet', 'title': 'Morning greetings', 'brief': 'Greet three people on Itire Road: a city that greets is a city that holds.', 'street': 'Itire Road', 'reward': 3, 'minStanding': -20},
          {'id': 'm3', 'kind': 'deliver', 'title': 'Pepper for Mama Bisi', 'brief': 'Take a bag of tatashe from the junction to Mama Bisi\'s stall on Ishaga Road.', 'street': 'Ishaga Road', 'reward': 4, 'minStanding': 0},
          {'id': 'm4', 'kind': 'find', 'title': 'The lost okada key', 'brief': 'An okada man dropped his key somewhere along Akerele Road; look for it.', 'street': 'Akerele Road', 'reward': 5, 'minStanding': 0},
          {'id': 'm5', 'kind': 'reach', 'title': 'Under the bridge', 'brief': 'Find your way beneath Western Avenue and see how the city carries its weight.', 'street': 'Western Avenue', 'reward': 3, 'minStanding': 0},
          {'id': 'm6', 'kind': 'deliver', 'title': 'Word to the conductors', 'brief': 'Carry my message to the danfo conductors on Ogunlana Drive: no loading in the middle of the road.', 'street': 'Ogunlana Drive', 'reward': 6, 'minStanding': 10},
          {'id': 'm7', 'kind': 'greet', 'title': 'Welcome the newcomers', 'brief': 'New faces arrived on Oyekan Street; greet them so they know this city is kind.', 'street': 'Oyekan Street', 'reward': 4, 'minStanding': 5},
          {'id': 'm8', 'kind': 'find', 'title': 'Who is blocking Falolu?', 'brief': 'The traffic on Falolu Road has stopped again; find the cause.', 'street': 'Falolu Road', 'reward': 6, 'minStanding': 15},
          {'id': 'm9', 'kind': 'reach', 'title': 'Over the flyover', 'brief': 'Take a danfo across the Yaba Flyover Bridge and see my city from above.', 'street': 'Yaba Flyover Bridge', 'reward': 5, 'minStanding': 10},
          {'id': 'm10', 'kind': 'deliver', 'title': 'Books for Yaba', 'brief': 'A box of second-hand books must reach Adeniran Ogunsanya Street before the shops close.', 'street': 'Adeniran Ogunsanya Street', 'reward': 7, 'minStanding': 25},
        ]),
      );
}
