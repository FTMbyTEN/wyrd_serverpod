import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'wallet_service.dart';

/// One thing you can do at a place: what it costs (negative) or pays (positive), the health it gives
/// back, the standing it earns, and how long before you can do it again.
class Activity {
  final String id, label, done;
  final int naira, heal, standing;
  final Duration again;
  const Activity(this.id, this.label, this.done, {this.naira = 0, this.heal = 0, this.standing = 0, this.again = const Duration(minutes: 1)});
  Map<String, dynamic> toJson() => {'id': id, 'label': label, 'naira': naira, 'heal': heal, 'standing': standing, 'againS': again.inSeconds};
}

/// Places you can walk into. Every tagged place in the city (food spots, markets, clubs, banks,
/// churches, the National Theatre...) offers a few things to do; the server sets what they cost or
/// pay and how often, and changes the wallet and standing. Health is given back on the player's side.
class PlaceService {
  static const _m = Duration(minutes: 1);
  static const activities = <String, List<Activity>>{
    'food': [
      Activity('amala', 'Eat amala and ewedu', 'You eat. The amala is hot, the ewedu slides. Full belly.', naira: -500, heal: 40),
      Activity('suya', 'Buy suya for the road', 'Spicy, smoky. You keep walking.', naira: -300, heal: 15),
    ],
    'bar': [Activity('drink', 'Have a cold drink', 'Ice cold. The DJ plays something you know.', naira: -800, heal: 10)],
    'club': [Activity('night', 'Night out', 'Lights, bass, the whole of Lagos in one room. People know your face now.', naira: -3000, standing: 2, again: Duration(minutes: 30))],
    'market': [
      Activity('stall', 'Work a stall shift', 'You call out prices till your voice goes. Mama pays you fairly.', naira: 1200, again: Duration(minutes: 5)),
      Activity('foodstuff', 'Buy foodstuff', 'Pepper, tomato, rice. Home will smell good.', naira: -400, heal: 20),
    ],
    'mall': [Activity('shop', 'Go shopping', 'New shoes. Lagos notices.', naira: -2000, standing: 1, again: Duration(minutes: 20))],
    'bank': [Activity('teller', 'Cover a shift at the counter', 'Queues, forms, cash. The manager nods at you.', naira: 2000, again: Duration(minutes: 10))],
    'hospital': [Activity('treat', 'Get treated', 'A nurse patches you up. Good as new.', naira: -1500, heal: 100)],
    'church': [Activity('pray', 'Pray', 'Quiet. The choir is rehearsing. You leave lighter.', standing: 1, again: Duration(minutes: 30))],
    'mosque': [Activity('pray', 'Pray', 'Quiet. You leave lighter.', standing: 1, again: Duration(minutes: 30))],
    'hotel': [Activity('sleep', 'Rest the night', 'Clean sheets, cold AC. You wake new.', naira: -5000, heal: 100, again: Duration(minutes: 10))],
    'factory': [Activity('shift', 'Work a factory shift', 'Hot, loud, honest work. You get paid.', naira: 2500, again: Duration(minutes: 10))],
    'fuel': [Activity('fuel', 'Fill up the hover-car', 'Tank full. Price don go up again.', naira: -1000)],
    'gov': [
      Activity('tax', 'Pay your city levy', 'Receipt stamped. The Authority notes it.', naira: -1000, standing: 3, again: Duration(hours: 1)),
    ],
    'police': [Activity('report', 'Report what you saw', 'The desk officer writes it down. Slowly.', standing: 1, again: Duration(minutes: 30))],
    'fire': [Activity('volunteer', 'Volunteer a shift', 'You drill with the crew. They remember you.', standing: 2, again: Duration(hours: 1))],
    'school': [Activity('class', 'Sit in on a lecture', 'You learn something. Standing goes up.', naira: -1000, standing: 1, again: Duration(minutes: 30))],
    'landmark': [Activity('visit', 'Take it in', 'You stand and look. This is Lagos.', standing: 1, again: Duration(hours: 1))],
  };

  // when each player last did each activity (in memory: a restart forgives you)
  static final Map<String, DateTime> _last = {};

  static String list(String kind) => jsonEncode([for (final a in activities[kind] ?? const <Activity>[]) a.toJson()]);

  static Future<String> visit(Session session, UuidValue user, String kind, String id, String place) async {
    final a = (activities[kind] ?? const <Activity>[]).where((x) => x.id == id).firstOrNull;
    if (a == null) return jsonEncode({'error': "You can't do that here."});
    final key = '${user.uuid}/$kind/$id', now = DateTime.now().toUtc();
    final last = _last[key];
    if (last != null && now.difference(last) < a.again) {
      final wait = a.again - now.difference(last);
      return jsonEncode({'error': 'Not yet -- come back in ${wait.inMinutes >= 1 ? '${wait.inMinutes} min' : '${wait.inSeconds} s'}.'});
    }
    var c = await WalletService.settle(session, user);
    if (a.naira < 0 && c.naira < -a.naira) return jsonEncode({'error': "You can't afford it (₦${-a.naira})."});
    c = await WorldCitizen.db.updateRow(session, c.copyWith(
      naira: c.naira + a.naira, standing: (c.standing + a.standing).clamp(-100, 100), updatedAt: now));
    _last[key] = now;
    final w = jsonDecode(await WalletService.wallet(session, user)) as Map<String, dynamic>;
    return jsonEncode({...w, 'text': a.done, 'delta': a.naira, 'heal': a.heal, 'standing': c.standing, 'place': place});
  }
}
