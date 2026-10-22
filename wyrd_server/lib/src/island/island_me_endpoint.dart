import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import '../world/bank.dart';
import '../world/world_authority.dart';
import 'grid_career.dart';
import 'island_auth_endpoint.dart';
import 'island_endpoint.dart';
import 'island_payout.dart';
import '../rewards/funded_jobs.dart';
import '../rewards/reward_config.dart';
import '../rewards/reward_math.dart';
import '../rewards/withdrawals.dart';
import 'island_topup.dart';

/// LAGOS ISLAND for signed-in WYRD users: the phone in the game.
///
/// - Wallet: naira on the same balanced books as the rest of the city (Bank), earned at realistic
///   Lagos rates by shifts at the refinery and the clubs, capped a day; no cash in or out.
/// - Casino: play money only, small stakes, a daily loss limit.
/// - Jobs: real employers post real jobs; WYRD's operator checks each before it shows. A user's
///   skills are matched to jobs only when they choose to be open to work, and an employer sees an
///   applicant's handle, skills and note -- nothing more -- and only after they apply.
/// - Chats: end-to-end encrypted in the browser. The server stores ciphertext and wrapped keys; it
///   can't read a message, a group's name, or who said what inside it.
/// - HQ: everyone's own place on HQ Row: invite-only unless they open it.
/// - WYRD: asked from the phone, it hears what the user types and which district they're in. It never
///   sees their chats, and their wallet only as a number when they ask about money.
class IslandMeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session s) =>
      UuidValue.fromString(s.authenticated!.userIdentifier);
  static final _rnd = Random.secure();
  static String _clean(String s, int max) {
    final t = s
        .replaceAll(RegExp(r'[\u0000-\u0008\u000b-\u001f<>]'), '')
        .trim();
    return t.length > max ? t.substring(0, max) : t;
  }

  static String _err(String m) => jsonEncode({'error': m});

  // one money action at a time per person (as CityEndpoint)
  static final _queues = <String, Future<void>>{};
  static Future<String> _money(
    Session s,
    Future<String> Function(UuidValue u) work,
  ) {
    final u = _user(s);
    final before = _queues[u.uuid] ?? Future.value();
    final run = before.catchError((_) {}).then((_) => work(u));
    final done = run.then((_) {}, onError: (_) {});
    _queues[u.uuid] = done;
    done.whenComplete(() {
      if (identical(_queues[u.uuid], done)) _queues.remove(u.uuid);
    });
    return run;
  }

  // ---------------- profile ----------------
  static Future<IslandProfile> _profile(Session s, UuidValue u) async {
    final p = await IslandProfile.db.findFirstRow(
      s,
      where: (t) => t.authUserId.equals(u),
    );
    if (p != null) return p;
    final base = 'lagosian${u.uuid.replaceAll('-', '').substring(0, 6)}';
    return IslandProfile.db.insertRow(
      s,
      IslandProfile(
        authUserId: u,
        handle: base,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  static Map<String, dynamic> _profileJson(IslandProfile p) => {
    'handle': p.handle,
    'skills': p.skills,
    'openToWork': p.openToWork,
    'pubKey': p.pubKey,
    'look': p.look,
    'hq': {
      'name': p.hqName ?? "${p.handle}'s HQ",
      'color': p.hqColor,
      'locked': p.hqLocked,
      'invites': jsonDecode(p.hqInvites),
    },
  };

  /// Who I am on the island, my naira, and whether I can check job posts. JSON.
  /// Add my real email (an account made with only a username gets asked for it the first time the phone opens).
  Future<String> setEmail(Session session, String email) async {
    final err = await IslandAuthEndpoint.setEmail(session, _user(session), email);
    return err == null ? jsonEncode({'ok': true}) : _err(err);
  }

  /// Confirm my game ID with my email and game password before the phone opens.
  Future<String> confirmPhone(Session session, String email, String password) async {
    final err = await IslandAuthEndpoint.confirmPhone(session, _user(session), email, password);
    return err == null ? jsonEncode({'ok': true}) : _err(err);
  }

  Future<String> me(Session session) async {
    final u = _user(session);
    final p = await _profile(session, u);
    final c = await WorldAuthority.citizen(session, u);
    return jsonEncode({
      ..._profileJson(p),
      'ghost': p.ghost,
      'naira': c.naira,
      'send': await (() async { final (left, limit, isNew) = await _sendRoom(session, u, p); return {'left': left, 'limit': limit, 'newAccount': isNew}; })(),
      'earnedToday': await _earnedToday(session, u),
      'dailyCap': dailyCap,
      'operator': await DroneService.isOperator(session, u),
      'hasEmail': await IslandAuthEndpoint.hasEmail(session, u), // false: signed up with only a username; the phone asks once
      'requests': await IslandAccess.db.count(
        session,
        where: (t) => t.ownerId.equals(u) & t.status.equals('pending'),
      ),
    });
  }

  /// Change my handle, skills, open-to-work, or messaging key. Empty strings leave a field as it is.
  Future<String> setProfile(
    Session session,
    String handle,
    String skills,
    bool openToWork,
    String pubKey,
  ) async {
    final u = _user(session);
    var p = await _profile(session, u);
    final h = handle.trim();
    if (h.isNotEmpty && h != p.handle) {
      if (!RegExp(r'^[a-zA-Z0-9_.-]{3,20}$').hasMatch(h))
        return _err('A name of 3 to 20 letters, digits, _ . or -.');
      // taken in any case, or too like someone else's (or a reserved name): nobody renames into another player
      final taken = await IslandProfile.db.findFirstRow(
        session,
        where: (t) => t.handle.ilike(h.replaceAll('_', r'\_')) & t.authUserId.notEquals(u),
      );
      if (taken != null) return _err('That name is taken.');
      if (h.toLowerCase() != p.handle.toLowerCase() && await IslandAuthEndpoint.lookalike(session, h)) return _err('That name is too close to someone else\'s. Pick one that\'s clearly yours.');
      p = p.copyWith(handle: h);
    }
    p = p.copyWith(skills: _clean(skills, 300), openToWork: openToWork);
    if (pubKey.isNotEmpty) {
      if (pubKey.length > 600) return _err('Key too large.');
      try {
        final k = jsonDecode(pubKey) as Map<String, dynamic>;
        if (k['kty'] != 'EC' || k['crv'] != 'P-256' || k.containsKey('d'))
          return _err('Not a public P-256 key.');
      } catch (_) {
        return _err('Not a key.');
      }
      p = p.copyWith(pubKey: pubKey);
    }
    p = await IslandProfile.db.updateRow(session, p);
    return jsonEncode(_profileJson(p));
  }

  /// Ghost mode on or off: anonymous on the island (no name on the map or in chat, hidden from search and profiles, HQ
  /// and homes closed to visitors and knocks), still on the map as a light, homes still counted as lived in.
  Future<String> setGhost(Session session, bool on) async {
    final u = _user(session);
    final p = await IslandProfile.db.updateRow(session, (await _profile(session, u)).copyWith(ghost: on));
    IslandEndpoint.forget(u.uuid);
    return jsonEncode({'ghost': p.ghost});
  }

  /// Save how I look on the island (chosen when I joined; changeable in Profile).
  Future<String> setLook(Session session, String look) async {
    // g,skin,hair,style,bottom and, optionally, the outfit being worn (a free starter or one I've bought) and the
    // accessories worn on top, joined by + (each bought, one per slot)
    final m = RegExp(r'^[mf](,[0-9]{1,2}){4}(,([a-z0-9_]{0,30}))?(,([a-z0-9_+]{0,200}))?$').firstMatch(look);
    if (m == null) return _err('Bad look.');
    final outfit = (m.group(3) ?? '').isEmpty ? null : m.group(3);
    final accs = (m.group(5) ?? '').split('+').where((a) => a.isNotEmpty).toList();
    if (accs.length > 5) return _err('Five accessories at most.');
    final slots = <String>{};
    for (final a in accs) {
      final slot = accessorySlot(a), o = outfitCatalog[a];
      if (slot == null || o == null) return _err('That accessory is not in any shop.');
      if (!slots.add(slot)) return _err('One accessory per slot.');
      if (await IslandOutfit.db.findFirstRow(session, where: (t) => t.authUserId.equals(_user(session)) & t.item.equals(a)) == null) {
        return _err('Buy the ${o.name} first.');
      }
    }
    if (outfit != null) {
      final o = outfitCatalog[outfit];
      if (o == null || outfit.startsWith('acc_')) return _err('That outfit is not in any shop.');
      if (o.price > 0 &&
          await IslandOutfit.db.findFirstRow(
                session,
                where: (t) =>
                    t.authUserId.equals(_user(session)) & t.item.equals(outfit),
              ) ==
              null)
        return _err('Buy the ${o.name} first.');
    }
    final p = await _profile(session, _user(session));
    await IslandProfile.db.updateRow(session, p.copyWith(look: look));
    return jsonEncode({'look': look});
  }

  /// Someone's public messaging key, by handle: {handle, pubKey} or {error}.
  Future<String> keyOf(Session session, String handle) async {
    final p = await IslandProfile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(handle.trim()),
    );
    if (p == null) return _err('Nobody on the island by that name.');
    if (p.pubKey == null)
      return _err(
        '${p.handle} hasn\'t opened their phone yet, so they can\'t receive encrypted messages.',
      );
    return jsonEncode({'handle': p.handle, 'pubKey': p.pubKey});
  }

  // ---------------- work and wallet ----------------
  /// Pay for one shift, and how long it is (a shift can be paid once per [minutes] at each workplace).
  static const shifts = {
    'club': (pay: 4000, minutes: 10, memo: 'Night shift at the club'),
    'market': (pay: 2500, minutes: 6, memo: 'Helping at the market stall'),
    'okada': (pay: 1800, minutes: 4, memo: 'Okada rides'),
  };
  static const dailyCap = 35000;
  /// the most one player can send to others in 24 hours
  static const sendDaily = 20000, sendDailyNew = 5000;

  /// What I may still send today: (left, my daily limit, whether I'm new). A new account (its first day) sends less.
  static Future<(int, int, bool)> _sendRoom(Session s, UuidValue u, IslandProfile me) async {
    final newAcct = DateTime.now().toUtc().difference(me.createdAt) < const Duration(days: 1), limit = newAcct ? sendDailyNew : sendDaily;
    final dayAgo = DateTime.now().toUtc().subtract(const Duration(hours: 24));
    final sent = (await NairaEntry.db.find(s, where: (t) => t.authUserId.equals(u) & t.key.like('island:send:%:out') & (t.createdAt > dayAgo))).fold<int>(0, (a, e) => a - e.amount);
    return (max(0, limit - sent), limit, newAcct);
  }

  static Future<int> _earnedToday(Session s, UuidValue u) async {
    final day = DateTime.now().toUtc().add(const Duration(hours: 1));
    final start = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).subtract(const Duration(hours: 1));
    final rows = await NairaEntry.db.find(
      s,
      where: (t) =>
          t.authUserId.equals(u) &
          t.createdAt.between(start, start.add(const Duration(days: 1))) &
          t.key.like('island:shift:%'),
    );
    return rows.fold<int>(0, (a, e) => a + e.amount);
  }

  /// Work a shift at [place] (refinery, club, market, okada). Paid at Lagos rates, capped each day.
  Future<String> work(Session session, String place) => _money(session, (
    u,
  ) async {
    final sh = shifts[place];
    if (sh == null) return _err('Nobody is hiring for that here.');
    if (place == 'club') {
      final h = DateTime.now().toUtc().add(const Duration(hours: 1)).hour;
      if (h >= 6 && h < 18)
        return _err('The clubs open at 6 pm. Come back tonight.');
    }
    await WorldAuthority.citizen(session, u);
    final earned = await _earnedToday(session, u);
    if (earned >= dailyCap)
      return _err(
        'You\'ve worked enough for today (₦${_n(dailyCap)}). Rest, and come back tomorrow.',
      );
    // the work is being here: on the island, moving about, for the shift's length (a tap alone pays nothing)
    final me = await _profile(session, u);
    final (mins, moved) = IslandEndpoint.activity(me.handle);
    if (mins < sh.minutes) return _err('Stay on the island and keep working: a shift here is ${sh.minutes} minutes (you\'ve been here ${mins.floor()}).');
    if (moved < 150) return _err('Get moving: walk or ride around the area to work your shift.');
    final pay = min(sh.pay, dailyCap - earned);
    final bucket =
        DateTime.now().millisecondsSinceEpoch ~/ (sh.minutes * 60000);
    final r = await Bank.post(
      session,
      u,
      key: 'island:shift:${u.uuid}:$place:$bucket',
      amount: pay,
      kind: 'job',
      counter: place == 'club' ? 'city:services' : 'city:market',
      memo: sh.memo,
    );
    if (r.repeat)
      return _err(
        'Your shift here is done. The next one starts in a few minutes.',
      );
    IslandEndpoint.paidShift(me.handle);
    final c = await Bank.fresh(session, u);
    return jsonEncode({'paid': pay, 'naira': c.naira, 'memo': sh.memo});
  });

  /// The Earn board, from what the server knows for me right now: each workplace's pay (and what lands after the
  /// treasury's tax), whether a shift is open now or when the next one opens, the clubs' hours, what I've earned today
  /// (and whether today's work is done), my National Grid levels, the job board, and my last paydays.
  Future<String> earnBoard(Session session) async {
    final u = _user(session);
    await WorldAuthority.citizen(session, u);
    final now = DateTime.now(), ms = now.millisecondsSinceEpoch, lagosHour = now.toUtc().add(const Duration(hours: 1)).hour;
    final earned = await _earnedToday(session, u);
    final out = <Map<String, dynamic>>[];
    for (final e in shifts.entries) {
      final win = e.value.minutes * 60000, bucket = ms ~/ win;
      final done = await NairaEntry.db.findFirstRow(session, where: (t) => t.key.equals('island:shift:${u.uuid}:${e.key}:$bucket')) != null;
      final closed = e.key == 'club' && lagosHour >= 6 && lagosHour < 18;
      out.add({
        'place': e.key, 'pay': e.value.pay, 'net': e.value.pay - Bank.taxOn(e.value.pay, 'job'), 'minutes': e.value.minutes, 'memo': e.value.memo,
        'ready': !done && !closed, 'nextAt': done ? DateTime.fromMillisecondsSinceEpoch((bucket + 1) * win).toUtc().toIso8601String() : null,
        if (e.key == 'club') 'hours': '6 pm to 6 am', if (closed) 'opensAt': '6 pm',
      });
    }
    final recent = await NairaEntry.db.find(session, where: (t) => t.authUserId.equals(u) & t.kind.equals('job'), orderBy: (t) => t.id.desc(), limit: 30);
    final jobs = await IslandJob.db.count(session, where: (t) => t.status.equals('open'));
    Map<String, dynamic> grid = const {};
    try { grid = await GridCareer.all(session, u); } catch (_) {}
    return jsonEncode({
      'shifts': out, 'earnedToday': earned, 'doneForToday': earned >= dailyCap, 'taxRate': Bank.taxRate,
      'grid': grid['tracks'] ?? {}, 'jobsOpen': jobs,
      'recent': [for (final r in recent) {'memo': r.memo, 'amount': r.amount, 'at': r.createdAt.toIso8601String()}],
    });
  }

  /// The player's National Grid career, as the server keeps it: level and experience on each track, recent shifts.
  Future<String> gridCareer(Session session) async {
    try {
      return jsonEncode(await GridCareer.all(session, _user(session)));
    } on GridRefused catch (e) {
      return _err(e.message);
    }
  }

  /// Start a shift on [track]: the server deals the tasks and keeps the answers.
  Future<String> gridStart(Session session, String track) => _money(session, (u) async {
        try {
          await WorldAuthority.citizen(session, u);
          return jsonEncode(await GridCareer.start(session, u, track));
        } on GridRefused catch (e) {
          return _err(e.message);
        }
      });

  /// Hand in a shift: [results] is what the player did in each task, as JSON. The server replays and scores it, adds
  /// the experience, and pays by the level it keeps and the score it worked out: one paid shift every 40 minutes,
  /// within the daily cap.
  Future<String> gridFinish(Session session, int workId, String results) => _money(session, (u) async {
        try {
          final (w, scores, c) = await GridCareer.finish(session, u, workId, results);
          final score = w.score!;
          var pay = 0;
          String? note;
          final earned = await _earnedToday(session, u);
          if (earned >= dailyCap) {
            note = 'You\'ve worked enough for today (₦${_n(dailyCap)}). The shift counts for your experience; pay starts again tomorrow.';
          } else {
            pay = min(GridCareer.payFor(w.level, score), dailyCap - earned);
            final bucket = DateTime.now().millisecondsSinceEpoch ~/ (40 * 60000);
            final r = await Bank.post(session, u, key: 'island:shift:${u.uuid}:${GridCareer.placeOf(w.track)}:$bucket', amount: pay, kind: 'job', counter: 'city:services', memo: GridCareer.memoOf(w.track));
            if (r.repeat) {
              pay = 0;
              note = 'One paid shift every 40 minutes. This one counts for your experience.';
            }
          }
          if (pay > 0) await GridCareer.setPaid(session, w.id!, pay);
          final cash = await Bank.fresh(session, u);
          return jsonEncode({
            'score': score, 'scores': scores, 'paid': pay, if (note != null) 'note': note, 'naira': cash.naira, 'memo': GridCareer.memoOf(w.track),
            'level': c.level, 'xp': c.xp, 'canExam': c.level < 5 && c.xp >= GridCareer.xpFor[c.level],
          });
        } on GridRefused catch (e) {
          return _err(e.message);
        }
      });

  /// The certification exam for the next level on [track] (needs the experience); the server sets and marks it.
  Future<String> gridExamStart(Session session, String track) async {
    try {
      return jsonEncode(await GridCareer.examStart(session, _user(session), track));
    } on GridRefused catch (e) {
      return _err(e.message);
    }
  }

  Future<String> gridExamAnswer(Session session, int workId, String answers) async {
    try {
      return jsonEncode(await GridCareer.examAnswer(session, _user(session), workId, answers));
    } on GridRefused catch (e) {
      return _err(e.message);
    }
  }

  /// The old shift report (the phone chose its own level and score). Kept so an old page gets an answer, not an error.
  Future<String> gridShift(Session session, int level, int score) async => _err('Update the game: reload the page to keep working at the Grid.');

  static String _n(int v) => v.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );

  /// My last receipts (JSON list).
  Future<String> receipts(Session session) async {
    final u = _user(session);
    final rows = await NairaEntry.db.find(
      session,
      where: (t) => t.authUserId.equals(u),
      orderBy: (t) => t.id.desc(),
      limit: 30,
    );
    return jsonEncode(rows.map(Bank.receipt).toList());
  }

  /// Send naira to another person by handle (at most ₦50,000 at a time).
  Future<String> send(
    Session session,
    String handle,
    int amount,
    String note,
  ) => _money(session, (u) async {
    if (amount < 50 || amount > 50000)
      return _err('Send between ₦50 and ₦50,000.');
    final to = await _byHandle(session, handle.trim().replaceFirst(RegExp(r'^@'), '')); // any capitals, with or without the @
    if (to == null) return _err('Nobody on the island by that name.');
    if (to.authUserId == u) return _err('That\'s you.');
    final me = await _profile(session, u);
    // new accounts can't send, and each sender has a daily limit, so a crowd of new accounts can't funnel naira to one
    // a new account (its first 3 days) sends a little; after that the full daily amount
    final (room, limit, newAcct) = await _sendRoom(session, u, me);
    if (amount > room) return _err(room == 0 ? 'You have sent all you can today (₦${_n(limit)} a day${newAcct ? ' on your first day' : ''}). Try again tomorrow.' : 'You can send ₦${_n(room)} more today (₦${_n(limit)} a day${newAcct ? ' on your first day' : ''}).');
    await WorldAuthority.citizen(session, to.authUserId);
    final id =
        '${DateTime.now().microsecondsSinceEpoch}${_rnd.nextInt(1 << 16)}';
    final memo = _clean(note, 60);
    final out = await Bank.post(
      session,
      u,
      key: 'island:send:$id:out',
      amount: -amount,
      kind: 'fee',
      counter: 'city:services',
      memo: 'To ${to.handle}${memo.isEmpty ? '' : ': $memo'}',
    );
    if (out.short != null) return _err('You don\'t have that much.');
    await Bank.post(
      session,
      to.authUserId,
      key: 'island:send:$id:in',
      amount: amount,
      kind: 'refund',
      counter: 'city:services',
      memo: 'From ${me.handle}${memo.isEmpty ? '' : ': $memo'}',
    );
    final c = await Bank.fresh(session, u);
    return jsonEncode({'sent': amount, 'to': to.handle, 'naira': c.naira});
  });

  // ---------------- casino ----------------
  static const _lossLimit = 10000;

  /// One round. [game]: roulette (bet red | black | green) or slots. [stake]: ₦100 to ₦5,000.
  /// Play money only, with a daily loss limit.
  Future<String> casino(
    Session session,
    String game,
    String bet,
    int stake,
  ) => _money(session, (u) async {
    if (stake < 100 || stake > 5000) return _err('Stakes are ₦100 to ₦5,000.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < stake) return _err('You don\'t have ₦${_n(stake)}.');
    final day = DateTime.now().toUtc().add(const Duration(hours: 1));
    final start = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).subtract(const Duration(hours: 1));
    final today = await NairaEntry.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(u) &
          t.createdAt.between(start, start.add(const Duration(days: 1))) &
          t.key.like('island:casino:%'),
    );
    final net = today.fold<int>(0, (a, e) => a + e.amount);
    if (-net >= _lossLimit)
      return _err(
        'You\'ve hit today\'s limit (₦${_n(_lossLimit)} lost). The casino closes for you until tomorrow.',
      );
    int payout; // what comes back, stake included
    Map<String, dynamic> show;
    if (game == 'roulette') {
      if (!{'red', 'black', 'green'}.contains(bet))
        return _err('Bet red, black or green.');
      final n = _rnd.nextInt(37); // 0 is green
      const reds = {
        1,
        3,
        5,
        7,
        9,
        12,
        14,
        16,
        18,
        19,
        21,
        23,
        25,
        27,
        30,
        32,
        34,
        36,
      };
      final colour = n == 0
          ? 'green'
          : reds.contains(n)
          ? 'red'
          : 'black';
      payout = colour == bet ? (bet == 'green' ? stake * 14 : stake * 2) : 0;
      show = {'number': n, 'colour': colour};
    } else if (game == 'slots') {
      const reel = ['🌴', '🌴', '🌴', '🛵', '🛵', '🥥', '🥥', '⭐', '💎'];
      final r = [for (var i = 0; i < 3; i++) reel[_rnd.nextInt(reel.length)]];
      final three = r[0] == r[1] && r[1] == r[2];
      final two = !three && (r[0] == r[1] || r[1] == r[2] || r[0] == r[2]);
      final mult = three
          ? {'💎': 30, '⭐': 15, '🥥': 8, '🛵': 6, '🌴': 4}[r[0]]!
          : two
          ? 1
          : 0;
      payout = stake * mult;
      show = {'reels': r};
    } else {
      return _err('No such table.');
    }
    final amount = payout - stake;
    final key =
        'island:casino:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}';
    if (amount != 0) {
      await Bank.post(
        session,
        u,
        key: key,
        amount: amount,
        kind: amount > 0 ? 'place' : 'fee',
        counter: 'city:market',
        memo: game == 'roulette' ? 'Casino: roulette' : 'Casino: slots',
      );
    }
    final after = await Bank.fresh(session, u);
    return jsonEncode({...show, 'won': amount, 'naira': after.naira});
  });

  // ---------------- jobs ----------------
  static Set<String> _words(String s) => s
      .toLowerCase()
      .split(RegExp(r'[,;/]+'))
      .map((w) => w.trim())
      .where((w) => w.length > 1)
      .toSet();

  static Map<String, dynamic> _jobJson(
    IslandJob j, {
    bool contact = false,
    int? match,
  }) => {
    'id': j.id,
    'company': j.company,
    'title': j.title,
    'pay': j.pay,
    'skills': j.skills,
    'location': j.location,
    'about': j.about,
    'status': j.status,
    if (contact) 'contact': j.contact,
    if (match != null) 'match': match,
    'at': j.createdAt.toIso8601String(),
  };

  /// The job board: open jobs, best matches first when I'm open to work (WYRD compares my skills with
  /// each job's, here on the server, for me only), with the ones I've applied to marked.
  Future<String> jobs(Session session) async {
    final u = _user(session);
    final p = await _profile(session, u);
    final open = await IslandJob.db.find(
      session,
      where: (t) => t.status.equals('open'),
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
    final mine = await IslandApplication.db.find(
      session,
      where: (t) => t.authUserId.equals(u),
    );
    final applied = {for (final a in mine) a.jobId};
    final have = p.openToWork ? _words(p.skills) : <String>{};
    final list = [
      for (final j in open)
        () {
          final need = _words(j.skills);
          final hit = need
              .where((w) => have.any((h) => h.contains(w) || w.contains(h)))
              .length;
          final m = have.isEmpty || need.isEmpty
              ? null
              : (100 * hit / need.length).round();
          return {
            ..._jobJson(j, contact: applied.contains(j.id), match: m),
            'applied': applied.contains(j.id),
          };
        }(),
    ];
    if (have.isNotEmpty)
      list.sort(
        (a, b) =>
            ((b['match'] ?? 0) as int).compareTo((a['match'] ?? 0) as int),
      );
    return jsonEncode(list);
  }

  /// Post a real job. It shows once WYRD's operator has checked it.
  Future<String> postJob(
    Session session,
    String company,
    String title,
    String pay,
    String skills,
    String location,
    String about,
    String contact,
  ) async {
    final u = _user(session);
    final f = [
      company,
      title,
      pay,
      skills,
      location,
      about,
      contact,
    ].map((v) => v.trim()).toList();
    if (f.any((v) => v.isEmpty)) return _err('Fill in every field.');
    final recent = await IslandJob.db.count(
      session,
      where: (t) =>
          t.employerUserId.equals(u) &
          (t.createdAt >
              DateTime.now().toUtc().subtract(const Duration(days: 1))),
    );
    if (recent >= 5) return _err('Five posts a day at most.');
    final j = await IslandJob.db.insertRow(
      session,
      IslandJob(
        employerUserId: u,
        company: _clean(company, 80),
        title: _clean(title, 80),
        pay: _clean(pay, 60),
        skills: _clean(skills, 200),
        location: _clean(location, 80),
        about: _clean(about, 1200),
        contact: _clean(contact, 160),
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return jsonEncode(_jobJson(j, contact: true));
  }

  /// Apply: the employer sees my handle, my skills and [note].
  Future<String> apply(Session session, int jobId, String note) async {
    final u = _user(session);
    final j = await IslandJob.db.findById(session, jobId);
    if (j == null || j.status != 'open')
      return _err('That job is no longer open.');
    if (j.employerUserId == u) return _err('That\'s your own post.');
    final had = await IslandApplication.db.findFirstRow(
      session,
      where: (t) => t.jobId.equals(jobId) & t.authUserId.equals(u),
    );
    if (had != null) return jsonEncode({'applied': true, 'contact': j.contact});
    await IslandApplication.db.insertRow(
      session,
      IslandApplication(
        jobId: jobId,
        authUserId: u,
        note: _clean(note, 800),
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return jsonEncode({'applied': true, 'contact': j.contact});
  }

  /// My posts, each with who applied: their handle, skills and note.
  Future<String> myJobs(Session session) async {
    final u = _user(session);
    final posts = await IslandJob.db.find(
      session,
      where: (t) => t.employerUserId.equals(u),
      orderBy: (t) => t.createdAt.desc(),
    );
    final out = [];
    for (final j in posts) {
      final apps = await IslandApplication.db.find(
        session,
        where: (t) => t.jobId.equals(j.id!),
        orderBy: (t) => t.createdAt,
      );
      final people = <Map<String, dynamic>>[];
      for (final a in apps) {
        final p = await _profile(session, a.authUserId);
        people.add({
          'handle': p.handle,
          'skills': p.skills,
          'note': a.note,
          'at': a.createdAt.toIso8601String(),
        });
      }
      out.add({..._jobJson(j, contact: true), 'applicants': people});
    }
    return jsonEncode(out);
  }

  /// Close one of my posts.
  Future<String> closeJob(Session session, int jobId) async {
    final u = _user(session);
    final j = await IslandJob.db.findById(session, jobId);
    if (j == null || j.employerUserId != u) return _err('Not your post.');
    await IslandJob.db.updateRow(session, j.copyWith(status: 'closed'));
    return jsonEncode({'closed': jobId});
  }

  /// The operator's queue: posts waiting to be checked.
  Future<String> pendingJobs(Session session) async {
    if (!await DroneService.isOperator(session, _user(session)))
      return _err('Operators only.');
    final rows = await IslandJob.db.find(
      session,
      where: (t) => t.status.equals('pending'),
      orderBy: (t) => t.createdAt,
    );
    return jsonEncode([for (final j in rows) _jobJson(j, contact: true)]);
  }

  /// The operator approves (open) or rejects a post.
  Future<String> reviewJob(Session session, int jobId, bool approve) async {
    if (!await DroneService.isOperator(session, _user(session)))
      return _err('Operators only.');
    final j = await IslandJob.db.findById(session, jobId);
    if (j == null) return _err('No such post.');
    await IslandJob.db.updateRow(
      session,
      j.copyWith(status: approve ? 'open' : 'rejected'),
    );
    return jsonEncode({'id': jobId, 'status': approve ? 'open' : 'rejected'});
  }

  // ---------------- encrypted chats ----------------
  static bool _b64(String s, int max) =>
      s.length <= max &&
      RegExp(r'^[A-Za-z0-9+/=]+\.[A-Za-z0-9+/=]+$').hasMatch(s);

  /// Start a chat. [members]: JSON list of {handle, wrappedKey} -- me included -- each with the group
  /// key wrapped (in my browser) for that person, using my public key [wrapperPub].
  Future<String> createGroup(
    Session session,
    String nameCt,
    String wrapperPub,
    String members,
  ) async {
    final u = _user(session);
    if (!_b64(nameCt, 400)) return _err('Bad name.');
    final list = (jsonDecode(members) as List).cast<Map<String, dynamic>>();
    if (list.length < 2 || list.length > 50)
      return _err('A chat has 2 to 50 people.');
    final now = DateTime.now().toUtc();
    final rows = <IslandMember>[];
    var hasMe = false;
    for (final m in list) {
      final p = await IslandProfile.db.findFirstRow(
        session,
        where: (t) => t.handle.equals('${m['handle']}'),
      );
      final wk = '${m['wrappedKey']}';
      if (p == null || !_b64(wk, 300))
        return _err('Unknown member ${m['handle']}.');
      if (p.authUserId == u) hasMe = true;
      rows.add(
        IslandMember(
          groupId: 0,
          authUserId: p.authUserId,
          wrappedKey: wk,
          wrapperPub: wrapperPub,
          addedAt: now,
        ),
      );
    }
    if (!hasMe) return _err('Include yourself.');
    final who = {for (final r in rows) r.authUserId.uuid}.toList()..sort();
    if (who.length != rows.length) return _err('Someone is in the list twice.');
    final sig = '${u.uuid}|${who.join(',')}';
    final recent = _made[sig];
    if (recent != null && DateTime.now().difference(recent.$2) < const Duration(seconds: 30)) return jsonEncode({'id': recent.$1, 'existing': true});
    if (rows.length == 2) {
      final other = rows.firstWhere((r) => r.authUserId != u).authUserId;
      final mineIds = {for (final m in await IslandMember.db.find(session, where: (t) => t.authUserId.equals(u))) m.groupId};
      if (mineIds.isNotEmpty) {
        final both = {for (final m in await IslandMember.db.find(session, where: (t) => t.groupId.inSet(mineIds) & t.authUserId.equals(other))) m.groupId};
        if (both.isNotEmpty) {
          final all = await IslandMember.db.find(session, where: (t) => t.groupId.inSet(both));
          for (final gid in both) {
            if (all.where((m) => m.groupId == gid).length == 2) return jsonEncode({'id': gid, 'existing': true});
          }
        }
      }
    }
    final g = await IslandGroup.db.insertRow(
      session,
      IslandGroup(createdBy: u, nameCt: nameCt, createdAt: now),
    );
    await IslandMember.db.insert(session, [
      for (final r in rows) r.copyWith(groupId: g.id!),
    ]);
    _made[sig] = (g.id!, DateTime.now());
    if (_made.length > 2000) _made.removeWhere((_, v) => DateTime.now().difference(v.$2) > const Duration(minutes: 1));
    return jsonEncode({'id': g.id});
  }
  static final _made = <String, (int, DateTime)>{}; // who made which chat with whom, just now (a second tap opens the same one)
  static final _posted = <String, (int, DateTime)>{}; // a message's id by the phone's own id for it, for 10 minutes

  /// Post a message with the phone's own id for it ([cid]): sending it again (a retry after a dropped connection,
  /// a double tap) returns the first one instead of posting it twice.
  Future<String> postOnce(Session session, int groupId, String ct, String cid) async {
    final u = _user(session);
    if (cid.isEmpty || cid.length > 64) return _err('Bad message.');
    final k = '${u.uuid}|$cid', was = _posted[k];
    if (was != null) return jsonEncode({'id': was.$1, 'again': true});
    final r = jsonDecode(await post(session, groupId, ct));
    if (r is Map && r['id'] is int) {
      _posted[k] = (r['id'] as int, DateTime.now());
      if (_posted.length > 5000) _posted.removeWhere((_, v) => DateTime.now().difference(v.$2) > const Duration(minutes: 10));
    }
    return jsonEncode(r);
  }

  /// Add someone to a chat I'm in, with the group key wrapped for them.
  Future<String> addMember(
    Session session,
    int groupId,
    String handle,
    String wrappedKey,
    String wrapperPub,
  ) async {
    final u = _user(session);
    if (await IslandMember.db.findFirstRow(
          session,
          where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u),
        ) ==
        null)
      return _err('Not your chat.');
    final p = await IslandProfile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(handle),
    );
    if (p == null || !_b64(wrappedKey, 300)) return _err('Unknown person.');
    if (await IslandMember.db.count(
          session,
          where: (t) => t.groupId.equals(groupId),
        ) >=
        50)
      return _err('The chat is full.');
    await IslandMember.db.insertRow(
      session,
      IslandMember(
        groupId: groupId,
        authUserId: p.authUserId,
        wrappedKey: wrappedKey,
        wrapperPub: wrapperPub,
        addedAt: DateTime.now().toUtc(),
      ),
    );
    return jsonEncode({'added': p.handle});
  }

  /// Leave a chat.
  Future<String> leaveGroup(Session session, int groupId) async {
    final u = _user(session);
    await IslandMember.db.deleteWhere(
      session,
      where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u),
    );
    return jsonEncode({'left': groupId});
  }

  /// My chats: each with its encrypted name, my wrapped key, who's in it, and the last message's id.
  Future<String> groups(Session session) async {
    final u = _user(session);
    final mine = await IslandMember.db.find(
      session,
      where: (t) => t.authUserId.equals(u),
    );
    final out = [];
    for (final m in mine) {
      final g = await IslandGroup.db.findById(session, m.groupId);
      if (g == null) continue;
      final members = await IslandMember.db.find(
        session,
        where: (t) => t.groupId.equals(g.id!),
      );
      final handles = <String>[];
      for (final x in members)
        handles.add((await _profile(session, x.authUserId)).handle);
      final last = await IslandMessage.db.findFirstRow(
        session,
        where: (t) => t.groupId.equals(g.id!),
        orderBy: (t) => t.id.desc(),
      );
      out.add({
        'id': g.id,
        'nameCt': g.nameCt,
        'wrappedKey': m.wrappedKey,
        'wrapperPub': m.wrapperPub,
        'members': handles,
        'last': last?.id ?? 0,
      });
    }
    out.sort((a, b) => (b['last'] as int).compareTo(a['last'] as int));
    return jsonEncode(out);
  }

  /// Every chat I'm in, in one go: its key material (as [groups]), its members, its latest message (still encrypted)
  /// and how many messages I haven't seen ([seenJson]: {groupId: last seen message id}). One request for the Link app's
  /// list and for the new-message notifications, instead of one per chat; the queries are batched too.
  Future<String> inbox(Session session, String seenJson) async {
    final u = _user(session);
    Map<String, dynamic> seen = const {};
    try {
      seen = (jsonDecode(seenJson) as Map).cast<String, dynamic>();
    } catch (_) {}
    final mine = await IslandMember.db.find(session, where: (t) => t.authUserId.equals(u));
    if (mine.isEmpty) return '[]';
    final gids = {for (final m in mine) m.groupId};
    final groups = {for (final g in await IslandGroup.db.find(session, where: (t) => t.id.inSet(gids))) g.id!: g};
    final members = await IslandMember.db.find(session, where: (t) => t.groupId.inSet(gids));
    final handles = {
      for (final p in await IslandProfile.db.find(session, where: (t) => t.authUserId.inSet({for (final m in members) m.authUserId}))) p.authUserId.uuid: p.handle,
    };
    final out = <Map<String, dynamic>>[];
    final live = [for (final m in mine) if (groups[m.groupId] != null) m];
    final lasts = await Future.wait([for (final m in live) IslandMessage.db.findFirstRow(session, where: (t) => t.groupId.equals(m.groupId), orderBy: (t) => t.id.desc())]);
    final unreads = await Future.wait([
      for (var i = 0; i < live.length; i++)
        () {
          final s = (seen['${live[i].groupId}'] as num?)?.toInt() ?? 0, last = lasts[i];
          return last == null || last.id! <= s ? Future.value(0) : IslandMessage.db.count(session, where: (t) => t.groupId.equals(live[i].groupId) & (t.id > s) & t.senderId.notEquals(u));
        }(),
    ]);
    for (var i = 0; i < live.length; i++) {
      final m = live[i], g = groups[m.groupId]!, last = lasts[i], unread = unreads[i];
      out.add({
        'id': g.id,
        'nameCt': g.nameCt,
        'wrappedKey': m.wrappedKey,
        'wrapperPub': m.wrapperPub,
        'members': [for (final x in members) if (x.groupId == g.id) handles[x.authUserId.uuid] ?? '?'],
        'last': last?.id ?? 0,
        if (last != null) 'lastMsg': {'id': last.id, 'from': handles[last.senderId.uuid] ?? '?', 'mine': last.senderId == u, 'ct': last.ct, 'at': last.createdAt.toIso8601String()},
        'unread': unread,
      });
    }
    out.sort((a, b) => (b['last'] as int).compareTo(a['last'] as int));
    return jsonEncode(out);
  }

  /// Post an encrypted message to a chat I'm in.
  static final _sent = <String, List<DateTime>>{};
  Future<String> post(Session session, int groupId, String ct) async {
    final u = _user(session);
    if (!_b64(ct, 8000)) return _err('Bad message.');
    final now0 = DateTime.now(), times = (_sent[u.uuid] ??= [])..removeWhere((t) => now0.difference(t) > const Duration(seconds: 10));
    if (times.length >= 20) return _err('Slow down a little: too many messages at once.');
    times.add(now0);
    if (await IslandMember.db.findFirstRow(
          session,
          where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u),
        ) ==
        null)
      return _err('Not your chat.');
    final m = await IslandMessage.db.insertRow(
      session,
      IslandMessage(
        groupId: groupId,
        senderId: u,
        ct: ct,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    // a message ends the sender's typing and wakes everyone waiting on the chat
    final h = (await _profile(session, u)).handle;
    _typing[groupId]?.remove(h);
    _bump(groupId);
    for (final mb in await IslandMember.db.find(session, where: (t) => t.groupId.equals(groupId))) {
      if (mb.authUserId != u) _ping(mb.authUserId, session);
    }
    return jsonEncode({'id': m.id});
  }

  /// A chat's messages after [since] (at most 100), as ciphertext with the sender's handle.
  Future<String> messages(Session session, int groupId, int since) async {
    final u = _user(session);
    if (await IslandMember.db.findFirstRow(
          session,
          where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u),
        ) ==
        null)
      return _err('Not your chat.');
    final rows = await IslandMessage.db.find(
      session,
      where: (t) => t.groupId.equals(groupId) & (t.id > since),
      orderBy: (t) => since == 0 ? t.id.desc() : t.id.asc(),
      limit: 100,
    );
    final list = since == 0 ? rows.reversed.toList() : rows;
    final names = <String, String>{};
    final out = [];
    for (final m in list) {
      names[m.senderId.uuid] ??= (await _profile(session, m.senderId)).handle;
      out.add({
        'id': m.id,
        'from': names[m.senderId.uuid],
        'mine': m.senderId == u,
        'ct': m.ct,
        'at': m.createdAt.toIso8601String(),
      });
    }
    return jsonEncode(out);
  }


  // ---------------- live chat: instant delivery, typing, read receipts ----------------
  // Each chat has a version that goes up whenever something happens in it (a message, someone typing, someone reading).
  // A phone with the chat open asks [live] with the version it has; the server holds the request until the version moves
  // (or 20 seconds pass) and answers at once, so a message lands the moment it's sent. Typing and read marks are kept in
  // memory: they're about now, and say nothing about what's in a message.
  static final _ver = <int, int>{};
  static final _waiters = <int, List<Completer<void>>>{};
  static final _typing = <int, Map<String, DateTime>>{}; // group -> handle -> typing until
  static final _reads = <int, Map<String, int>>{}; // group -> handle -> last message id read
  static void _bump(int groupId) {
    _ver[groupId] = (_ver[groupId] ?? 0) + 1;
    final ws = _waiters.remove(groupId) ?? [];
    for (final c in ws) {
      if (!c.isCompleted) c.complete();
    }
  }

  Future<bool> _member(Session session, int groupId, UuidValue u) async =>
      await IslandMember.db.findFirstRow(
        session,
        where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u),
      ) !=
      null;

  /// Wait (up to 20 s) for anything new in a chat after [since] / version [ver]; returns the new messages, who's typing
  /// (and for how much longer), how far each other member has read, and the chat's version now.
  Future<String> live(Session session, int groupId, int since, int ver) async {
    final u = _user(session);
    if (!await _member(session, groupId, u)) return _err('Not your chat.');
    final me = (await _profile(session, u)).handle;
    final end = DateTime.now().add(const Duration(seconds: 20));
    while ((_ver[groupId] ?? 0) == ver && DateTime.now().isBefore(end)) {
      final c = Completer<void>();
      (_waiters[groupId] ??= []).add(c);
      await c.future.timeout(end.difference(DateTime.now()), onTimeout: () {});
      _waiters[groupId]?.remove(c);
    }
    final msgs = jsonDecode(await messages(session, groupId, since));
    final now = DateTime.now();
    final typing = [
      for (final e in (_typing[groupId] ?? {}).entries)
        if (e.key != me && e.value.isAfter(now))
          {'h': e.key, 'ms': e.value.difference(now).inMilliseconds},
    ];
    final reads = {
      for (final e in (_reads[groupId] ?? {}).entries)
        if (e.key != me) e.key: e.value,
    };
    return jsonEncode({
      'messages': msgs,
      'typing': typing,
      'reads': reads,
      'ver': _ver[groupId] ?? 0,
    });
  }

  /// I'm typing in a chat (sent every few seconds while I type; it lapses on its own).
  Future<String> typing(Session session, int groupId) async {
    final u = _user(session);
    if (!await _member(session, groupId, u)) return _err('Not your chat.');
    final me = (await _profile(session, u)).handle;
    (_typing[groupId] ??= {})[me] =
        DateTime.now().add(const Duration(seconds: 5));
    _bump(groupId);
    return jsonEncode({'ok': true});
  }

  /// I've read a chat up to message [upTo].
  Future<String> read(Session session, int groupId, int upTo) async {
    final u = _user(session);
    if (!await _member(session, groupId, u)) return _err('Not your chat.');
    final me = (await _profile(session, u)).handle;
    final m = _reads[groupId] ??= {};
    if ((m[me] ?? 0) >= upTo) return jsonEncode({'ok': true});
    m[me] = upTo;
    _bump(groupId);
    return jsonEncode({'ok': true});
  }

  // ---------------- HQ ----------------
  /// Set up my HQ: its name, colour, whether it's locked, and who's invited (JSON list of handles).
  Future<String> setHq(
    Session session,
    String name,
    String color,
    bool locked,
    String invites,
  ) async {
    final u = _user(session);
    final p = await _profile(session, u);
    if (!RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color))
      return _err('Bad colour.');
    final list = (jsonDecode(invites) as List)
        .map((e) => '$e'.trim())
        .where((e) => e.isNotEmpty)
        .take(40)
        .toList();
    final saved = await IslandProfile.db.updateRow(
      session,
      p.copyWith(
        hqName: _clean(name, 40),
        hqColor: color,
        hqLocked: locked,
        hqInvites: jsonEncode(list),
      ),
    );
    return jsonEncode(_profileJson(saved)['hq']);
  }

  /// HQ Row: every HQ, with whether I may go in (mine, open, or I'm invited). Names show only for
  /// HQs I may enter.
  Future<String> hqRow(Session session) async {
    final u = _user(session);
    final me = await _profile(session, u);
    final all = await IslandProfile.db.find(
      session,
      orderBy: (t) => t.id,
      limit: 300,
    );
    final asked = {
      for (final a in await IslandAccess.db.find(
        session,
        where: (t) => t.requesterId.equals(u),
      ))
        a.ownerId.uuid: a.status,
    };
    return jsonEncode([
      for (final p in all)
        () {
          final mine = p.authUserId == u;
          // a ghost's BQ: lived in, but nameless and closed to everyone
          if (p.ghost && !mine) return {'slot': p.id, 'resident': 'Private resident', 'color': p.hqColor, 'mine': false, 'may': false, 'ghost': true};
          final may =
              mine ||
              !p.hqLocked ||
              (jsonDecode(p.hqInvites) as List).contains(me.handle);
          final req = asked[p.authUserId.uuid];
          return {
            'slot': p.id,
            'resident': p.handle, // HQ Row is public: each BQ's resident, shouted out on the Row's billboard
            'color': p.hqColor,
            'mine': mine,
            'may': may,
            if (!may && req != null) 'asked': req,
            if (may) 'name': p.hqName ?? "${p.handle}'s HQ",
            if (may) 'owner': p.handle,
          };
        }(),
    ]);
  }

  // ---- the HQ Row board: a resident's own announcement, shown to everyone for a day (one at a time each, a new one at
  // most every 2 hours); kept in memory, so a restart clears the board
  static final _board = <String, ({String by, String text, DateTime at})>{};

  /// Put my announcement on the HQ Row board (an empty [text] takes it down).
  Future<String> boardPost(Session session, String text) async {
    final u = _user(session), p = await _profile(session, u), t = _clean(text, 80), now = DateTime.now();
    if (t.isEmpty) {
      _board.remove(u.uuid);
      return jsonEncode({'ok': true});
    }
    final had = _board[u.uuid];
    if (had != null && now.difference(had.at) < const Duration(hours: 2)) return _err('One announcement every 2 hours. Yours is still up.');
    _board[u.uuid] = (by: p.ghost ? 'A neighbour' : p.handle, text: t, at: now);
    return jsonEncode({'ok': true});
  }

  /// What's on the HQ Row board now: residents' announcements from the last day, newest first.
  Future<String> board(Session session) async {
    final u = _user(session), now = DateTime.now();
    _board.removeWhere((_, v) => now.difference(v.at) > const Duration(hours: 24));
    final list = _board.entries.toList()..sort((a, b) => b.value.at.compareTo(a.value.at));
    return jsonEncode([for (final e in list.take(12)) {'by': e.value.by, 'text': e.value.text, 'mine': e.key == u.uuid, 'at': e.value.at.toUtc().toIso8601String()}]);
  }

  /// Ask to enter the HQ in [slot] (from hqRow). The owner gets the request on their phone.
  Future<String> askHq(Session session, int slot) async {
    final u = _user(session);
    final owner = await IslandProfile.db.findById(session, slot);
    if (owner == null) return _err('No HQ there.');
    if (owner.authUserId == u) return jsonEncode({'status': 'granted'});
    if (owner.ghost) return _err('This resident isn\'t taking visitors.');
    final had = await IslandAccess.db.findFirstRow(
      session,
      where: (t) =>
          t.ownerId.equals(owner.authUserId) & t.requesterId.equals(u),
    );
    if (had != null) {
      if (had.status == 'denied' &&
          DateTime.now().toUtc().difference(had.createdAt).inHours >= 24) {
        await IslandAccess.db.updateRow(
          session,
          had.copyWith(status: 'pending', createdAt: DateTime.now().toUtc()),
        );
        return jsonEncode({'status': 'pending'});
      }
      return jsonEncode({'status': had.status});
    }
    await IslandAccess.db.insertRow(
      session,
      IslandAccess(
        ownerId: owner.authUserId,
        requesterId: u,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return jsonEncode({'status': 'pending'});
  }

  /// Requests to enter my HQ, waiting for my answer.
  Future<String> hqRequests(Session session) async {
    final u = _user(session);
    final rows = await IslandAccess.db.find(
      session,
      where: (t) => t.ownerId.equals(u) & t.status.equals('pending'),
      orderBy: (t) => t.createdAt,
    );
    return jsonEncode([
      for (final r in rows)
        {
          'id': r.id,
          'handle': (await _profile(session, r.requesterId)).handle,
          'at': r.createdAt.toIso8601String(),
        },
    ]);
  }

  /// Let someone in (they join my HQ's invite list) or turn them away.
  Future<String> answerHq(Session session, int id, bool grant) async {
    final u = _user(session);
    final r = await IslandAccess.db.findById(session, id);
    if (r == null || r.ownerId != u) return _err('Not your request.');
    await IslandAccess.db.updateRow(
      session,
      r.copyWith(
        status: grant ? 'granted' : 'denied',
        createdAt: DateTime.now().toUtc(),
      ),
    );
    if (grant) {
      final p = await _profile(session, u),
          who = (await _profile(session, r.requesterId)).handle;
      final inv = (jsonDecode(p.hqInvites) as List).map((e) => '$e').toList();
      if (!inv.contains(who))
        await IslandProfile.db.updateRow(
          session,
          p.copyWith(hqInvites: jsonEncode([...inv, who])),
        );
    }
    return jsonEncode({'id': id, 'status': grant ? 'granted' : 'denied'});
  }

  // ---------------- rides (like a ride-hailing app: quote, request, pay on arrival) ----------------
  /// Fares in naira for a trip between two board tiles (distance on the grid): okada and car.
  static Map<String, int> _fares(int fi, int fj, int ti, int tj) {
    final d = (fi - ti).abs() + (tj - fj).abs();
    return {'okada': min(6000, 400 + d * 22), 'car': min(15000, 1000 + d * 48)};
  }

  static final _rides =
      <String, ({String user, int fare, String kind, DateTime at})>{};

  /// What a trip would cost, and roughly how long until a rider reaches you.
  Future<String> rideQuote(
    Session session,
    int fi,
    int fj,
    int ti,
    int tj,
  ) async {
    final f = _fares(fi, fj, ti, tj), d = (fi - ti).abs() + (tj - fj).abs();
    return jsonEncode({
      ...f,
      'tiles': d,
      'okadaEta': 2 + _rnd.nextInt(3),
      'carEta': 3 + _rnd.nextInt(4),
    });
  }

  /// Book a ride: the fare is fixed now (and must be affordable); it's charged when you arrive.
  Future<String> requestRide(
    Session session,
    int fi,
    int fj,
    int ti,
    int tj,
    String kind,
  ) async {
    final u = _user(session);
    final f = _fares(fi, fj, ti, tj)[kind];
    if (f == null) return _err('Okada or car.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < f)
      return _err(
        'This ride costs ₦${_n(f)} and you have ₦${_n(c.naira)}. Work a shift first.',
      );
    _rides.removeWhere((_, r) => DateTime.now().difference(r.at).inHours >= 2);
    final id =
        '${DateTime.now().millisecondsSinceEpoch}${_rnd.nextInt(1 << 20)}';
    _rides[id] = (user: u.uuid, fare: f, kind: kind, at: DateTime.now());
    return jsonEncode({'id': id, 'fare': f, 'kind': kind});
  }

  /// You've arrived: pay the fare (once).
  Future<String> payRide(Session session, String id) =>
      _money(session, (u) async {
        final r = _rides[id];
        if (r == null || r.user != u.uuid) return _err('No such ride.');
        final res = await Bank.post(
          session,
          u,
          key: 'island:ride:$id',
          amount: -r.fare,
          kind: 'ride',
          counter: 'city:transport',
          memo: r.kind == 'okada' ? 'Okada ride' : 'Car ride',
        );
        if (res.short != null) return _err('Not enough naira for the fare.');
        _rides.remove(id);
        final c = await Bank.fresh(session, u);
        return jsonEncode({'paid': r.fare, 'naira': c.naira});
      });

  /// Cancel before the trip starts: nothing is charged.
  Future<String> cancelRide(Session session, String id) async {
    final r = _rides[id];
    if (r != null && r.user == _user(session).uuid) _rides.remove(id);
    return jsonEncode({'cancelled': true});
  }

  // ---------------- cars: the dealers' catalogue, buying, your garage ----------------
  /// model id -> (name, kind of body for drawing, price in naira, which dealer sells it)
  static const carCatalog = {
    'corolla': (
      name: 'Toyota Corolla',
      body: 'sedan',
      price: 450000,
      dealer: 'polanco',
    ),
    'camry': (
      name: 'Toyota Camry',
      body: 'sedan',
      price: 900000,
      dealer: 'polanco',
    ),
    'highlander': (
      name: 'Toyota Highlander',
      body: 'suv',
      price: 1500000,
      dealer: 'polanco',
    ),
    'lexusrx': (
      name: 'Lexus RX 350',
      body: 'suv',
      price: 2200000,
      dealer: 'polanco',
    ),
    'landcruiser': (
      name: 'Toyota Land Cruiser',
      body: 'bigsuv',
      price: 4000000,
      dealer: 'polanco',
    ),
    'cybertruck': (
      name: 'Tesla Cybertruck',
      body: 'cyber',
      price: 10000000,
      dealer: 'polanco',
    ),
    'porsche911': (
      name: 'Porsche 911',
      body: 'super',
      price: 12000000,
      dealer: 'polanco',
    ),
    'huracan': (
      name: 'Lamborghini Huracan',
      body: 'super',
      price: 20000000,
      dealer: 'polanco',
    ),
    'rangerover': (
      name: 'Range Rover',
      body: 'bigsuv',
      price: 6500000,
      dealer: 'lekkiluxury',
    ),
    'gwagon': (
      name: 'Mercedes G-Wagon',
      body: 'gwagon',
      price: 9000000,
      dealer: 'lekkiluxury',
    ),
    'urus': (
      name: 'Lamborghini Urus',
      body: 'supersuv',
      price: 15000000,
      dealer: 'lekkiluxury',
    ),
    'ferrari': (
      name: 'Ferrari Roma',
      body: 'super',
      price: 18000000,
      dealer: 'lekkiluxury',
    ),
    'cullinan': (
      name: 'Rolls-Royce Cullinan',
      body: 'bigsuv',
      price: 30000000,
      dealer: 'lekkiluxury',
    ),
  };
  static const carColors = {
    '#F8FAFC',
    '#111827',
    '#9CA3AF',
    '#B91C1C',
    '#1D4ED8',
    '#065F46',
    '#F59E0B',
    '#7C3AED',
    '#D4AF37',
    '#7F1D1D',
    '#1E3A8A',
    '#64748B',
    '#0B0B0F',
    '#FACC15',
    '#DC2626',
    '#C0C4CC',
    '#E5E7EB',
    '#16A34A',
  };

  /// The catalogue (for the dealers' showrooms and the Garage app).
  Future<String> cars(Session session) async => jsonEncode([
    for (final e in carCatalog.entries)
      {
        'id': e.key,
        'name': e.value.name,
        'body': e.value.body,
        'price': e.value.price,
        'dealer': e.value.dealer,
      },
  ]);

  /// The cars I own.
  Future<String> myCars(Session session) async {
    final rows = await IslandCar.db.find(
      session,
      where: (t) => t.authUserId.equals(_user(session)),
      orderBy: (t) => t.boughtAt,
    );
    return jsonEncode([
      for (final c in rows)
        {
          'id': c.id,
          'model': c.model,
          'name': carCatalog[c.model]?.name ?? c.model,
          'body': carCatalog[c.model]?.body ?? 'sedan',
          'color': c.color,
          'price': c.price,
          'active': c.active,
        },
    ]);
  }

  /// Buy a car: the price comes out of my wallet; it becomes the car I drive.
  Future<String> buyCar(
    Session session,
    String model,
    String color,
  ) => _money(session, (u) async {
    final m = carCatalog[model];
    if (m == null) return _err('That car is not for sale.');
    if (!carColors.contains(color))
      return _err('Pick one of the dealer colours.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < m.price)
      return _err(
        'You need N${_n(m.price)} for the ${m.name}. You have N${_n(c.naira)}.',
      );
    final r = await Bank.post(
      session,
      u,
      key: 'island:car:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}',
      amount: -m.price,
      kind: 'fee',
      counter: 'city:market',
      memo: 'Bought a ${m.name}',
    );
    if (r.short != null) return _err('Not enough naira.');
    final mine = await IslandCar.db.find(
      session,
      where: (t) => t.authUserId.equals(u),
    );
    for (final o in mine) {
      if (o.active)
        await IslandCar.db.updateRow(session, o.copyWith(active: false));
    }
    final car = await IslandCar.db.insertRow(
      session,
      IslandCar(
        authUserId: u,
        model: model,
        color: color,
        price: m.price,
        dealer: m.dealer,
        active: true,
        boughtAt: DateTime.now().toUtc(),
      ),
    );
    final after = await Bank.fresh(session, u);
    return jsonEncode({'id': car.id, 'name': m.name, 'naira': after.naira});
  });

  /// Choose which of my cars I drive.
  Future<String> driveCar(Session session, int carId) async {
    final u = _user(session);
    final mine = await IslandCar.db.find(
      session,
      where: (t) => t.authUserId.equals(u),
    );
    if (!mine.any((c) => c.id == carId)) return _err('Not your car.');
    for (final o in mine) {
      if (o.active != (o.id == carId))
        await IslandCar.db.updateRow(
          session,
          o.copyWith(active: o.id == carId),
        );
    }
    return jsonEncode({'active': carId});
  }

  // ---------------- fashion: outfits from the boutiques ----------------
  /// outfit id -> (name, price in naira). The same list as OUTFIT_LIST in web/index.html. Price 0: a free starter.
  /// Brand names only (no logos); not affiliated with the brands.
  static const outfitCatalog = {
    'st_tee': (name: 'White tee & jeans', price: 0),
    'st_polo': (name: 'Polo & chinos', price: 0),
    'st_ankara': (name: 'Ankara shirt & trousers', price: 0),
    'st_sport': (name: 'Sports set', price: 0),
    'puma_run': (name: 'Puma Running set', price: 28000),
    'nike_dri': (name: 'Nike Dri-FIT tee & shorts', price: 35000),
    'adidas_jersey': (name: 'Adidas Green and white football kit', price: 45000),
    'adidas_track': (name: 'Adidas Track suit', price: 75000),
    'nike_tech': (name: 'Nike Tech Fleece tracksuit', price: 85000),
    'hm_hoodie': (name: 'H&M Hoodie & joggers', price: 30000),
    'zara_linen': (name: 'Zara Linen shirt & trousers', price: 55000),
    'levis_denim': (name: 'Levi\'s Denim jacket & jeans', price: 65000),
    'zara_dress': (name: 'Zara Summer dress', price: 48000),
    'offwhite_set': (name: 'Off-White Striped tee & cargos', price: 180000),
    'lanre_buba': (name: 'Lanre Da Silva Buba & sokoto', price: 150000),
    'orange_kaftan': (name: 'Orange Culture Kaftan', price: 220000),
    'folawiyo_ankara': (name: 'Lisa Folawiyo Ankara two-piece', price: 260000),
    'ize_asooke': (name: 'Kenneth Ize Aso-oke set', price: 380000),
    'atafo_agbada': (name: 'Mai Atafo Bespoke agbada', price: 950000),
    'ralph_suit': (name: 'Ralph Lauren Navy suit', price: 420000),
    'balenciaga_set': (name: 'Balenciaga Oversized hoodie set', price: 950000),
    'gucci_track': (name: 'Gucci Tracksuit', price: 1200000),
    'versace_silk': (name: 'Versace Baroque silk shirt', price: 1400000),
    'fendi_set': (name: 'Fendi Monogram set', price: 1800000),
    'lv_jacket': (name: 'Louis Vuitton Monogram jacket', price: 2400000),
    'dior_gown': (name: 'Dior Evening gown', price: 3000000),
    // accessories (worn on top of an outfit, one per slot; see accessorySlot)
    'acc_shades': (name: 'Balogun Classic shades', price: 12000),
    'acc_aviators': (name: 'Ray-Ban Aviator sunglasses', price: 85000),
    'acc_cap_green': (name: 'Naija Green cap', price: 18000),
    'acc_cap_black': (name: 'New Era Black cap', price: 25000),
    'acc_cap_white': (name: 'New Era White cap', price: 25000),
    'acc_beanie': (name: 'Carhartt Beanie', price: 30000),
    'acc_bucket': (name: 'Kangol White bucket hat', price: 45000),
    'acc_bucket_black': (name: 'Kangol Black bucket hat', price: 45000),
    'acc_fedora': (name: 'Borsalino Fedora', price: 180000),
    'acc_chain_silver': (name: 'Idumota Silver chain', price: 60000),
    'acc_chain_gold': (name: 'Jacob & Co Gold Cuban chain', price: 1500000),
    'acc_watch': (name: 'Casio Digital watch', price: 40000),
    'acc_watch_gold': (name: 'Rolex Gold watch', price: 4500000),
    'acc_backpack': (name: 'The North Face Backpack', price: 60000),
  };

  /// Where each accessory is worn: one per slot (ACC_LIST in web/index.html).
  static String? accessorySlot(String id) => !id.startsWith('acc_')
      ? null
      : id.startsWith('acc_shades') || id.startsWith('acc_aviators')
      ? 'eyes'
      : id.startsWith('acc_cap') || id.startsWith('acc_beanie') || id.startsWith('acc_bucket') || id.startsWith('acc_fedora')
      ? 'head'
      : id.startsWith('acc_chain')
      ? 'neck'
      : id.startsWith('acc_watch')
      ? 'wrist'
      : id.startsWith('acc_backpack')
      ? 'back'
      : null;

  /// Buy an outfit: the price comes out of my wallet; it's in my wardrobe to wear whenever I like.
  Future<String> buyOutfit(Session session, String item) => _money(session, (
    u,
  ) async {
    final o = outfitCatalog[item];
    if (o == null || o.price == 0) return _err('That outfit is not for sale.');
    if (await IslandOutfit.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(u) & t.item.equals(item),
        ) !=
        null)
      return _err('It\'s already in your wardrobe.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < o.price)
      return _err(
        'The ${o.name} costs N${_n(o.price)}. You have N${_n(c.naira)}.',
      );
    final r = await Bank.post(
      session,
      u,
      key: 'island:outfit:${u.uuid}:$item',
      amount: -o.price,
      kind: 'fee',
      counter: 'city:market',
      memo: 'Bought: ${o.name}',
    );
    if (r.short != null) return _err('Not enough naira.');
    await IslandOutfit.db.insertRow(
      session,
      IslandOutfit(
        authUserId: u,
        item: item,
        price: o.price,
        boughtAt: DateTime.now().toUtc(),
      ),
    );
    final after = await Bank.fresh(session, u);
    return jsonEncode({'item': item, 'name': o.name, 'naira': after.naira});
  });

  /// The outfits in my wardrobe (the free starters are everyone's and aren't listed).
  Future<String> myOutfits(Session session) async {
    final rows = await IslandOutfit.db.find(
      session,
      where: (t) => t.authUserId.equals(_user(session)),
    );
    return jsonEncode([for (final o in rows) o.item]);
  }

  // ---------------- the Eko Home Store: furniture, cheap to luxury ----------------
  /// store id -> (name, price in naira). The same list as STORE_ITEMS in web/index.html.
  static const furnitureCatalog = {
    'k:rugDoormat': (name: 'Doormat', price: 2000),
    'k:trashcan': (name: 'Bin', price: 2500),
    'k:plantSmall1': (name: 'Small plant', price: 3500),
    'k:plantSmall3': (name: 'Cactus', price: 4000),
    'k:pottedPlant': (name: 'Potted palm', price: 9000),
    'k:rugRectangle': (name: 'Rug', price: 10000),
    'k:rugSquare': (name: 'Square rug', price: 18000),
    'k:rugRound': (name: 'Round rug', price: 30000),
    'k:rugRounded': (name: 'Wool rug', price: 55000),
    'k:coatRackStanding': (name: 'Coat stand', price: 9000),
    'k:bench': (name: 'Bench', price: 15000),
    'k:benchCushion': (name: 'Cushioned bench', price: 32000),
    'k:lampRoundFloor': (name: 'Floor lamp', price: 14000),
    'k:lampSquareFloor': (name: 'Designer floor lamp', price: 72000),
    'k:loungeChair': (name: 'Armchair', price: 18000),
    'k:loungeSofa': (name: 'Two-seater sofa', price: 45000),
    'k:loungeChairRelax': (name: 'Recliner', price: 65000),
    'k:loungeSofaLong': (name: 'Three-seater sofa', price: 120000),
    'k:loungeDesignChair': (name: 'Designer armchair', price: 240000),
    'k:loungeSofaOttoman': (name: 'Sofa and ottoman', price: 280000),
    'k:loungeSofaCorner': (name: 'Corner sofa', price: 420000),
    'k:loungeDesignSofa': (name: 'Designer sofa', price: 750000),
    'k:loungeDesignSofaCorner': (name: 'Designer corner suite', price: 1500000),
    'k:tableCoffee': (name: 'Coffee table', price: 12000),
    'k:tableCoffeeSquare': (name: 'Square coffee table', price: 20000),
    'k:tableCoffeeGlass': (name: 'Glass coffee table', price: 85000),
    'k:tableCoffeeGlassSquare': (name: 'Glass cube table', price: 110000),
    'k:televisionVintage': (name: 'Old TV', price: 15000),
    'k:cabinetTelevision': (name: 'TV stand', price: 35000),
    'k:cabinetTelevisionDoors': (name: 'TV cabinet', price: 60000),
    'k:televisionModern': (name: 'Flat-screen TV', price: 350000),
    'k:speakerSmall': (name: 'Bookshelf speaker', price: 25000),
    'k:speaker': (name: 'Tower speaker', price: 180000),
    'k:bookcaseOpenLow': (name: 'Low bookcase', price: 15000),
    'k:bookcaseOpen': (name: 'Bookcase', price: 28000),
    'k:bookcaseClosedWide': (name: 'Wide cabinet', price: 90000),
    'k:bedSingle': (name: 'Single bed', price: 30000),
    'k:bedBunk': (name: 'Bunk bed', price: 55000),
    'k:bedDouble': (name: 'Double bed', price: 180000),
    'k:cabinetBed': (name: 'Bedside table', price: 12000),
    'k:cabinetBedDrawerTable': (name: 'Bedside drawers', price: 40000),
    'k:bookcaseClosedDoors': (name: 'Wardrobe', price: 95000),
    'k:kitchenCabinet': (name: 'Kitchen cabinet', price: 25000),
    'k:kitchenCabinetDrawer': (name: 'Drawer unit', price: 32000),
    'k:kitchenSink': (name: 'Kitchen sink', price: 40000),
    'k:kitchenStove': (name: 'Gas cooker', price: 60000),
    'k:kitchenStoveElectric': (name: 'Electric cooker', price: 150000),
    'k:kitchenFridgeSmall': (name: 'Small fridge', price: 70000),
    'k:kitchenFridge': (name: 'Fridge', price: 220000),
    'k:kitchenFridgeLarge': (name: 'American fridge', price: 650000),
    'k:kitchenBar': (name: 'Kitchen bar', price: 90000),
    'k:stoolBar': (name: 'Bar stool', price: 12000),
    'k:stoolBarSquare': (name: 'Square bar stool', price: 20000),
    'k:chair': (name: 'Wooden chair', price: 6000),
    'k:chairCushion': (name: 'Cushioned chair', price: 12000),
    'k:chairRounded': (name: 'Rounded chair', price: 25000),
    'k:chairModernCushion': (name: 'Modern chair', price: 45000),
    'k:chairModernFrameCushion': (name: 'Designer chair', price: 95000),
    'k:table': (name: 'Dining table', price: 35000),
    'k:tableRound': (name: 'Round table', price: 45000),
    'k:tableCloth': (name: 'Table with cloth', price: 55000),
    'k:tableCross': (name: 'Farmhouse table', price: 140000),
    'k:tableGlass': (name: 'Glass dining table', price: 260000),
    'k:toilet': (name: 'Toilet', price: 30000),
    'k:bathroomSink': (name: 'Basin', price: 25000),
    'k:bathroomCabinetDrawer': (name: 'Vanity unit', price: 35000),
    'k:shower': (name: 'Shower', price: 60000),
    'k:toiletSquare': (name: 'Designer toilet', price: 85000),
    'k:bathroomSinkSquare': (name: 'Designer basin', price: 70000),
    'k:showerRound': (name: 'Rain shower', price: 150000),
    'k:bathtub': (name: 'Bathtub', price: 240000),
    'k:washer': (name: 'Washing machine', price: 190000),
    'k:washerDryerStacked': (name: 'Washer-dryer tower', price: 420000),
    'k:desk': (name: 'Desk', price: 30000),
    'k:chairDesk': (name: 'Office chair', price: 28000),
    'k:deskCorner': (name: 'Corner desk', price: 110000),
  };

  /// Buy one piece: the price comes out of my wallet; I place it from my home's "Arrange furniture".
  Future<String> buyFurniture(Session session, String item) => _money(session, (
    u,
  ) async {
    final f = furnitureCatalog[item];
    if (f == null) return _err('That piece is not for sale.');
    if (await IslandFurniture.db.count(
          session,
          where: (t) => t.authUserId.equals(u),
        ) >=
        400)
      return _err('Your homes are full: 400 pieces at most.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < f.price)
      return _err(
        'You need N${_n(f.price)} for the ${f.name}. You have N${_n(c.naira)}.',
      );
    final r = await Bank.post(
      session,
      u,
      key: 'island:furn:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}',
      amount: -f.price,
      kind: 'fee',
      counter: 'city:market',
      memo: 'Eko Home Store: ${f.name}',
    );
    if (r.short != null) return _err('Not enough naira.');
    await IslandFurniture.db.insertRow(
      session,
      IslandFurniture(
        authUserId: u,
        item: item,
        price: f.price,
        boughtAt: DateTime.now().toUtc(),
      ),
    );
    final after = await Bank.fresh(session, u);
    return jsonEncode({'item': item, 'name': f.name, 'naira': after.naira});
  });

  /// What I own: {items: {id: count}}, and how many of each already stand in my homes other than [room] ('' for all).
  Future<String> myFurniture(Session session, String room) async {
    final u = _user(session);
    final elsewhere = <String, int>{};
    for (final k in await _myRoomKeys(session, u)) {
      if (k == room) continue;
      _countInto(elsewhere, await _layoutOf(session, k));
    }
    return jsonEncode({
      'items': await _owned(session, u),
      'elsewhere': elsewhere,
    });
  }

  static Future<Map<String, int>> _owned(Session s, UuidValue u) async {
    final out = <String, int>{};
    for (final f in await IslandFurniture.db.find(
      s,
      where: (t) => t.authUserId.equals(u),
    )) {
      out[f.item] = (out[f.item] ?? 0) + 1;
    }
    return out;
  }

  static void _countInto(
    Map<String, int> into,
    List layout, {
    bool storeOnly = true,
  }) {
    for (final it in layout) {
      final k = it is Map ? it['k'] : null;
      if (k is String && (!storeOnly || k.startsWith('k:')))
        into[k] = (into[k] ?? 0) + 1;
    }
  }

  static Future<List> _layoutOf(Session s, String key) async {
    final r = await IslandRoom.db.findFirstRow(
      s,
      where: (t) => t.key.equals(key),
    );
    if (r == null) return const [];
    final v = jsonDecode(r.layout);
    return v is List ? v : const [];
  }

  /// The rooms I furnish: my free BQ on HQ Row and every home I've bought.
  static Future<List<String>> _myRoomKeys(Session s, UuidValue u) async {
    final p = await _profile(s, u);
    return [
      'hq:${p.id}',
      for (final h in await IslandHome.db.find(
        s,
        where: (t) => t.authUserId.equals(u),
      ))
        'home:${h.plot}',
    ];
  }

  // ---------------- homes: a free BQ for everyone, and plots to buy, Ajah to Banana Island ----------------
  /// style -> (name, price in naira). The same list as HOME_STYLES in web/index.html.
  static const homeStyles = {
    'flat': (name: 'Mini flat', price: 800000),
    'bungalow': (name: 'Bungalow', price: 2500000),
    'terrace': (name: 'Terrace house', price: 6000000),
    'duplex': (name: 'Duplex', price: 15000000),
    'townhouse': (name: 'Townhouse', price: 18000000),
    'loft': (name: 'Loft', price: 25000000),
    'mansion': (name: 'Mansion with BQ', price: 40000000),
    'villa': (name: 'Waterfront villa', price: 120000000),
    'nml': (name: "No Man's Land mansion", price: 500000000),
  };

  /// estate -> the style of each plot, in order (plot `<estate>:<n>`). The same list as ESTATES in web/index.html.
  static const estates = {
    'vgc': [
      'bungalow',
      'flat',
      'duplex',
      'flat',
      'bungalow',
      'flat',
      'bungalow',
      'duplex',
      'flat',
    ],
    'lekki1': [
      'duplex',
      'terrace',
      'duplex',
      'terrace',
      'duplex',
      'terrace',
      'loft',
      'duplex',
      'terrace',
    ],
    'lekkiest': [
      'terrace',
      'terrace',
      'duplex',
      'terrace',
      'bungalow',
      'terrace',
      'duplex',
      'terrace',
      'terrace',
    ],
    'ikoyihomes': ['loft', 'townhouse', 'loft', 'townhouse', 'loft', 'townhouse', 'townhouse', 'loft', 'townhouse', 'loft', 'townhouse', 'loft', 'townhouse', 'duplex', 'loft'],
    'oldikoyi': ['mansion', 'mansion', 'loft', 'mansion', 'townhouse', 'mansion', 'loft', 'mansion', 'mansion', 'mansion', 'townhouse', 'mansion', 'loft', 'mansion', 'mansion'],
    'banana': ['villa', 'villa', 'loft', 'villa', 'villa', 'villa', 'villa', 'loft', 'villa', 'villa', 'mansion', 'villa'],
    'nomansland': ['nml', 'nml', 'nml', 'nml'], // No Man's Land: four mansions on the private island
    // the new estates on the reclaimed land, 12 homes each
    'atlantic': ['flat', 'bungalow', 'flat', 'terrace', 'bungalow', 'flat', 'terrace', 'flat', 'bungalow', 'terrace', 'flat', 'bungalow'],
    'oceancrest': ['duplex', 'terrace', 'townhouse', 'duplex', 'terrace', 'duplex', 'townhouse', 'terrace', 'duplex', 'loft', 'townhouse', 'duplex'],
    'marinacourt': ['flat', 'flat', 'bungalow', 'flat', 'terrace', 'flat', 'bungalow', 'flat', 'flat', 'terrace', 'bungalow', 'flat', 'flat', 'bungalow', 'flat', 'terrace', 'flat', 'flat', 'bungalow', 'terrace', 'flat', 'bungalow', 'flat', 'terrace'],
    'harbourview': ['loft', 'duplex', 'mansion', 'loft', 'townhouse', 'mansion', 'duplex', 'loft', 'villa', 'mansion', 'townhouse', 'villa', 'duplex', 'loft', 'townhouse', 'mansion', 'loft', 'duplex', 'villa', 'townhouse', 'loft', 'mansion', 'duplex', 'villa'],
  };

  static String? _styleOf(String plot) {
    final m = RegExp(r'^([a-z0-9]+):(\d+)$').firstMatch(plot);
    final list = m == null ? null : estates[m.group(1)];
    final n = m == null ? -1 : int.parse(m.group(2)!);
    return list != null && n >= 0 && n < list.length ? list[n] : null;
  }

  /// Every bought plot: who owns it (when I may know), and whether I may go in.
  Future<String> homes(Session session) async {
    final u = _user(session);
    final me = await _profile(session, u);
    final rows = await IslandHome.db.find(session, limit: 500);
    final out = [];
    for (final h in rows) {
      final owner = await IslandProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(h.authUserId),
      );
      if (owner == null) continue;
      final mine = h.authUserId == u;
      // a ghost's home: still lived in (and not for sale), but nameless and closed
      if (owner.ghost && !mine) {
        out.add({'plot': h.plot, 'style': h.style, 'mine': false, 'may': false, 'ghost': true, 'color': owner.hqColor});
        continue;
      }
      final may =
          mine ||
          !owner.hqLocked ||
          (jsonDecode(owner.hqInvites) as List).contains(me.handle);
      out.add({
        'plot': h.plot,
        'style': h.style,
        'mine': mine,
        'may': may,
        'slot': owner.id,
        'color': owner.hqColor,
        if (may) 'owner': owner.handle,
      });
    }
    return jsonEncode(out);
  }

  /// Buy the home on [plot]: it's mine to furnish, and it's where my HQ settings (name, colour, who may enter) apply too.
  Future<String> buyHome(Session session, String plot) =>
      _money(session, (u) async {
        final style = _styleOf(plot);
        if (style == null) return _err('There is no home there.');
        final h = homeStyles[style]!;
        if (await IslandHome.db.findFirstRow(
              session,
              where: (t) => t.plot.equals(plot),
            ) !=
            null)
          return _err('Someone already lives there.');
        if (await IslandHome.db.count(
              session,
              where: (t) => t.authUserId.equals(u),
            ) >=
            3)
          return _err('Three homes is the limit.');
        final c = await WorldAuthority.citizen(session, u);
        if (c.naira < h.price)
          return _err(
            'This ${h.name} costs N${_n(h.price)}. You have N${_n(c.naira)}.',
          );
        final r = await Bank.post(
          session,
          u,
          key: 'island:home:$plot',
          amount: -h.price,
          kind: 'fee',
          counter: 'city:market',
          memo: 'Bought a ${h.name} ($plot)',
        );
        if (r.short != null) return _err('Not enough naira.');
        await IslandHome.db.insertRow(
          session,
          IslandHome(
            authUserId: u,
            plot: plot,
            style: style,
            price: h.price,
            boughtAt: DateTime.now().toUtc(),
          ),
        );
        final after = await Bank.fresh(session, u);
        return jsonEncode({
          'plot': plot,
          'style': style,
          'name': h.name,
          'naira': after.naira,
        });
      });

  // ---------------- house parties ----------------
  /// Parties going on now, by room key (`hq:<slot>` or `home:<plot>`). Kept in memory: a party lasts a few hours at most.
  static final _parties =
      <
        String,
        ({
          UuidValue host,
          String hostHandle,
          String theme,
          bool open,
          List<String> guests,
          DateTime until,
          String place,
        })
      >{};
  static const partyThemes = {'afro', 'piano', 'owambe'};

  static ({
    UuidValue host,
    String hostHandle,
    String theme,
    bool open,
    List<String> guests,
    DateTime until,
    String place,
  })?
  _liveParty(String key) {
    final p = _parties[key];
    if (p == null) return null;
    if (DateTime.now().toUtc().isAfter(p.until)) {
      _parties.remove(key);
      return null;
    }
    return p;
  }

  /// Throw a party in one of my homes for [minutes] (30 to 180). [open]: anyone may walk in; otherwise the people on my
  /// invite list (my HQ settings) and [guests] (handles, JSON list). Those invited see it on their phones.
  Future<String> startParty(
    Session session,
    String key,
    String theme,
    int minutes,
    bool open,
    String guests,
  ) async {
    final u = _user(session);
    if (!await _mayArrange(session, u, key))
      return _err('You can only throw a party in your own home.');
    if (!partyThemes.contains(theme)) return _err('Pick a vibe.');
    final me = await _profile(session, u);
    final list = {
      ...(jsonDecode(me.hqInvites) as List).map((e) => '$e'),
      ...(jsonDecode(guests) as List).map((e) => '$e'.trim()),
    }.where((e) => e.isNotEmpty).take(60).toList();
    final until = DateTime.now().toUtc().add(
      Duration(minutes: minutes.clamp(30, 180)),
    );
    _parties[key] = (
      host: u,
      hostHandle: me.handle,
      theme: theme,
      open: open,
      guests: list,
      until: until,
      place: me.hqName ?? "${me.handle}'s place",
    );
    return jsonEncode({
      'key': key,
      'until': until.toIso8601String(),
      'guests': list.length,
    });
  }

  /// End my party early.
  Future<String> endParty(Session session, String key) async {
    final p = _liveParty(key);
    if (p == null || p.host != _user(session))
      return _err('No party of yours there.');
    _parties.remove(key);
    return jsonEncode({'ended': key});
  }

  /// The parties I can go to right now: open ones, ones I'm invited to, and my own.
  Future<String> parties(Session session) async {
    final u = _user(session);
    final me = await _profile(session, u);
    final out = [];
    for (final k in _parties.keys.toList()) {
      final p = _liveParty(k);
      if (p == null) continue;
      final mine = p.host == u, invited = p.guests.contains(me.handle);
      if (!mine && !invited && !p.open) continue;
      out.add({
        'key': k,
        'host': p.hostHandle,
        'theme': p.theme,
        'open': p.open,
        'until': p.until.toIso8601String(),
        'place': p.place,
        'mine': mine,
        'invited': invited,
        'guests': p.guests.length,
      });
    }
    return jsonEncode(out);
  }

  // ---------------- Banana Island Marina: yacht charters ----------------
  /// kind -> (name, price in naira). The same list as CHARTERS in web/index.html (the harbour tour is free and needs no call).
  static const charters = {
    'cruise': (name: 'Lagoon cruise', price: 15000),
    'sunset': (name: 'Sunset party', price: 30000),
    'private': (name: 'Private charter', price: 250000),
  };

  /// Pay for a charter; the trip itself runs in the game.
  Future<String> charterYacht(Session session, String kind) => _money(session, (
    u,
  ) async {
    final c = charters[kind];
    if (c == null) return _err('That charter isn\'t running.');
    final w = await WorldAuthority.citizen(session, u);
    if (w.naira < c.price)
      return _err(
        'The ${c.name} costs N${_n(c.price)}. You have N${_n(w.naira)}.',
      );
    final r = await Bank.post(
      session,
      u,
      key: 'island:yacht:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}',
      amount: -c.price,
      kind: 'fee',
      counter: 'city:services',
      memo: 'Banana Island Marina: ${c.name}',
    );
    if (r.short != null) return _err('Not enough naira.');
    final after = await Bank.fresh(session, u);
    return jsonEncode({'kind': kind, 'name': c.name, 'naira': after.naira});
  });

  /// Private-jet flights out of Lagos Island Airport, by destination: what a seat costs (the flight runs in the game).
  static const flights = {
    'island': (name: 'Island joyride', price: 8000),
    'abuja': (name: 'Abuja', price: 25000),
    'accra': (name: 'Accra', price: 40000),
    'dakar': (name: 'Dakar', price: 60000),
    'nairobi': (name: 'Nairobi', price: 80000),
    'dubai': (name: 'Dubai', price: 90000),
    'joburg': (name: 'Johannesburg', price: 100000),
    'london': (name: 'London', price: 150000),
  };

  /// Pay for a seat on a flight; the trip itself (out, a moment there, home) runs in the game.
  Future<String> bookFlight(Session session, String dest) => _money(session, (u) async {
    final f = flights[dest];
    if (f == null) return _err('There\'s no flight there.');
    final w = await WorldAuthority.citizen(session, u);
    if (w.naira < f.price) return _err('A seat to ${f.name} is N${_n(f.price)}. You have N${_n(w.naira)}.');
    final r = await Bank.post(session, u, key: 'island:flight:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}', amount: -f.price, kind: 'fee', counter: 'city:services', memo: 'Lagos Island Airport: flight to ${f.name}');
    if (r.short != null) return _err('Not enough naira.');
    final after = await Bank.fresh(session, u);
    return jsonEncode({'dest': dest, 'name': f.name, 'naira': after.naira});
  });

  /// Private jets for sale at Lagos Island Airport (one each), by kind.
  static const jetCatalog = {
    'light': (name: 'Light jet', seats: 6, price: 60000000),
    'midsize': (name: 'Midsize jet', seats: 8, price: 120000000),
    'heavy': (name: 'Long-range jet', seats: 13, price: 250000000),
  };
  static const jetLiveries = 10; // the game's jet colours (LIVERY on the page)

  static Map<String, dynamic> _jetJson(IslandJet j) => {'model': j.model, 'name': jetCatalog[j.model]?.name ?? j.model, 'tail': j.tail, 'livery': j.livery, 'showName': j.showName, 'price': j.price};

  /// My jet, if I have one.
  Future<String> myJet(Session session) async {
    final j = await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(_user(session)));
    return jsonEncode({'jet': j == null ? null : _jetJson(j)});
  }

  /// Buy a jet (one each): the price comes out of my wallet; it gets its own registration and lives in a hangar.
  Future<String> buyJet(Session session, String model, int livery) => _money(session, (u) async {
    final m = jetCatalog[model];
    if (m == null) return _err('That jet is not for sale.');
    if (livery < 0 || livery >= jetLiveries) return _err('Pick one of the colours.');
    if (await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(u)) != null) return _err('You already have a jet in the hangar.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < m.price) return _err('A ${m.name} is N${_n(m.price)}. You have N${_n(c.naira)}.');
    final r = await Bank.post(session, u, key: 'island:jet:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}', amount: -m.price, kind: 'fee', counter: 'city:market', memo: 'Bought a ${m.name}');
    if (r.short != null) return _err('Not enough naira.');
    final rnd = Random.secure();
    IslandJet? j;
    for (var k = 0; k < 8 && j == null; k++) { // a fresh registration: 5N- and three letters
      final tail = '5N-${String.fromCharCodes([for (var i = 0; i < 3; i++) 65 + rnd.nextInt(26)])}';
      try {
        j = await IslandJet.db.insertRow(session, IslandJet(authUserId: u, model: model, tail: tail, livery: livery, price: m.price, boughtAt: DateTime.now().toUtc()));
      } catch (_) {
        if (await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(u)) != null) break; // bought at the same moment elsewhere
      }
    }
    final after = await Bank.fresh(session, u);
    if (j == null) return _err('The registry is busy. Your naira is safe: ask an operator to finish the registration.');
    return jsonEncode({'jet': _jetJson(j), 'naira': after.naira});
  });

  /// Repaint my jet, or show / hide my name on its hangar.
  Future<String> setJet(Session session, int livery, bool showName) async {
    final j = await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(_user(session)));
    if (j == null) return _err('You don\'t have a jet.');
    if (livery < 0 || livery >= jetLiveries) return _err('Pick one of the colours.');
    final j2 = await IslandJet.db.updateRow(session, j.copyWith(livery: livery, showName: showName));
    return jsonEncode({'jet': _jetJson(j2)});
  }

  /// Fly my own jet: no seat to buy, only the fuel and handling (a quarter of a seat's price; N2,000 round the island).
  Future<String> flyJet(Session session, String dest) => _money(session, (u) async {
    final f = flights[dest];
    if (f == null) return _err('There\'s no flight there.');
    final j = await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(u));
    if (j == null) return _err('You don\'t have a jet. Buy one, or book a seat.');
    final fee = dest == 'island' ? 2000 : f.price ~/ 4;
    final w = await WorldAuthority.citizen(session, u);
    if (w.naira < fee) return _err('Fuel and handling to ${f.name} is N${_n(fee)}. You have N${_n(w.naira)}.');
    final r = await Bank.post(session, u, key: 'island:jetfly:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}', amount: -fee, kind: 'fee', counter: 'city:services', memo: 'Lagos Island Airport: fuel and handling for ${j.tail} to ${f.name}');
    if (r.short != null) return _err('Not enough naira.');
    final after = await Bank.fresh(session, u);
    return jsonEncode({'dest': dest, 'name': f.name, 'tail': j.tail, 'fee': fee, 'naira': after.naira});
  });

  // ---------------- people: public profiles, finding Lagosians, friend requests ----------------
  /// What anyone signed in may see about a Lagosian: the name, the look, since when, the HQ's name, the skills only if
  /// they're open to work, their career titles, how many friends. Never their wallet, email, messages, where they
  /// are, who their friends are or what's inside their home.
  static const _gridTitles = ['Trainee', 'Technician', 'Senior', 'Supervisor', 'Chief'];
  static const _trackNames = {'control': 'Control Room Operator', 'lineman': 'Lineman', 'solar': 'Solar Technician', 'plant': 'Plant Engineer', 'marshal': 'Ground Crew', 'atc': 'Air Traffic Controller'};
  static Future<IslandProfile?> _byHandle(Session s, String handle) =>
      IslandProfile.db.findFirstRow(s, where: (t) => t.handle.ilike(_clean(handle, 40).replaceAll(r'\', '').replaceAll('_', r'\_').replaceAll('%', r'\%'))); // names are unique in any case

  Future<String> publicProfile(Session session, String handle) async {
    final u = _user(session);
    final p = await _byHandle(session, handle);
    if (p == null) return _err('No Lagosian by that name.');
    // a ghost shows their profile only to themselves and their friends
    if (p.ghost && p.authUserId != u && await _rel(session, u, p.authUserId) != 'friends') return _err('No Lagosian by that name.');
    final careers = await IslandGridCareer.db.find(session, where: (t) => t.authUserId.equals(p.authUserId) & (t.xp > 0));
    final friends = await IslandFriend.db.count(session, where: (t) => (t.fromUser.equals(p.authUserId) | t.toUser.equals(p.authUserId)) & t.status.equals('accepted'));
    final jet = await IslandJet.db.findFirstRow(session, where: (t) => t.authUserId.equals(p.authUserId));
    return jsonEncode({
      'handle': p.handle,
      'look': p.look,
      'since': p.createdAt.toIso8601String(),
      'hq': p.hqName ?? "${p.handle}'s HQ",
      if (p.openToWork && p.skills.trim().isNotEmpty) 'skills': p.skills,
      'careers': [for (final c in careers..sort((a, b) => b.level.compareTo(a.level))) '${_gridTitles[(c.level - 1).clamp(0, 4)]} ${_trackNames[c.track] ?? c.track}'],
      'friends': friends,
      if (jet != null && jet.showName) 'jet': jet.tail,
      'me': p.authUserId == u,
      'rel': p.authUserId == u ? 'me' : await _rel(session, u, p.authUserId),
    });
  }

  /// me and them: none | sent (waiting for them) | received (waiting for me) | friends
  static Future<String> _rel(Session s, UuidValue me, UuidValue them) async {
    final rows = await IslandFriend.db.find(s, where: (t) => (t.fromUser.equals(me) & t.toUser.equals(them)) | (t.fromUser.equals(them) & t.toUser.equals(me)));
    if (rows.any((r) => r.status == 'accepted')) return 'friends';
    if (rows.any((r) => r.status == 'pending' && r.fromUser == me)) return 'sent';
    if (rows.any((r) => r.status == 'pending' && r.fromUser == them)) return 'received';
    return 'none';
  }

  static Map<String, dynamic> _card(IslandProfile p) => {'handle': p.handle, 'look': p.look, 'since': p.createdAt.toIso8601String()};

  /// The newest Lagosians (to say hello to), and a search by name.
  Future<String> people(Session session, String query) async {
    final u = _user(session);
    final q = _clean(query, 30).toLowerCase();
    final rows = q.isEmpty
        ? await IslandProfile.db.find(session, orderBy: (t) => t.createdAt.desc(), limit: 15)
        : await IslandProfile.db.find(session, where: (t) => t.handle.ilike('%${q.replaceAll(RegExp(r'[%_\\]'), '')}%'), orderBy: (t) => t.handle, limit: 15);
    return jsonEncode([for (final p in rows) if (p.authUserId != u && !p.ghost) _card(p)]);
  }

  /// Send a friend request (with an optional short hello). If they already asked me, this accepts it.
  static final _uver = <String, int>{};
  static final _uwait = <String, List<Completer<void>>>{};
  static void _ping(UuidValue who, [Session? session]) {
    final k = who.uuid, listening = (_uwait[k] ?? const []).isNotEmpty;
    _uver[k] = (_uver[k] ?? 0) + 1;
    for (final c in _uwait.remove(k) ?? <Completer<void>>[]) {
      if (!c.isCompleted) c.complete();
    }
    if (!listening && session != null) unawaited(_push(session, who));
  }

  // ---------------- web push: a wake-up to the player's phones while the game is closed ----------------
  static final _pushed = <String, DateTime>{};
  static final _pushHttp = http.Client();

  /// Wake [who]'s phones (no content: the notification is generic, the game shows the real thing). At most once in 30 s.
  static Future<void> _push(Session req, UuidValue who) async {
    final secret = (req.passwords['pushSecret'] ?? '').trim();
    if (secret.isEmpty) return;
    final last = _pushed[who.uuid];
    if (last != null && DateTime.now().difference(last) < const Duration(seconds: 30)) return;
    _pushed[who.uuid] = DateTime.now();
    // its own session: the request that caused it may already have finished
    final s = await Serverpod.instance.createSession(enableLogging: false);
    try {
      for (final sub in await IslandPushSub.db.find(s, where: (t) => t.authUserId.equals(who), limit: 5)) {
        final r = await _pushHttp.post(Uri.parse('https://play.lagos-island.workers.dev/push'), headers: {'x-push-secret': secret, 'Content-Type': 'application/json'}, body: jsonEncode({'endpoint': sub.endpoint, 'ttl': 3600})).timeout(const Duration(seconds: 10));
        final st = (jsonDecode(r.body) as Map)['status'];
        if (st == 404 || st == 410) await IslandPushSub.db.deleteRow(s, sub); // the phone unsubscribed or reinstalled
      }
    } catch (e) {
      s.log('[push] ${who.uuid}: $e', level: LogLevel.warning);
    } finally {
      await s.close();
    }
  }

  /// This phone's push address (from its browser), so it can be woken while the game is closed.
  Future<String> pushSubscribe(Session session, String endpoint) async {
    final u = _user(session);
    final ep = Uri.tryParse(endpoint);
    if (ep == null || ep.scheme != 'https' || endpoint.length > 900) return _err('Bad address.');
    final had = await IslandPushSub.db.findFirstRow(session, where: (t) => t.endpoint.equals(endpoint));
    if (had != null && had.authUserId != u) await IslandPushSub.db.deleteRow(session, had); // the phone changed hands
    if (had == null || had.authUserId != u) {
      if (await IslandPushSub.db.count(session, where: (t) => t.authUserId.equals(u)) >= 5) {
        final oldest = await IslandPushSub.db.findFirstRow(session, where: (t) => t.authUserId.equals(u), orderBy: (t) => t.createdAt);
        if (oldest != null) await IslandPushSub.db.deleteRow(session, oldest);
      }
      await IslandPushSub.db.insertRow(session, IslandPushSub(authUserId: u, endpoint: endpoint, createdAt: DateTime.now().toUtc()));
    }
    return jsonEncode({'ok': true});
  }

  /// Wait (up to 25 s) until something happens to me (my number moves past [ver]); then look at friends and messages.
  Future<String> wake(Session session, int ver) async {
    final k = _user(session).uuid;
    final end = DateTime.now().add(const Duration(seconds: 25));
    while ((_uver[k] ?? 0) == ver && DateTime.now().isBefore(end)) {
      final c = Completer<void>();
      (_uwait[k] ??= []).add(c);
      await c.future.timeout(end.difference(DateTime.now()), onTimeout: () {});
      _uwait[k]?.remove(c);
    }
    return jsonEncode({'ver': _uver[k] ?? 0});
  }

  Future<String> friendRequest(Session session, String handle, String note) async {
    final u = _user(session);
    final p = await _byHandle(session, handle);
    if (p == null) return _err('No Lagosian by that name.');
    if (p.authUserId == u) return _err('That\'s you.');
    final back = await IslandFriend.db.findFirstRow(session, where: (t) => t.fromUser.equals(p.authUserId) & t.toUser.equals(u));
    if (p.ghost && back == null) return _err('No Lagosian by that name.'); // a ghost can't be found to be asked (they can still ask you)
    if (back != null && back.status == 'pending') { await IslandFriend.db.updateRow(session, back.copyWith(status: 'accepted', decidedAt: DateTime.now().toUtc())); _ping(p.authUserId, session); return jsonEncode({'rel': 'friends'}); }
    if (back != null && back.status == 'accepted') return jsonEncode({'rel': 'friends'});
    final day = DateTime.now().toUtc().subtract(const Duration(days: 1));
    if (await IslandFriend.db.count(session, where: (t) => t.fromUser.equals(u) & (t.createdAt > day)) >= 30) return _err('That\'s a lot of requests for one day. Try again tomorrow.');
    final mine = await IslandFriend.db.findFirstRow(session, where: (t) => t.fromUser.equals(u) & t.toUser.equals(p.authUserId));
    final n = _clean(note, 140);
    if (mine == null) {
      await IslandFriend.db.insertRow(session, IslandFriend(fromUser: u, toUser: p.authUserId, status: 'pending', note: n.isEmpty ? null : n, createdAt: DateTime.now().toUtc()));
    } else if (mine.status == 'declined') {
      if (mine.decidedAt != null && DateTime.now().toUtc().difference(mine.decidedAt!) < const Duration(days: 7)) return _err('They said no for now. You can ask again in a week.');
      await IslandFriend.db.updateRow(session, mine.copyWith(status: 'pending', note: n.isEmpty ? null : n, createdAt: DateTime.now().toUtc(), decidedAt: null));
    }
    _ping(p.authUserId, session);
    return jsonEncode({'rel': mine?.status == 'accepted' ? 'friends' : 'sent'});
  }

  /// Accept or decline a request someone sent me.
  Future<String> friendRespond(Session session, String handle, bool accept) async {
    final u = _user(session);
    final p = await _byHandle(session, handle);
    if (p == null) return _err('No Lagosian by that name.');
    final r = await IslandFriend.db.findFirstRow(session, where: (t) => t.fromUser.equals(p.authUserId) & t.toUser.equals(u) & t.status.equals('pending'));
    if (r == null) return _err('No request from them.');
    await IslandFriend.db.updateRow(session, r.copyWith(status: accept ? 'accepted' : 'declined', decidedAt: DateTime.now().toUtc()));
    if (accept) _ping(p.authUserId, session);
    return jsonEncode({'rel': accept ? 'friends' : 'none'});
  }

  /// Cancel a request I sent, or end a friendship (either side).
  Future<String> unfriend(Session session, String handle) async {
    final u = _user(session);
    final p = await _byHandle(session, handle);
    if (p == null) return _err('No Lagosian by that name.');
    await IslandFriend.db.deleteWhere(session, where: (t) => ((t.fromUser.equals(u) & t.toUser.equals(p.authUserId)) | (t.fromUser.equals(p.authUserId) & t.toUser.equals(u))) & (t.status.equals('accepted') | (t.status.equals('pending') & t.fromUser.equals(u))));
    return jsonEncode({'rel': 'none'});
  }

  /// My friends, the requests waiting for me (with their hello), and the ones I sent.
  Future<String> friends(Session session) async {
    final u = _user(session);
    final rows = await IslandFriend.db.find(session, where: (t) => (t.fromUser.equals(u) | t.toUser.equals(u)) & (t.status.equals('accepted') | t.status.equals('pending')));
    final ids = {for (final r in rows) r.fromUser == u ? r.toUser : r.fromUser};
    final profs = {for (final p in await IslandProfile.db.find(session, where: (t) => t.authUserId.inSet(ids))) p.authUserId: p};
    final out = {'friends': <Map<String, dynamic>>[], 'incoming': <Map<String, dynamic>>[], 'sent': <Map<String, dynamic>>[]};
    for (final r in rows) {
      final p = profs[r.fromUser == u ? r.toUser : r.fromUser];
      if (p == null) continue;
      final c = {..._card(p), 'at': (r.decidedAt ?? r.createdAt).toIso8601String()};
      if (r.status == 'accepted') { out['friends']!.add(c); } else if (r.toUser == u) { out['incoming']!.add({...c, if (r.note != null) 'note': r.note}); } else { out['sent']!.add(c); }
    }
    return jsonEncode(out);
  }

  // ---------------- insides ----------------
  /// May I arrange the room [key]? My own HQ, or (operators) the public buildings.
  static Future<bool> _mayArrange(Session s, UuidValue u, String key) async {
    if (key.startsWith('hq:')) {
      final p = await IslandProfile.db.findById(
        s,
        int.tryParse(key.substring(3)) ?? -1,
      );
      return p != null && p.authUserId == u;
    }
    if (key.startsWith('home:')) {
      final h = await IslandHome.db.findFirstRow(
        s,
        where: (t) => t.plot.equals(key.substring(5)),
      );
      return h != null && h.authUserId == u;
    }
    return false; // only homes are arranged by players; every other building keeps its design
  }

  /// A room's furniture (JSON list), and whether I may arrange it. An HQ's inside shows only to its
  /// owner and the people they've let in.
  Future<String> room(Session session, String key) async {
    final u = _user(session);
    // a party that's on lets in its guests (everyone, for an open party)
    final party = _liveParty(key);
    bool partyLetsIn(String handle) =>
        party != null && (party.open || party.guests.contains(handle));
    if (key.startsWith('hq:')) {
      final p = await IslandProfile.db.findById(
        session,
        int.tryParse(key.substring(3)) ?? -1,
      );
      if (p == null) return _err('No HQ there.');
      final me = await _profile(session, u);
      final may =
          p.authUserId == u ||
          !p.hqLocked ||
          (jsonDecode(p.hqInvites) as List).contains(me.handle) ||
          partyLetsIn(me.handle);
      if (!may) return _err('Knock first: the owner lets people in.');
    }
    if (key.startsWith('home:')) {
      final h = await IslandHome.db.findFirstRow(
        session,
        where: (t) => t.plot.equals(key.substring(5)),
      );
      if (h == null) return _err('Nobody lives there yet.');
      final p = await IslandProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(h.authUserId),
      );
      final me = await _profile(session, u);
      final may =
          h.authUserId == u ||
          (p != null &&
              (!p.hqLocked ||
                  (jsonDecode(p.hqInvites) as List).contains(me.handle))) ||
          partyLetsIn(me.handle);
      if (!may) return _err('Knock first: the owner lets people in.');
    }
    final r = await IslandRoom.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );
    return jsonEncode({
      'key': key,
      'layout': r == null ? null : jsonDecode(r.layout),
      'mine': await _mayArrange(session, u, key),
    });
  }

  /// Save a room's furniture.
  Future<String> saveRoom(Session session, String key, String layout) async {
    final u = _user(session);
    if (!await _mayArrange(session, u, key))
      return _err('Only the owner can arrange this room.');
    if (layout.length > 24000) return _err('Too much furniture.');
    final list = jsonDecode(layout);
    if (list is! List || list.length > 200) return _err('At most 200 pieces.');
    for (final it in list) {
      if (it is! Map ||
          it['k'] is! String ||
          it['x'] is! num ||
          it['z'] is! num)
        return _err('Bad furniture.');
    }
    // a room's finish (room:living, room:bedroom, ...): its floor and wall colour, free to choose; not furniture
    final hex = RegExp(r'^#[0-9a-fA-F]{6}$');
    for (final it in list.where((it) => (it['k'] as String).startsWith('room:'))) {
      if (!RegExp(r'^room:[a-z]{2,12}$').hasMatch(it['k'] as String) || (it['f'] != null && !RegExp(r'^[a-z]{2,12}$').hasMatch('${it['f']}')) || (it['w'] != null && !hex.hasMatch('${it['w']}')))
        return _err('Bad room finish.');
    }
    final finishes = list.where((it) => (it['k'] as String).startsWith('room:')).length;
    if (finishes > 8) return _err('Too many rooms.');
    final had = await IslandRoom.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );
    // a home holds only what its owner bought (counting what stands in their other homes), plus the
    // old built-in pieces it already had (those can be moved or removed, not added)
    final placed = <String, int>{},
        old = <String, int>{},
        elsewhere = <String, int>{};
    _countInto(placed, list, storeOnly: false);
    if (had != null)
      _countInto(old, jsonDecode(had.layout) as List, storeOnly: false);
    for (final k in await _myRoomKeys(session, u)) {
      if (k != key) _countInto(elsewhere, await _layoutOf(session, k));
    }
    final owned = await _owned(session, u);
    for (final e in placed.entries) {
      if (e.key.startsWith('room:')) continue;
      if (e.key.startsWith('k:')) {
        if (e.value + (elsewhere[e.key] ?? 0) > (owned[e.key] ?? 0))
          return _err('Buy that piece at the Eko Home Store first.');
      } else if (e.value > (old[e.key] ?? 0)) {
        return _err('New furniture comes from the Eko Home Store.');
      }
    }
    final now = DateTime.now().toUtc();
    if (had == null) {
      await IslandRoom.db.insertRow(
        session,
        IslandRoom(key: key, layout: layout, updatedAt: now),
      );
    } else {
      await IslandRoom.db.updateRow(
        session,
        had.copyWith(layout: layout, updatedAt: now),
      );
    }
    return jsonEncode({'saved': list.length});
  }

  // ---------------- delivery from the Home Store ----------------
  static const courierFee = 1500;

  /// Have bought furniture delivered into one of my homes (or my HQ): [layout] is that room with the new pieces in it,
  /// checked like any arrangement (only pieces I own). [mode] courier: Eko Swift Couriers bring it for N1,500;
  /// car: I take it home in my own car, free (I need a car).
  Future<String> deliverFurniture(Session session, String key, String layout, String mode) async {
    final u = _user(session);
    if (mode != 'courier' && mode != 'car') return _err('Choose a courier or your car.');
    if (mode == 'car' && await IslandCar.db.count(session, where: (t) => t.authUserId.equals(u)) == 0) return _err('You need a car for that. Buy one at a dealer, or use Eko Swift Couriers.');
    if (mode == 'courier' && (await WorldAuthority.citizen(session, u)).naira < courierFee) return _err('Delivery is N${_n(courierFee)}. Top up your wallet first.');
    final saved = await saveRoom(session, key, layout);
    if ((jsonDecode(saved) as Map)['error'] != null) return saved;
    if (mode == 'courier') {
      await Bank.post(session, u, key: 'island:courier:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}', amount: -courierFee, kind: 'fee', counter: 'city:services', memo: 'Eko Swift Couriers: delivery');
    }
    final c = await WorldAuthority.citizen(session, u);
    return jsonEncode({'ok': true, 'naira': c.naira});
  }

  // ---------------- buying naira (Flutterwave) ----------------
  /// Whether buying naira is open (off, test or live) and the packs.
  Future<String> topUpInfo(Session session) async {
    _user(session);
    return jsonEncode(TopUp.info(session));
  }

  /// Start checkout for a pack; [returnTo] is the game's address to come back to.
  Future<String> topUpStart(Session session, String pack, String returnTo) async {
    final u = _user(session);
    try {
      return jsonEncode(await TopUp.start(session, u, pack, returnTo));
    } on TopUpRefused catch (e) {
      return _err(e.message);
    }
  }

  // ---------------- my payout bank account ----------------
  Future<String> _payout(Future<Map<String, dynamic>> Function() f) async {
    try {
      return jsonEncode(await f());
    } on PayoutRefused catch (e) {
      return _err(e.message);
    }
  }

  /// Nigerian banks for the payout account form.
  Future<String> payoutBanks(Session session) {
    _user(session);
    return _payout(() async => {'banks': await Payout.banks(session)});
  }

  /// My payout account (the number masked), or none.
  Future<String> payoutAccount(Session session) async {
    final u = _user(session);
    return jsonEncode({'account': Payout.view(await IslandPayoutAccount.db.findFirstRow(session, where: (t) => t.authUserId.equals(u)))});
  }

  /// Add or replace my payout account: looked up at the bank, names compared, a code emailed.
  Future<String> payoutAccountSet(Session session, String bankCode, String accountNumber, String legalName, String email, String dateOfBirth, String password) {
    final u = _user(session);
    return _payout(() => Payout.set(session, u, bankCode, accountNumber, legalName, email, dateOfBirth, password));
  }

  /// The code from the email.
  Future<String> payoutAccountVerify(Session session, String code) {
    final u = _user(session);
    return _payout(() => Payout.verify(session, u, code));
  }

  /// Send the email code again.
  Future<String> payoutAccountResend(Session session) {
    final u = _user(session);
    return _payout(() => Payout.resend(session, u));
  }

  /// I accept the payout terms (needed once before the first withdrawal).
  Future<String> payoutAcceptTerms(Session session) async {
    final u = _user(session);
    final a = await IslandPayoutAccount.db.findFirstRow(session, where: (t) => t.authUserId.equals(u));
    if (a == null) return _err('Add your bank account first.');
    final done = await IslandPayoutAccount.db.updateRow(session, a.copyWith(termsAcceptedAt: DateTime.now().toUtc()));
    return jsonEncode({'account': Payout.view(done)});
  }

  /// Withdraw real earnings to my verified bank account: verified (name and email), 18 or older, terms accepted;
  /// the limits, the fee and the review window are the payout system's (Withdrawals.request).
  Future<String> withdrawToBank(Session session, int amountKobo, String requestKey) async {
    final u = _user(session);
    final a = await IslandPayoutAccount.db.findFirstRow(session, where: (t) => t.authUserId.equals(u));
    if (a == null || a.status != 'verified') return _err('Verify your bank account first (Wallet, then Bank account).');
    if (a.dateOfBirth == null || Payout.ageOf(a.dateOfBirth!) < RewardConfig.current.minAge) return _err('You need to be ${RewardConfig.current.minAge} or older to be paid real money.');
    if (a.termsAcceptedAt == null) return _err('Accept the payout terms first.');
    if (a.holdUntil != null && a.holdUntil!.isAfter(DateTime.now().toUtc())) return _err('Your bank account was changed recently. For your safety, withdrawals open again 48 hours after a change.');
    try {
      final w = await Withdrawals.request(session, u, amountKobo, 'flw:${a.bankCode}:${a.accountNumber}', requestKey);
      return jsonEncode({'ref': w.ref, 'status': w.status, 'amountKobo': w.amountKobo, 'feeKobo': w.feeKobo, 'feePayer': w.feePayer, 'reviewHours': RewardConfig.current.reviewHours, 'to': '${a.bankName} ••${a.accountNumber.substring(6)}'});
    } on JobRefused catch (e) {
      return _err(e.message);
    }
  }

  /// The payout's last check before it's sent: the player's bank account is still verified, still the one it was
  /// requested to, not on hold after a change, and its owner still old enough.
  static Future<bool> payableNow(Session s, RewardWithdrawal w) async {
    final a = await IslandPayoutAccount.db.findFirstRow(s, where: (t) => t.authUserId.equals(w.authUserId));
    if (a == null || a.status != 'verified' || w.beneficiary != 'flw:${a.bankCode}:${a.accountNumber}') return false;
    if (a.dateOfBirth == null || Payout.ageOf(a.dateOfBirth!) < RewardConfig.current.minAge) return false;
    return true;
  }

  /// Operators: withdrawals waiting in their review window (who, how much, when they go), to stop any that look wrong.
  Future<String> payoutQueue(Session session) async {
    final u = _user(session);
    if (!await DroneService.isOperator(session, u)) return _err('Operators only.');
    final rows = await RewardWithdrawal.db.find(session, where: (t) => t.status.equals(PayoutState.requested), orderBy: (t) => t.createdAt, limit: 50);
    final hrs = RewardConfig.current.reviewHours;
    return jsonEncode([
      for (final w in rows) {'ref': w.ref, 'handle': (await _profile(session, w.authUserId)).handle, 'amountKobo': w.amountKobo, 'at': w.createdAt.toIso8601String(), 'goesAt': w.createdAt.add(Duration(hours: hrs)).toIso8601String()},
    ]);
  }

  /// Operators: stop a withdrawal in review (the money goes back to the player's available earnings).
  Future<String> payoutStop(Session session, String ref) async {
    final u = _user(session);
    if (!await DroneService.isOperator(session, u)) return _err('Operators only.');
    return jsonEncode({'stopped': await Withdrawals.stop(session, ref, 'operator:${u.uuid}')});
  }

  /// the island's administrators: only they see the Government console (the treasury, the books)
  static const govAdmins = {'rockerfeller', 'believecaxa'};
  static Future<bool> _govAdmin(Session s, UuidValue u) async {
    final p = await IslandProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    return p != null && govAdmins.contains(p.handle.toLowerCase());
  }

  static int _i(Object? v) => v is num ? v.toInt() : int.tryParse('$v') ?? 0;

  /// What every citizen sees of the government about themselves: the tax they've paid, rent and fines paid, what they owe.
  Future<String> civic(Session session) async {
    final u = _user(session), p = QueryParameters.named({'u': u.uuid});
    final q = (await session.db.unsafeQuery(
            'SELECT COALESCE(SUM(-"amount") FILTER (WHERE "kind" = \'tax\'), 0), COALESCE(SUM(-"amount") FILTER (WHERE "kind" = \'tax\' AND "createdAt" > NOW() - INTERVAL \'7 days\'), 0), '
            'COALESCE(SUM(-"amount") FILTER (WHERE "counter" = \'city:courts\' AND "amount" < 0), 0), COALESCE(SUM(-"amount") FILTER (WHERE "counter" = \'city:landlord\' AND "amount" < 0), 0) '
            'FROM "naira_entry" WHERE "authUserId" = CAST(@u AS uuid)',
            parameters: p))
        .first;
    final c = await session.db.unsafeQuery('SELECT "debt" FROM "world_citizen" WHERE "authUserId" = CAST(@u AS uuid)', parameters: p);
    final fines = await NairaEntry.db.find(session, where: (t) => t.authUserId.equals(u) & (t.counter.equals('city:courts') | t.kind.equals('credit')), orderBy: (t) => t.createdAt.desc(), limit: 8);
    return jsonEncode({
      'admin': await _govAdmin(session, u), 'taxRate': Bank.taxRate,
      'taxPaid': _i(q[0]), 'taxWeek': _i(q[1]), 'finesPaid': _i(q[2]), 'rentPaid': _i(q[3]), 'owed': c.isEmpty ? 0 : _i(c.first[0]),
      'fines': [for (final e in fines) {'memo': e.memo, 'amount': e.amount, 'at': e.createdAt.toIso8601String()}],
    });
  }

  /// The Government console (administrators only): Treasury 1 (the 2% tax on every movement of game naira), what each
  /// city account has taken in and paid out, the citizens and the naira in circulation, and Treasury 2 (real naira).
  Future<String> govBoard(Session session) async {
    final u = _user(session);
    if (!await _govAdmin(session, u)) return _err('The Government console is for the island\'s administrators.');
    final t = (await session.db.unsafeQuery(
            'SELECT COALESCE(SUM(-"amount"), 0), COALESCE(SUM(-"amount") FILTER (WHERE "createdAt" > NOW() - INTERVAL \'1 day\'), 0), COALESCE(SUM(-"amount") FILTER (WHERE "createdAt" > NOW() - INTERVAL \'7 days\'), 0), COUNT(*), COUNT(DISTINCT "authUserId") '
            'FROM "naira_entry" WHERE "kind" = \'tax\''))
        .first;
    final byCounter = await session.db.unsafeQuery(
        'SELECT "counter", COALESCE(SUM(-"amount") FILTER (WHERE "amount" < 0), 0), COALESCE(SUM("amount") FILTER (WHERE "amount" > 0 AND "kind" <> \'open\'), 0) FROM "naira_entry" WHERE "kind" <> \'tax\' GROUP BY "counter" ORDER BY 1');
    // every island player has a wallet: anyone missing one gets it now, so players and wallets always match
    for (final r in await session.db.unsafeQuery('SELECT p."authUserId" FROM "island_profile" p LEFT JOIN "world_citizen" c ON c."authUserId" = p."authUserId" WHERE c."id" IS NULL')) {
      try { await WorldAuthority.citizen(session, UuidValue.fromString('${r[0]}')); } catch (e) { session.log('[gov] wallet for ${r[0]} failed: $e', level: LogLevel.warning); }
    }
    final cit = (await session.db.unsafeQuery('SELECT COUNT(*), COALESCE(SUM(c."naira"), 0), COALESCE(SUM(c."debt"), 0), COUNT(*) FILTER (WHERE c."debt" > 0) FROM "world_citizen" c JOIN "island_profile" p ON p."authUserId" = c."authUserId"')).first;
    final others = _i((await session.db.unsafeQuery('SELECT COUNT(*) FROM "world_citizen" c LEFT JOIN "island_profile" p ON p."authUserId" = c."authUserId" WHERE p."id" IS NULL')).first[0]);
    final days = await session.db.unsafeQuery(
        'SELECT to_char(date_trunc(\'day\', "createdAt" + INTERVAL \'1 hour\'), \'YYYY-MM-DD\'), SUM(-"amount") FROM "naira_entry" WHERE "kind" = \'tax\' AND "createdAt" > NOW() - INTERVAL \'14 days\' GROUP BY 1 ORDER BY 1');
    return jsonEncode({
      'tax': {'total': _i(t[0]), 'today': _i(t[1]), 'week': _i(t[2]), 'entries': _i(t[3]), 'payers': _i(t[4]), 'rate': Bank.taxRate},
      'days': [for (final d in days) {'day': d[0], 'tax': _i(d[1])}],
      'counters': [for (final r in byCounter) {'counter': r[0], 'in': _i(r[1]), 'out': _i(r[2])}],
      'citizens': {'count': _i(cit[0]), 'naira': _i(cit[1]), 'owed': _i(cit[2]), 'owing': _i(cit[3]), 'players': await IslandProfile.db.count(session), 'otherWyrd': others},
      'treasury2': await TopUp.treasury2(session),
    });
  }

  /// Treasury 2 (operators only): real naira paid by players and the half reserved for paychecks.
  Future<String> treasury2(Session session) async {
    final u = _user(session);
    if (!await DroneService.isOperator(session, u)) return _err('Operators only.');
    return jsonEncode(await TopUp.treasury2(session));
  }

  /// My naira purchases, newest first: each one's pack, price, naira and state (paid only once Flutterwave confirmed it).
  Future<String> topUpHistory(Session session) async {
    final u = _user(session);
    final rows = await IslandTopUp.db.find(session, where: (t) => t.authUserId.equals(u), orderBy: (t) => t.createdAt.desc(), limit: 15);
    return jsonEncode([
      for (final r in rows) {'ref': r.txRef, 'ngn': r.amountNgn, 'naira': r.naira, 'status': r.status, 'at': r.createdAt.toIso8601String(), if (r.status == 'pending' && r.payTo != null) 'pay': jsonDecode(r.payTo!), if (r.paidAt != null) 'paidAt': r.paidAt!.toIso8601String()},
    ]);
  }

  /// How my payment [ref] went (asks Flutterwave, credits it once if it succeeded).
  Future<String> topUpCheck(Session session, String ref) async {
    final u = _user(session);
    final r = await TopUp.settle(session, ref, onlyFor: u);
    if (r['status'] == 'paid') r['balance'] = (await WorldAuthority.citizen(session, u)).naira;
    return jsonEncode(r);
  }

  // ---------------- the arena ----------------
  static Map<String, dynamic> _showJson(
    IslandShow s, {
    int sold = 0,
    bool mine = false,
    bool ticket = false,
  }) {
    final now = DateTime.now().toUtc();
    return {
      'id': s.id,
      'artist': s.artist,
      'title': s.title,
      'startsAt': s.startsAt.toIso8601String(),
      'minutes': s.minutes,
      'price': s.price,
      'capacity': s.capacity,
      'sold': sold,
      'status': s.status,
      'mine': mine,
      'ticket': ticket,
      'live':
          s.status == 'on_sale' &&
          !now.isBefore(s.startsAt) &&
          now.isBefore(s.startsAt.add(Duration(minutes: s.minutes))),
    };
  }

  /// Shows on sale and coming up (and my own, whatever their status).
  Future<String> shows(Session session) async {
    final u = _user(session);
    final from = DateTime.now().toUtc().subtract(const Duration(hours: 4));
    final rows = await IslandShow.db.find(
      session,
      where: (t) =>
          (t.status.equals('on_sale') | t.hostUserId.equals(u)) &
          (t.startsAt > from),
      orderBy: (t) => t.startsAt,
      limit: 50,
    );
    final mine = {
      for (final k in await IslandTicket.db.find(
        session,
        where: (t) => t.authUserId.equals(u),
      ))
        k.showId,
    };
    return jsonEncode([
      for (final s in rows)
        _showJson(
          s,
          sold: await IslandTicket.db.count(
            session,
            where: (t) => t.showId.equals(s.id!),
          ),
          mine: s.hostUserId == u,
          ticket: mine.contains(s.id),
        ),
    ]);
  }

  /// An artist books the arena. Tickets go on sale once WYRD's operator has checked it.
  Future<String> hostShow(
    Session session,
    String artist,
    String title,
    String startsAt,
    int minutes,
    int price,
  ) async {
    final u = _user(session);
    final at = DateTime.tryParse(startsAt)?.toUtc();
    if (artist.trim().isEmpty || title.trim().isEmpty)
      return _err('Give the artist and the show a name.');
    if (at == null || at.isBefore(DateTime.now().toUtc()))
      return _err('Pick a time in the future.');
    if (minutes < 15 || minutes > 240)
      return _err('A show runs 15 minutes to 4 hours.');
    if (price < 0 || price > 20000) return _err('Tickets cost ₦0 to ₦20,000.');
    final clash = await IslandShow.db.findFirstRow(
      session,
      where: (t) =>
          t.status.equals('on_sale') &
          (t.startsAt > at.subtract(const Duration(hours: 4))) &
          (t.startsAt < at.add(Duration(minutes: minutes))),
    );
    if (clash != null &&
        clash.startsAt.add(Duration(minutes: clash.minutes)).isAfter(at))
      return _err('The arena is booked then. Pick another time.');
    final s = await IslandShow.db.insertRow(
      session,
      IslandShow(
        hostUserId: u,
        artist: _clean(artist, 60),
        title: _clean(title, 80),
        startsAt: at,
        minutes: minutes,
        price: price,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return jsonEncode(_showJson(s, mine: true));
  }

  /// The operator's queue of shows to check, and the decision.
  Future<String> pendingShows(Session session) async {
    if (!await DroneService.isOperator(session, _user(session)))
      return _err('Operators only.');
    final rows = await IslandShow.db.find(
      session,
      where: (t) => t.status.equals('pending'),
      orderBy: (t) => t.startsAt,
    );
    return jsonEncode([for (final s in rows) _showJson(s)]);
  }

  Future<String> reviewShow(Session session, int showId, bool approve) async {
    if (!await DroneService.isOperator(session, _user(session)))
      return _err('Operators only.');
    final s = await IslandShow.db.findById(session, showId);
    if (s == null) return _err('No such show.');
    await IslandShow.db.updateRow(
      session,
      s.copyWith(status: approve ? 'on_sale' : 'rejected'),
    );
    return jsonEncode({
      'id': showId,
      'status': approve ? 'on_sale' : 'rejected',
    });
  }

  /// Buy a ticket with naira. Nine tenths goes to the artist who hosts the show.
  Future<String> buyTicket(Session session, int showId) =>
      _money(session, (u) async {
        final s = await IslandShow.db.findById(session, showId);
        if (s == null || s.status != 'on_sale')
          return _err('That show isn\'t on sale.');
        if (DateTime.now().toUtc().isAfter(
          s.startsAt.add(Duration(minutes: s.minutes)),
        ))
          return _err('That show is over.');
        if (await IslandTicket.db.findFirstRow(
              session,
              where: (t) => t.showId.equals(showId) & t.authUserId.equals(u),
            ) !=
            null)
          return jsonEncode({'ticket': true});
        if (await IslandTicket.db.count(
              session,
              where: (t) => t.showId.equals(showId),
            ) >=
            s.capacity)
          return _err('Sold out.');
        await WorldAuthority.citizen(session, u);
        if (s.price > 0) {
          final r = await Bank.post(
            session,
            u,
            key: 'island:ticket:$showId:${u.uuid}',
            amount: -s.price,
            kind: 'fee',
            counter: 'city:services',
            memo: 'Ticket: ${s.artist}',
          );
          if (r.short != null) return _err('You need ${'₦'}${_n(s.price)}.');
          if (s.hostUserId != u) {
            await WorldAuthority.citizen(session, s.hostUserId);
            await Bank.post(
              session,
              s.hostUserId,
              key: 'island:ticket:$showId:${u.uuid}:artist',
              amount: s.price * 9 ~/ 10,
              kind: 'job',
              counter: 'city:services',
              memo: 'Ticket sold: ${s.title}',
            );
          }
        }
        await IslandTicket.db.insertRow(
          session,
          IslandTicket(
            showId: showId,
            authUserId: u,
            createdAt: DateTime.now().toUtc(),
          ),
        );
        final c = await Bank.fresh(session, u);
        return jsonEncode({'ticket': true, 'naira': c.naira});
      });

  /// What the artist has performed (said, sung, announced) so far, live -- for ticket holders and the artist.
  static final _stage = <int, List<Map<String, dynamic>>>{};
  Future<String> stage(Session session, int showId, int since) async {
    final u = _user(session);
    final s = await IslandShow.db.findById(session, showId);
    if (s == null) return _err('No such show.');
    final host = s.hostUserId == u;
    if (!host &&
        await IslandTicket.db.findFirstRow(
              session,
              where: (t) => t.showId.equals(showId) & t.authUserId.equals(u),
            ) ==
            null)
      return _err('You need a ticket.');
    final lines = (_stage[showId] ?? const [])
        .where((l) => (l['n'] as int) > since)
        .toList();
    return jsonEncode({
      ..._showJson(s, mine: host, ticket: !host),
      'crowd': await IslandTicket.db.count(
        session,
        where: (t) => t.showId.equals(showId),
      ),
      'lines': lines,
    });
  }

  /// The artist performs: a line onto the arena's screens, for everyone with a ticket.
  Future<String> perform(Session session, int showId, String text) async {
    final u = _user(session);
    final s = await IslandShow.db.findById(session, showId);
    if (s == null || s.hostUserId != u)
      return _err('Only the artist can take the stage.');
    final now = DateTime.now().toUtc();
    if (now.isBefore(s.startsAt.subtract(const Duration(minutes: 10))) ||
        now.isAfter(s.startsAt.add(Duration(minutes: s.minutes))))
      return _err(
        'The stage is yours from 10 minutes before the show until it ends.',
      );
    final list = _stage.putIfAbsent(showId, () => []);
    final n = list.isEmpty ? 1 : (list.last['n'] as int) + 1;
    list.add({'n': n, 'text': _clean(text, 400), 'at': now.toIso8601String()});
    if (list.length > 400) list.removeAt(0);
    return jsonEncode({'n': n});
  }

  // ---------------- WYRD ----------------
  /// What WYRD knows of Lagos Island: the board, the buildings and their insides, the phone, the rules.
  /// It is told this with every question asked from the island, so it can answer as the island's guide.
  static const _islandBrief =
      "You are WYRD, and Lagos Island is your game: a multiplayer browser game of Lagos Island, Ikoyi, Victoria Island, Eko Atlantic, Lekki, Ajah and Ilashe, "
      "drawn as a little game town on the water and run by you. The player is talking to you from WYRD Tower in VI (your glass tower with an atom on its crown) or from their in-game phone.\n"
      "THE BOARD: districts as blocks of land joined by bridges (the Ikoyi Link Bridge lights up in colour at night) and the Lagos-Calabar Coastal Road along the Atlantic. "
      "Landmarks: the Central Mosque, Balogun Market, the Oba's palace, Tinubu Square, the Cathedral, Tafawa Balewa Square, the Marina towers, General Hospital, Ikoyi Club, Banana Island, "
      "Obalende motor park, Eko Hotel, Federal Palace Hotel, Bar and Kuramo beaches, Eko Atlantic, the Lekki Toll Gate, Nike Art Gallery, Lekki Conservation Centre, Circle Mall, Elegushi and Landmark beaches, Ajah market, "
      "Victoria Garden City, Ilashe beach (a bridge from the Marina), the refinery in the Lekki Free Zone (always running), Ad Island (digital billboards), Welcome Point (WELCOME TO LAGOS ISLAND carved in the sand), "
      "HQ Row (everyone's own HQ), the Blue Line station, Lagos Island Airport (private jets in hangars), and reclaimed land still being built. The island keeps Lagos time and lights up at night.\n"
      "INSIDE BUILDINGS (tap a building to go in; players are only seen inside): "
      "HQs are private apartments (bedroom, living room, kitchen, bathroom); only the owner can arrange the furniture, everyone else knocks and the owner lets them in from the phone. "
      "The clubs (Club Ozumba in VI, Club Lekki) have a DJ stage with an LED wall, moving lights, a dance floor with podiums, a long bar, a champagne bar, VIP booths with bottle service behind a rope, a lounge and a coat check; they are open every night. "
      "The Island Casino has roulette and blackjack tables, rows of slots, chandeliers, a cashier's cage and a high-rollers room; it is play money only, stakes 100 to 5,000 naira, and a 10,000 naira daily loss limit. "
      "WYRD Tower is your lobby: reception, live screens, glass walls onto the city, lifts, and you at the centre in a ring of light. "
      "The Arena on its own land by Eko Atlantic hosts live shows: tiered stands, a mixing desk, a big screen; artists book it, fans buy tickets with naira (the artist gets nine tenths), and ticket holders attend in person while the artist performs on the screen. "
      "In rooms players can sit on chairs, sofas, stools and booths, and sleep in beds. Players are human figures, men and women, chosen at the door.\n"
      "OTHER PLACES: tapping a landmark offers what you can do there. Working shifts at the refinery, the market and the motor park works now. Flights, the Blue Line, boats, hotels, shopping, the hospital, beaches, "
      "visits and tours are coming soon.\n"
      "THE PHONE (WYRD OS): Wallet (naira earned at Lagos rates, capped at 35,000 a day; no real money in or out), Jobs (real jobs from real employers, checked before they show; matching only for people open to work), "
      "Link (end-to-end encrypted private conversations and groups; you can never read them), My HQ, Arena, Casino, Ride (book an okada or a car like a ride-hailing app: a rider comes, takes you, and the fare comes from the wallet on arrival), "
      "Profile, Privacy, and you.\n"
      "ACCOUNTS: one username and password for Lagos Island and WYRD. You never see a player's messages, HQ or who they talk to; never ask for them. Answer in a few short lines, warm, with a little Lagos flavour.";

  /// Ask WYRD from the phone or in WYRD Tower. It hears [text] and where the player is -- nothing from their chats.
  Future<String> askWyrd(Session session, String text, String district) async {
    final u = _user(session);
    final d = _clean(district, 40);
    return WorldAuthority.address(
      session,
      u,
      'speak',
      text,
      '$_islandBrief\nRight now the player is in $d.',
    );
  }
}
