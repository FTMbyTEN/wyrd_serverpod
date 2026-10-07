import 'dart:convert';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'world_authority.dart';

/// A home in the city: where it is (metres from Ojuelegba, like the game's world), what it is, and
/// what it costs a week to rent or once to buy.
class Home {
  final String slug, name, district, kind;
  final int x, z, rent, price;
  const Home(this.slug, this.name, this.district, this.kind, this.x, this.z, this.rent, this.price);
}

/// NAIJA 2099's money and housing. Naira only ever changes here, on the server: missions pay, fares
/// and rent cost, homes are rented by the week (charged when you next check in) or bought outright.
/// Each home has one occupant at a time.
class WalletService {
  // the districts: centre (lat, lon) and price tier (1 cheap .. 5 very dear), as in the game's map
  static const _districts = <String, (double, double, int)>{
    'Ojuelegba': (6.50955, 3.36395, 1),
    'Yaba': (6.5095, 3.3785, 2),
    'Surulere': (6.4985, 3.3535, 2),
    'Mushin': (6.5273, 3.3449, 1),
    'Ebute-Metta': (6.4878, 3.3805, 1),
    'Maryland': (6.5713, 3.3676, 3),
    'Lagos Island': (6.4541, 3.3947, 3),
    'Ikoyi': (6.4523, 3.4339, 5),
    'Victoria Island': (6.4281, 3.4219, 5),
    'Eko Atlantic': (6.4067, 3.4106, 5),
  };
  static const _kinds = [
    // kind, label, weekly rent and price at tier 1
    ('room', 'Room', 1500, 60000),
    ('miniflat', 'Mini flat', 3000, 150000),
    ('flat', '2-bed flat', 6000, 400000),
    ('duplex', 'Duplex', 12000, 1200000),
    ('penthouse', 'Penthouse', 25000, 4000000),
  ];
  static final List<Home> homes = _build();

  static List<Home> _build() {
    const o = (6.50955, 3.36395);
    final kx = 111320 * math.cos(o.$1 * math.pi / 180), kz = 110540.0;
    final out = <Home>[];
    var seed = 20261006;
    double rnd() => (seed = (seed * 16807) % 2147483647) / 2147483647;
    _districts.forEach((d, v) {
      final (lat, lon, tier) = v;
      final cx = (lon - o.$2) * kx, cz = -(lat - o.$1) * kz;
      for (var i = 0; i < 8; i++) {
        // cheaper districts have more rooms; dear ones more duplexes and penthouses
        final k = _kinds[math.min(4, ((rnd() * 3).floor() + (tier - 1) * 0.6).round())];
        final a = rnd() * math.pi * 2, r = 120 + rnd() * 520;
        final mult = [1.0, 1.0, 1.6, 2.4, 4.0, 7.0][tier];
        out.add(Home('${d.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '')}-$i', '${k.$2} · $d', d, k.$1,
            (cx + math.cos(a) * r).round(), (cz + math.sin(a) * r).round(),
            (k.$3 * mult / 100).round() * 100, (k.$4 * mult / 1000).round() * 1000));
      }
    });
    return out;
  }

  static Home? home(String? slug) => slug == null ? null : homes.where((h) => h.slug == slug).firstOrNull;

  /// The wallet, after collecting any rent that has fallen due (a week at a time; can't pay: you're out).
  static Future<WorldCitizen> settle(Session session, UuidValue user) async {
    var c = await WorldAuthority.citizen(session, user);
    final h = home(c.homeSlug);
    if (h == null || c.homeMode != 'rent') return c;
    final now = DateTime.now().toUtc();
    var paid = c.rentPaidUntil ?? now;
    var naira = c.naira;
    var lost = false;
    while (paid.isBefore(now)) {
      if (naira < h.rent) { lost = true; break; }
      naira -= h.rent;
      paid = paid.add(const Duration(days: 7));
    }
    c = lost
        ? c.copyWith(naira: naira, homeSlug: null, homeMode: null, rentPaidUntil: null, updatedAt: now)
        : c.copyWith(naira: naira, rentPaidUntil: paid, updatedAt: now);
    return WorldCitizen.db.updateRow(session, c);
  }

  static Map<String, dynamic> _wallet(WorldCitizen c) {
    final h = home(c.homeSlug);
    return {
      'naira': c.naira,
      'guide': GuideService.done(c),
      'home': h == null ? null : {..._homeJson(h), 'mode': c.homeMode, 'paidUntil': c.rentPaidUntil?.toIso8601String()},
    };
  }

  static Map<String, dynamic> _homeJson(Home h) => {
        'slug': h.slug, 'name': h.name, 'district': h.district, 'kind': h.kind, 'x': h.x, 'z': h.z, 'rent': h.rent, 'price': h.price,
      };

  static Future<String> wallet(Session session, UuidValue user) async => jsonEncode(_wallet(await settle(session, user)));

  /// Every home, with whether it's taken and whether it's yours.
  static Future<String> listHomes(Session session, UuidValue user) async {
    final taken = await WorldCitizen.db.find(session, where: (t) => t.homeSlug.notEquals(null));
    final byHome = {for (final c in taken) c.homeSlug!: c.authUserId.uuid};
    return jsonEncode([
      for (final h in homes) {..._homeJson(h), 'taken': byHome.containsKey(h.slug), 'mine': byHome[h.slug] == user.uuid},
    ]);
  }

