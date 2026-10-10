import 'dart:convert';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'bank.dart';
import 'city_wire.dart';
import 'story_service.dart';
import 'wallet_service.dart';

/// Fair Streets: NAIJA 2099's police, held by the server.
///
/// The game drives the patrols and draws them; the server decides. It keeps each player's wanted state (heat, whose
/// whole part is the stars) and their record: every offence the game reports becomes a citation with its evidence and
/// how sure the city is. Weak evidence is a note or a warning, never a fine; the first offence of a kind in a week is a
/// warning; after that, a fine -- pending until it's settled: at a stop (less if you complied), posted when a pursuit
/// ends without one, at the fines desk, or waived by a favour. Fines go through the naira ledger (the ₦500 floor, the
/// payment plan). Pursuits are rare and short: at most 3 minutes, one per 10 minutes, none for 5 minutes after a stop,
/// none at all with Calm streets on. Any citation can be appealed; the server rechecks the evidence (WYRD's traffic
/// units go faulty now and then, and it's found out a couple of days late) and refunds through the ledger.
///
/// No one is hurt: patrols follow, signal and stop you. That's all.
class PoliceService {
  /// code -> (label, severity 1..4)
  static const offences = <String, (String, int)>{
    'RL-1': ('Red light run', 2),
    'SP-1': ('Speeding, up to 30 km/h over', 1),
    'SP-2': ('Speeding, more than 30 km/h over', 3),
    'CD-1': ('Careless driving: a crash', 2),
    'PT-1': ('Striking a patrol car', 4),
    'FS-1': ('Failing to stop for a patrol', 3),
  };
  /// how sure each kind of evidence is, before anything else (a unit's sensor also by its health)
  static const _source = {'unit': 0.85, 'patrol': 0.9, 'crash': 0.95, 'witness': 0.4, 'admission': 1.0};
  static const _heat = {1: 0.7, 2: 1.0, 3: 1.5, 4: 2.5};
  static const pursuitCap = Duration(minutes: 3), pursuitGap = Duration(minutes: 10), afterStop = Duration(minutes: 5);
  static const _decayPerSecond = 1 / 40;

  // ---- the state ----

