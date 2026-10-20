import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// A refusal the player should read.
class GridRefused implements Exception {
  GridRefused(this.message);
  final String message;
}

/// The National Grid career, kept by the server. The server deals each shift (the turbine readings, the faults, the
/// solar panels, the sunlight) and keeps the answers; the phone sends back what the player did, and the score is
/// worked out here by replaying it. Level and experience live here too, and promotion is a certification exam the
/// server sets and marks. So pay can't be raised by telling the server a higher level or a better score.
abstract final class GridCareer {
  static const tracks = ['control', 'lineman', 'solar', 'plant'];

  /// the experience needed to sit the exam for the next level, by current level (1..4)
  static const xpFor = [0, 60, 160, 320, 560];

  /// pay for a perfect shift, by level; half of it for a score of 0
  static const pay = [12000, 16000, 21000, 27000, 34000];

  /// the least a whole shift can take on each track (the control room's three balancing tasks are 90 s each)
  static const minSeconds = {'control': 270, 'lineman': 40, 'solar': 40, 'plant': 30};

  static const shiftHours = 2, examMinutes = 30, examRetryMinutes = 30;

  static const _faults = [['a blown fuse', 'Fuse, 63 A'], ['a cracked insulator', 'Insulator, 33 kV'], ['a burnt jumper', 'Jumper cable']];

  /// [question, options, index of the right option]
  static const bank = <String, List<List<Object>>>{
    "control": [
      ["The island is in balance when the frequency is…", ["50 Hz", "60 Hz", "45 Hz"], 0],
      ["Demand jumps and the frequency falls. You…", ["Raise generation", "Cut generation", "Wait"], 0],
      ["A turbine trips. The quickest power to bring in is…", ["Spinning reserve / the import line", "A new power station", "The solar farm at night"], 0],
      ["Solar output at 9 pm is…", ["About zero", "At its highest", "The same as noon"], 0],
      ["When can frequency go too high?", ["When generation exceeds demand", "When demand exceeds generation", "Never"], 0],
      ["The evening peak in Lagos comes mostly from…", ["Lights, ACs and TVs when people get home", "The solar farm", "Midnight"], 0],
    ],
    "lineman": [
      ["Before touching a line, the first step is…", ["Open the breaker to isolate it", "Replace the part", "Remove the earths"], 0],
      ["After isolating, you must…", ["Prove it dead with a tester", "Close the breaker", "Climb straight up"], 0],
      ["Earths are applied to…", ["Protect you if the line is re-energised", "Make it brighter", "Hold the pylon up"], 0],
      ["A blown fuse is replaced with…", ["A fuse of the right rating", "Any wire", "A bigger fuse"], 0],
      ["The last step before restoring is…", ["Remove the earths", "Apply more earths", "Leave the site"], 0],
      ["Rain on a cracked insulator causes…", ["Flashover and trips", "Nothing", "Better conduction"], 0],
    ],
    "solar": [
      ["A dusty panel produces…", ["Less power", "More power", "The same"], 0],
      ["A cracked panel should be…", ["Flagged for replacement", "Cleaned harder", "Ignored"], 0],
      ["Solar panels produce the most around…", ["Midday", "Midnight", "Sunrise only"], 0],
      ["Harmattan season means…", ["More dust: clean more often", "No sun at all", "Panels freeze"], 0],
      ["Panels in a string share…", ["Current: one bad panel drags the string", "Nothing", "Their colour"], 0],
      ["The best time to clean panels is…", ["Early morning or evening", "Noon in full sun", "During a storm"], 0],
    ],
    "plant": [
      ["Turbine bearing vibration above the limit means…", ["Shut down for inspection", "Run harder", "Nothing"], 0],
      ["Exhaust temperature a little high, everything else normal:", ["Reduce load", "Shut down at once", "Ignore it"], 0],
      ["Low oil pressure risks…", ["Bearing damage", "Better efficiency", "Nothing"], 0],
      ["All readings normal. You…", ["Keep it running", "Shut it down", "Reduce load to zero"], 0],
      ["Why keep spinning reserve?", ["To cover a trip instantly", "To waste gas", "For decoration"], 0],
      ["The cooling towers…", ["Reject heat from the cycle", "Make the electricity", "Store gas"], 0],
    ],
  };

