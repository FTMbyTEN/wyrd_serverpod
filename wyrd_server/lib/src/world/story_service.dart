import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'wallet_service.dart';

/// NAIJA 2099's story layer (design/naija2099): reputation that differs by district, faction and
/// social circle, and the branching missions. Everything is decided here -- the app only asks to
/// take a step -- so money and standing can't be faked: each step checks it follows the last, waits
/// as long as the journey really takes, charges what it costs and pays what it pays.
///
/// Stored on the citizen as JSON: {rep: {district: {}, faction: {}, social: {}}, missions: {id: {...}}, memory: [...]}
class StoryService {
  /// Tests skip the journeys (each step's minimum time).
  static bool noWaitsForTesting = false;

  /// The ten factions of the bible (Part 3 §2): id -> name.
  static const factions = {
    'waterfront': 'Waterfront Alliance',
    'atlantic': 'Atlantic Rise Consortium',
    'yaba': 'Yaba Collective',
    'nurtw': 'NURTW 2099 (transport unions)',
    'market': "Market Women's Guild",
    'state': 'Lagos State Government',
    'youth': 'Youth Assembly',
    'faith': 'Faith Coalition',
    'ports': 'Ports Syndicate',
    'archive': 'Orisa Data Keepers',
  };
  static const social = {'street': 'Street', 'elite': 'Elite', 'online': 'Online audience', 'police': 'Police', 'family': 'Family', 'wyrd': 'WYRD, the city mind'};

  static Map<String, dynamic> _blank() => {
        'rep': {'district': <String, dynamic>{}, 'faction': <String, dynamic>{}, 'social': <String, dynamic>{}},
        'missions': <String, dynamic>{},
        'memory': <dynamic>[],
      };

  static Map<String, dynamic> read(WorldCitizen c) {
    if (c.story == null) return _blank();
    try { return {..._blank(), ...(jsonDecode(c.story!) as Map<String, dynamic>)}; } catch (_) { return _blank(); }
  }

  /// The story as the app reads it: reputation, missions, and the names to show.
  static Future<String> get(Session session, UuidValue user) async {
    final c = await WalletService.settle(session, user);
    return jsonEncode({...read(c), 'factions': factions, 'social': social, 'naira': c.naira});
  }

  static void _rep(Map<String, dynamic> s, String group, String key, int delta) {
    final g = (s['rep'] as Map<String, dynamic>)[group] as Map<String, dynamic>;
    g[key] = ((g[key] as num? ?? 0) + delta).clamp(-100, 100).toInt();
  }

  static void _remember(Map<String, dynamic> s, String what) {
    final m = (s['memory'] as List<dynamic>)..add({'at': DateTime.now().toUtc().toIso8601String(), 'what': what});
    if (m.length > 40) m.removeRange(0, m.length - 40);
  }

  // ---- the missions: each step names what may come next, how long it must take, and what it does ----

