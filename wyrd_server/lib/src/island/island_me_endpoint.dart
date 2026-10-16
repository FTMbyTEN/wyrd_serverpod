import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import '../world/bank.dart';
import '../world/world_authority.dart';

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
    final t = s.replaceAll(RegExp(r'[\u0000-\u0008\u000b-\u001f<>]'), '').trim();
    return t.length > max ? t.substring(0, max) : t;
  }

  static String _err(String m) => jsonEncode({'error': m});

  // one money action at a time per person (as CityEndpoint)
  static final _queues = <String, Future<void>>{};
  static Future<String> _money(Session s, Future<String> Function(UuidValue u) work) {
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
    final p = await IslandProfile.db.findFirstRow(s, where: (t) => t.authUserId.equals(u));
    if (p != null) return p;
    final base = 'lagosian${u.uuid.replaceAll('-', '').substring(0, 6)}';
    return IslandProfile.db.insertRow(
      s,
      IslandProfile(authUserId: u, handle: base, createdAt: DateTime.now().toUtc()),
    );
  }

  static Map<String, dynamic> _profileJson(IslandProfile p) => {
    'handle': p.handle,
    'skills': p.skills,
    'openToWork': p.openToWork,
    'pubKey': p.pubKey,
    'hq': {
      'name': p.hqName ?? "${p.handle}'s HQ",
      'color': p.hqColor,
      'locked': p.hqLocked,
      'invites': jsonDecode(p.hqInvites),
    },
  };

  /// Who I am on the island, my naira, and whether I can check job posts. JSON.
  Future<String> me(Session session) async {
    final u = _user(session);
    final p = await _profile(session, u);
    final c = await WorldAuthority.citizen(session, u);
    return jsonEncode({
      ..._profileJson(p),
      'naira': c.naira,
      'earnedToday': await _earnedToday(session, u),
      'dailyCap': dailyCap,
      'operator': await DroneService.isOperator(session, u),
      'requests': await IslandAccess.db.count(session, where: (t) => t.ownerId.equals(u) & t.status.equals('pending')),
    });
  }

  /// Change my handle, skills, open-to-work, or messaging key. Empty strings leave a field as it is.
  Future<String> setProfile(Session session, String handle, String skills, bool openToWork, String pubKey) async {
    final u = _user(session);
    var p = await _profile(session, u);
    final h = handle.trim();
    if (h.isNotEmpty && h != p.handle) {
      if (!RegExp(r'^[a-zA-Z0-9_.-]{3,20}$').hasMatch(h)) return _err('A name of 3 to 20 letters, digits, _ . or -.');
      final taken = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals(h));
      if (taken != null) return _err('That name is taken.');
      p = p.copyWith(handle: h);
    }
    p = p.copyWith(skills: _clean(skills, 300), openToWork: openToWork);
    if (pubKey.isNotEmpty) {
      if (pubKey.length > 600) return _err('Key too large.');
      try {
        final k = jsonDecode(pubKey) as Map<String, dynamic>;
        if (k['kty'] != 'EC' || k['crv'] != 'P-256' || k.containsKey('d')) return _err('Not a public P-256 key.');
      } catch (_) {
        return _err('Not a key.');
      }
      p = p.copyWith(pubKey: pubKey);
    }
    p = await IslandProfile.db.updateRow(session, p);
    return jsonEncode(_profileJson(p));
  }

  /// Someone's public messaging key, by handle: {handle, pubKey} or {error}.
  Future<String> keyOf(Session session, String handle) async {
    final p = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals(handle.trim()));
    if (p == null) return _err('Nobody on the island by that name.');
    if (p.pubKey == null) return _err('${p.handle} hasn\'t opened their phone yet, so they can\'t receive encrypted messages.');
    return jsonEncode({'handle': p.handle, 'pubKey': p.pubKey});
  }

  // ---------------- work and wallet ----------------
  /// Pay for one shift, and how long it is (a shift can be paid once per [minutes] at each workplace).
  static const shifts = {
    'refinery': (pay: 6500, minutes: 10, memo: 'Shift at the refinery'),
    'club': (pay: 4000, minutes: 10, memo: 'Night shift at the club'),
    'market': (pay: 2500, minutes: 6, memo: 'Helping at the market stall'),
    'okada': (pay: 1800, minutes: 4, memo: 'Okada rides'),
  };
  static const dailyCap = 35000;

  static Future<int> _earnedToday(Session s, UuidValue u) async {
    final day = DateTime.now().toUtc().add(const Duration(hours: 1));
    final start = DateTime.utc(day.year, day.month, day.day).subtract(const Duration(hours: 1));
    final rows = await NairaEntry.db.find(
      s,
      where: (t) => t.authUserId.equals(u) & t.createdAt.between(start, start.add(const Duration(days: 1))) & t.key.like('island:shift:%'),
    );
    return rows.fold<int>(0, (a, e) => a + e.amount);
  }

  /// Work a shift at [place] (refinery, club, market, okada). Paid at Lagos rates, capped each day.
  Future<String> work(Session session, String place) => _money(session, (u) async {
    final sh = shifts[place];
    if (sh == null) return _err('Nobody is hiring for that here.');
    if (place == 'club') {
      final h = DateTime.now().toUtc().add(const Duration(hours: 1)).hour;
      if (h >= 6 && h < 18) return _err('The clubs open at 6 pm. Come back tonight.');
    }
    await WorldAuthority.citizen(session, u);
    final earned = await _earnedToday(session, u);
    if (earned >= dailyCap) return _err('You\'ve worked enough for today (₦${_n(dailyCap)}). Rest, and come back tomorrow.');
    final pay = min(sh.pay, dailyCap - earned);
    final bucket = DateTime.now().millisecondsSinceEpoch ~/ (sh.minutes * 60000);
    final r = await Bank.post(
      session,
      u,
      key: 'island:shift:${u.uuid}:$place:$bucket',
      amount: pay,
      kind: 'job',
      counter: place == 'club' ? 'city:services' : 'city:market',
      memo: sh.memo,
    );
    if (r.repeat) return _err('Your shift here is done. The next one starts in a few minutes.');
    final c = await Bank.fresh(session, u);
    return jsonEncode({'paid': pay, 'naira': c.naira, 'memo': sh.memo});
  });

  static String _n(int v) => v.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');

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
  Future<String> send(Session session, String handle, int amount, String note) => _money(session, (u) async {
    if (amount < 50 || amount > 50000) return _err('Send between ₦50 and ₦50,000.');
    final to = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals(handle.trim()));
    if (to == null) return _err('Nobody on the island by that name.');
    if (to.authUserId == u) return _err('That\'s you.');
    final me = await _profile(session, u);
    await WorldAuthority.citizen(session, to.authUserId);
    final id = '${DateTime.now().microsecondsSinceEpoch}${_rnd.nextInt(1 << 16)}';
    final memo = _clean(note, 60);
    final out = await Bank.post(session, u, key: 'island:send:$id:out', amount: -amount, kind: 'fee', counter: 'city:services', memo: 'To ${to.handle}${memo.isEmpty ? '' : ': $memo'}');
    if (out.short != null) return _err('You don\'t have that much.');
    await Bank.post(session, to.authUserId, key: 'island:send:$id:in', amount: amount, kind: 'refund', counter: 'city:services', memo: 'From ${me.handle}${memo.isEmpty ? '' : ': $memo'}');
    final c = await Bank.fresh(session, u);
    return jsonEncode({'sent': amount, 'to': to.handle, 'naira': c.naira});
  });

  // ---------------- casino ----------------
  static const _lossLimit = 10000;

  /// One round. [game]: roulette (bet red | black | green) or slots. [stake]: ₦100 to ₦5,000.
  /// Play money only, with a daily loss limit.
  Future<String> casino(Session session, String game, String bet, int stake) => _money(session, (u) async {
    if (stake < 100 || stake > 5000) return _err('Stakes are ₦100 to ₦5,000.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < stake) return _err('You don\'t have ₦${_n(stake)}.');
    final day = DateTime.now().toUtc().add(const Duration(hours: 1));
    final start = DateTime.utc(day.year, day.month, day.day).subtract(const Duration(hours: 1));
    final today = await NairaEntry.db.find(session, where: (t) => t.authUserId.equals(u) & t.createdAt.between(start, start.add(const Duration(days: 1))) & t.key.like('island:casino:%'));
    final net = today.fold<int>(0, (a, e) => a + e.amount);
    if (-net >= _lossLimit) return _err('You\'ve hit today\'s limit (₦${_n(_lossLimit)} lost). The casino closes for you until tomorrow.');
    int payout; // what comes back, stake included
    Map<String, dynamic> show;
    if (game == 'roulette') {
      if (!{'red', 'black', 'green'}.contains(bet)) return _err('Bet red, black or green.');
      final n = _rnd.nextInt(37); // 0 is green
      const reds = {1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36};
      final colour = n == 0 ? 'green' : reds.contains(n) ? 'red' : 'black';
      payout = colour == bet ? (bet == 'green' ? stake * 14 : stake * 2) : 0;
      show = {'number': n, 'colour': colour};
    } else if (game == 'slots') {
      const reel = ['🌴', '🌴', '🌴', '🛵', '🛵', '🥥', '🥥', '⭐', '💎'];
      final r = [for (var i = 0; i < 3; i++) reel[_rnd.nextInt(reel.length)]];
      final three = r[0] == r[1] && r[1] == r[2];
      final two = !three && (r[0] == r[1] || r[1] == r[2] || r[0] == r[2]);
      final mult = three ? {'💎': 30, '⭐': 15, '🥥': 8, '🛵': 6, '🌴': 4}[r[0]]! : two ? 1 : 0;
      payout = stake * mult;
      show = {'reels': r};
    } else {
      return _err('No such table.');
    }
    final amount = payout - stake;
    final key = 'island:casino:${u.uuid}:${DateTime.now().microsecondsSinceEpoch}';
    if (amount != 0) {
      await Bank.post(session, u, key: key, amount: amount, kind: amount > 0 ? 'place' : 'fee', counter: 'city:market', memo: game == 'roulette' ? 'Casino: roulette' : 'Casino: slots');
    }
    final after = await Bank.fresh(session, u);
    return jsonEncode({...show, 'won': amount, 'naira': after.naira});
  });

  // ---------------- jobs ----------------
  static Set<String> _words(String s) => s.toLowerCase().split(RegExp(r'[,;/]+')).map((w) => w.trim()).where((w) => w.length > 1).toSet();

  static Map<String, dynamic> _jobJson(IslandJob j, {bool contact = false, int? match}) => {
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
    final open = await IslandJob.db.find(session, where: (t) => t.status.equals('open'), orderBy: (t) => t.createdAt.desc(), limit: 100);
    final mine = await IslandApplication.db.find(session, where: (t) => t.authUserId.equals(u));
    final applied = {for (final a in mine) a.jobId};
    final have = p.openToWork ? _words(p.skills) : <String>{};
    final list = [
      for (final j in open)
        () {
          final need = _words(j.skills);
          final hit = need.where((w) => have.any((h) => h.contains(w) || w.contains(h))).length;
          final m = have.isEmpty || need.isEmpty ? null : (100 * hit / need.length).round();
          return {..._jobJson(j, contact: applied.contains(j.id), match: m), 'applied': applied.contains(j.id)};
        }(),
    ];
    if (have.isNotEmpty) list.sort((a, b) => ((b['match'] ?? 0) as int).compareTo((a['match'] ?? 0) as int));
    return jsonEncode(list);
  }

  /// Post a real job. It shows once WYRD's operator has checked it.
  Future<String> postJob(Session session, String company, String title, String pay, String skills, String location, String about, String contact) async {
    final u = _user(session);
    final f = [company, title, pay, skills, location, about, contact].map((v) => v.trim()).toList();
    if (f.any((v) => v.isEmpty)) return _err('Fill in every field.');
    final recent = await IslandJob.db.count(session, where: (t) => t.employerUserId.equals(u) & (t.createdAt > DateTime.now().toUtc().subtract(const Duration(days: 1))));
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
    if (j == null || j.status != 'open') return _err('That job is no longer open.');
    if (j.employerUserId == u) return _err('That\'s your own post.');
    final had = await IslandApplication.db.findFirstRow(session, where: (t) => t.jobId.equals(jobId) & t.authUserId.equals(u));
    if (had != null) return jsonEncode({'applied': true, 'contact': j.contact});
    await IslandApplication.db.insertRow(session, IslandApplication(jobId: jobId, authUserId: u, note: _clean(note, 800), createdAt: DateTime.now().toUtc()));
    return jsonEncode({'applied': true, 'contact': j.contact});
  }

  /// My posts, each with who applied: their handle, skills and note.
  Future<String> myJobs(Session session) async {
    final u = _user(session);
    final posts = await IslandJob.db.find(session, where: (t) => t.employerUserId.equals(u), orderBy: (t) => t.createdAt.desc());
    final out = [];
    for (final j in posts) {
      final apps = await IslandApplication.db.find(session, where: (t) => t.jobId.equals(j.id!), orderBy: (t) => t.createdAt);
      final people = <Map<String, dynamic>>[];
      for (final a in apps) {
        final p = await _profile(session, a.authUserId);
        people.add({'handle': p.handle, 'skills': p.skills, 'note': a.note, 'at': a.createdAt.toIso8601String()});
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
    if (!await DroneService.isOperator(session, _user(session))) return _err('Operators only.');
    final rows = await IslandJob.db.find(session, where: (t) => t.status.equals('pending'), orderBy: (t) => t.createdAt);
    return jsonEncode([for (final j in rows) _jobJson(j, contact: true)]);
  }

  /// The operator approves (open) or rejects a post.
  Future<String> reviewJob(Session session, int jobId, bool approve) async {
    if (!await DroneService.isOperator(session, _user(session))) return _err('Operators only.');
    final j = await IslandJob.db.findById(session, jobId);
    if (j == null) return _err('No such post.');
    await IslandJob.db.updateRow(session, j.copyWith(status: approve ? 'open' : 'rejected'));
    return jsonEncode({'id': jobId, 'status': approve ? 'open' : 'rejected'});
  }

  // ---------------- encrypted chats ----------------
  static bool _b64(String s, int max) => s.length <= max && RegExp(r'^[A-Za-z0-9+/=]+\.[A-Za-z0-9+/=]+$').hasMatch(s);

  /// Start a chat. [members]: JSON list of {handle, wrappedKey} -- me included -- each with the group
  /// key wrapped (in my browser) for that person, using my public key [wrapperPub].
  Future<String> createGroup(Session session, String nameCt, String wrapperPub, String members) async {
    final u = _user(session);
    if (!_b64(nameCt, 400)) return _err('Bad name.');
    final list = (jsonDecode(members) as List).cast<Map<String, dynamic>>();
    if (list.length < 2 || list.length > 50) return _err('A chat has 2 to 50 people.');
    final now = DateTime.now().toUtc();
    final rows = <IslandMember>[];
    var hasMe = false;
    for (final m in list) {
      final p = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals('${m['handle']}'));
      final wk = '${m['wrappedKey']}';
      if (p == null || !_b64(wk, 300)) return _err('Unknown member ${m['handle']}.');
      if (p.authUserId == u) hasMe = true;
      rows.add(IslandMember(groupId: 0, authUserId: p.authUserId, wrappedKey: wk, wrapperPub: wrapperPub, addedAt: now));
    }
    if (!hasMe) return _err('Include yourself.');
    final g = await IslandGroup.db.insertRow(session, IslandGroup(createdBy: u, nameCt: nameCt, createdAt: now));
    await IslandMember.db.insert(session, [for (final r in rows) r.copyWith(groupId: g.id!)]);
    return jsonEncode({'id': g.id});
  }

  /// Add someone to a chat I'm in, with the group key wrapped for them.
  Future<String> addMember(Session session, int groupId, String handle, String wrappedKey, String wrapperPub) async {
    final u = _user(session);
    if (await IslandMember.db.findFirstRow(session, where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u)) == null) return _err('Not your chat.');
    final p = await IslandProfile.db.findFirstRow(session, where: (t) => t.handle.equals(handle));
    if (p == null || !_b64(wrappedKey, 300)) return _err('Unknown person.');
    if (await IslandMember.db.count(session, where: (t) => t.groupId.equals(groupId)) >= 50) return _err('The chat is full.');
    await IslandMember.db.insertRow(session, IslandMember(groupId: groupId, authUserId: p.authUserId, wrappedKey: wrappedKey, wrapperPub: wrapperPub, addedAt: DateTime.now().toUtc()));
    return jsonEncode({'added': p.handle});
  }

  /// Leave a chat.
  Future<String> leaveGroup(Session session, int groupId) async {
    final u = _user(session);
    await IslandMember.db.deleteWhere(session, where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u));
    return jsonEncode({'left': groupId});
  }

  /// My chats: each with its encrypted name, my wrapped key, who's in it, and the last message's id.
  Future<String> groups(Session session) async {
    final u = _user(session);
    final mine = await IslandMember.db.find(session, where: (t) => t.authUserId.equals(u));
    final out = [];
    for (final m in mine) {
      final g = await IslandGroup.db.findById(session, m.groupId);
      if (g == null) continue;
      final members = await IslandMember.db.find(session, where: (t) => t.groupId.equals(g.id!));
      final handles = <String>[];
      for (final x in members) handles.add((await _profile(session, x.authUserId)).handle);
      final last = await IslandMessage.db.findFirstRow(session, where: (t) => t.groupId.equals(g.id!), orderBy: (t) => t.id.desc());
      out.add({'id': g.id, 'nameCt': g.nameCt, 'wrappedKey': m.wrappedKey, 'wrapperPub': m.wrapperPub, 'members': handles, 'last': last?.id ?? 0});
    }
    out.sort((a, b) => (b['last'] as int).compareTo(a['last'] as int));
    return jsonEncode(out);
  }

  /// Post an encrypted message to a chat I'm in.
  Future<String> post(Session session, int groupId, String ct) async {
    final u = _user(session);
    if (!_b64(ct, 8000)) return _err('Bad message.');
    if (await IslandMember.db.findFirstRow(session, where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u)) == null) return _err('Not your chat.');
    final m = await IslandMessage.db.insertRow(session, IslandMessage(groupId: groupId, senderId: u, ct: ct, createdAt: DateTime.now().toUtc()));
    return jsonEncode({'id': m.id});
  }

  /// A chat's messages after [since] (at most 100), as ciphertext with the sender's handle.
  Future<String> messages(Session session, int groupId, int since) async {
    final u = _user(session);
    if (await IslandMember.db.findFirstRow(session, where: (t) => t.groupId.equals(groupId) & t.authUserId.equals(u)) == null) return _err('Not your chat.');
    final rows = await IslandMessage.db.find(session, where: (t) => t.groupId.equals(groupId) & (t.id > since), orderBy: (t) => since == 0 ? t.id.desc() : t.id.asc(), limit: 100);
    final list = since == 0 ? rows.reversed.toList() : rows;
    final names = <String, String>{};
    final out = [];
    for (final m in list) {
      names[m.senderId.uuid] ??= (await _profile(session, m.senderId)).handle;
      out.add({'id': m.id, 'from': names[m.senderId.uuid], 'mine': m.senderId == u, 'ct': m.ct, 'at': m.createdAt.toIso8601String()});
    }
    return jsonEncode(out);
  }

  // ---------------- HQ ----------------
  /// Set up my HQ: its name, colour, whether it's locked, and who's invited (JSON list of handles).
  Future<String> setHq(Session session, String name, String color, bool locked, String invites) async {
    final u = _user(session);
    final p = await _profile(session, u);
    if (!RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color)) return _err('Bad colour.');
    final list = (jsonDecode(invites) as List).map((e) => '$e'.trim()).where((e) => e.isNotEmpty).take(40).toList();
    final saved = await IslandProfile.db.updateRow(session, p.copyWith(hqName: _clean(name, 40), hqColor: color, hqLocked: locked, hqInvites: jsonEncode(list)));
    return jsonEncode(_profileJson(saved)['hq']);
  }

  /// HQ Row: every HQ, with whether I may go in (mine, open, or I'm invited). Names show only for
  /// HQs I may enter.
  Future<String> hqRow(Session session) async {
    final u = _user(session);
    final me = await _profile(session, u);
    final all = await IslandProfile.db.find(session, orderBy: (t) => t.id, limit: 300);
    final asked = {for (final a in await IslandAccess.db.find(session, where: (t) => t.requesterId.equals(u))) a.ownerId.uuid: a.status};
    return jsonEncode([
      for (final p in all)
        () {
          final mine = p.authUserId == u;
          final may = mine || !p.hqLocked || (jsonDecode(p.hqInvites) as List).contains(me.handle);
          final req = asked[p.authUserId.uuid];
          return {'slot': p.id, 'color': p.hqColor, 'mine': mine, 'may': may, if (!may && req != null) 'asked': req, if (may) 'name': p.hqName ?? "${p.handle}'s HQ", if (may) 'owner': p.handle};
        }(),
    ]);
  }

  /// Ask to enter the HQ in [slot] (from hqRow). The owner gets the request on their phone.
  Future<String> askHq(Session session, int slot) async {
    final u = _user(session);
    final owner = await IslandProfile.db.findById(session, slot);
    if (owner == null) return _err('No HQ there.');
    if (owner.authUserId == u) return jsonEncode({'status': 'granted'});
    final had = await IslandAccess.db.findFirstRow(session, where: (t) => t.ownerId.equals(owner.authUserId) & t.requesterId.equals(u));
    if (had != null) {
      if (had.status == 'denied' && DateTime.now().toUtc().difference(had.createdAt).inHours >= 24) {
        await IslandAccess.db.updateRow(session, had.copyWith(status: 'pending', createdAt: DateTime.now().toUtc()));
        return jsonEncode({'status': 'pending'});
      }
      return jsonEncode({'status': had.status});
    }
    await IslandAccess.db.insertRow(session, IslandAccess(ownerId: owner.authUserId, requesterId: u, createdAt: DateTime.now().toUtc()));
    return jsonEncode({'status': 'pending'});
  }

  /// Requests to enter my HQ, waiting for my answer.
  Future<String> hqRequests(Session session) async {
    final u = _user(session);
    final rows = await IslandAccess.db.find(session, where: (t) => t.ownerId.equals(u) & t.status.equals('pending'), orderBy: (t) => t.createdAt);
    return jsonEncode([
      for (final r in rows) {'id': r.id, 'handle': (await _profile(session, r.requesterId)).handle, 'at': r.createdAt.toIso8601String()},
    ]);
  }

  /// Let someone in (they join my HQ's invite list) or turn them away.
  Future<String> answerHq(Session session, int id, bool grant) async {
    final u = _user(session);
    final r = await IslandAccess.db.findById(session, id);
    if (r == null || r.ownerId != u) return _err('Not your request.');
    await IslandAccess.db.updateRow(session, r.copyWith(status: grant ? 'granted' : 'denied', createdAt: DateTime.now().toUtc()));
    if (grant) {
      final p = await _profile(session, u), who = (await _profile(session, r.requesterId)).handle;
      final inv = (jsonDecode(p.hqInvites) as List).map((e) => '$e').toList();
      if (!inv.contains(who)) await IslandProfile.db.updateRow(session, p.copyWith(hqInvites: jsonEncode([...inv, who])));
    }
    return jsonEncode({'id': id, 'status': grant ? 'granted' : 'denied'});
  }

  // ---------------- rides (like a ride-hailing app: quote, request, pay on arrival) ----------------
  /// Fares in naira for a trip between two board tiles (distance on the grid): okada and car.
  static Map<String, int> _fares(int fi, int fj, int ti, int tj) {
    final d = (fi - ti).abs() + (tj - fj).abs();
    return {'okada': min(6000, 400 + d * 22), 'car': min(15000, 1000 + d * 48)};
  }

  static final _rides = <String, ({String user, int fare, String kind, DateTime at})>{};

  /// What a trip would cost, and roughly how long until a rider reaches you.
  Future<String> rideQuote(Session session, int fi, int fj, int ti, int tj) async {
    final f = _fares(fi, fj, ti, tj), d = (fi - ti).abs() + (tj - fj).abs();
    return jsonEncode({...f, 'tiles': d, 'okadaEta': 2 + _rnd.nextInt(3), 'carEta': 3 + _rnd.nextInt(4)});
  }

  /// Book a ride: the fare is fixed now (and must be affordable); it's charged when you arrive.
  Future<String> requestRide(Session session, int fi, int fj, int ti, int tj, String kind) async {
    final u = _user(session);
    final f = _fares(fi, fj, ti, tj)[kind];
    if (f == null) return _err('Okada or car.');
    final c = await WorldAuthority.citizen(session, u);
    if (c.naira < f) return _err('This ride costs ₦${_n(f)} and you have ₦${_n(c.naira)}. Work a shift first.');
    _rides.removeWhere((_, r) => DateTime.now().difference(r.at).inHours >= 2);
    final id = '${DateTime.now().millisecondsSinceEpoch}${_rnd.nextInt(1 << 20)}';
    _rides[id] = (user: u.uuid, fare: f, kind: kind, at: DateTime.now());
    return jsonEncode({'id': id, 'fare': f, 'kind': kind});
  }

  /// You've arrived: pay the fare (once).
  Future<String> payRide(Session session, String id) => _money(session, (u) async {
    final r = _rides[id];
    if (r == null || r.user != u.uuid) return _err('No such ride.');
    final res = await Bank.post(session, u, key: 'island:ride:$id', amount: -r.fare, kind: 'ride', counter: 'city:transport', memo: r.kind == 'okada' ? 'Okada ride' : 'Car ride');
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

  // ---------------- insides ----------------
  /// May I arrange the room [key]? My own HQ, or (operators) the public buildings.
  static Future<bool> _mayArrange(Session s, UuidValue u, String key) async {
    if (key.startsWith('hq:')) {
      final p = await IslandProfile.db.findById(s, int.tryParse(key.substring(3)) ?? -1);
      return p != null && p.authUserId == u;
    }
    return false; // only HQs are arranged by players; every other building keeps its design
  }

  /// A room's furniture (JSON list), and whether I may arrange it. An HQ's inside shows only to its
  /// owner and the people they've let in.
  Future<String> room(Session session, String key) async {
    final u = _user(session);
    if (key.startsWith('hq:')) {
      final p = await IslandProfile.db.findById(session, int.tryParse(key.substring(3)) ?? -1);
      if (p == null) return _err('No HQ there.');
      final me = await _profile(session, u);
      final may = p.authUserId == u || !p.hqLocked || (jsonDecode(p.hqInvites) as List).contains(me.handle);
      if (!may) return _err('Knock first: the owner lets people in.');
    }
    final r = await IslandRoom.db.findFirstRow(session, where: (t) => t.key.equals(key));
    return jsonEncode({'key': key, 'layout': r == null ? null : jsonDecode(r.layout), 'mine': await _mayArrange(session, u, key)});
  }

  /// Save a room's furniture.
  Future<String> saveRoom(Session session, String key, String layout) async {
    final u = _user(session);
    if (!await _mayArrange(session, u, key)) return _err('Only the owner can arrange this room.');
    if (layout.length > 24000) return _err('Too much furniture.');
    final list = jsonDecode(layout);
    if (list is! List || list.length > 200) return _err('At most 200 pieces.');
    for (final it in list) {
      if (it is! Map || it['k'] is! String || it['x'] is! num || it['z'] is! num) return _err('Bad furniture.');
    }
    final had = await IslandRoom.db.findFirstRow(session, where: (t) => t.key.equals(key));
    final now = DateTime.now().toUtc();
    if (had == null) {
      await IslandRoom.db.insertRow(session, IslandRoom(key: key, layout: layout, updatedAt: now));
    } else {
      await IslandRoom.db.updateRow(session, had.copyWith(layout: layout, updatedAt: now));
    }
    return jsonEncode({'saved': list.length});
  }

  // ---------------- the arena ----------------
  static Map<String, dynamic> _showJson(IslandShow s, {int sold = 0, bool mine = false, bool ticket = false}) {
    final now = DateTime.now().toUtc();
    return {
      'id': s.id, 'artist': s.artist, 'title': s.title, 'startsAt': s.startsAt.toIso8601String(), 'minutes': s.minutes,
      'price': s.price, 'capacity': s.capacity, 'sold': sold, 'status': s.status, 'mine': mine, 'ticket': ticket,
      'live': s.status == 'on_sale' && !now.isBefore(s.startsAt) && now.isBefore(s.startsAt.add(Duration(minutes: s.minutes))),
    };
  }

  /// Shows on sale and coming up (and my own, whatever their status).
  Future<String> shows(Session session) async {
    final u = _user(session);
    final from = DateTime.now().toUtc().subtract(const Duration(hours: 4));
    final rows = await IslandShow.db.find(session, where: (t) => (t.status.equals('on_sale') | t.hostUserId.equals(u)) & (t.startsAt > from), orderBy: (t) => t.startsAt, limit: 50);
    final mine = {for (final k in await IslandTicket.db.find(session, where: (t) => t.authUserId.equals(u))) k.showId};
    return jsonEncode([
      for (final s in rows)
        _showJson(s, sold: await IslandTicket.db.count(session, where: (t) => t.showId.equals(s.id!)), mine: s.hostUserId == u, ticket: mine.contains(s.id)),
    ]);
  }

  /// An artist books the arena. Tickets go on sale once WYRD's operator has checked it.
  Future<String> hostShow(Session session, String artist, String title, String startsAt, int minutes, int price) async {
    final u = _user(session);
    final at = DateTime.tryParse(startsAt)?.toUtc();
    if (artist.trim().isEmpty || title.trim().isEmpty) return _err('Give the artist and the show a name.');
    if (at == null || at.isBefore(DateTime.now().toUtc())) return _err('Pick a time in the future.');
    if (minutes < 15 || minutes > 240) return _err('A show runs 15 minutes to 4 hours.');
    if (price < 0 || price > 20000) return _err('Tickets cost ₦0 to ₦20,000.');
    final clash = await IslandShow.db.findFirstRow(session, where: (t) => t.status.equals('on_sale') & (t.startsAt > at.subtract(const Duration(hours: 4))) & (t.startsAt < at.add(Duration(minutes: minutes))));
    if (clash != null && clash.startsAt.add(Duration(minutes: clash.minutes)).isAfter(at)) return _err('The arena is booked then. Pick another time.');
    final s = await IslandShow.db.insertRow(session, IslandShow(hostUserId: u, artist: _clean(artist, 60), title: _clean(title, 80), startsAt: at, minutes: minutes, price: price, createdAt: DateTime.now().toUtc()));
    return jsonEncode(_showJson(s, mine: true));
  }

  /// The operator's queue of shows to check, and the decision.
  Future<String> pendingShows(Session session) async {
    if (!await DroneService.isOperator(session, _user(session))) return _err('Operators only.');
    final rows = await IslandShow.db.find(session, where: (t) => t.status.equals('pending'), orderBy: (t) => t.startsAt);
    return jsonEncode([for (final s in rows) _showJson(s)]);
  }

  Future<String> reviewShow(Session session, int showId, bool approve) async {
    if (!await DroneService.isOperator(session, _user(session))) return _err('Operators only.');
    final s = await IslandShow.db.findById(session, showId);
    if (s == null) return _err('No such show.');
    await IslandShow.db.updateRow(session, s.copyWith(status: approve ? 'on_sale' : 'rejected'));
    return jsonEncode({'id': showId, 'status': approve ? 'on_sale' : 'rejected'});
  }

  /// Buy a ticket with naira. Nine tenths goes to the artist who hosts the show.
  Future<String> buyTicket(Session session, int showId) => _money(session, (u) async {
    final s = await IslandShow.db.findById(session, showId);
    if (s == null || s.status != 'on_sale') return _err('That show isn\'t on sale.');
    if (DateTime.now().toUtc().isAfter(s.startsAt.add(Duration(minutes: s.minutes)))) return _err('That show is over.');
    if (await IslandTicket.db.findFirstRow(session, where: (t) => t.showId.equals(showId) & t.authUserId.equals(u)) != null) return jsonEncode({'ticket': true});
    if (await IslandTicket.db.count(session, where: (t) => t.showId.equals(showId)) >= s.capacity) return _err('Sold out.');
    await WorldAuthority.citizen(session, u);
    if (s.price > 0) {
      final r = await Bank.post(session, u, key: 'island:ticket:$showId:${u.uuid}', amount: -s.price, kind: 'fee', counter: 'city:services', memo: 'Ticket: ${s.artist}');
      if (r.short != null) return _err('You need ${'₦'}${_n(s.price)}.');
      if (s.hostUserId != u) {
        await WorldAuthority.citizen(session, s.hostUserId);
        await Bank.post(session, s.hostUserId, key: 'island:ticket:$showId:${u.uuid}:artist', amount: s.price * 9 ~/ 10, kind: 'job', counter: 'city:services', memo: 'Ticket sold: ${s.title}');
      }
    }
    await IslandTicket.db.insertRow(session, IslandTicket(showId: showId, authUserId: u, createdAt: DateTime.now().toUtc()));
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
    if (!host && await IslandTicket.db.findFirstRow(session, where: (t) => t.showId.equals(showId) & t.authUserId.equals(u)) == null) return _err('You need a ticket.');
    final lines = (_stage[showId] ?? const []).where((l) => (l['n'] as int) > since).toList();
    return jsonEncode({..._showJson(s, mine: host, ticket: !host), 'crowd': await IslandTicket.db.count(session, where: (t) => t.showId.equals(showId)), 'lines': lines});
  }

  /// The artist performs: a line onto the arena's screens, for everyone with a ticket.
  Future<String> perform(Session session, int showId, String text) async {
    final u = _user(session);
    final s = await IslandShow.db.findById(session, showId);
    if (s == null || s.hostUserId != u) return _err('Only the artist can take the stage.');
    final now = DateTime.now().toUtc();
    if (now.isBefore(s.startsAt.subtract(const Duration(minutes: 10))) || now.isAfter(s.startsAt.add(Duration(minutes: s.minutes)))) return _err('The stage is yours from 10 minutes before the show until it ends.');
    final list = _stage.putIfAbsent(showId, () => []);
    final n = list.isEmpty ? 1 : (list.last['n'] as int) + 1;
    list.add({'n': n, 'text': _clean(text, 400), 'at': now.toIso8601String()});
    if (list.length > 400) list.removeAt(0);
    return jsonEncode({'n': n});
  }

  // ---------------- WYRD ----------------
  /// Ask WYRD from the phone. It hears [text] and the district I'm in -- nothing from my chats.
  Future<String> askWyrd(Session session, String text, String district) async {
    final u = _user(session);
    final d = _clean(district, 40);
    return WorldAuthority.address(session, u, 'speak', text,
        'The player is on LAGOS ISLAND (the game version of Lagos Island, Ikoyi, VI, Eko Atlantic, Lekki, Ajah and Ilashe), in $d, '
        'asking from their in-game phone. The phone has: Wallet (naira earned by shifts at the refinery, clubs, market, okada), '
        'Jobs (real jobs from real employers), encrypted Chats, their HQ, the Casino (play money), and you. '
        'You do not see their chats or messages; never ask for them.');
  }
}