  static void _track(String t) {
    if (!tracks.contains(t)) throw GridRefused('Pick a track first.');
  }

  static Future<IslandGridCareer> career(Session s, UuidValue u, String track) async {
    _track(track);
    final c = await IslandGridCareer.db.findFirstRow(s, where: (t) => t.authUserId.equals(u) & t.track.equals(track));
    if (c != null) return c;
    try {
      return await IslandGridCareer.db.insertRow(s, IslandGridCareer(authUserId: u, track: track, xp: 0, level: 1));
    } catch (_) {
      return (await IslandGridCareer.db.findFirstRow(s, where: (t) => t.authUserId.equals(u) & t.track.equals(track)))!;
    }
  }

  static Future<Map<String, dynamic>> all(Session s, UuidValue u) async {
    final rows = {for (final c in await IslandGridCareer.db.find(s, where: (t) => t.authUserId.equals(u))) c.track: c};
    final recent = await IslandGridWork.db.find(s, where: (t) => t.authUserId.equals(u) & t.kind.equals('shift') & t.status.equals('done'), orderBy: (t) => t.doneAt.desc(), limit: 20);
    return {
      'tracks': {
        for (final t in tracks)
          t: {'level': rows[t]?.level ?? 1, 'xp': rows[t]?.xp ?? 0, if (rows[t]?.examAfter != null) 'examAfter': rows[t]!.examAfter!.toIso8601String()},
      },
      'shifts': [for (final w in recent) {'at': w.doneAt!.toIso8601String(), 'track': w.track, 'level': w.level, 'score': w.score, 'paid': w.paid}],
    };
  }

  /// The sun over the solar farm now, clear sky (MW): nothing before 7 or after 18, Lagos time.
  static int sunNow([DateTime? at]) {
    final d = (at ?? DateTime.now().toUtc()).add(const Duration(hours: 1));
    final h = d.hour + d.minute / 60;
    if (h < 7 || h > 18) return 0;
    return (600 * sin((h - 7) / 11 * pi)).round();
  }

  static Map<String, dynamic> _task(Random r, String type, String title) {
    switch (type) {
      case 'balance':
        return {'type': type, 'title': title, 'sun': sunNow()};
      case 'fault':
        return {'type': type, 'title': title, 'kind': r.nextInt(3), 'seed': r.nextInt(100000)};
      case 'solar':
        return {'type': type, 'title': title, 'panels': [for (var i = 0; i < 24; i++) (() { final x = r.nextDouble(); return x < 0.35 ? 'dust' : x < 0.47 ? 'crack' : 'ok'; })()]};
      case 'turbine':
        return {
          'type': type, 'title': title,
          'units': [
            for (var u = 1; u <= 3; u++)
              (() {
                final k = r.nextInt(3);
                return {'u': u, 'temp': k == 1 ? 612 + r.nextInt(16) : 560 + r.nextInt(26), 'vib': k == 2 ? 11 + r.nextInt(5) : 3 + r.nextInt(4), 'oil': k == 2 ? 1.6 : (26 + r.nextInt(6)) / 10, 'right': ['keep', 'reduce', 'shut'][k]};
              })(),
          ],
        };
      default:
        return {'type': type, 'title': title};
    }
  }

  /// What the phone may see: the deal without the answers.
  static Map<String, dynamic> _public(Map<String, dynamic> t) => {
        ...t,
        if (t['units'] != null) 'units': [for (final un in t['units'] as List) {...(un as Map<String, dynamic>)}..remove('right')],
      };

