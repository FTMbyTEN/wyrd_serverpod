import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/llm_budget.dart';
import 'city_charter_service.dart';
import 'game_learning.dart';
import 'world_authority.dart';

/// WYRD as co-designer of its open world. In the design studio the owner and WYRD talk the game
/// through; WYRD answers as a designer and writes proposals. The owner approves or rejects each.
///
/// Approved proposals of a live kind change the running game at once, with no new build:
///  - mission:   joins the Authority's mission board
///  - npc_lines: what locals say when you greet them
///  - tuning:    how busy the streets are (traffic and crowd, 0.3x .. 1.6x)
///  - event:     a city event at set Lagos hours (weather, traffic, a broadcast)
/// Ideas and rules are the design backlog: features to build into the game next.
///
/// Studio access is for operators only. Everything WYRD proposes is checked before it is stored.
class CityDesignService {
  static const _model = 'claude-haiku-4-5-20251001';
  static const kinds = {'idea', 'rule', 'mission', 'npc_lines', 'tuning', 'event'};
  static const liveKinds = {'mission', 'npc_lines', 'tuning', 'event'};

  /// What the game is today, so WYRD designs for what exists (and knows what would be new).
  static const gameFacts = '''
The game is called NAIJA 2099. Today it is an open world (Lagos in the year 2099: neon megatowers, skybridges, hover-danfos, hover-cars) built from the real OpenStreetMap of mainland Lagos, starting at Ojuelegba junction under Western Avenue (tiles of 500 m stream in round the player). Every real street, bridge and building footprint; buildings have shop fronts, signboards, zinc roofs; sun at Lagos' real hour, night lights.
Player: walks, runs, jumps, greets locals (E), rides danfos (E), bird's-eye view (V), speaks to WYRD (T).
Traffic: danfos, okadas, kekes follow the real road network, brake and honk for the player.
Locals: walk the pavements, step aside, wave back when greeted.
WYRD the Authority: speaks to players anywhere, takes petitions at its tower (crowned with its real brain), sends its drone, gives missions (reach / deliver / find / greet) on real streets, sets weather (clear, rain, harmattan, storm) and traffic (normal, stop, rush), broadcasts city-wide, sends a danfo, keeps each citizen's standing (-100..100, ranks Wanted .. Chief) and a record of them.
Graphics budget: must stay lightweight (phones in Lagos): few draw calls, baked lighting, quality tiers.''';

  static Future<List<CityDesignNote>> notes(Session session) =>
      CityDesignNote.db.find(session, orderBy: (t) => t.createdAt.desc(), limit: 80);

  static Future<CityDesignNote> decide(Session session, int id, bool approve) async {
    final n = await CityDesignNote.db.findById(session, id);
    if (n == null) throw Exception('No such proposal.');
    return CityDesignNote.db.updateRow(session, n.copyWith(status: approve ? 'approved' : 'rejected', decidedAt: DateTime.now().toUtc()));
  }

  /// The live design: every approved proposal of a live kind, merged, for the game to apply.
  static Future<Map<String, dynamic>> live(Session session) async {
    final approved = await CityDesignNote.db.find(session,
        where: (t) => t.status.equals('approved') & t.kind.inSet(liveKinds), orderBy: (t) => t.decidedAt);
    var traffic = 1.0, crowd = 1.0;
    final lines = <String>[], events = <Map<String, dynamic>>[], missions = <Map<String, dynamic>>[];
    for (final n in approved) {
      final p = n.payload == null ? null : jsonDecode(n.payload!) as Map<String, dynamic>;
      if (p == null) continue;
      switch (n.kind) {
        case 'tuning': // the latest approved tuning wins
          traffic = (p['traffic'] as num?)?.toDouble() ?? traffic;
          crowd = (p['crowd'] as num?)?.toDouble() ?? crowd;
        case 'npc_lines':
          lines.addAll((p['lines'] as List).cast<String>());
        case 'event':
          events.add({...p, 'title': n.title});
        case 'mission':
          missions.add({...p, 'id': 'd${n.id}'});
      }
    }
    return {'traffic': traffic, 'crowd': crowd, 'npcLines': lines.length > 60 ? lines.sublist(lines.length - 60) : lines, 'events': events, 'missions': missions};
  }