  static Future<WantedState> _load(Session session, UuidValue user) async {
    final now = DateTime.now().toUtc();
    var w = await WantedState.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));
    w ??= await WantedState.db.insertRow(session, WantedState(authUserId: user, stateAt: now, updatedAt: now));
    // heat cools unless a patrol is on you
    if (!const {'pursuit', 'complying', 'searching'}.contains(w.state) && w.heat > 0) {
      final secs = now.difference(w.updatedAt).inMilliseconds / 1000;
      final heat = math.max(0.0, w.heat - secs * _decayPerSecond);
      w = w.copyWith(heat: heat, updatedAt: now);
      if (heat == 0) {
        // cooled off without a chase: what was pending becomes a caution ("drive well and it comes off by itself")
        await _settle(session, user, 'cooled');
        w = w.copyWith(state: 'clear', stateAt: now);
      } else if (heat < 1 && w.state == 'watched') {
        w = w.copyWith(state: 'cooling', stateAt: now);
      }
    } else {
      w = w.copyWith(updatedAt: now);
    }
    return w;
  }

  static Future<WantedState> _save(Session session, WantedState w) => WantedState.db.updateRow(session, w);

  static Future<Map<String, dynamic>> _status(Session session, WantedState w) async {
    final pending = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(w.authUserId) & t.status.equals('pending'));
    final active = const {'pursuit', 'complying', 'searching'}.contains(w.state);
    return {
      'stars': w.heat.floor().clamp(0, 5), 'heat': w.heat, 'state': w.state, 'calm': w.calm,
      'pending': pending.fold<int>(0, (s, c) => s + c.amount),
      'clearIn': active ? null : (w.heat / _decayPerSecond).ceil(),
      'pursuitLeft': w.pursuitAt == null || !active ? null : math.max(0, pursuitCap.inSeconds - DateTime.now().toUtc().difference(w.pursuitAt!).inSeconds),
      'searchLeft': w.state == 'searching' && w.searchUntil != null ? math.max(0, w.searchUntil!.difference(DateTime.now().toUtc()).inSeconds) : null,
    };
  }

  // ---- evidence ----

  /// Units that are faulty in the story until a player fixes them (the Unit T-31 mission): they read wrong and the city
  /// doesn't know it -- every citation they issue looks sound until it's appealed, or the unit is fixed.
  static const storyFaults = {'T-31'};
  static final Set<String> _fixed = {};
  static DateTime _fixedAt = DateTime.fromMillisecondsSinceEpoch(0);
  static Set<String> get fixedUnits => _fixed;

  /// What's been fixed, from the city's flags (read again at most once a minute).
  static Future<void> loadFixed(Session session) async {
    if (DateTime.now().difference(_fixedAt) < const Duration(minutes: 1)) return;
    _fixedAt = DateTime.now();
    final flags = await CityFlag.db.find(session, where: (t) => t.name.like('unit-fixed:%'));
    _fixed..clear()..addAll(flags.map((f) => f.name.substring('unit-fixed:'.length)));
  }

  /// Fix a faulty unit for the whole city: every citation it issued, for every player, is overturned and refunded
  /// through the ledger, and the live wire says so. Returns how many drivers and how much came back.
  static Future<(int, int)> fixUnit(Session session, String unit, String how) async {
    final flag = 'unit-fixed:$unit';
    if (await CityFlag.db.findFirstRow(session, where: (t) => t.name.equals(flag)) == null) {
      try { await CityFlag.db.insertRow(session, CityFlag(name: flag, value: how, at: DateTime.now().toUtc())); } catch (_) {}
    }
    _fixed.add(unit);
    final cites = await PoliceCitation.db.find(session, where: (t) => t.evidence.like('%"id":"$unit"%') &
        (t.status.equals('pending') | t.status.equals('paid') | t.status.equals('caution') | t.status.equals('warning')));
    final drivers = <String>{};
    var back = 0;
    for (final c in cites) {
      final (refund, unowed) = await _undo(session, c.authUserId, c, 'overturned');
      await PoliceCitation.db.updateRow(session, (await PoliceCitation.db.findById(session, c.id!))!.copyWith(appealResult: 'unit fixed'));
      drivers.add(c.authUserId.uuid);
      back += refund + unowed;
    }
    CityWire.say('fault', 'WYRD: Unit $unit was reading 20 km/h high. It\'s fixed now, and every citation it issued is cancelled'
        '${back > 0 ? ': ${drivers.length} driver${drivers.length == 1 ? '' : 's'}, ₦$back back' : ''}. Thank the citizen who proved it.');
    return (drivers.length, back);
  }

  /// A unit's sensor health: most weeks 1; one week in ten a unit reads wrong (0.5). The city only finds out after the
  /// fault's first two days, so a citation issued in that window looks sound -- until someone appeals it.
  static (double, bool) unitHealth(String unit, DateTime at) {
    if (storyFaults.contains(unit) && !_fixed.contains(unit)) return (0.5, false);
    final week = at.millisecondsSinceEpoch ~/ (7 * 86400000);
    final h = '$unit:$week'.codeUnits.fold<int>(7, (a, b) => (a * 31 + b) & 0x7fffffff);
    if (h % 10 != 0) return (1.0, true);
    final weekStart = DateTime.fromMillisecondsSinceEpoch(week * 7 * 86400000, isUtc: true);
    return (0.5, at.difference(weekStart) > const Duration(days: 2)); // (faulty; known yet?)
  }

  /// How sure the city is: independent sources combine (1 - Π(1 - c)); one kind of source counts once.
  static double confidence(List<Map<String, dynamic>> evidence) {
    final best = <String, double>{};
    for (final e in evidence) {
      final s = e['source'] as String, c = (e['confidence'] as num).toDouble();
      if (c > (best[s] ?? 0)) best[s] = c;
    }
    return 1 - best.values.fold<double>(1, (p, c) => p * (1 - c));
  }

  static int _fineFor(int severity, int repeats, int naira) {
    final base = {1: 800, 2: 1200, 3: 2000, 4: 4000}[severity]!;
    final wealth = math.min(4000, naira * 0.04);
    return (base * (1 + 0.5 * repeats) + wealth).round().clamp(500, 8000);
  }

  // ---- what the game reports ----

  /// An offence the game saw: {code, place, unit?, kmh?, witnesses?, patrol?}. Returns the citation and the status.
  static Future<String> report(Session session, UuidValue user, String json) async {
    final Map<String, dynamic> m;
    try { m = jsonDecode(json) as Map<String, dynamic>; } catch (_) { return jsonEncode({'error': 'Not a report.'}); }
    await loadFixed(session);
    final code = m['code'], place = _clean(m['place']);
    if (code is! String || !offences.containsKey(code) || place == null) return jsonEncode({'error': 'Unknown offence.'});
    final now = DateTime.now().toUtc();
    // the same offence at the same place within a minute is one offence
    final dup = await PoliceCitation.db.findFirstRow(session, where: (t) => t.authUserId.equals(user) & t.code.equals(code) & t.place.equals(place) & (t.createdAt > now.subtract(const Duration(minutes: 1))));
    var w = await _load(session, user);
    if (dup != null) return jsonEncode({'citation': _view(dup), ...await _status(session, w)});
    final evidence = <Map<String, dynamic>>[];
    final unit = _clean(m['unit']);
    if (unit != null) {
      final (health, known) = unitHealth(unit, now);
      final h = known ? health : 1.0; // (a fault not found yet looks like a sound reading)
      evidence.add({'source': 'unit', 'id': unit, 'confidence': _source['unit']! * h, 'detail': m['kmh'] != null ? 'read ${(m['kmh'] as num).round()} km/h' : 'saw it'});
    }
    if (m['patrol'] == true) evidence.add({'source': 'patrol', 'id': _clean(m['patrolId']) ?? 'patrol', 'confidence': _source['patrol'], 'detail': 'saw it from the patrol car'});
    if (code == 'CD-1' || code == 'PT-1') evidence.add({'source': 'crash', 'id': 'crash', 'confidence': _source['crash'], 'detail': 'the collision record'});
    final wit = ((m['witnesses'] as num?) ?? 0).round().clamp(0, 3);
    for (var i = 0; i < wit; i++) {
      evidence.add({'source': 'witness', 'id': 'w$i', 'confidence': _source['witness']! * (0.6 + 0.4 * ((i + 1) / 3)), 'detail': _witnessLine(code, i)});
    }
    final conf = confidence(evidence);
    final (label, severity) = offences[code]!;
    final weekAgo = now.subtract(const Duration(days: 7));
    final before = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user) & t.code.equals(code) & (t.createdAt > weekAgo) & t.status.notEquals('note') & t.status.notEquals('overturned'));
    String outcome;
    var amount = 0;
    if (conf < 0.5) {
      outcome = 'note';
    } else if (conf < 0.8 || before.isEmpty) {
      outcome = 'warning';
    } else {
      outcome = 'fine';
      final c = await Bank.fresh(session, user);
      amount = _fineFor(severity, before.where((b) => b.outcome == 'fine').length, c.naira);
    }
    final cit = await PoliceCitation.db.insertRow(session, PoliceCitation(authUserId: user, code: code, place: place, evidence: jsonEncode(evidence),
        confidence: conf, outcome: outcome, amount: amount, status: outcome == 'fine' ? 'pending' : outcome, createdAt: now));
    if (outcome == 'fine') {
      w = w.copyWith(heat: math.min(5.9, w.heat + _heat[severity]!), state: const {'pursuit', 'complying', 'searching'}.contains(w.state) ? w.state : 'watched', stateAt: now);
      if (severity >= 3) CityWire.happened(code == 'PT-1' ? 'crash' : code.startsWith('SP') ? 'speeding' : 'redlight', place, 1, (m['kmh'] as num?)?.toDouble() ?? 0);
    }
    w = await _save(session, w);
    return jsonEncode({'citation': _view(cit), ...await _status(session, w)});
  }

  static String _witnessLine(String code, int i) => switch (code) {
        'RL-1' => ['"I saw it go through on red. I think it was red."', '"The light was red, I\'m sure."', '"Something went through fast. Red, maybe."'][i],
        'CD-1' => ['"I heard the bang and turned round."', '"That car didn\'t even slow down."', '"Two cars, one of them came too fast."'][i],
        'PT-1' => ['"It went straight into the police car."', '"Hit the patrol, then kept going."', '"I saw the patrol car get hit."'][i],
        _ => ['"It was going very fast."', '"Too fast for this road."', '"Like a hover-car with wheels."'][i],
      };

  /// The pursuit as the game sees it, every couple of seconds while anything is going on:
  /// {dist: metres to the nearest patrol or null, speed: m/s, seen: a patrol or unit can see you, hazards: hazards on
  /// (in a car) or hands up (on foot), onFoot}. The server moves the state machine and says what happens.
  static Future<String> tick(Session session, UuidValue user, String json) async {
    final Map<String, dynamic> m;
    try { m = jsonDecode(json) as Map<String, dynamic>; } catch (_) { return jsonEncode({'error': 'Not a tick.'}); }
    final now = DateTime.now().toUtc();
    var w = await _load(session, user);
    final out = <String, dynamic>{};
    final dist = (m['dist'] as num?)?.toDouble(), speed = ((m['speed'] as num?) ?? 0).toDouble();
    final seen = m['seen'] == true, hazards = m['hazards'] == true, onFoot = m['onFoot'] == true;
    final stars = w.heat.floor();

    if (w.state == 'watched' || w.state == 'cooling') {
      if (stars >= 2) {
        final pending = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user) & t.status.equals('pending'));
        final worst = pending.fold<int>(0, (s, c) => math.max(s, offences[c.code]!.$2));
        final gapOk = w.lastPursuitAt == null || now.difference(w.lastPursuitAt!) > pursuitGap || worst >= 4;
        final stopOk = w.lastStopAt == null || now.difference(w.lastStopAt!) > afterStop || worst >= 4;
        if (!w.calm && gapOk && stopOk) {
          w = w.copyWith(state: 'pursuit', stateAt: now, pursuitAt: now, lastPursuitAt: now, lostSince: null, complyingSince: null, nearSince: null);
          out['dispatch'] = stars >= 4 ? 2 : 1;
        } else {
          // no pursuit (Calm streets, or too soon after the last): the city posts the citation instead
          out['posted'] = await _settle(session, user, 'posted');
          out['why'] = w.calm ? 'calm' : 'rest';
          w = w.copyWith(heat: 0.9, state: 'cooling', stateAt: now);
        }
      }
    } else if (const {'pursuit', 'complying', 'searching'}.contains(w.state)) {
      final pursuing = now.difference(w.pursuitAt ?? now);
      if (pursuing > pursuitCap) {
        // three minutes is long enough for anyone
        out['breakOff'] = true;
        out['posted'] = await _settle(session, user, 'posted');
        w = w.copyWith(heat: 0.9, state: 'cooling', stateAt: now, pursuitAt: null);
      } else {
        // complying: slow, hazards on (or hands up on foot) -- ten seconds of it and the stop happens wherever it's safe
        final complying = hazards && (onFoot || speed < 8);
        w = w.copyWith(complyingSince: complying ? (w.complyingSince ?? now) : null, state: complying ? 'complying' : (w.state == 'complying' ? 'pursuit' : w.state));
        // failing to stop: 20 s into a pursuit, not complying, still going
        if (!complying && pursuing > const Duration(seconds: 20) && speed > 8) {
          final fs = await PoliceCitation.db.findFirstRow(session, where: (t) => t.authUserId.equals(user) & t.code.equals('FS-1') & (t.createdAt > w.pursuitAt!));
          if (fs == null) {
            await _save(session, w); // (what this tick has worked out so far, before the report reads it)
            await report(session, user, jsonEncode({'code': 'FS-1', 'place': _clean(m['place']) ?? 'Lagos', 'patrol': true}));
            w = await _load(session, user);
          }
        }
        final near = dist != null && dist < 10 && speed < 2.2;
        w = w.copyWith(nearSince: near ? (w.nearSince ?? now) : null);
        final stopped = (w.nearSince != null && now.difference(w.nearSince!) >= const Duration(seconds: 2)) ||
            (w.complyingSince != null && now.difference(w.complyingSince!) >= const Duration(seconds: 10));
        if (stopped) {
          final complied = w.complyingSince != null;
          out['stop'] = await _settle(session, user, complied ? 'complied' : 'stop');
          out['complied'] = complied;
          w = w.copyWith(heat: 0, state: 'clear', stateAt: now, pursuitAt: null, lastStopAt: now, complyingSince: null, nearSince: null, lostSince: null);
        } else if (w.state == 'searching') {
          if (seen) {
            w = w.copyWith(state: 'pursuit', stateAt: now, lostSince: null, searchUntil: null);
          } else if (w.searchUntil != null && now.isAfter(w.searchUntil!)) {
            // got away -- but escaping isn't free: the citation is posted
            out['escaped'] = true;
            out['posted'] = await _settle(session, user, 'posted');
            w = w.copyWith(heat: 0.9, state: 'cooling', stateAt: now, pursuitAt: null, searchUntil: null);
          }
        } else if (!seen) {
          w = w.copyWith(lostSince: w.lostSince ?? now);
          if (now.difference(w.lostSince!) >= const Duration(seconds: 15)) {
            w = w.copyWith(state: 'searching', stateAt: now, searchUntil: now.add(Duration(seconds: 30 + math.Random().nextInt(30))));
            out['searching'] = true;
          }
        } else {
          w = w.copyWith(lostSince: null);
        }
      }
    }
    w = await _save(session, w);
    return jsonEncode({...out, ...await _status(session, w)});
  }

  /// Settle what's pending, as [how]: stop (in full), complied (severity 1–2 a caution; worse, a third off), posted (in
  /// full), desk (in full), cooled (cautions), counsel / favour (waived). Returns {fine, paid, owed, waived, caution, codes}.
  static Future<Map<String, dynamic>> _settle(Session session, UuidValue user, String how) async {
    final pending = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user) & t.status.equals('pending'), orderBy: (t) => t.id);
    final now = DateTime.now().toUtc();
    if (pending.isEmpty) return {'fine': 0, 'paid': 0, 'owed': 0, 'waived': 0, 'caution': false, 'codes': <String>[]};
    final codes = pending.map((c) => c.code).toList();
    final worst = pending.fold<int>(0, (s, c) => math.max(s, offences[c.code]!.$2));
    final caution = how == 'cooled' || (how == 'complied' && worst <= 2);
    if (caution || how == 'counsel' || how == 'favour') {
      for (final c in pending) {
        await PoliceCitation.db.updateRow(session, c.copyWith(status: caution ? 'caution' : 'waived', settledBy: how, settledAt: now));
      }
      return {'fine': 0, 'paid': 0, 'owed': 0, 'waived': 0, 'caution': caution, 'codes': codes};
    }
    var total = math.min(8000, pending.fold<int>(0, (s, c) => s + c.amount));
    if (how == 'complied') total = (total * 2 / 3).round();
    final key = 'police:${pending.first.id}:$how';
    final labels = codes.toSet().join(', ');
    final (paid, owed, waived, entry) = await WalletService.chargeFine(session, user, total, key, 'Police fine ($labels)');
    // each citation's share of what was paid and owed
    final sum = pending.fold<int>(0, (s, c) => s + c.amount);
    for (final c in pending) {
      final share = sum == 0 ? 0.0 : c.amount / sum;
      await PoliceCitation.db.updateRow(session, c.copyWith(status: 'paid', paid: (paid * share).round(), owed: (owed * share).round(),
          entryId: entry?.id, settledBy: how, settledAt: now));
    }
    return {'fine': total, 'paid': paid, 'owed': owed, 'waived': waived, 'caution': false, 'codes': codes};
  }

  // ---- calls that make it go away ----

  /// A call from the phone. Returns {ok, cleared (stars), reason?, wait?, fee?, standDown, ...status}. [id]: fines | wyrd
  /// for everyone; daddy | lawyer | uncle for the Ikoyi heir; sgt for the nurse; chairman for the conductor's child.
  static Future<String> call(Session session, UuidValue user, String id) async {
    final now = DateTime.now().toUtc();
    var w = await _load(session, user);
    final c = await Bank.fresh(session, user);
    final bg = StoryService.read(c)['background'] as String?;
    final allowed = {'fines': true, 'wyrd': true, 'daddy': bg == 'heir', 'lawyer': bg == 'heir', 'uncle': bg == 'heir', 'sgt': bg == 'nurse', 'chairman': bg == 'conductor'};
    if (allowed[id] != true) return jsonEncode({'ok': false, 'reason': 'unreachable', ...await _status(session, w)});
    final stars = w.heat.floor();
    final pendingNow = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user) & t.status.equals('pending'));
    if (stars == 0 && pendingNow.isEmpty) return jsonEncode({'ok': false, 'reason': 'clean', ...await _status(session, w)});
    final calls = w.calls == null ? <String, dynamic>{} : jsonDecode(w.calls!) as Map<String, dynamic>;
    int wait(int minutes) {
      final last = calls[id] == null ? null : DateTime.parse(calls[id] as String);
      return last == null ? 0 : math.max(0, (Duration(minutes: minutes) - now.difference(last)).inMinutes + 1);
    }
    const cooldown = {'wyrd': 10, 'daddy': 4, 'uncle': 15, 'sgt': 10, 'chairman': 10};
    if (cooldown.containsKey(id) && wait(cooldown[id]!) > 0 && wait(cooldown[id]!) <= cooldown[id]!) {
      return jsonEncode({'ok': false, 'reason': 'busy', 'wait': wait(cooldown[id]!), ...await _status(session, w)});
    }
    final out = <String, dynamic>{'ok': true};
    var heat = w.heat;
    switch (id) {
      case 'fines':
        // the desk settles what's pending, in full (a flat ₦2,000 when nothing is), and takes two stars off
        final s = pendingNow.isEmpty ? null : await _settle(session, user, 'desk');
        if (s == null) {
          final r = await Bank.post(session, user, key: 'desk:${user.uuid}:${now.millisecondsSinceEpoch ~/ 60000}', amount: -2000, kind: 'fine', counter: 'city:courts', memo: 'Fine paid at the Alagbon desk');
          if (!r.ok) return jsonEncode({'ok': false, 'reason': 'payment_failed', ...await _status(session, w)});
          out['fee'] = 2000;
        } else {
          out['fee'] = s['fine']; out['owed'] = s['owed'];
        }
        heat = math.max(0, heat - 2);
      case 'wyrd':
        if (stars > 2) return jsonEncode({'ok': false, 'reason': 'too_many', ...await _status(session, w)});
        heat = math.max(0, heat - 1);
      case 'daddy' || 'sgt' || 'chairman':
        heat = math.max(0, heat - 1);
      case 'lawyer':
        final r = await Bank.post(session, user, key: 'lawyer:${user.uuid}:${now.millisecondsSinceEpoch ~/ 60000}', amount: -10000, kind: 'fee', counter: 'city:services', memo: 'Barr. Adeyemi, SAN: retainer');
        if (!r.ok) return jsonEncode({'ok': false, 'reason': 'payment_failed', ...await _status(session, w)});
        out['fee'] = 10000;
        await _settle(session, user, 'counsel');
        heat = 0;
      case 'uncle':
        if (math.Random().nextDouble() < 0.3) {
          calls[id] = now.subtract(const Duration(minutes: 10)).toIso8601String(); // (try again in five)
          w = await _save(session, w.copyWith(calls: jsonEncode(calls)));
          return jsonEncode({'ok': false, 'reason': 'no_answer', 'wait': 5, ...await _status(session, w)});
        }
        await _settle(session, user, 'favour');
        heat = 0;
        CityWire.say('minutes', 'WYRD: a call from Force HQ cleared a driver\'s record today. I keep the minutes.');
    }
    calls[id] = now.toIso8601String();
    out['cleared'] = w.heat.floor() - heat.floor();
    final active = const {'pursuit', 'complying', 'searching'}.contains(w.state);
    if (active && heat < 2) out['standDown'] = true;
    w = w.copyWith(heat: heat, calls: jsonEncode(calls),
        state: heat <= 0 ? 'clear' : (active && heat < 2) ? 'cooling' : w.state, stateAt: now, pursuitAt: active && heat < 2 ? null : w.pursuitAt);
    if (heat <= 0) {
      final left = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user) & t.status.equals('pending'));
      if (left.isNotEmpty) await _settle(session, user, 'cooled'); // (stars gone by a word in the right ear: what's pending is a caution)
    }
    w = await _save(session, w);
    return jsonEncode({...out, ...await _status(session, w)});
  }

  // ---- the record and appeals ----

  static Map<String, dynamic> _view(PoliceCitation c) => {
        'id': c.id, 'code': c.code, 'label': offences[c.code]?.$1 ?? c.code, 'place': c.place, 'outcome': c.outcome, 'status': c.status,
        'amount': c.amount, 'paid': c.paid, 'owed': c.owed, 'confidence': (c.confidence * 100).round(),
        'evidence': jsonDecode(c.evidence), 'settledBy': c.settledBy, 'appealResult': c.appealResult, 'at': c.createdAt.toIso8601String(),
        'appealable': c.appealResult == null && const {'paid', 'pending', 'caution', 'warning'}.contains(c.status) &&
            DateTime.now().toUtc().difference(c.createdAt) < const Duration(days: 7),
      };

  static Future<String> citations(Session session, UuidValue user) async {
    final rows = await PoliceCitation.db.find(session, where: (t) => t.authUserId.equals(user), orderBy: (t) => t.id.desc(), limit: 40);
    final w = await _save(session, await _load(session, user));
    return jsonEncode({'citations': rows.map(_view).toList(), ...await _status(session, w)});
  }

  /// Appeal a citation. First the evidence is checked again (a unit's real health at the time); if the city is no
  /// longer sure (under 0.8), it's overturned and refunded. Then WYRD's review: a fine resting on one kind of evidence,
  /// ₦4,000 or less, is reduced to a caution (refunded); bigger ones go to the owner's review; the rest stand.
  static Future<String> appeal(Session session, UuidValue user, int id, String reason) async {
    final c = await PoliceCitation.db.findById(session, id);
    if (c == null || c.authUserId != user) return jsonEncode({'error': 'No such citation.'});
    if (!(_view(c)['appealable'] as bool)) return jsonEncode({'error': 'This one can\'t be appealed now.'});
    final reasonText = reason.length > 200 ? reason.substring(0, 200) : reason;
    final evidence = (jsonDecode(c.evidence) as List).cast<Map<String, dynamic>>();
    final faulty = <String>[];
    final rechecked = [
      for (final e in evidence)
        if (e['source'] == 'unit') () {
          final (h, _) = unitHealth(e['id'] as String, c.createdAt);
          if (h < 1) faulty.add(e['id'] as String);
          return {...e, 'confidence': _source['unit']! * h};
        }() else e,
    ];
    final conf = confidence(rechecked);
    String result, say;
    var refund = 0, unowed = 0;
    if (conf < 0.8) {
      result = 'overturned';
      (refund, unowed) = await _undo(session, user, c, 'overturned');
      say = faulty.isNotEmpty
          ? 'I checked. Unit ${faulty.first} was reading wrong that day. Citation cancelled${refund > 0 ? ', ₦$refund back in your wallet' : ''}, and someone is going to fix it.'
          : 'I checked. The evidence doesn\'t hold. Citation cancelled${refund > 0 ? ', ₦$refund back in your wallet' : ''}.';
      if (faulty.isNotEmpty) CityWire.say('fault', 'WYRD: Unit ${faulty.first} was found reading wrong. Its citations are being refunded.');
    } else if (c.outcome == 'fine' && c.amount > 4000) {
      result = 'queued';
      say = 'This one is above what I decide alone. It\'s with the review queue now; any refund shows in your wallet.';
    } else if (c.outcome == 'fine' && evidence.map((e) => e['source']).toSet().length == 1) {
      result = 'reduced';
      (refund, unowed) = await _undo(session, user, c, 'caution');
      say = 'One source of evidence is enough to stop you, not enough to take your money. It stands as a caution${refund > 0 ? ', and ₦$refund is back' : ''}.';
    } else {
      result = 'upheld';
      say = 'The evidence holds: ${evidence.map((e) => e['source']).toSet().join(', ')} all saw it. It stands. You can still pay it off through your plan.';
    }
    await PoliceCitation.db.updateRow(session, (await PoliceCitation.db.findById(session, id))!.copyWith(appealReason: reasonText, appealResult: result));
    return jsonEncode({'result': result, 'say': say, 'refund': refund, 'unowed': unowed, 'citation': _view((await PoliceCitation.db.findById(session, id))!)});
  }

  /// Take back what a citation cost: the paid part refunded, the plan part taken off; status [to].
  static Future<(int, int)> _undo(Session session, UuidValue user, PoliceCitation c, String to) async {
    var refund = 0, unowed = 0;
    if (c.status == 'paid') {
      if (c.paid > 0) {
        final r = await Bank.post(session, user, key: 'appeal:${c.id}', amount: c.paid, kind: 'refund', counter: 'city:courts', memo: 'Refund: ${c.code} appeal');
        if (!r.repeat) refund = c.paid;
      }
      if (c.owed > 0) {
        final r = await Bank.owe(session, user, key: 'appeal:${c.id}:plan', amount: -c.owed, memo: '${c.code} appeal: ₦${c.owed} taken off your plan');
        if (!r.repeat) unowed = c.owed;
      }
    }
    await PoliceCitation.db.updateRow(session, c.copyWith(status: to));
    return (refund, unowed);
  }

  static Future<String> settings(Session session, UuidValue user, bool calm) async {
    var w = await _load(session, user);
    w = await _save(session, w.copyWith(calm: calm));
    return jsonEncode(await _status(session, w));
  }

  static String? _clean(Object? s) {
    if (s is! String) return null;
    final t = s.replaceAll(RegExp(r"[^A-Za-z0-9 /'&.,\-]"), '').trim();
    if (t.isEmpty) return null;
    return t.length > 60 ? t.substring(0, 60) : t;
  }
}