  /// Deal a new shift (any open one is dropped).
  static Future<Map<String, dynamic>> start(Session s, UuidValue u, String track) async {
    final c = await career(s, u, track);
    await s.db.unsafeExecute('UPDATE "island_grid_work" SET "status" = \'void\' WHERE "authUserId" = @u AND "kind" = \'shift\' AND "status" = \'open\'', parameters: QueryParameters.named({'u': u.uuid}));
    final r = Random.secure();
    final tasks = switch (track) {
      'control' => [_task(r, 'balance', 'Morning ramp-up'), _task(r, 'balance', 'The evening peak'), _task(r, 'balance', 'Turbine 2 trips!')],
      'lineman' => [_task(r, 'van', 'Collect the crew van'), _task(r, 'fault', 'Repair the fault'), _task(r, 'fault', 'Second call-out')],
      'solar' => [_task(r, 'solar', 'Clean and inspect, rows A to C'), _task(r, 'solar', 'Clean and inspect, rows D to F'), _task(r, 'turbine', 'Inverter station readings')],
      _ => [_task(r, 'turbine', 'Morning rounds'), _task(r, 'turbine', 'Load change review'), _task(r, 'turbine', 'End of shift handover')],
    };
    final w = await IslandGridWork.db.insertRow(s, IslandGridWork(authUserId: u, kind: 'shift', track: track, level: c.level, spec: jsonEncode({'tasks': tasks}), status: 'open', issuedAt: DateTime.now().toUtc()));
    return {'id': w.id, 'track': track, 'level': c.level, 'tasks': [for (final t in tasks) _public(t)]};
  }

  static double _demand(String scen, int t) {
    final base = scen.contains('peak') ? 1180 + t * 2.4 : scen.contains('Morning') ? 820 + t * 2.8 : 1050.0;
    return base + sin(t / 6) * 30 + (t > 40 && t < 55 && scen.contains('peak') ? 140 : 0);
  }

  static int _int(Object? v, int lo, int hi) => (v is num ? v.round() : int.tryParse('$v') ?? lo).clamp(lo, hi);

  /// Score one task (0..100) from what the player did, replaying it against what was dealt.
  static (int, String?) grade(Map<String, dynamic> t, Map<String, dynamic> r) {
    switch (t['type']) {
      case 'van':
        return (_int(r['checked'], 0, 5) * 20, null);
      case 'balance': // the slider positions each second, replayed against the demand
        final log = r['log'];
        if (log is! List || log.length != 90) return (0, null);
        final scen = t['title'] as String, sun = (t['sun'] as num).toDouble();
        var inBand = 0;
        var low = 50.0;
        for (var i = 0; i < 90; i++) {
          final e = log[i];
          if (e is! List || e.length != 4) return (0, null);
          final t1 = _int(e[0], 0, 400), t2 = _int(e[1], 0, 400), t3 = _int(e[2], 0, 400), imp = _int(e[3], 0, 250);
          final tripped = scen.contains('trips') && i >= 20;
          final gen = (t1 + (tripped ? 0 : t2) + t3 + imp + sun * 0.6).round(), dem = _demand(scen, i).round();
          final f = 50 + (gen - dem) / 400;
          if (f >= 49.8 && f <= 50.2) inBand++;
          low = min(low, f);
        }
        return ((inBand / 90 * 100).round(), low.toStringAsFixed(2));
      case 'fault': // the taps in order: every wrong step or wrong part is a safety strike
        final fk = _faults[t['kind'] as int];
        final steps = ['Open the breaker', 'Prove it dead with the tester', 'Apply the earths', 'Replace ${fk[0].replaceFirst(RegExp(r'^a '), 'the ')}', 'Remove the earths', 'Close the breaker and restore'];
        final clicks = r['clicks'];
        if (clicks is! List || clicks.length > 60) return (0, null);
        var next = 0, strikes = 0;
        var part = false;
        for (final c in clicks) {
          final k = '$c';
          if (next >= 6) break;
          if (next == 3 && !part) {
            if (!k.startsWith('part:')) continue;
            if (k.substring(5) == fk[1]) {
              part = true;
            } else {
              strikes++;
            }
          } else if (k == steps[next]) {
            next++;
          } else if (!k.startsWith('part:')) {
            strikes++;
          }
        }
        return (next >= 6 ? max(0, 100 - strikes * 18) : 0, '$strikes');
      case 'solar': // the panels tapped: dusty and cracked ones count, good ones touched cost
        final p = [...(t['panels'] as List).map((e) => '$e')];
        final taps = r['taps'];
        if (taps is! List || taps.length > 200) return (0, null);
        var right = 0, wrong = 0;
        for (final x in taps) {
          final k = _int(x, -1, 23);
          if (k < 0) continue;
          if (p[k] == 'dust' || p[k] == 'crack') {
            right++;
            p[k] = 'done';
          } else if (p[k] == 'ok') {
            wrong++;
            p[k] = 'oops';
          }
        }
        final left = p.where((v) => v == 'dust' || v == 'crack').length, total = right + left;
        return (total == 0 ? 100 : max(0, min(100, (right / total * 100 - wrong * 8).round())), null);
      case 'turbine':
        final picks = r['picks'];
        if (picks is! Map) return (0, null);
        final ok = (t['units'] as List).where((un) => picks['${un['u']}'] == un['right']).length;
        return ((ok / 3 * 100).round(), null);
    }
    return (0, null);
  }