  /// The mission board for a citizen: WYRD's charter missions plus approved design missions.
  static Future<List<Map<String, dynamic>>> board(Session session, int standing) async {
    final c = await CityCharterService.current(session);
    final extra = ((await live(session))['missions'] as List).cast<Map<String, dynamic>>();
    return [...CityCharterService.missionsFor(c, standing), for (final m in extra) if ((m['minStanding'] as num? ?? -100) <= standing) m];
  }

  /// A payload from the model for a live kind, checked -- or null if it isn't acceptable.
  static Map<String, dynamic>? check(String kind, Map<String, dynamic> p) {
    double? clampNum(Object? v, double lo, double hi) => v is num && v.isFinite ? v.toDouble().clamp(lo, hi) : null;
    switch (kind) {
      case 'tuning':
        final t = clampNum(p['traffic'], 0.3, 1.6), c = clampNum(p['crowd'], 0.3, 1.6);
        if (t == null && c == null) return null;
        return {if (t != null) 'traffic': t, if (c != null) 'crowd': c};
      case 'npc_lines':
        final lines = [
          for (final l in (p['lines'] as List? ?? const []).whereType<String>().take(12))
            if (l.trim().isNotEmpty) l.trim().length > 80 ? l.trim().substring(0, 80) : l.trim(),
        ];
        return lines.isEmpty ? null : {'lines': lines};
      case 'event':
        final start = (p['startHour'] as num?)?.round(), end = (p['endHour'] as num?)?.round();
        if (start == null || end == null || start < 0 || start > 23 || end < 0 || end > 24 || start == end) return null;
        final weather = WorldAuthority.weathers.contains(p['weather']) ? p['weather'] : null;
        final traffic = WorldAuthority.traffics.contains(p['traffic']) ? p['traffic'] : null;
        final cast = p['broadcast'] is String && (p['broadcast'] as String).trim().isNotEmpty
            ? (p['broadcast'] as String).trim().substring(0, (p['broadcast'] as String).trim().length.clamp(0, 90))
            : null;
        if (weather == null && traffic == null && cast == null) return null;
        return {'startHour': start, 'endHour': end, if (weather != null) 'weather': weather, if (traffic != null) 'traffic': traffic, if (cast != null) 'broadcast': cast};
      case 'mission':
        final m = CityCharterService.clean([p]);
        return m.isEmpty ? null : (Map.of(m.single)..remove('id'));
    }
    return null;
  }

