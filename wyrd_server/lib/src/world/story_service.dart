import 'dart:convert';

import 'city_wire.dart';

import 'package:serverpod/serverpod.dart';
import 'bank.dart';

import '../generated/protocol.dart';
import 'wallet_service.dart';
import 'police_service.dart';

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
    await PoliceService.loadFixed(session);
    return jsonEncode({..._view(read(c)), 'fixedUnits': PoliceService.fixedUnits.toList(), 'factions': factions, 'social': social, 'naira': c.naira, 'cityVars': _varNames,
      'backgrounds': {for (final e in backgrounds.entries) e.key: [e.value.$1, e.value.$2]},
      'careers': {for (final e in careers.entries) e.key: e.value.$1}, 'careerStages': careerStages});
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
    // ---- Unit T-31 (Fair Streets): a WYRD unit in Mushin reading 20 km/h high ----
    't31': {
      'accept': _Move(after: {null}, to: 'pace', say: 'Rasheed: "T-31 dey fine my riders for speeds wey okada no fit reach. Prove am, and we go remember you."'),
      'pace': _Move(after: {'pace'}, wait: 20, to: 'witnesses',
          say: 'You drive past T-31 at a steady speed and note it. Your speedometer says one thing; T-31 logs you 20 km/h faster. Now find people who saw it happen to others.'),
      'witness:listen': _Move(after: {'witnesses'}, wait: 30, to: 'compare', rep: [('social', 'street', 4), ('district', 'Mushin', 4)],
          say: 'Three riders and a mama who sells by the junction tell the same story, with dates. You write it all down.'),
      'witness:cctv': _Move(after: {'witnesses'}, wait: 10, cost: 1000, to: 'compare', rep: [('district', 'Mushin', 2)],
          say: 'The phone shop sells you a week of its CCTV for ₦1,000: bikes crawling past while T-31 logs them speeding.'),
      'expose:wyrd': _Move(after: {'compare'}, wait: 20, to: 'done', pay: 4000, rep: [('social', 'wyrd', 8), ('district', 'Mushin', 8), ('social', 'street', 4)],
          say: 'You file it with WYRD, readings and statements side by side. WYRD checks T-31 against its patrols, finds the fault, and fixes it on the spot.'),
      'expose:press': _Move(after: {'compare'}, wait: 20, to: 'done', pay: 4000, rep: [('social', 'online', 10), ('district', 'Mushin', 6), ('social', 'wyrd', -3)],
          say: 'Your thread goes everywhere: "The robot that fines okadas for flying." By evening WYRD has fixed T-31 and apologised in public.'),
      'expose:riders': _Move(after: {'compare'}, wait: 20, to: 'done', pay: 4000, rep: [('faction', 'nurtw', 10), ('district', 'Mushin', 10), ('social', 'street', 6)],
          say: 'You hand everything to Rasheed\'s union. They march it to WYRD together; T-31 is fixed before the riders have finished their tea.'),
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
    // ---- Owambe Under the Rain (Arc C) ----
    "owambe": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mama Tolu: \"The other mother-in-law is already crying. Please, do something before the couple dance in.\""),
      "fix:rival": _Move(after: {'decide'}, to: 'done', pay: 6000, rep: [("social", "elite", 8), ("faction", "market", 3), ("district", "Victoria Island", 5)],
          say: "Mrs Dosunmu sends six canopies and a smile you cannot read. The couple enter dry. Somewhere, a favour is written down."),
      "fix:indoors": _Move(after: {'decide'}, to: 'done', pay: 4000, rep: [("social", "family", 5), ("district", "Victoria Island", 3)],
          say: "Two hundred guests, one hall, zero space. Nobody can dance properly — and everybody says it was the best wedding of the year."),
      "fix:rain": _Move(after: {'decide'}, to: 'done', pay: 5000, rep: [("social", "online", 12), ("social", "elite", -3), ("district", "Victoria Island", 4)],
          say: "The DJ drops the beat, the couple dance in under the rain, and the video reaches a million people by morning. The aunties are divided."),
    },
    // ---- Sea Wall Crack (Arc A) ----
    "seawall": {
      'accept': _Move(after: {null}, to: 'decide', say: "Engr. Hauwa: \"My bosses at Atlantic Rise say wait for the quarterly review. The sea does not do quarterly reviews.\""),
      "fix:atlantic": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 9000, rep: [("faction", "atlantic", 12), ("faction", "waterfront", -4), ("district", "Eko Atlantic", 6)],
          say: "Atlantic Rise seals the crack in a day and announces it as \"proactive maintenance\". Engr. Hauwa gets a bonus she did not ask for."),
      "fix:press": _Move(after: {'decide'}, to: 'done', wait: 20, rep: [("social", "online", 10), ("faction", "youth", 6), ("faction", "atlantic", -10)],
          say: "The story runs at dawn: \"THE WALL IS CRACKING\". The wall is fixed by noon. Atlantic Rise wants to know who talked."),
      "fix:divers": _Move(after: {'decide'}, to: "go_divers", say: "Bring the divers from Makoko."),
      "divers": _Move(after: {"go_divers"}, to: 'done', wait: 40, pay: 4000, rep: [("faction", "waterfront", 12), ("district", "Makoko", 6), ("faction", "atlantic", 2)],
          say: "The Makoko divers patch the crack by torchlight. In the morning, Eko Atlantic's residents never know whose hands held back the sea."),
    },
    // ---- Union Election (Arc C) ----
    "union": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mama Kemi: \"Alhaji has the money and the boys. I have the drivers' hearts. Hearts don't buy fuel.\""),
      "vote:campaign": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 3000, rep: [("faction", "nurtw", 6), ("social", "street", 8), ("district", "Obalende", 8)],
          say: "Mama Kemi wins by forty votes. Levies fall by a third. Alhaji Bello shakes her hand and does not look at you."),
      "vote:deal": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 6000, rep: [("faction", "nurtw", 10), ("district", "Obalende", 4), ("social", "street", -2)],
          say: "A handshake over suya: Alhaji keeps the title, Mama Kemi keeps the books. Nobody is happy. Nobody fights."),
      "vote:expose": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("social", "online", 10), ("social", "police", 4), ("faction", "nurtw", -6), ("district", "Obalende", 6)],
          say: "Your video of the envelopes plays on every phone in the park. The vote is re-run, clean. Some of the boys now know your face."),
    },
    // ---- Phone of the Minister (Arc A) ----
    "phone": {
      'accept': _Move(after: {null}, to: 'decide', say: "Musa: \"If they ask, I never saw you. Please.\""),
      "phone:return": _Move(after: {'decide'}, to: 'done', pay: 15000, rep: [("faction", "state", 12), ("faction", "waterfront", -8), ("social", "elite", 4)],
          say: "The minister thanks you warmly and asks no questions. The envelope is thick. Somewhere in Makoko, the surveyors arrive early."),
      "phone:leak": _Move(after: {'decide'}, to: 'done', rep: [("faction", "youth", 12), ("faction", "waterfront", 10), ("faction", "state", -12), ("district", "Makoko", 8)],
          say: "The screenshots trend for three days. The deal freezes. The Youth Assembly marches. A State car parks outside your house for a while."),
      "phone:sell": _Move(after: {'decide'}, to: 'done', pay: 25000, rep: [("faction", "atlantic", 12), ("faction", "state", -6), ("faction", "waterfront", -10)],
          say: "Atlantic Rise pays well and smiles wider. Now they own a minister. You try not to think about what they will build."),
    },
    // ---- The Eyo Procession (Arc D) ----
    "eyo": {
      'accept': _Move(after: {null}, to: 'decide', say: "The aide: \"Respect is the first rule. The second is: do not let anybody get hurt.\""),
      "eyo:palace": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 4000, rep: [("faction", "archive", 10), ("district", "Lagos Island", 8), ("social", "family", 3)],
          say: "The guards walk the route with you at dawn. The Eyo pass in perfect silence and white. The aide nods once — high praise."),
      "eyo:wyrd": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 4000, rep: [("social", "wyrd", 8), ("faction", "state", 4), ("faction", "archive", -2), ("district", "Lagos Island", 5)],
          say: "WYRD clears every road in four minutes. \"I have studied the rites,\" it says, \"and I will stay out of them.\" An elder mutters, then smiles."),
      "eyo:youth": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 3000, rep: [("faction", "youth", 8), ("social", "street", 6), ("district", "Lagos Island", 10)],
          say: "Two hundred young people in white T-shirts hold the route like a wall. Not one sandal crosses. The island is proud of its own."),
    },
    // ---- Container 4B (Arc C) ----
    "container": {
      'accept': _Move(after: {null}, to: 'decide', say: "Dr Bello: \"You can get inside the port. I can't. Please.\""),
      "cargo:return": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 5000, rep: [("social", "family", 4), ("faction", "ports", -8), ("district", "Apapa", 8)],
          say: "A borrowed truck, a long night, and the drugs are back on the hospital shelves by morning. Dr Bello cries. The port remembers your number plate."),
      "cargo:whistle": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("social", "police", 8), ("social", "online", 8), ("faction", "ports", -12), ("faction", "state", 4)],
          say: "Three customs officers are suspended on live TV. The supplies go back. The Ports Syndicate sends you a fruit basket with no card."),
      "cargo:sell": _Move(after: {'decide'}, to: 'done', pay: 20000, rep: [("faction", "ports", 12), ("social", "street", -6), ("district", "Apapa", -8)],
          say: "The syndicate pays in cash and respect. Dr Bello stops answering your calls. You count the money twice; it does not feel like more."),
    },
    // ---- Startup Buyout (Arc B) ----
    "startup": {
      'accept': _Move(after: {null}, to: 'decide', say: "Chidinma: \"My mother says take it. My drivers say don't. What do you say?\""),
      "buy:refuse": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 2000, rep: [("faction", "yaba", 12), ("faction", "waterfront", 8), ("district", "Yaba", 6)],
          say: "Three Lagos investors and a market women's cooperative put in the money. FloatRide stays local. Chidinma names a boat after you."),
      "buy:protect": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 6000, rep: [("faction", "yaba", 4), ("faction", "waterfront", 4), ("social", "elite", 6)],
          say: "Lawyers argue for a week; the contract keeps the drivers and keeps the data in Lagos. Everyone signs, nobody fully trusts it."),
      "buy:sell": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 12000, rep: [("social", "elite", 8), ("faction", "waterfront", -8), ("faction", "yaba", -4)],
          say: "Chidinma shares the money with every driver. Six months later the fares double. She calls you from London; the line is quiet."),
    },
    // ---- The Kidnapped Goat (Arc D) ----
    "goat": {
      'accept': _Move(after: {null}, to: 'decide', say: "Abba: \"He likes bread and he hates the colour red. That is all I know.\""),
      "goat:gossip": _Move(after: {'decide'}, to: 'done', wait: 25, pay: 3000, rep: [("faction", "market", 6), ("district", "Festac", 8), ("social", "family", 3)],
          say: "Aunty Bose heard from Aunty Nkem who heard from a boy who sells bread: a ram that hates red is hiding in a garage on 4th Avenue. Babangida comes home."),
      "goat:trade": _Move(after: {'decide'}, to: 'done', wait: 15, cost: 4000, rep: [("district", "Festac", 4), ("social", "street", -2)],
          say: "Four thousand naira and an awkward handshake later, Babangida walks home eating bread. Next week, two more goats go missing."),
      "goat:trap": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 3000, rep: [("social", "police", 4), ("district", "Festac", 10), ("social", "online", 4)],
          say: "The thieves come for the bread; Babangida sees the red cloth and charges. The vigilantes do not even need to move. The video is everywhere by Friday."),
    },
    // ---- Flood Night (Arc A) ----
    "flood": {
      'accept': _Move(after: {null}, to: 'decide', say: "Tunde: \"Waist-deep already. Children in the buses.\""),
      "flood:boats": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 4000, rep: [("faction", "waterfront", 10), ("district", "Lekki", 10), ("social", "street", 4)],
          say: "Twelve canoes, all night, back and forth. Every bus is emptied by 3am. In the morning, Lekki brings bread to the waterfront."),
      "flood:gates": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 4000, rep: [("social", "wyrd", 6), ("district", "Lekki", 12), ("district", "Makoko", -12), ("faction", "waterfront", -8)],
          say: "WYRD opens the gates. \"Decision logged,\" it says, very quietly. The expressway drains in an hour. Makoko spends the night on its roofs."),
      "flood:drains": _Move(after: {'decide'}, to: 'done', wait: 40, pay: 2000, rep: [("faction", "youth", 8), ("district", "Lekki", 8), ("social", "online", 4)],
          say: "Two hundred volunteers pull plastic out of the drains until their hands bleed. The water drops slowly — and nobody else floods."),
    },
    // ---- The Leak (Arc B) ----
    "leak": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mustapha: \"My job, my family — please, be careful who you show.\""),
      "leak:publish": _Move(after: {'decide'}, to: 'done', wait: 20, rep: [("faction", "youth", 12), ("social", "online", 10), ("social", "elite", -12), ("district", "Ikoyi", -6)],
          say: "The logs go public. The estates switch SENTINEL off \"for maintenance\". Ikoyi stops inviting you to things. Mustapha keeps his job — just."),
      "leak:wyrd": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 3000, rep: [("social", "wyrd", 10), ("faction", "state", 4), ("social", "elite", -4)],
          say: "WYRD reads the logs for nine seconds. \"This is not who we are,\" it says, and cuts SENTINEL off the city network. Quietly. Permanently."),
      "leak:blackmail": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 20000, rep: [("social", "elite", 4), ("faction", "youth", -10), ("social", "street", -4)],
          say: "The estate board pays you to forget. You buy something nice. Mustapha asks what happened to the logs; you change the subject."),
    },
    // ---- Pepper Soup Diplomacy (Arc C) ----
    "peppersoup": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mama Ireti: \"Men listen better when they are eating.\""),
      "soup:meal": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 3000, rep: [("district", "Mushin", 10), ("social", "street", 6), ("faction", "faith", 4)],
          say: "Three pots of goat pepper soup and two hours of shouting later, the crews share the street — and a recycling machine Mama Ireti makes them buy together."),
      "soup:prove": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 4000, rep: [("social", "online", 6), ("district", "Mushin", 8), ("social", "police", 3)],
          say: "Your camera shows a factory truck dumping on both sides at night. The crews turn on the factory instead. The canal is cleaned by the weekend."),
      "soup:split": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 2000, rep: [("district", "Mushin", 5), ("social", "street", 3)],
          say: "You draw a line down Ladipo Street. Both crews hate it equally, which is how you know it is fair."),
    },
    // ---- Ghost Bus (Arc B) ----
    "ghostbus": {
      'accept': _Move(after: {null}, to: 'decide', say: "Sule: \"If na juju, I dey go home. If na machine... e still no make sense.\""),
      "ghost:investigate": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 5000, rep: [("faction", "youth", 6), ("social", "online", 6), ("faction", "state", -4)],
          say: "The account belongs to an AREA network supervisor running six ghost buses. The story breaks; so does the network's reputation."),
      "ghost:hack": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 2000, rep: [("faction", "yaba", 8), ("social", "street", 8), ("social", "police", -6)],
          say: "Ten minutes of code and the ghost bus becomes the free night bus. Sule rides it home every night. The police are still looking for the hacker."),
      "ghost:wyrd": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 3000, rep: [("social", "wyrd", 8), ("faction", "state", 6)],
          say: "WYRD grounds every unregistered AREA bus at once. \"I do not like ghosts in my network,\" it says. Sule is a little disappointed."),
    },
    // ---- Grandma's Land (Arc A) ----
    "grandma": {
      'accept': _Move(after: {null}, to: 'decide', say: "Grandma Adunni: \"Do it properly. And eat something first.\""),
      "land:archive": _Move(after: {'decide'}, to: "go_records", say: "Search the records at the National Museum, Onikan."),
      "records": _Move(after: {"go_records"}, to: 'done', wait: 40, pay: 2000, rep: [("faction", "archive", 12), ("social", "family", 10), ("district", "Ebute-Metta", 6)],
          say: "A 1961 survey plan, your great-grandfather's signature, and a stamp. The claim collapses. Grandma Adunni says she knew all along, and cooks for a week."),
      "land:court": _Move(after: {'decide'}, to: 'done', wait: 30, cost: 6000, rep: [("faction", "state", 4), ("social", "family", 6)],
          say: "Eleven adjournments compressed into one long month. You win. The other family does not speak to yours again."),
      "land:talk": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("social", "family", 12), ("district", "Ebute-Metta", 8), ("faction", "faith", 3)],
          say: "The two grandmothers discover their fathers were friends. The claim is dropped, and you are now expected at two Christmases."),
    },
    // ---- Match Day (Arc D) ----
    "matchday": {
      'accept': _Move(after: {null}, to: 'decide', say: "Coach Emeka: \"They won't listen to me. I'm the losing coach.\""),
      "match:var": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 4000, rep: [("social", "online", 8), ("district", "Surulere", 8), ("faction", "youth", 4)],
          say: "The big screen shows it: no penalty. The referee reverses it. The stadium explodes — with joy. Nobody gets hurt."),
      "match:legend": _Move(after: {'decide'}, to: 'done', wait: 25, pay: 4000, rep: [("district", "Surulere", 10), ("social", "street", 6)],
          say: "Captain Okon walks onto the pitch with a megaphone and starts singing the old anthem. Forty thousand people sing with him, and go home."),
      "match:wyrd": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 3000, rep: [("social", "wyrd", 8), ("faction", "state", 4), ("district", "Surulere", 4)],
          say: "WYRD opens gates one by one and holds the trains with free suya vouchers. The anger leaks away a few hundred people at a time."),
    },
    // ---- Japa or Stay (Arc C) ----
    "japa": {
      'accept': _Move(after: {null}, to: 'decide', say: "Tobi: \"Everybody I graduated with is gone. Everybody.\""),
      "japa:fund": _Move(after: {'decide'}, to: 'done', wait: 20, cost: 8000, rep: [("social", "family", 10), ("social", "elite", 2)],
          say: "Tobi gets the visa. At the airport, Mummy cries, then laughs, then cries again. Every Sunday now, there is a call from Toronto."),
      "japa:job": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("social", "family", 8), ("faction", "yaba", 6), ("district", "Yaba", 4)],
          say: "A startup in Yaba hires Tobi on your word. The money is less than Canada. The jollof is much better. Tobi stays — for now."),
      "japa:scholarship": _Move(after: {'decide'}, to: 'done', wait: 40, pay: 2000, rep: [("social", "family", 12), ("faction", "youth", 4)],
          say: "A full scholarship, with a promise to come back and teach. Tobi leaves for two years — and Lagos already has a seat waiting."),
    },
    // ---- The Drone Strike (Arc C) ----
    "dronestrike": {
      'accept': _Move(after: {null}, to: 'decide', say: "Ifeoma: \"The company says you can fly a drone for them today. Double pay. Will you?\""),
      "drone:support": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("social", "street", 8), ("faction", "youth", 6), ("faction", "yaba", -4)],
          say: "Three days of empty skies. Then the company folds: pay restored, plus a rest rule. Ifeoma buys everyone puff-puff."),
      "drone:cross": _Move(after: {'decide'}, to: 'done', wait: 20, pay: 10000, rep: [("faction", "yaba", 6), ("social", "street", -10), ("faction", "youth", -6)],
          say: "You fly forty deliveries over the picket line. The money is good. The pilots know your callsign now, and not fondly."),
      "drone:negotiate": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 5000, rep: [("faction", "yaba", 6), ("social", "street", 4), ("faction", "state", 4)],
          say: "Eight hours, one room, a lot of jollof. Pay goes back up halfway; a pilots' seat is added to the board. The drones fly at dawn."),
    },
    // ---- Recovered Voices (Arc D) ----
    "voices": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mrs Hunpatin: \"We do this slowly, and with respect. These are people's grandparents.\""),
      "voices:elders": _Move(after: {'decide'}, to: 'done', wait: 40, pay: 3000, rep: [("faction", "archive", 12), ("social", "family", 6), ("district", "Badagry Road", 8)],
          say: "Six weeks of evenings on porches. The new recordings are warmer than the old. One elder sings; everybody in the room goes quiet."),
      "voices:crowd": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 2000, rep: [("social", "online", 8), ("faction", "archive", 6), ("faction", "yaba", 4)],
          say: "Ten thousand volunteers clean the audio frame by frame. The heritage centre opens with a wall of the names who helped."),
      "voices:museum": _Move(after: {'decide'}, to: 'done', wait: 40, pay: 4000, rep: [("faction", "archive", 10), ("social", "elite", 6), ("faction", "state", 3)],
          say: "After four months of letters, the museum sends the tapes home with an apology. Mrs Hunpatin holds the box for a long time before opening it."),
    },
    // ---- Blackout Bank Run (Arc B) ----
    "bankrun": {
      'accept': _Move(after: {null}, to: 'decide', say: "Mr Coker: \"If this turns into a stampede, people will die for money that is still here.\""),
      "bank:ajo": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 4000, rep: [("faction", "market", 10), ("social", "street", 6), ("district", "Lagos Island", 6)],
          say: "The ÀJỌ women set up tables and pay out small cash against bank IOUs. The panic stops. The banks owe the market women — and they know it."),
      "bank:trace": _Move(after: {'decide'}, to: 'done', wait: 40, pay: 6000, rep: [("faction", "yaba", 12), ("social", "police", 6), ("social", "online", 4)],
          say: "The trail leads to a server farm in a warehouse in Ojota. The systems come back by midnight. The attackers do not."),
      "bank:peace": _Move(after: {'decide'}, to: 'done', wait: 25, pay: 3000, rep: [("social", "police", 6), ("district", "Lagos Island", 8), ("social", "family", 2)],
          say: "Chairs, water, and an update every fifteen minutes. Nobody runs. When the screens come back on, the crowd applauds the bank staff."),
    },
    // ---- The Gate Decision (Arc A + B) ----
    "finale": {
      'accept': _Move(after: {null}, to: 'decide', say: "WYRD: \"I have shown you the map. Everything you have built in this city is on it.\""),
      "gate:atlantic": _Move(after: {'decide'}, to: 'done', wait: 30, pay: 20000, rep: [("faction", "atlantic", 20), ("faction", "waterfront", -20), ("district", "Makoko", -20), ("social", "wyrd", -4)],
          say: "The towers stand untouched. Makoko loses half its homes by dawn. WYRD logs the decision and says nothing at all for a day."),
      "gate:makoko": _Move(after: {'decide'}, to: 'done', wait: 30, rep: [("faction", "waterfront", 20), ("district", "Makoko", 20), ("faction", "atlantic", -20), ("social", "elite", -8)],
          say: "Makoko holds. The sea walks into Eko Atlantic's lobbies. Atlantic Rise sues the city; Makoko paints your face on a wall."),
      "gate:third": _Move(after: {'decide'}, to: 'done', wait: 45, rep: [("social", "wyrd", 15), ("faction", "waterfront", 10), ("faction", "nurtw", 8), ("faction", "faith", 8), ("faction", "atlantic", 4)],
          say: "Canoes, danfos, drones and church halls, all night. Both gates half-open; every family moved in time. Nobody is fully safe; nobody is left behind. \"I did not know this was possible,\" WYRD says. \"Now I do.\""),
      "gate:assembly": _Move(after: {'decide'}, to: 'done', wait: 40, rep: [("faction", "youth", 15), ("social", "wyrd", 10), ("faction", "state", -6)],
          say: "Five hundred Lagosians, chosen by lot, argue for four hours and vote. Whatever they chose, they chose together — and the city will live with it together."),
    },
  };

  /// Takes one step in a mission for this citizen. Returns {ok, say, story, naira} or {error}.
  // ---- the city answers (bible Part 1 §2): nine variables per district, 0-100 ----

  static const cityVars = ['wealth', 'flooding', 'crime', 'trust', 'energy', 'displacement', 'pollution', 'transport', 'culture'];
  static const _varNames = {
    'wealth': 'Wealth', 'flooding': 'Flood risk', 'crime': 'Crime', 'trust': 'Public trust', 'energy': 'Energy access',
    'displacement': 'Displacement', 'pollution': 'Pollution', 'transport': 'Transport', 'culture': 'Cultural vitality',
  };

  /// Each district's resting state: what it drifts back to unless the player keeps pushing.
  static const _baseline = <String, Map<String, int>>{
    'Lagos Island': {'wealth': 60, 'flooding': 45, 'crime': 45, 'trust': 45, 'energy': 50, 'displacement': 40, 'pollution': 60, 'transport': 30, 'culture': 75},
    'Victoria Island': {'wealth': 85, 'flooding': 40, 'crime': 25, 'trust': 50, 'energy': 75, 'displacement': 35, 'pollution': 35, 'transport': 45, 'culture': 65},
    'Ikoyi': {'wealth': 90, 'flooding': 30, 'crime': 15, 'trust': 45, 'energy': 85, 'displacement': 30, 'pollution': 25, 'transport': 55, 'culture': 50},
    'Eko Atlantic': {'wealth': 95, 'flooding': 35, 'crime': 10, 'trust': 40, 'energy': 95, 'displacement': 20, 'pollution': 15, 'transport': 70, 'culture': 35},
    'Lekki': {'wealth': 75, 'flooding': 65, 'crime': 30, 'trust': 45, 'energy': 65, 'displacement': 45, 'pollution': 35, 'transport': 35, 'culture': 50},
    'Makoko': {'wealth': 20, 'flooding': 75, 'crime': 40, 'trust': 55, 'energy': 20, 'displacement': 70, 'pollution': 65, 'transport': 35, 'culture': 70},
    'Surulere': {'wealth': 50, 'flooding': 45, 'crime': 45, 'trust': 50, 'energy': 40, 'displacement': 35, 'pollution': 50, 'transport': 40, 'culture': 75},
    'Yaba': {'wealth': 55, 'flooding': 40, 'crime': 35, 'trust': 55, 'energy': 50, 'displacement': 40, 'pollution': 45, 'transport': 45, 'culture': 70},
    'Mushin': {'wealth': 30, 'flooding': 55, 'crime': 60, 'trust': 40, 'energy': 30, 'displacement': 40, 'pollution': 70, 'transport': 30, 'culture': 60},
  };
  static Map<String, int> _base(String d) => _baseline[d] ?? const {'wealth': 45, 'flooding': 45, 'crime': 45, 'trust': 50, 'energy': 45, 'displacement': 40, 'pollution': 50, 'transport': 40, 'culture': 55};

  /// What each ending does to the city: (district, variable, change). No single move shifts a variable more than 15.
  static const _cityEffects = <String, List<(String, String, int)>>{
    'tomato:sell:fair': [('Lagos Island', 'wealth', 5), ('Lagos Island', 'trust', 5)],
    'tomato:sell:hold': [('Lagos Island', 'wealth', 2), ('Lagos Island', 'trust', -6)],
    'gridlock:fix:wyrd': [('Ojuelegba', 'transport', 8), ('Ojuelegba', 'trust', 4)],
    't31:expose:wyrd': [('Mushin', 'trust', 8)],
    't31:expose:press': [('Mushin', 'trust', 6), ('Mushin', 'culture', 2)],
    't31:expose:riders': [('Mushin', 'trust', 8), ('Mushin', 'transport', 3)],
    'gridlock:fix:hack': [('Ojuelegba', 'transport', 8), ('Ojuelegba', 'crime', 2)],
    'gridlock:fix:area': [('Ojuelegba', 'transport', 5), ('Ojuelegba', 'crime', 3)],
    'school:arrive': [('Makoko', 'culture', 5), ('Makoko', 'trust', 6)],
    'masters:how:crowd': [('Surulere', 'culture', 8)],
    'masters:proof': [('Surulere', 'culture', 10)],
    'masters:how:conscience': [('Surulere', 'culture', 6)],
    'water:tell:faith': [('Mushin', 'pollution', -8), ('Mushin', 'trust', 5)],
    'water:tell:online': [('Mushin', 'pollution', -8), ('Mushin', 'trust', -3)],
    'water:tell:private': [('Mushin', 'pollution', -6), ('Mushin', 'trust', 2)],
    'generator:fix:schedule': [('Surulere', 'energy', 3)],
    'generator:fix:solar': [('Surulere', 'energy', 12), ('Surulere', 'pollution', -4)],
    'generator:fix:grid': [('Surulere', 'energy', 8)],
    'owambe:fix:rival': [('Victoria Island', 'culture', 4)],
    'owambe:fix:indoors': [('Victoria Island', 'culture', 3)],
    'owambe:fix:rain': [('Victoria Island', 'culture', 8)],
    'seawall:fix:atlantic': [('Eko Atlantic', 'flooding', -10)],
    'seawall:fix:press': [('Eko Atlantic', 'flooding', -10), ('Eko Atlantic', 'trust', -4)],
    'seawall:divers': [('Eko Atlantic', 'flooding', -10), ('Makoko', 'trust', 5)],
    'union:vote:campaign': [('Obalende', 'transport', 6), ('Obalende', 'trust', 6)],
    'union:vote:deal': [('Obalende', 'crime', -3)],
    'union:vote:expose': [('Obalende', 'trust', 8), ('Obalende', 'crime', 2)],
    'phone:phone:return': [('Makoko', 'displacement', 12)],
    'phone:phone:leak': [('Makoko', 'displacement', -10), ('Makoko', 'trust', 6)],
    'phone:phone:sell': [('Makoko', 'displacement', 15)],
    'eyo:eyo:palace': [('Lagos Island', 'culture', 10)],
    'eyo:eyo:wyrd': [('Lagos Island', 'culture', 6), ('Lagos Island', 'transport', 4)],
    'eyo:eyo:youth': [('Lagos Island', 'culture', 8), ('Lagos Island', 'crime', -4)],
    'container:cargo:return': [('Apapa', 'trust', 6), ('Apapa', 'crime', -4)],
    'container:cargo:whistle': [('Apapa', 'trust', 8), ('Apapa', 'crime', -6)],
    'container:cargo:sell': [('Apapa', 'crime', 8), ('Apapa', 'trust', -8)],
    'startup:buy:refuse': [('Makoko', 'transport', 6), ('Yaba', 'wealth', 5)],
    'startup:buy:protect': [('Makoko', 'transport', 4)],
    'startup:buy:sell': [('Makoko', 'transport', -4), ('Makoko', 'displacement', 4)],
    'goat:goat:gossip': [('Festac', 'trust', 5), ('Festac', 'culture', 3)],
    'goat:goat:trade': [('Festac', 'crime', 4)],
    'goat:goat:trap': [('Festac', 'crime', -6)],
    'flood:flood:boats': [('Lekki', 'flooding', -4), ('Makoko', 'trust', 4)],
    'flood:flood:gates': [('Lekki', 'flooding', -12), ('Makoko', 'flooding', 15), ('Makoko', 'displacement', 8)],
    'flood:flood:drains': [('Lekki', 'flooding', -10), ('Lekki', 'pollution', -4)],
    'leak:leak:publish': [('Ikoyi', 'trust', -6)],
    'leak:leak:wyrd': [('Ikoyi', 'trust', 4)],
    'leak:leak:blackmail': [('Ikoyi', 'crime', 4)],
    'peppersoup:soup:meal': [('Mushin', 'crime', -8), ('Mushin', 'pollution', -4)],
    'peppersoup:soup:prove': [('Mushin', 'pollution', -12)],
    'peppersoup:soup:split': [('Mushin', 'crime', -4)],
    'ghostbus:ghost:investigate': [('Ebute-Metta', 'trust', 4)],
    'ghostbus:ghost:hack': [('Ebute-Metta', 'transport', 6), ('Ebute-Metta', 'crime', 2)],
    'ghostbus:ghost:wyrd': [('Ebute-Metta', 'transport', -3), ('Ebute-Metta', 'crime', -4)],
    'grandma:records': [('Ebute-Metta', 'displacement', -10), ('Ebute-Metta', 'culture', 4)],
    'grandma:land:court': [('Ebute-Metta', 'displacement', -6)],
    'grandma:land:talk': [('Ebute-Metta', 'displacement', -8), ('Ebute-Metta', 'trust', 6)],
    'matchday:match:var': [('Surulere', 'crime', -8), ('Surulere', 'trust', 6)],
    'matchday:match:legend': [('Surulere', 'crime', -8), ('Surulere', 'culture', 6)],
    'matchday:match:wyrd': [('Surulere', 'crime', -6), ('Surulere', 'transport', 3)],
    'japa:japa:job': [('Yaba', 'wealth', 3)],
    'japa:japa:scholarship': [('Yaba', 'culture', 2)],
    'dronestrike:drone:support': [('Ikeja', 'transport', -4), ('Ikeja', 'trust', 4)],
    'dronestrike:drone:cross': [('Ikeja', 'trust', -6)],
    'dronestrike:drone:negotiate': [('Ikeja', 'transport', 4), ('Ikeja', 'trust', 4)],
    'voices:voices:elders': [('Badagry Road', 'culture', 12)],
    'voices:voices:crowd': [('Badagry Road', 'culture', 8)],
    'voices:voices:museum': [('Badagry Road', 'culture', 10)],
    'bankrun:bank:ajo': [('Lagos Island', 'trust', 8), ('Lagos Island', 'wealth', 4)],
    'bankrun:bank:trace': [('Lagos Island', 'crime', -6)],
    'bankrun:bank:peace': [('Lagos Island', 'trust', 6), ('Lagos Island', 'crime', -4)],
    'finale:gate:atlantic': [('Eko Atlantic', 'flooding', -15), ('Makoko', 'flooding', 15), ('Makoko', 'displacement', 15)],
    'finale:gate:makoko': [('Makoko', 'flooding', -15), ('Eko Atlantic', 'flooding', 15), ('Eko Atlantic', 'wealth', -10)],
    'finale:gate:third': [('Makoko', 'flooding', -8), ('Eko Atlantic', 'flooding', -8), ('Makoko', 'trust', 10)],
    'finale:gate:assembly': [('Makoko', 'trust', 8), ('Eko Atlantic', 'trust', 8), ('Makoko', 'flooding', -5)],
  };

  /// Whom each mission puts you in front of; they remember how it ended (bible Part 2 §5).
  static const _people = {
    'tomato': 'Iya Rofiat', 'gridlock': 'Officer Ngozi', 'school': 'Mr Ayọ̀', 'masters': 'Baba Tunde', 'water': 'Sister Grace',
    'generator': 'Mrs Lawal', 't31': 'Rasheed', 'owambe': 'Mama Tolu', 'seawall': 'Engr. Hauwa', 'union': 'Mama Kemi', 'phone': 'Musa',
    'eyo': "The Ìdẹ̀jọ chief's aide", 'container': 'Dr Bello', 'startup': 'Chidinma', 'goat': 'Malam Sani', 'flood': 'Tunde',
    'leak': 'Mustapha', 'peppersoup': 'Mama Ireti', 'ghostbus': 'Sule', 'grandma': 'Grandma Adunni', 'matchday': 'Coach Emeka',
    'japa': 'Tobi', 'dronestrike': 'Ifeoma', 'voices': 'Mrs Hunpatin', 'bankrun': 'Mr Coker', 'finale': 'WYRD',
  };
  /// Endings the person you helped did not like (default: they're grateful, +8).
  static const _trust = {
    'tomato:sell:hold': -10, 'phone:phone:return': -4, 'phone:phone:sell': -8, 'container:cargo:sell': -20, 'startup:buy:sell': -6,
    'leak:leak:blackmail': -10, 'dronestrike:drone:cross': -15, 'flood:flood:gates': 2, 'goat:goat:trade': 4, 'peppersoup:soup:split': 4,
    'finale:gate:atlantic': -5, 'finale:gate:makoko': 0,
  };

  static Map<String, dynamic> _cityNow(Map<String, dynamic> s) {
    // drift back toward each district's baseline: two points a day, for each day since last looked
    final city = (s['city'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    final at = s['cityAt'] == null ? null : DateTime.tryParse(s['cityAt'] as String);
    final days = at == null ? 0 : DateTime.now().toUtc().difference(at).inHours / 24;
    final drift = (days * 2).floor();
    if (drift > 0) {
      for (final d in city.keys) {
        final v = (city[d] as Map).cast<String, dynamic>(), b = _base(d);
        for (final k in v.keys.toList()) {
          final cur = (v[k] as num).toInt(), base = b[k] ?? 50;
          v[k] = cur > base ? (cur - drift).clamp(base, 100) : (cur + drift).clamp(0, base);
        }
        city[d] = v;
      }
      s['cityAt'] = DateTime.now().toUtc().toIso8601String();
    }
    s['city'] = city;
    return city;
  }

  /// Applies an ending to the city and the people in it; returns WYRD's bulletin about it, if any.
  static String? _consequences(Map<String, dynamic> s, String mission, String move) {
    final key = '$mission:$move';
    final city = _cityNow(s);
    s['cityAt'] ??= DateTime.now().toUtc().toIso8601String();
    final news = <String>[];
    for (final (d, k, delta) in _cityEffects[key] ?? const <(String, String, int)>[]) {
      final v = (city[d] as Map?)?.cast<String, dynamic>() ?? {for (final e in _base(d).entries) e.key: e.value};
      v[k] = ((v[k] as num? ?? 50) + delta.clamp(-15, 15)).clamp(0, 100).toInt();
      city[d] = v;
      final better = (k == 'flooding' || k == 'crime' || k == 'displacement' || k == 'pollution') ? delta < 0 : delta > 0;
      news.add('${_varNames[k]} in $d is ${delta > 0 ? 'rising' : 'falling'}${better ? '' : ' — not the good kind of news'}');
    }
    final who = _people[mission];
    if (who != null) {
      final people = (s['people'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
      final p = (people[who] as Map?)?.cast<String, dynamic>() ?? {'trust': 0, 'notes': <dynamic>[]};
      final t = _trust[key] ?? 8;
      p['trust'] = ((p['trust'] as num) + t).clamp(-100, 100).toInt();
      final _Move? m = _moves[mission]?[move];
      final notes = (p['notes'] as List)..add({'at': DateTime.now().toUtc().toIso8601String(), 'what': m?.say ?? move, 'felt': t > 0 ? 'grateful' : t < 0 ? 'betrayed' : 'unsure'});
      if (notes.length > 6) notes.removeRange(0, notes.length - 6);
      people[who] = p;
      s['people'] = people;
    }
    // on the live wire, for everyone in the city
    final helper = who == null ? 'a citizen' : '$who and a citizen';
    CityWire.say('deed', news.isEmpty ? 'Word from the streets: $helper just settled things. The city noticed.' : 'Word from the streets: $helper just settled things. ${news.first}.');
    if (news.isEmpty) return null;
    final bulletin = 'WYRD city bulletin: ${news.join('. ')}.';
    final b = ((s['bulletins'] as List?) ?? <dynamic>[])..add({'at': DateTime.now().toUtc().toIso8601String(), 'text': bulletin});
    if (b.length > 12) b.removeRange(0, b.length - 12);
    s['bulletins'] = b;
    return bulletin;
  }

  // ---- who you were, and what you do (bible Part 2 §1-2) ----

  static const backgrounds = <String, (String, String)>{
    'conductor': ("Danfo conductor's child", 'Ojuelegba. Street and talk; the unions know your family.'),
    'returnee': ('Returnee from abroad', 'Savings in foreign money, rusty Pidgin; everyone overcharges you at first.'),
    'makoko': ("Makoko fisher's child", 'On the water at 4am. The Waterfront Alliance is family.'),
    'coder': ('Yaba coding dropout', 'A broken laptop, a half-finished app, and the Yaba crowd.'),
    'heir': ('Ikoyi heir with a problem', 'Money is easy; trust is not. The family business is under investigation.'),
    'nurse': ('Nurse from Ibadan', 'Newly posted to a Surulere clinic. Patients from every class know your face.'),
  };
  static const _backgroundStart = <String, (int, List<(String, String, int)>)>{
    'conductor': (0, [('faction', 'nurtw', 10), ('social', 'street', 8), ('district', 'Ojuelegba', 10)]),
    'returnee': (15000, [('social', 'elite', 4), ('social', 'street', -5), ('social', 'family', 4)]),
    'makoko': (0, [('faction', 'waterfront', 12), ('district', 'Makoko', 12)]),
    'coder': (0, [('faction', 'yaba', 12), ('district', 'Yaba', 8)]),
    'heir': (30000, [('social', 'elite', 12), ('social', 'street', -8), ('district', 'Ikoyi', 6)]),
    'nurse': (0, [('social', 'family', 6), ('district', 'Surulere', 8), ('social', 'police', 4)]),
  };

  /// The fourteen careers: id -> (name, the job it's paid more for, or null).
  static const careers = <String, (String, String?)>{
    'danfo': ('Danfo driver', 'danfo'), 'trader': ('Market trader', null), 'rider': ('Delivery rider', 'delivery'),
    'mechanic': ('Mechanic', null), 'coder': ('Software builder', null), 'events': ('Event producer', null),
    'musician': ('Musician', null), 'fisher': ('Fisher', null), 'medic': ('Nurse / medic', 'chase'),
    'journalist': ('Journalist', null), 'clearing': ('Clearing agent', null), 'fixer': ('Fixer', null),
    'fuel': ('Fuel trader', null), 'hacker': ('Hacker for hire', null),
  };
  static const careerStages = ['Starting out', 'Own equipment', 'A crew', 'Your own business'];
  static int careerStage(int xp) => xp >= 60 ? 3 : xp >= 30 ? 2 : xp >= 10 ? 1 : 0;

  /// A job finished: experience for the career, and the bonus it earns on the right kind of work.
  static (int, String?) careerBonus(WorldCitizen c, String jobType, int pay) {
    final s = read(c);
    final id = s['career'] as String?;
    if (id == null) return (0, null);
    final match = careers[id]?.$2 == jobType;
    s['careerXp'] = ((s['careerXp'] as num? ?? 0) + (match ? 2 : 1)).toInt();
    return (match ? (pay * (0.25 + 0.1 * careerStage((s['careerXp'] as num).toInt()))).round() : 0, jsonEncode(s));
  }

  static Future<String> _life(Session session, UuidValue user, String move) async {
    var c = await WalletService.settle(session, user);
    final s = read(c);
    var start0 = 0;
    String say;
    if (move.startsWith('background:')) {
      final id = move.substring(11);
      final start = _backgroundStart[id];
      if (start == null) return jsonEncode({'error': 'Nobody in Lagos starts like that.'});
      if (s['background'] != null) return jsonEncode({'error': 'You only get to be born once.'});
      s['background'] = id;
      start0 = start.$1;
      for (final (g, k, d) in start.$2) _rep(s, g, k, d);
      say = 'You are a ${backgrounds[id]!.$1.toLowerCase()}. Lagos already knows a little of who you are.';
    } else if (move.startsWith('career:')) {
      final id = move.substring(7);
      if (!careers.containsKey(id)) return jsonEncode({'error': 'That is not a hustle in this city.'});
      if (s['career'] == id) return jsonEncode({'error': 'You already do that.'});
      final since = s['careerAt'] == null ? 1e9 : DateTime.now().toUtc().difference(DateTime.parse(s['careerAt'] as String)).inMinutes;
      if (since < 10) return jsonEncode({'error': 'Give it a chance first -- change again in a few minutes.'});
      s['career'] = id;
      s['careerXp'] = 0;
      s['careerAt'] = DateTime.now().toUtc().toIso8601String();
      say = 'New hustle: ${careers[id]!.$1}. Start small, own your tools, build a crew.';
    } else {
      return jsonEncode({'error': 'That is not something you can do here.'});
    }
    _remember(s, 'life: $move');
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(story: jsonEncode(s), updatedAt: DateTime.now().toUtc()));
    var naira = c.naira;
    if (start0 > 0) {
      final r = await Bank.post(session, user, key: 'life:background:${user.uuid}', amount: start0, kind: 'story', counter: 'city:treasury',
          memo: 'Starting money: ${backgrounds[s['background']]?.$1 ?? 'your background'}');
      naira = r.balance;
    }
    return jsonEncode({'ok': true, 'say': say, 'naira': naira, 'story': _view(read(c))});
  }

  /// The story as the app sees it, with the city's state worked out for now.
  static Map<String, dynamic> _view(Map<String, dynamic> s) {
    final city = _cityNow(s);
    final stage = s['career'] == null ? null : careerStages[careerStage((s['careerXp'] as num? ?? 0).toInt())];
    return {...s, 'city': city, 'careerStage': stage};
  }

  static Future<String> act(Session session, UuidValue user, String mission, String move) async {
    if (mission == 'life') return _life(session, user, move);
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
    // this step's money, once (the step's own time is in the key: a retry finds it, the next step is new)
    final stepKey = 'story:$mission:$move:${user.uuid}:${state['at'] ?? 'start'}';
    if (m.cost > 0) {
      final r = await Bank.post(session, user, key: '$stepKey:cost', amount: -m.cost, kind: 'story', counter: 'city:market', memo: 'Story: $mission');
      if (!r.ok) return jsonEncode({'error': 'Not enough naira -- you need ₦${m.cost}.'});
      if (r.repeat) return jsonEncode({'error': 'Already done.'});
    }
    for (final (g, k, d) in m.rep) _rep(s, g, k, d);
    missions[mission] = {...state, 'step': m.to, 'at': DateTime.now().toUtc().toIso8601String(), 'moves': [...(state['moves'] as List? ?? []), move]};
    String? bulletin;
    if (m.to == 'done') { _remember(s, '$mission: $move'); bulletin = _consequences(s, mission, move); }
    if (m.pay > 0) await Bank.post(session, user, key: '$stepKey:pay', amount: m.pay, kind: 'story', counter: 'city:treasury', memo: 'Story: $mission');
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(
      story: jsonEncode(s),
      missionsDone: c.missionsDone + (m.to == 'done' ? 1 : 0),
      updatedAt: DateTime.now().toUtc(),
    ));
    var say = m.say;
    if (mission == 't31' && m.to == 'done') {
      final (drivers, back) = await PoliceService.fixUnit(session, 'T-31', move);
      if (back > 0) say = '$say Every citation T-31 issued is cancelled: $drivers driver${drivers == 1 ? '' : 's'} refunded, ₦$back in all.';
    }
    return jsonEncode({'ok': true, 'say': say, 'step': m.to, 'naira': c.naira, 'paid': m.pay, 'cost': m.cost, 'bulletin': bulletin, 'story': _view(read(c))});
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
