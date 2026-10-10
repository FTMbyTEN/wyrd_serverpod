import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../mind/training_data_service.dart';
import 'city_wire.dart';
import 'game_learning.dart';

/// WYRD learns what its city is like -- from players who agreed, and anonymously.
///
/// NAIJA 2099 sends small batches of what happened around a player (cars queued at a junction, a crash on a
/// street, a ride to a district, a chase and how it ended) at most once a minute. Only players who opted in to
/// "let WYRD learn from my play" are counted, and nothing about them is kept: each signal goes into a tally of
/// that kind, at that place, in that hour -- no player, no position, no times finer than the hour. Tallies are
/// dropped after 180 days, the same promise as WYRD's game conversations.
///
/// What WYRD gets from it: a short "city memory" in the Authority's prompt (the week's crash and red-light
/// hotspots, the junctions that jam, where people ride to), so what the city has seen shapes what it says;
/// and its training data: each week's tallies as dated questions and answers (trainingExamples).
class CitySignals {
  static const keepDays = 180;
  static const kinds = {'queue', 'ride', 'air', 'crash', 'redlight', 'speeding', 'caught', 'lost', 'call', 'switch'};
  static final Map<String, DateTime> _lastBatch = {};
  static DateTime _lastPrune = DateTime.fromMillisecondsSinceEpoch(0);
  static String? _memory;
  static DateTime _memoryAt = DateTime.fromMillisecondsSinceEpoch(0);