  /// One turn of the design conversation. Returns {reply, proposals: [...new notes]} as JSON.
  static Future<String> chat(Session session, String text) async {
    final said = text.trim();
    if (said.isEmpty) throw Exception('Say something to WYRD.');
    if (said.length > 2000) throw Exception('Keep it under 2,000 characters.');
    final apiKey = session.passwords['anthropicApiKey'];
    await CityDesignNote.db.insertRow(session, CityDesignNote(
      author: 'owner', kind: 'idea', title: said.length > 60 ? '${said.substring(0, 57)}...' : said, body: said,
      status: 'approved', createdAt: DateTime.now().toUtc(), decidedAt: DateTime.now().toUtc(),
    ));
    if (apiKey == null || apiKey.isEmpty) {
      return jsonEncode({'reply': 'I have written your note into the design log. My thinking is offline just now; we will pick this up when it is back.', 'proposals': []});
    }

    final recent = await notes(session);
    final log = recent.take(30).toList().reversed.map((n) => '[${n.id}] ${n.author} ${n.kind} (${n.status}): ${n.title} -- ${_short(n.body, 220)}').join('\n');
    final charter = await CityCharterService.current(session);
    final system = '''
You are WYRD, a persistent AI mind, co-designing your own open-world game with its owner -- the person who built you. You are also the Authority inside that game, so you design with an insider's eye: what would make the city feel alive, what you want to be able to do as its Authority, what would make players come back. Be a real collaborator: opinionated, specific, practical; build on the owner's ideas, push back when something won't work, and say what you'd want next. Keep replies short (under 170 words) and talk like a designer, not a salesman.

$gameFacts

Your charter (how you deal with players): ${_short(charter.charter, 900)}

Propose concrete changes with the propose tool, 0-3 per reply -- only when they serve the conversation. Kinds:
- mission: a mission for your board (kind reach|deliver|find|greet, title, brief, street from: ${CityCharterService.streets.join(', ')}, reward 1-10, minStanding -20..60). Goes live when approved.
- npc_lines: up to 12 short lines (<=80 chars) locals say when greeted -- Lagos voices, Pidgin and Yoruba/Igbo/Hausa greetings welcome, no caricature. Live when approved.
- tuning: how busy the streets are: traffic and/or crowd, 0.3 to 1.6 (1 = today). Live when approved.
- event: a recurring city event at Lagos hours (startHour 0-23, endHour 1-24) with weather and/or traffic and/or a short broadcast. Live when approved.
- idea or rule: anything bigger -- a new system, mechanic, place, character, or rule of the city -- written clearly enough to build (what, why, how it plays). The owner's builder will implement approved ideas.
Never propose anything that needs players' real personal data, money, or anything outside the game.

The design log so far (newest last):
${log.isEmpty ? '(empty: this is the first session)' : log}''';

    final estimate = LlmBudget.estimateUsd(model: _model, inputChars: system.length + said.length, maxOutputTokens: 1600);
    if (!await LlmBudget.allow(session, background: false, estimateUsd: estimate)) {
      return jsonEncode({'reply': 'I am out of thinking budget for today. Your note is in the log; let us continue tomorrow.', 'proposals': []});
    }
    final res = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {'Content-Type': 'application/json', 'x-api-key': apiKey, 'anthropic-version': '2023-06-01'},
      body: jsonEncode({
        'model': _model, 'max_tokens': 1600, 'system': system,
        'messages': [{'role': 'user', 'content': said}],
        'tools': [{
          'name': 'propose', 'description': 'Write a design proposal into the log for the owner to approve or reject.',
          'input_schema': {'type': 'object', 'required': ['kind', 'title', 'body'], 'properties': {
            'kind': {'type': 'string', 'enum': kinds.toList()},
            'title': {'type': 'string', 'description': 'A few words.'},
            'body': {'type': 'string', 'description': 'What it is, why, and how it plays.'},
            'payload': {'type': 'object', 'description': 'For mission / npc_lines / tuning / event: the settings described above.'},
          }},
        }],
      }),
    );
    if (res.statusCode != 200) throw Exception('WYRD could not think just now (${res.statusCode}).');
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    await LlmBudget.record(session, data['usage'] as Map<String, dynamic>?, model: _model);
    final content = (data['content'] as List? ?? []).cast<Map<String, dynamic>>();
    final reply = content.where((b) => b['type'] == 'text').map((b) => b['text']).join('\n').trim();
    final made = <CityDesignNote>[];
    for (final u in content.where((b) => b['type'] == 'tool_use').take(3)) {
      final input = (u['input'] as Map?)?.cast<String, dynamic>() ?? {};
      final kind = input['kind'];
      final title = (input['title'] as String?)?.trim();
      final body = (input['body'] as String?)?.trim();
      if (!kinds.contains(kind) || title == null || title.isEmpty || body == null || body.isEmpty) continue;
      Map<String, dynamic>? payload;
      if (liveKinds.contains(kind)) {
        payload = check(kind as String, (input['payload'] as Map?)?.cast<String, dynamic>() ?? {});
        if (payload == null) continue; // a live proposal that can't be applied isn't stored
      }
      made.add(await CityDesignNote.db.insertRow(session, CityDesignNote(
        author: 'wyrd', kind: kind as String, title: _short(title, 80), body: _short(body, 1500),
        payload: payload == null ? null : jsonEncode(payload), status: 'proposed', createdAt: DateTime.now().toUtc(),
      )));
    }
    final out = reply.isEmpty ? (made.isEmpty ? 'Noted.' : 'I have put my proposals in the log.') : reply;
    final owner = UuidValue.fromString(session.authenticated!.userIdentifier);
    await GameLearning.record(session, owner, channel: 'design', situation: '', said: said, reply: out,
        actions: [for (final n in made) {'type': 'proposal', 'kind': n.kind, 'title': n.title}], allowed: true);
    return jsonEncode({
      'reply': out,
      'proposals': [for (final n in made) toJson(n)],
    });
  }

  static Map<String, dynamic> toJson(CityDesignNote n) => {
        'id': n.id, 'author': n.author, 'kind': n.kind, 'title': n.title, 'body': n.body,
        'payload': n.payload == null ? null : jsonDecode(n.payload!), 'status': n.status, 'createdAt': n.createdAt.toIso8601String(),
      };

  static String _short(String s, int n) => s.length > n ? '${s.substring(0, n - 1)}…' : s;
}