  /// Close a shift once: grade it and add the experience. Returns the work (with its score) and the per-task scores;
  /// the caller pays it.
  static Future<(IslandGridWork, List<int>, IslandGridCareer)> finish(Session s, UuidValue u, int workId, String resultsJson) async {
    final w = await IslandGridWork.db.findById(s, workId);
    if (w == null || w.authUserId != u || w.kind != 'shift' || w.status != 'open') throw GridRefused('That shift is over. Start a new one in the WYRD Grid app.');
    final now = DateTime.now().toUtc(), took = now.difference(w.issuedAt);
    if (took > const Duration(hours: shiftHours)) {
      await IslandGridWork.db.updateRow(s, w.copyWith(status: 'void'));
      throw GridRefused('That shift ran out of time. Start a new one.');
    }
    if (took.inSeconds < minSeconds[w.track]!) throw GridRefused('That was quicker than the work can be done. Finish each task properly.');
    List results;
    try {
      results = jsonDecode(resultsJson) as List;
    } catch (_) {
      throw GridRefused('The shift report didn\'t arrive properly. Try again.');
    }
    final tasks = (jsonDecode(w.spec)['tasks'] as List).cast<Map<String, dynamic>>();
    final scores = [for (var i = 0; i < tasks.length; i++) grade(tasks[i], i < results.length && results[i] is Map ? (results[i] as Map).cast<String, dynamic>() : const {}).$1];
    final score = (scores.reduce((a, b) => a + b) / scores.length).round();
    // close it once, even if the same report arrives twice at the same moment
    final closed = await s.db.unsafeExecute('UPDATE "island_grid_work" SET "status" = \'done\', "score" = @sc, "doneAt" = @at WHERE "id" = @id AND "status" = \'open\'',
        parameters: QueryParameters.named({'sc': score, 'at': now, 'id': w.id}));
    if (closed != 1) throw GridRefused('That shift is over. Start a new one in the WYRD Grid app.');
    final c = await career(s, u, w.track);
    final c2 = await IslandGridCareer.db.updateRow(s, c.copyWith(xp: c.xp + (10 + score / 5).round()));
    return (w.copyWith(status: 'done', score: score, doneAt: now), scores, c2);
  }