  /// One move in a mission. [after]: steps it may follow; [wait]: seconds that must have passed since
  /// the step it follows (the journey); [cost]/[pay]: naira; [rep]: (group, key, delta); [needs]: a
  /// reputation it requires; [to]: the step it leads to; [say]: what the people in it say.
  static final _moves = <String, Map<String, _Move>>{
    'tomato': {
      'accept': _Move(after: {null}, to: 'route', say: 'Iya Rofiat: "God bless you, my child. Forty baskets before the Eid rush, or this market go turn to graveyard. Choose how."'),
      'route:mile12': _Move(after: {'route'}, to: 'mile12', say: 'Go to Mile 12 market. The northern traders are there -- haggle well.'),
      'route:union': _Move(after: {'route'}, to: 'union', say: 'Go to Obalende motor park. The union can send danfos -- for a price.'),
      'route:drone': _Move(after: {'route'}, to: 'drone', say: 'Go to the drone couriers in Yaba. Fast, and not cheap.'),
      // Mile 12: a fair price keeps the northern traders sweet; a hard bargain saves money and makes enemies
      'haggle:fair': _Move(after: {'mile12'}, wait: 60, cost: 18000, to: 'haul', rep: [('district', 'Mile 12', 6), ('social', 'street', 3)],
          say: 'Alhaji Musa: "Fair price, fair trader. Forty baskets. Take a vehicle -- you no fit carry am for head."'),
      'haggle:hard': _Move(after: {'mile12'}, wait: 60, cost: 12000, to: 'haul', rep: [('district', 'Mile 12', -10), ('social', 'street', 2)],
          say: 'Alhaji Musa: "You get mouth o. Take am, but next time, my price go double." Drive it to Balogun.'),
      // the union: pay the levy, or call in a favour if the unions already like you
      'union:pay': _Move(after: {'union'}, wait: 45, cost: 3000, to: 'convoy', rep: [('faction', 'nurtw', 4)],
          say: 'Chairman Bello: "Levy collected. Three danfos go carry your tomatoes. Meet them at Balogun."'),
      'union:favour': _Move(after: {'union'}, wait: 45, needs: ('faction', 'nurtw', 15), to: 'convoy', rep: [('faction', 'nurtw', -10)],
          say: 'Chairman Bello: "For you? No wahala. But remember say you owe us one." The danfos are on their way to Balogun.'),
      // the drone courier: quick and dear
      'drone:pay': _Move(after: {'drone'}, wait: 30, cost: 12000, to: 'airborne', rep: [('faction', 'yaba', 5)],
          say: 'The courier\'s drones lift off with the baskets. Meet them at Balogun.'),
      // at Balogun: the long road (Mile 12) takes time; the others less
      'arrive': _Move(after: {'haul', 'convoy', 'airborne'}, wait: 60, to: 'sell',
          say: 'Iya Rofiat: "You don reach! Now -- how we go sell am? The whole market dey look."'),
      // the choice that matters
      'sell:fair': _Move(after: {'sell'}, pay: 26000, to: 'done',
          rep: [('faction', 'market', 15), ('district', 'Lagos Island', 10), ('social', 'online', 5), ('social', 'street', 4)],
          say: 'Prices fall back to normal. The traders cheer you through Balogun. Iya Rofiat will remember this.'),
      'sell:hold': _Move(after: {'sell'}, pay: 46000, to: 'done',
          rep: [('faction', 'market', -20), ('district', 'Lagos Island', -10), ('social', 'online', -8), ('social', 'elite', 4)],
          say: 'You sell slowly, at the top of the market. Your pocket is heavy; Balogun\'s mood is not. Iya Rofiat says nothing, which is worse.'),
    },
    // ---- 2. Ojuelegba Gridlock (Arc B: who runs the city) ----
    'gridlock': {
      'accept': _Move(after: {null}, to: 'fix', say: 'Officer Ngozi: "This light don die since morning. If you fit sort am, Lagos go thank you."'),
      'fix:wyrd': _Move(after: {'fix'}, wait: 20, to: 'done', rep: [('social', 'wyrd', 10), ('faction', 'state', 4), ('district', 'Ojuelegba', 5)], pay: 3000,
          say: 'You report it on the city channel. WYRD answers in eleven seconds: "Seen. Rerouting until a crew arrives. Thank you, citizen." The junction breathes again.'),
      'fix:hack': _Move(after: {'fix'}, wait: 20, to: 'done', rep: [('faction', 'yaba', 6), ('social', 'police', -8), ('social', 'wyrd', -4), ('district', 'Ojuelegba', 8)], pay: 2000,
          say: 'Two minutes with a laptop and the light blinks back to life. The traffic flows; somewhere, a WYRD log notes an unauthorised change.'),
      'fix:area': _Move(after: {'fix'}, wait: 20, cost: 2000, to: 'done', rep: [('faction', 'nurtw', 6), ('social', 'street', 5), ('social', 'police', -4), ('district', 'Ojuelegba', 3)],
          say: 'The area boys take the ₦2,000 and direct traffic like a symphony. Tomorrow they will expect it again.'),
    },
    // ---- 3. The Floating School Run (Arc A: who owns the waterfront) ----
    'school': {
      'accept': _Move(after: {null}, to: 'papers', say: 'Mr Ayọ̀: "The WAEC papers are at UNILAG. If they no reach Makoko before eight tomorrow, my children go miss the exam."'),
      'collect': _Move(after: {'papers'}, wait: 30, to: 'boat', say: 'The exam officer seals the box and hands it over. Now -- how will it cross the water?'),
      'boat:canoe': _Move(after: {'boat'}, to: 'deliver', rep: [('faction', 'waterfront', 8)], say: 'The fishermen make room in a canoe. Slow, but they know every channel. Get to Makoko.'),
      'boat:smugglers': _Move(after: {'boat'}, to: 'deliver', rep: [('faction', 'ports', 6), ('social', 'police', -5)], say: 'The speedboat crew grins: "We go carry am -- you go owe us one." Get to Makoko, fast.'),
      'boat:wyrd': _Move(after: {'boat'}, to: 'deliver', rep: [('social', 'wyrd', 6), ('faction', 'state', 3)], say: 'WYRD holds the Ebute-Metta ferry four minutes for you. "Education is infrastructure," it says. Get to Makoko.'),
      'arrive': _Move(after: {'deliver'}, wait: 60, to: 'done', pay: 8000, rep: [('district', 'Makoko', 15), ('faction', 'waterfront', 4), ('social', 'family', 2)],
          say: 'Mr Ayọ̀ counts the papers twice and laughs. Forty children will sit their exams. Makoko will not forget who brought them.'),
    },
    // ---- 5. Lost Masters (Arc D: memory and culture) ----
    'masters': {
      'accept': _Move(after: {null}, to: 'how', say: 'Baba Tunde: "My father\'s master tapes -- forty years of highlife -- dey for auction abroad. If they go, our history go with them."'),
      'how:crowd': _Move(after: {'how'}, wait: 30, cost: 5000, to: 'done', rep: [('social', 'online', 12), ('district', 'Surulere', 6), ('faction', 'archive', 4)], pay: 0,
          say: 'You put in ₦5,000 and start the campaign. Lagos gives -- ₦1,000 at a time -- and the tapes come home with a hashtag.'),
      'how:archive': _Move(after: {'how'}, to: 'museum', say: 'The Òrìṣà Data Keepers say the proof is in the National Museum\'s old recordings. Go to Onikan.'),
      'proof': _Move(after: {'museum'}, wait: 45, to: 'done', pay: 10000, rep: [('faction', 'archive', 15), ('district', 'Surulere', 8), ('social', 'elite', 3)],
          say: 'A 1974 recording names the true owner. The auction is halted; the family pays you a finder\'s fee and a seat at the homecoming.'),
      'how:conscience': _Move(after: {'how'}, wait: 30, to: 'done', rep: [('social', 'elite', 6), ('faction', 'archive', 5), ('district', 'Surulere', 4)],
          say: 'You call the seller and talk about his own father. A long silence. He withdraws the tapes -- and sends them back himself.'),
    },
    // ---- 7. The Prophet's Miracle Water (Arc C: the hustle and its price) ----
    'water': {
      'accept': _Move(after: {null}, to: 'test', say: 'Sister Grace: "Since Prophet start to sell that blessed water, children dey fall sick for Mushin. Abeg, help us."'),
      'test': _Move(after: {'test'}, wait: 30, cost: 1500, to: 'choose', say: 'The clinic tests a bottle: contaminated well water. Now -- what will you do with the truth?'),
      'tell:faith': _Move(after: {'choose'}, to: 'done', rep: [('faction', 'faith', 12), ('district', 'Mushin', 8)], pay: 5000,
          say: 'The interfaith council steps in quietly. The selling stops, the sick are treated, and the congregation keeps its dignity.'),
      'tell:online': _Move(after: {'choose'}, to: 'done', rep: [('social', 'online', 15), ('faction', 'faith', -6), ('district', 'Mushin', 4)], pay: 5000,
          say: 'Your post goes everywhere. The prophet is finished -- and some of his flock blame you, not him.'),
      'tell:private': _Move(after: {'choose'}, wait: 20, to: 'done', rep: [('faction', 'faith', 6), ('social', 'street', 6), ('district', 'Mushin', 10)],
          say: 'You show him the results to his face. He refunds every bottle and closes the stall. No one else ever knows how.'),
    },
    // ---- 10. Generator Wars (Arc C) ----
    'generator': {
      'accept': _Move(after: {null}, to: 'fix', say: 'Mrs Lawal: "Every night, Mr Okafor and me dey fight over this generator. NEPA no dey, fuel no dey, peace no dey!"'),
      'fix:schedule': _Move(after: {'fix'}, wait: 20, to: 'done', rep: [('district', 'Surulere', 6), ('social', 'street', 4)], pay: 2000,
          say: 'A rota on the wall, fuel shared by the hour. Not perfect -- but the street sleeps quietly tonight.'),
      'fix:solar': _Move(after: {'fix'}, wait: 20, cost: 8000, to: 'done', rep: [('district', 'Surulere', 12), ('faction', 'yaba', 6), ('social', 'online', 3)],
          say: 'You put ₦8,000 into a street solar co-op. Panels on three roofs, a battery in the shop -- and the generator goes quiet for good.'),
      'fix:grid': _Move(after: {'fix'}, wait: 20, to: 'done', rep: [('faction', 'state', 8), ('social', 'wyrd', 5), ('district', 'Surulere', 4)], pay: 1000,
          say: 'You file the fault with WYRD and push until a crew comes. The grid returns -- the whole street cheers when the fan spins.'),
    },
  };

