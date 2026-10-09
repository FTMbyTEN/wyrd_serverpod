import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import 'city_design_service.dart';
import 'world_stats.dart';

/// WYRD's live wire to everyone in NAIJA 2099: what happens in the city, as it happens, for every player at once.
///
/// - deeds: a citizen settles a story mission somewhere, and the city changes (from StoryService);
/// - events: a live city event (an approved design event) starting, with its broadcast;
/// - pulses: WYRD checking in every few minutes -- the hour in Lagos, how many are on the streets, a line about the city.
///
/// The game asks for what's new every 20 s ([since]). Kept in memory (the last 60): the wire is about now, not history.
/// No AI is called: the lines are put together from what the city knows.
class CityWire {
  static final _items = <Map<String, Object>>[];
  static int _next = 1;
  static DateTime _lastPulse = DateTime.fromMillisecondsSinceEpoch(0);
  static final _announced = <String>{};
  static final _rnd = Random();

  static void say(String kind, String text) {
    _items.add({'id': _next++, 'at': DateTime.now().toUtc().toIso8601String(), 'kind': kind, 'text': text});
    if (_items.length > 60) _items.removeRange(0, _items.length - 60);
  }

  /// What's new since [since] (an item id; 0 for the latest few), and how many are on the streets, as JSON.
  static Future<String> since(Session session, int since) async {
    await _pulse(session);
    final fresh = since <= 0 ? _items.sublist(max(0, _items.length - 5)) : _items.where((i) => (i['id'] as int) > since).toList();
    return jsonEncode({'items': fresh, 'online': WorldStats.online(), 'last': _items.isEmpty ? 0 : _items.last['id']});
  }

  static const _morning = [
    'Lagos is waking up. Third Mainland is already full of opinions.',
    'Danfos are calling their routes. The city clears its throat.',
    'Fresh bread at the bus stops, fresh traffic on Ikorodu Road.',
  ];
  static const _day = [
    'Balogun is loud, Idumota is louder. Business is good.',
    'The sun is working overtime. So are the okadas.',
    'Somewhere in Yaba a startup just pivoted. Twice.',
  ];
  static const _evening = [
    'The go-slow home has begun. Patience is a Lagos sport.',
    'Suya smoke over Surulere. The city smells like evening.',
    'The lagoon is turning gold. Even the traffic looks good from the bridge.',
  ];
  static const _night = [
    'Night in Lagos: the neon is on, the generators are humming, the city does not sleep.',
    'Victoria Island after dark — every rooftop a party, every street a story.',
    'Quiet hour on the Marina. I keep watch while the city dreams.',
  ];

  /// WYRD checking in (every ~4 min, when someone is listening), and any live city event starting this hour.
  static Future<void> _pulse(Session session) async {
    final now = DateTime.now().toUtc();
    if (now.difference(_lastPulse) < const Duration(minutes: 4)) return;
    _lastPulse = now;
    final lagos = now.add(const Duration(hours: 1));
    final h = lagos.hour;
    final pool = h >= 5 && h < 10 ? _morning : h >= 10 && h < 17 ? _day : h >= 17 && h < 21 ? _evening : _night;
    final online = WorldStats.online();
    final clock = '${h.toString().padLeft(2, '0')}:${lagos.minute.toString().padLeft(2, '0')}';
    final people = online <= 1 ? 'You have the streets to yourself' : '$online citizens on the streets';
    say('pulse', '$clock in Lagos. $people. ${pool[_rnd.nextInt(pool.length)]}');
    try {
      final events = ((await CityDesignService.live(session))['events'] as List).cast<Map<String, dynamic>>();
      for (final e in events) {
        final s = (e['startHour'] as num?)?.toInt(), end = (e['endHour'] as num?)?.toInt();
        if (s == null || end == null) continue;
        final on = s <= end ? h >= s && h < end : h >= s || h < end;
        final key = '${e['title']}|${lagos.year}-${lagos.month}-${lagos.day}';
        if (on && !_announced.contains(key)) {
          _announced.add(key);
          say('event', (e['broadcast'] as String?)?.trim().isNotEmpty == true ? e['broadcast'] as String : 'Happening now: ${e['title']}.');
        }
      }
      if (_announced.length > 200) _announced.clear();
    } catch (_) {}
  }
}