  static Future<void> setPaid(Session s, int workId, int paid) =>
      s.db.unsafeExecute('UPDATE "island_grid_work" SET "paid" = @p WHERE "id" = @id', parameters: QueryParameters.named({'p': paid, 'id': workId}));

  static int payFor(int level, int score) => (pay[level.clamp(1, 5) - 1] * (0.5 + 0.5 * score.clamp(0, 100) / 100)).round();

  /// Five questions for the next level, options shuffled here; the answers stay on the server.
  static Future<Map<String, dynamic>> examStart(Session s, UuidValue u, String track) async {
    final c = await career(s, u, track), now = DateTime.now().toUtc();
    if (c.level >= 5) throw GridRefused('You\'re already Chief. There\'s no higher grade.');
    if (c.xp < xpFor[c.level]) throw GridRefused('You need ${xpFor[c.level]} XP to sit the exam (you have ${c.xp}). Work more shifts.');
    if (c.examAfter != null && c.examAfter!.isAfter(now)) throw GridRefused('You can sit the exam again ${c.examAfter!.difference(now).inMinutes + 1} minutes from now. Study the job meanwhile.');
    await s.db.unsafeExecute('UPDATE "island_grid_work" SET "status" = \'void\' WHERE "authUserId" = @u AND "kind" = \'exam\' AND "status" = \'open\'', parameters: QueryParameters.named({'u': u.uuid}));
    final r = Random.secure(), qs = [...bank[track]!]..shuffle(r);
    final picked = [
      for (final q in qs.take(5))
        (() {
          final order = [0, 1, 2]..shuffle(r);
          final opts = q[1] as List;
          return {'q': q[0], 'opts': [for (final i in order) opts[i]], 'right': order.indexOf(q[2] as int)};
        })(),
    ];
    final w = await IslandGridWork.db.insertRow(s, IslandGridWork(authUserId: u, kind: 'exam', track: track, level: c.level, spec: jsonEncode(picked), status: 'open', issuedAt: now));
    return {'id': w.id, 'track': track, 'questions': [for (final q in picked) {'q': q['q'], 'opts': q['opts']}]};
  }

  /// Mark the exam once: four right of five promotes.
  static Future<Map<String, dynamic>> examAnswer(Session s, UuidValue u, int workId, String answersJson) async {
    final w = await IslandGridWork.db.findById(s, workId), now = DateTime.now().toUtc();
    if (w == null || w.authUserId != u || w.kind != 'exam' || w.status != 'open') throw GridRefused('That exam is closed. Start it again from the WYRD Grid app.');
    if (now.difference(w.issuedAt) > const Duration(minutes: examMinutes)) {
      await IslandGridWork.db.updateRow(s, w.copyWith(status: 'void'));
      throw GridRefused('The exam timed out. Sit it again.');
    }
    List answers;
    try {
      answers = jsonDecode(answersJson) as List;
    } catch (_) {
      answers = const [];
    }
    final qs = jsonDecode(w.spec) as List;
    var right = 0;
    for (var i = 0; i < qs.length; i++) {
      if (i < answers.length && answers[i] == qs[i]['right']) right++;
    }
    final closed = await s.db.unsafeExecute('UPDATE "island_grid_work" SET "status" = \'done\', "score" = @sc, "doneAt" = @at WHERE "id" = @id AND "status" = \'open\'',
        parameters: QueryParameters.named({'sc': right, 'at': now, 'id': w.id}));
    if (closed != 1) throw GridRefused('That exam is closed.');
    final c = await career(s, u, w.track), pass = right >= 4 && c.level == w.level;
    final c2 = await IslandGridCareer.db.updateRow(s, pass ? c.copyWith(level: c.level + 1, examAfter: null) : c.copyWith(examAfter: now.add(const Duration(minutes: examRetryMinutes))));
    return {'right': right, 'of': qs.length, 'pass': pass, 'level': c2.level, 'xp': c2.xp};
  }
}
