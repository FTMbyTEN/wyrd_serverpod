import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'city_design_service.dart';
import 'world_stats.dart';

/// WYRD's live wire to everyone in NAIJA 2099: what is actually happening in the city, as it happens, for every
/// player at once. Nothing on it is made up or scripted:
///
/// - happenings: what players' games saw on the roads, from the anonymous tallies of those who agreed to teach
///   WYRD (CitySignals) -- a crash on a street, a red light run at a junction, a police stop, a chase lost, a jam
///   building, a WYRD flight -- named by the street, never by the player. The same thing on the same street within
///   15 minutes is one item, counted up ("3 crashes on Ikorodu Road in the last 15 minutes"), not a repeat;
/// - deeds: a citizen settles a story mission somewhere, and the city changes (from StoryService);
/// - people: someone new on the streets;
/// - events: a live city event (an approved design event) starting, with its broadcast;
/// - the hour: at the top of each hour, what the last hour actually held, from the tallies.
///
/// The game asks for what's new every 20 s ([since]). Kept in memory (the last 60): the wire is about now, not
/// history. No AI is called: every line is put together from what the city recorded.
class CityWire {
  static final _items = <Map<String, Object>>[];
  static int _next = 1;
  static int _lastHour = -1;
  static int _lastOnline = 0;
  static DateTime _lastPeople = DateTime.fromMillisecondsSinceEpoch(0);
  static final _announced = <String>{};
  /// recent happenings by kind|place: when the run started and how many so far (to merge, not repeat)
  static final _runs = <String, (DateTime, int)>{};

  static void say(String kind, String text) {
    // never the same line twice among the recent items
    if (_items.reversed.take(12).any((i) => i['text'] == text)) return;
    _items.add({'id': _next++, 'at': DateTime.now().toUtc().toIso8601String(), 'kind': kind, 'text': text});
    if (_items.length > 60) _items.removeRange(0, _items.length - 60);
  }

  /// What's new since [since] (an item id; 0 for the latest few), and how many are on the streets, as JSON.
  static Future<String> since(Session session, int since) async {
    await _tick(session);
    final fresh = since <= 0 ? _items.sublist(max(0, _items.length - 5)) : _items.where((i) => (i['id'] as int) > since).toList();
    return jsonEncode({'items': fresh, 'online': WorldStats.online(), 'last': _items.isEmpty ? 0 : _items.last['id']});
  }

  /// Something a player's game saw (anonymous: a kind, a named place, how many, a quantity). From CitySignals.
  static void happened(String kind, String place, int n, double v) {
    final line = _line(kind, place, n, v);
    if (line == null) return;
    final now = DateTime.now().toUtc(), key = '$kind|$place';
    final run = _runs[key];
    if (run != null && now.difference(run.$1) < const Duration(minutes: 15)) {
      // the same again: counted into the run, and said again only as it grows (3, 5, 10, 20...)
      final total = run.$2 + n;
      _runs[key] = (run.$1, total);
      final mark = [3, 5, 10, 20, 50].where((m) => run.$2 < m && total >= m).firstOrNull;
      final plural = _plural(kind, total, place);
      if (mark != null && plural != null) say('happening', plural);
      return;
    }
    _runs[key] = (now, n);
    if (_runs.length > 400) _runs.removeWhere((_, r) => now.difference(r.$1) > const Duration(minutes: 15));
    say('happening', n > 1 ? (_plural(kind, n, place) ?? line) : line);
  }

  static String? _line(String kind, String place, int n, double v) => switch (kind) {
        'crash' => 'Crash on $place.',
        'redlight' => 'Red light run at $place — a WYRD unit logged it.',
        'speeding' => 'Speeding on $place: ${(v / max(1, n)).round()} km/h logged.',
        'caught' => 'Police stop near $place. The driver was pulled over.',
        'lost' => 'A patrol lost a car near $place. WYRD\'s units are still watching.',
        'queue' => v / max(1, n) >= 5 ? 'Traffic building at $place: ${(v / max(1, n)).round()} cars waiting.' : null,
        'ride' => 'WYRD Ride heading for $place.',
        'air' => 'WYRD Air flight bound for $place.',
        _ => null, // (calls and light switches stay off the wire)
      };

  static String? _plural(String kind, int n, String place) => switch (kind) {
        'crash' => '$n crashes on $place in the last 15 minutes. Drive with sense.',
        'redlight' => '$n red lights run at $place in the last 15 minutes.',
        'speeding' => '$n cars caught speeding on $place in the last 15 minutes.',
        'caught' => '$n police stops near $place in the last 15 minutes.',
        'lost' => '$n chases lost near $place in the last 15 minutes.',
        'queue' => '$place keeps jamming: $n queues in the last 15 minutes.',
        'ride' => '$n WYRD Rides heading for $place in the last 15 minutes.',
        'air' => '$n WYRD Air flights bound for $place in the last 15 minutes.',
        _ => null,
      };

  /// Each time the wire is asked: new people on the streets, the hour's round-up, and live city events.
  static Future<void> _tick(Session session) async {
    final now = DateTime.now().toUtc();
    final lagos = now.add(const Duration(hours: 1));
    final online = WorldStats.online();
    // someone new on the streets (at most every 5 min)
    if (online > _lastOnline && _lastOnline > 0 && now.difference(_lastPeople) > const Duration(minutes: 5)) {
      _lastPeople = now;
      say('people', online == 2 ? 'Someone else is on the streets now. 2 citizens out.' : 'More people out: $online citizens on the streets now.');
    }
    _lastOnline = online;
    // the top of the hour: what the last hour actually held
    if (lagos.hour != _lastHour) {
      final first = _lastHour == -1;
      _lastHour = lagos.hour;
      if (!first) await _hour(session, now, lagos, online);
    }
    try {
      final events = ((await CityDesignService.live(session))['events'] as List).cast<Map<String, dynamic>>();
      final h = lagos.hour;
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

  static Future<void> _hour(Session session, DateTime now, DateTime lagos, int online) async {
    final from = DateTime.utc(now.year, now.month, now.day, now.hour).subtract(const Duration(hours: 1));
    final rows = await CitySignal.db.find(session, where: (t) => t.hour.equals(from));
    final count = <String, int>{}, top = <String, (String, int)>{};
    for (final r in rows) {
      count[r.kind] = (count[r.kind] ?? 0) + r.times;
      if ((top[r.kind]?.$2 ?? 0) < r.times) top[r.kind] = (r.place, r.times);
    }
    final parts = <String>[];
    void add(String kind, String one, String many) {
      final n = count[kind] ?? 0;
      if (n == 0) return;
      final where = top[kind]!.$1;
      parts.add(n == 1 ? '$one ($where)' : '$n $many (most at $where)');
    }
    add('crash', '1 crash', 'crashes');
    add('redlight', '1 red light run', 'red lights run');
    add('caught', '1 police stop', 'police stops');
    add('lost', '1 chase lost', 'chases lost');
    final rides = (count['ride'] ?? 0) + (count['air'] ?? 0);
    if (rides > 0) parts.add('$rides WYRD ride${rides == 1 ? '' : 's'}');
    final clock = '${lagos.hour.toString().padLeft(2, '0')}:00';
    final people = online == 0 ? 'Nobody on the streets' : online == 1 ? '1 citizen on the streets' : '$online citizens on the streets';
    say('hour', parts.isEmpty ? '$clock in Lagos. Nothing reported on the roads last hour. $people.' : '$clock in Lagos. Last hour: ${parts.join(', ')}. $people.');
  }
}