  /// Rent (first week paid now) or buy a home. Returns the wallet, or {error}.
  static Future<String> takeHome(Session session, UuidValue user, String slug, String mode) async {
    final h = home(slug);
    if (h == null || (mode != 'rent' && mode != 'own')) return jsonEncode({'error': 'No such home.'});
    var c = await settle(session, user);
    if (c.homeSlug == slug) return jsonEncode({'error': 'This is already your home.'});
    final other = await WorldCitizen.db.findFirstRow(session, where: (t) => t.homeSlug.equals(slug));
    if (other != null) return jsonEncode({'error': 'Someone already lives here.'});
    final cost = mode == 'rent' ? h.rent : h.price;
    if (c.naira < cost) return jsonEncode({'error': 'You need ₦${_fmt(cost)} -- you have ₦${_fmt(c.naira)}.'});
    final now = DateTime.now().toUtc();
    c = await WorldCitizen.db.updateRow(session, c.copyWith(
      naira: c.naira - cost, homeSlug: slug, homeMode: mode,
      rentPaidUntil: mode == 'rent' ? now.add(const Duration(days: 7)) : null, updatedAt: now));
    return jsonEncode(_wallet(c));
  }

  /// Move out (renting: no refund; owning: sold back for 70% of the price).
  static Future<String> leaveHome(Session session, UuidValue user) async {
    var c = await settle(session, user);
    final h = home(c.homeSlug);
    if (h == null) return jsonEncode(_wallet(c));
    final back = c.homeMode == 'own' ? (h.price * 0.7).round() : 0;
    c = await WorldCitizen.db.updateRow(session, c.copyWith(
      naira: c.naira + back, homeSlug: null, homeMode: null, rentPaidUntil: null, updatedAt: DateTime.now().toUtc()));
    return jsonEncode(_wallet(c));
  }

  /// What things cost; the game names the reason, the server sets the price.
  static const fares = {'maglev': 200, 'danfo': 100};

  static Future<String> pay(Session session, UuidValue user, String reason) async {
    final cost = fares[reason];
    if (cost == null) return jsonEncode({'error': 'Unknown charge.'});
    var c = await settle(session, user);
    if (c.naira < cost) return jsonEncode({'error': 'Not enough naira (₦${_fmt(cost)}).'});
    c = await WorldCitizen.db.updateRow(session, c.copyWith(naira: c.naira - cost, updatedAt: DateTime.now().toUtc()));
    return jsonEncode(_wallet(c));
  }

  /// The street board's missions and what they pay (each once a day).
  static const streetPay = {
    'st-tejuosho': 2500, 'st-flyover': 1500, 'st-herbert': 2500, 'st-bode': 1500,
    'st-itire': 1500, 'st-akerele': 2500, 'st-3mb': 4000, 'st-broad': 6000,
  };

  static final _lastStreet = <String, DateTime>{};

  static Future<String> missionPaid(Session session, UuidValue user, String id) async {
    final pay = streetPay[id];
    if (pay == null) return jsonEncode({'error': 'Unknown mission.'});
    var c = await settle(session, user);
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    final p = c.paidToday == null ? <String, dynamic>{} : jsonDecode(c.paidToday!) as Map<String, dynamic>;
    final ids = p['day'] == today ? List<String>.from(p['ids'] as List) : <String>[];
    if (ids.contains(id)) return jsonEncode({..._wallet(c), 'paid': 0, 'note': 'Already paid today.'});
    // a street mission takes minutes to play: one paid every three minutes, so a script can't
    // collect the whole board at once
    final last = _lastStreet[user.uuid];
    if (last != null && DateTime.now().difference(last) < const Duration(minutes: 3)) {
      return jsonEncode({..._wallet(c), 'paid': 0, 'note': 'Take a breath -- the next job opens in a few minutes.'});
    }
    _lastStreet[user.uuid] = DateTime.now();
    ids.add(id);
    c = await WorldCitizen.db.updateRow(session, c.copyWith(
      naira: c.naira + pay, paidToday: jsonEncode({'day': today, 'ids': ids}), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({..._wallet(c), 'paid': pay});
  }

  /// WYRD's own missions pay too, when it marks one done.
  static const boardPay = 3000;

  static String _fmt(int n) => n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');
}

/// The first-time guide: six steps that teach the city, each paying a small bonus once.
class GuideService {
  static const steps = {'earn': 500, 'eat': 300, 'wyrd': 300, 'maglev': 500, 'home': 1000, 'job': 1000};

  static List<String> done(WorldCitizen c) => c.guideDone == null ? <String>[] : List<String>.from(jsonDecode(c.guideDone!) as List);

  /// Mark a step done: pays its bonus the first time. 'home' is checked (you must have one).
  static Future<String> mark(Session session, UuidValue user, String step) async {
    final bonus = steps[step];
    if (bonus == null) return jsonEncode({'error': 'No such step.'});
    var c = await WalletService.settle(session, user);
    final list = done(c);
    if (list.contains(step)) return jsonEncode({'guide': list, 'paid': 0, 'naira': c.naira});
    if (step == 'home' && c.homeSlug == null) return jsonEncode({'error': 'You have no home yet.'});
    list.add(step);
    c = await WorldCitizen.db.updateRow(session, c.copyWith(naira: c.naira + bonus, guideDone: jsonEncode(list), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({'guide': list, 'paid': bonus, 'naira': c.naira});
  }

  /// Skip the guide (counts every step done, pays nothing more).
  static Future<String> skip(Session session, UuidValue user) async {
    var c = await WalletService.settle(session, user);
    c = await WorldCitizen.db.updateRow(session, c.copyWith(guideDone: jsonEncode(steps.keys.toList()), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({'guide': done(c), 'paid': 0, 'naira': c.naira});
  }
}