  /// A batch from the game: [batch] is JSON, a list of {k: kind, p: place, n: count, v: amount}.
  static Future<String> record(Session session, UuidValue user, String batch) async {
    if (batch.length > 12000) return jsonEncode({'error': 'Too much at once.'});
    final c = await WorldCitizen.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));
    if (c == null || !c.trainingOptIn) return jsonEncode({'kept': 0, 'optIn': false});
    // one batch a minute per player is plenty
    final now = DateTime.now().toUtc();
    final last = _lastBatch[user.uuid];
    if (last != null && now.difference(last) < const Duration(seconds: 45)) return jsonEncode({'kept': 0, 'later': true});
    _lastBatch[user.uuid] = now;
    if (now.difference(_lastPrune) > const Duration(hours: 24)) { _lastPrune = now; await prune(session); }

    final List<dynamic> items;
    try { items = jsonDecode(batch) as List<dynamic>; } catch (_) { return jsonEncode({'error': 'Not a batch.'}); }
    // the same thing at the same place, added up before it's written
    final sums = <String, (String, String, int, double)>{};
    for (final it in items.take(80)) {
      if (it is! Map) continue;
      final kind = it['k'], place = _place(it['p']);
      if (kind is! String || !kinds.contains(kind) || place == null) continue;
      final n = ((it['n'] as num?) ?? 1).round().clamp(1, 50);
      final v = ((it['v'] as num?) ?? 0).toDouble().clamp(0, 100000).toDouble();
      final key = '$kind|$place';
      final was = sums[key];
      sums[key] = (kind, place, (was?.$3 ?? 0) + n, (was?.$4 ?? 0) + v);
    }
    final hour = DateTime.utc(now.year, now.month, now.day, now.hour);
    for (final (kind, place, n, v) in sums.values) {
      CityWire.happened(kind, place, n, v); // (on the live wire too: anonymous, by street)
      final row = await CitySignal.db.findFirstRow(session, where: (t) => t.hour.equals(hour) & t.kind.equals(kind) & t.place.equals(place));
      if (row == null) {
        try {
          await CitySignal.db.insertRow(session, CitySignal(hour: hour, kind: kind, place: place, times: n, total: v));
        } catch (_) {
          // (another batch wrote it a moment ago: add to that)
          final again = await CitySignal.db.findFirstRow(session, where: (t) => t.hour.equals(hour) & t.kind.equals(kind) & t.place.equals(place));
          if (again != null) await CitySignal.db.updateRow(session, again.copyWith(times: again.times + n, total: again.total + v));
        }
      } else {
        await CitySignal.db.updateRow(session, row.copyWith(times: row.times + n, total: row.total + v));
      }
    }
    return jsonEncode({'kept': sums.length, 'optIn': true});
  }

  /// A place name as the game's map has it -- nothing else gets in (no personal details, no free text).
  static String? _place(Object? p) {
    if (p is! String) return null;
    final s = TrainingDataService.scrub(p).replaceAll(RegExp(r"[^A-Za-z0-9 /'&.,\-]"), '').replaceAll(RegExp(r'\s+'), ' ').trim();
    if (s.length < 2) return null;
    return s.length > 60 ? s.substring(0, 60) : s;
  }

  static Future<void> prune(Session session) async {
    final cutoff = DateTime.now().toUtc().subtract(const Duration(days: keepDays));
    await CitySignal.db.deleteWhere(session, where: (t) => t.hour < cutoff);
  }

  /// What the city has seen this past week, in a few lines for WYRD's prompt (worked out at most every 10 min).
  static Future<String> memory(Session session) async {
    final now = DateTime.now().toUtc();
    if (_memory != null && now.difference(_memoryAt) < const Duration(minutes: 10)) return _memory!;
    final since = now.subtract(const Duration(days: 7));
    final rows = await CitySignal.db.find(session, where: (t) => t.hour > since, limit: 20000);
    final by = <String, Map<String, (int, double)>>{};
    for (final r in rows) {
      final m = by.putIfAbsent(r.kind, () => {});
      final w = m[r.place];
      m[r.place] = ((w?.$1 ?? 0) + r.times, (w?.$2 ?? 0) + r.total);
    }
    String top(String kind, String label, {int n = 3, String Function(String, int, double)? fmt}) {
      final m = by[kind];
      if (m == null || m.isEmpty) return '';
      final list = m.entries.toList()..sort((a, b) => b.value.$1.compareTo(a.value.$1));
      return '- $label: ${list.take(n).map((e) => fmt != null ? fmt(e.key, e.value.$1, e.value.$2) : '${e.key} (${e.value.$1})').join('; ')}';
    }
    final lines = [
      top('crash', 'Crashes, most on'),
      top('redlight', 'Red lights run, most at'),
      top('speeding', 'Speeding logged, most on'),
      top('queue', 'Junctions that jam (times your units switched for a queue; cars waiting on average)',
          fmt: (p, n, v) => '$p ($n, ~${(v / n).toStringAsFixed(1)} cars)'),
      top('ride', 'Where people ride to by road'),
      top('air', 'Where people fly to'),
      top('caught', 'Police stops made, most near'),
      top('lost', 'Chases lost, most near'),
      top('call', 'Calls made to get out of trouble'),
    ].where((l) => l.isNotEmpty).toList();
    _memory = lines.isEmpty ? '(nothing yet)' : lines.join('\n');
    _memoryAt = now;
    return _memory!;
  }

  // ---- the tallies as training data ----

  /// what each kind is called, one and many
  static const _names = <String, (String, String)>{
    'crash': ('crash', 'crashes'), 'redlight': ('red light run', 'red lights run'), 'speeding': ('car caught speeding', 'cars caught speeding'),
    'caught': ('police stop', 'police stops'), 'lost': ('chase lost', 'chases lost'), 'queue': ('jam', 'jams'),
    'ride': ('WYRD Ride', 'WYRD Rides'), 'air': ('WYRD Air flight', 'WYRD Air flights'),
  };
  static String _n(String kind, int n) => '$n ${n == 1 ? _names[kind]!.$1 : _names[kind]!.$2}';
  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  /// The tallies as training examples for TrainingDataService: one set per week, stamped with the week -- so WYRD
  /// learns them as what the city saw then, not as fixed facts. For each week with enough on the roads (at least
  /// 5 things): how the roads were overall; where each kind of thing happened most; and what each busy place (3 or
  /// more things) was like. The answers are built from the numbers alone, in WYRD's short voice; nothing personal
  /// is in them (the tallies hold none).
  static Future<List<TrainingExample>> trainingExamples(Session session, void Function(String) count) async {
    final since = DateTime.now().toUtc().subtract(const Duration(days: keepDays));
    final rows = await CitySignal.db.find(session, where: (t) => t.hour > since, orderBy: (t) => t.hour, limit: 200000);
    return examplesFrom(rows, count);
  }

  /// [trainingExamples], from the tallies themselves.
  static List<TrainingExample> examplesFrom(List<CitySignal> rows, void Function(String) count) {
    // by week (starting Monday), then kind -> place -> times
    final weeks = <DateTime, Map<String, Map<String, int>>>{};
    for (final r in rows) {
      if (!_names.containsKey(r.kind)) continue; // (calls and light switches aren't about the roads)
      final d = DateTime.utc(r.hour.year, r.hour.month, r.hour.day);
      final monday = d.subtract(Duration(days: d.weekday - 1));
      final k = weeks.putIfAbsent(monday, () => {}).putIfAbsent(r.kind, () => {});
      k[r.place] = (k[r.place] ?? 0) + r.times;
    }
    final out = <TrainingExample>[];
    TrainingExample ex(String stamp, String q, String a) => TrainingExample('city', [
          (role: 'system', content: GameLearning.worldSystem),
          (role: 'user', content: '[NAIJA 2099 · city memory · $stamp]\n$q'),
          (role: 'assistant', content: a),
        ]);
    for (final MapEntry(key: monday, value: kinds) in weeks.entries) {
      final total = kinds.values.fold<int>(0, (s, m) => s + m.values.fold(0, (a, b) => a + b));
      if (total < 5) { count('dropped.city.thin_week'); continue; }
      final stamp = 'week of ${monday.day} ${_months[monday.month - 1]} ${monday.year}';
      List<MapEntry<String, int>> ranked(String kind) => (kinds[kind]?.entries.toList() ?? [])..sort((a, b) => b.value.compareTo(a.value));
      int sum(String kind) => kinds[kind]?.values.fold<int>(0, (a, b) => a + b) ?? 0;

      // 1. the roads that week, overall
      final parts = <String>[];
      for (final kind in ['crash', 'redlight', 'speeding', 'caught', 'lost']) {
        final n = sum(kind);
        if (n > 0) parts.add('${_n(kind, n)}${n > 1 ? ', most ${kind == 'redlight' ? 'at' : kind == 'caught' || kind == 'lost' ? 'near' : 'on'} ${ranked(kind).first.key}' : ' (${ranked(kind).first.key})'}');
      }
      final rides = sum('ride') + sum('air');
      final dest = [...ranked('ride'), ...ranked('air')]..sort((a, b) => b.value.compareTo(a.value));
      final overall = [
        if (parts.isNotEmpty) '${parts.first[0].toUpperCase()}${parts.first.substring(1)}${parts.length > 1 ? '; ${parts.skip(1).join('; ')}' : ''}.',
        if (rides > 0) '$rides ride${rides == 1 ? '' : 's'} with me${dest.isNotEmpty ? ' — most to ${dest.first.key}' : ''}.',
        if (sum('queue') > 0) 'The worst jams were at ${ranked('queue').first.key}.',
      ].join(' ');
      if (overall.isNotEmpty) { out.add(ex(stamp, 'What were the roads of Lagos like this week?', overall)); count('kept.city'); }

      // 2. where each kind happened most
      const asks = {
        'crash': 'Where did people crash most this week?', 'redlight': 'Where were red lights run most this week?',
        'speeding': 'Where did people speed most this week?', 'queue': 'Which junctions jammed most this week?',
        'caught': 'Where did the police stop the most drivers this week?', 'ride': 'Where did people ride to most this week?',
      };
      for (final MapEntry(key: kind, value: q) in asks.entries) {
        final top = ranked(kind).take(3).toList();
        if (top.isEmpty || sum(kind) < 2) continue;
        final names = top.map((e) => e.key).toList();
        final a = names.length == 1 ? '${names.first} (${_n(kind, top.first.value)}).'
            : '${names.first} (${top.first.value}), then ${names.skip(1).join(' and ')}.';
        out.add(ex(stamp, q, a)); count('kept.city');
      }

      // 3. each busy place: what happened there
      final byPlace = <String, Map<String, int>>{};
      for (final MapEntry(key: kind, value: places) in kinds.entries) {
        if (kind == 'ride' || kind == 'air') continue; // (destinations, not what the road was like)
        for (final MapEntry(key: p, value: n) in places.entries) { byPlace.putIfAbsent(p, () => {})[kind] = n; }
      }
      final busy = byPlace.entries.where((e) => e.value.values.fold(0, (a, b) => a + b) >= 3).toList()
        ..sort((a, b) => b.value.values.fold<int>(0, (x, y) => x + y).compareTo(a.value.values.fold<int>(0, (x, y) => x + y)));
      for (final MapEntry(key: place, value: m) in busy.take(15)) {
        final said = (m.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).map((e) => _n(e.key, e.value)).toList();
        final bad = (m['crash'] ?? 0) + (m['redlight'] ?? 0) + (m['speeding'] ?? 0);
        final a = 'That week: ${said.length == 1 ? said.first : '${said.take(said.length - 1).join(', ')} and ${said.last}'}. '
            '${bad >= 3 ? 'Drive it with sense.' : (m['queue'] ?? 0) >= 2 ? 'Leave early or take another way.' : 'Mostly calm otherwise.'}';
        out.add(ex(stamp, 'What was it like on $place this week?', a)); count('kept.city');
      }
    }
    return out;
  }
}