  /// Takes one step in a mission for this citizen. Returns {ok, say, story, naira} or {error}.
  static Future<String> act(Session session, UuidValue user, String mission, String move) async {
    final m = _moves[mission]?[move];
    if (m == null) return jsonEncode({'error': 'That is not something you can do here.'});
    var c = await WalletService.settle(session, user);
    final s = read(c);
    final missions = s['missions'] as Map<String, dynamic>;
    final state = (missions[mission] as Map<String, dynamic>?) ?? {};
    final step = state['step'] as String?;
    if (!m.after.contains(step)) return jsonEncode({'error': step == 'done' ? 'You have finished that one.' : 'Not yet -- one thing at a time.'});
    final since = state['at'] == null ? 1e9 : DateTime.now().toUtc().difference(DateTime.parse(state['at'] as String)).inSeconds;
    if (!noWaitsForTesting && since < m.wait) return jsonEncode({'error': 'You can\'t have got there that fast. Keep going.'});
    if (m.needs != null) {
      final (g, k, min) = m.needs!;
      final have = (((s['rep'] as Map)[g] as Map)[k] as num?) ?? 0;
      if (have < min) return jsonEncode({'error': 'They don\'t know you well enough for favours yet.'});
    }
    if (m.cost > 0 && c.naira < m.cost) return jsonEncode({'error': 'Not enough naira -- you need ₦${m.cost}.'});
    for (final (g, k, d) in m.rep) _rep(s, g, k, d);
    missions[mission] = {...state, 'step': m.to, 'at': DateTime.now().toUtc().toIso8601String(), 'moves': [...(state['moves'] as List? ?? []), move]};
    if (m.to == 'done') _remember(s, '$mission: $move');
    c = await WorldCitizen.db.updateRow(session, c.copyWith(
      naira: c.naira - m.cost + m.pay,
      story: jsonEncode({'rep': s['rep'], 'missions': s['missions'], 'memory': s['memory']}),
      missionsDone: c.missionsDone + (m.to == 'done' ? 1 : 0),
      updatedAt: DateTime.now().toUtc(),
    ));
    return jsonEncode({'ok': true, 'say': m.say, 'step': m.to, 'naira': c.naira, 'paid': m.pay, 'cost': m.cost, 'story': read(c)});
  }
}

class _Move {
  final Set<String?> after;
  final int wait, cost, pay;
  final (String, String, int)? needs;
  final List<(String, String, int)> rep;
  final String to, say;
  const _Move({required this.after, required this.to, required this.say, this.wait = 0, this.cost = 0, this.pay = 0, this.needs, this.rep = const []});
}
