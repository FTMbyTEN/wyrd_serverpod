import 'dart:convert';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';
import 'bank.dart';

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

  /// rent unpaid: how long the home is kept, from the first visit it was due
  static const rentGrace = Duration(days: 14);

  /// The wallet, after collecting any rent that has fallen due (a week at a time). Rent you can't pay doesn't cost you
  /// the home at once: you keep it for [rentGrace] from the first visit it was due (time away doesn't count against
  /// you), paying the weeks owed whenever you can; only after that do you move out -- to a free hostel bed, with nothing
  /// else lost. A plan under ₦2,000 owed for 30 days is forgiven here too.
  static Future<WorldCitizen> settle(Session session, UuidValue user) async {
    var c = await WorldAuthority.citizen(session, user);
    final now = DateTime.now().toUtc();
    if (c.debt > 0 && c.debt < 2000 && c.debtSince != null && now.difference(c.debtSince!) > const Duration(days: 30)) {
      await Bank.owe(session, user, key: 'forgive:${user.uuid}:${c.debtSince!.toIso8601String()}', amount: -c.debt, memo: 'Payment plan forgiven (₦${_fmt(c.debt)}): 30 days is long enough');
      c = await Bank.fresh(session, user);
    }
    final h = home(c.homeSlug);
    if (h == null || c.homeMode != 'rent') return c;
    var paid = c.rentPaidUntil ?? now;
    if (!paid.isBefore(now)) return c;
    var short = false;
    while (paid.isBefore(now)) {
      // each week's rent once, by its date (two requests at once can't charge it twice)
      final week = paid.toIso8601String().substring(0, 10);
      final r = await Bank.post(session, user, key: 'rent:${h.slug}:${user.uuid}:$week', amount: -h.rent, kind: 'rent',
          counter: 'city:landlord', memo: 'Rent, ${h.name} (week from $week)');
      if (!r.ok) { short = true; break; }
      paid = paid.add(const Duration(days: 7));
    }
    c = await Bank.fresh(session, user);
    if (!short) {
      c = c.copyWith(rentPaidUntil: paid, rentGraceUntil: null, updatedAt: now);
    } else if (c.rentGraceUntil == null) {
      c = c.copyWith(rentPaidUntil: paid, rentGraceUntil: now.add(rentGrace), updatedAt: now); // (the grace starts now)
    } else if (now.isAfter(c.rentGraceUntil!)) {
      c = c.copyWith(homeSlug: null, homeMode: 'hostel', rentPaidUntil: null, rentGraceUntil: null, updatedAt: now);
    } else {
      c = c.copyWith(rentPaidUntil: paid, updatedAt: now);
    }
    return Bank.save(session, c);
  }

  static Map<String, dynamic> _wallet(WorldCitizen c) {
    final h = home(c.homeSlug);
    return {
      'naira': c.naira,
      'debt': c.debt,
      'rentGraceUntil': c.rentGraceUntil?.toIso8601String(),
      'hostel': c.homeMode == 'hostel' && c.homeSlug == null,
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
    final now = DateTime.now().toUtc();
    final r = await Bank.post(session, user, key: 'home:$slug:$mode:${user.uuid}:${now.millisecondsSinceEpoch ~/ 60000}', amount: -cost, kind: 'home',
        counter: 'city:landlord', memo: mode == 'rent' ? 'First week\'s rent, ${h.name}' : 'Bought ${h.name}');
    if (!r.ok) return jsonEncode({'error': 'You need ₦${_fmt(cost)} -- you have ₦${_fmt(r.balance)}.'});
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(homeSlug: slug, homeMode: mode,
      rentPaidUntil: mode == 'rent' ? now.add(const Duration(days: 7)) : null, updatedAt: now));
    return jsonEncode({..._wallet(c), 'receipt': Bank.receipt(r.entry!)});
  }

  /// Move out (renting: no refund; owning: sold back for 70% of the price).
  static Future<String> leaveHome(Session session, UuidValue user) async {
    var c = await settle(session, user);
    final h = home(c.homeSlug);
    if (h == null) return jsonEncode(_wallet(c));
    final back = c.homeMode == 'own' ? (h.price * 0.7).round() : 0;
    // out first, then paid: a second request finds no home to sell
    c = await Bank.save(session, c.copyWith(homeSlug: null, homeMode: null, rentPaidUntil: null, updatedAt: DateTime.now().toUtc()));
    if (back > 0) {
      final r = await Bank.post(session, user, key: 'home:sell:${h.slug}:${user.uuid}:${DateTime.now().millisecondsSinceEpoch ~/ 60000}', amount: back,
          kind: 'home', counter: 'city:landlord', memo: 'Sold ${h.name} back (70%)');
      return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'receipt': Bank.receipt(r.entry!)});
    }
    return jsonEncode(_wallet(c));
  }

  /// What things cost; the game names the reason, the server sets the price.
  // (ride: a WYRD Ride by road; air: a WYRD Air flight -- ordered from the phone in NAIJA 2099)
  static const fares = {'maglev': 200, 'danfo': 100, 'ride': 500, 'air': 1500, 'fine': 2000, 'fine_desk': 2000, 'lawyer': 10000, 'lift': 0};

  /// what each charge is on the books: its kind, the city account it goes to, and what the receipt says
  static const _charge = <String, (String, String, String)>{
    'maglev': ('fare', 'city:transport', 'Maglev fare'), 'danfo': ('fare', 'city:transport', 'Danfo fare across town'),
    'ride': ('ride', 'city:transport', 'WYRD Ride'), 'air': ('air', 'city:transport', 'WYRD Air flight'),
    'fine': ('fine', 'city:courts', 'Police fine'), 'fine_desk': ('fine', 'city:courts', 'Fine paid at the Alagbon desk'),
    'lawyer': ('fee', 'city:services', 'Barr. Adeyemi, SAN: retainer'), 'lift': ('ride', 'city:transport', 'WYRD Lift (free)'),
  };

  /// the most a police stop takes you down to
  static const fineFloor = 500;
  /// fares that can be ridden on credit when you're short, and how much of a plan that can make
  static const _credit = {'danfo', 'maglev'};
  static const creditCap = 1000;

  static Future<String> pay(Session session, UuidValue user, String reason) async {
    final cost = fares[reason];
    if (cost == null) return jsonEncode({'error': 'Unknown charge.'});
    if (reason == 'fine') return _policeStop(session, user);
    if (reason == 'lift') return _lift(session, user);
    await settle(session, user);
    final (kind, counter, memo) = _charge[reason]!;
    // (a double tap within two seconds is one charge)
    final r = await Bank.post(session, user, key: 'pay:$reason:${user.uuid}:${DateTime.now().millisecondsSinceEpoch ~/ 2000}',
        amount: -cost, kind: kind, counter: counter, memo: memo);
    if (!r.ok) {
      // a danfo or maglev when you're short: ride now, pay later from what you earn (up to ₦1,000 on credit)
      final c0 = await Bank.fresh(session, user);
      if (_credit.contains(reason) && c0.debt + cost <= creditCap) {
        final o = await Bank.owe(session, user, key: 'credit:$reason:${user.uuid}:${DateTime.now().millisecondsSinceEpoch ~/ 2000}', amount: cost,
            memo: '$memo on credit (₦${_fmt(cost)} owed)');
        if (o.ok) return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'paid': 0, 'credit': cost, 'receipt': Bank.receipt(o.entry!)});
      }
      return jsonEncode({'error': 'Not enough naira (₦${_fmt(cost)}).'});
    }
    return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'paid': cost, 'receipt': Bank.receipt(r.entry!)});
  }

  /// A police stop: the first in a day is a warning; after that a fine scaled to what you have (₦2,000, plus 4% of your
  /// naira up to ₦4,000 more; ₦500–8,000), taking you no lower than ₦500 -- the rest goes on your payment plan; past
  /// the plan's cap, the rest is waived.
  static Future<String> _policeStop(Session session, UuidValue user) async {
    var c = await settle(session, user);
    final now = DateTime.now().toUtc();
    if (c.fineWarnedAt == null || now.difference(c.fineWarnedAt!) > const Duration(hours: 24)) {
      c = await Bank.save(session, c.copyWith(fineWarnedAt: now, updatedAt: now));
      return jsonEncode({..._wallet(c), 'warning': true, 'fine': 0, 'paid': 0, 'owed': 0});
    }
    final fine = (2000 + [4000.0, c.naira * 0.04].reduce((a, b) => a < b ? a : b)).round().clamp(500, 8000);
    final payNow = [fine, (c.naira - fineFloor).clamp(0, fine)].reduce((a, b) => a < b ? a : b);
    var owed = fine - payNow, waived = 0;
    final stop = 'stop:${user.uuid}:${now.millisecondsSinceEpoch ~/ 60000}';
    Map<String, dynamic>? receipt;
    if (payNow > 0) {
      final r = await Bank.post(session, user, key: stop, amount: -payNow, kind: 'fine', counter: 'city:courts', memo: 'Police fine (₦${_fmt(fine)})');
      if (r.repeat) return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'warning': false, 'fine': fine, 'paid': 0, 'owed': 0, 'repeat': true});
      if (r.ok) receipt = Bank.receipt(r.entry!);
    }
    if (owed > 0) {
      final room = Bank.debtCap - (await Bank.fresh(session, user)).debt;
      if (owed > room) { waived = owed - room.clamp(0, owed); owed -= waived; }
      if (owed > 0) await Bank.owe(session, user, key: '$stop:plan', amount: owed, memo: 'Police fine: ₦${_fmt(owed)} on your payment plan');
    }
    return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'warning': false, 'fine': fine, 'paid': payNow, 'owed': owed, 'waived': waived, 'receipt': receipt});
  }

  /// WYRD Lift: a free ride by road for someone with under ₦500, once an hour.
  static Future<String> _lift(Session session, UuidValue user) async {
    final c = await settle(session, user);
    if (c.naira >= 500) return jsonEncode({'error': 'WYRD Lift is for when you\'re short of fare. Take a WYRD Ride.'});
    final since = DateTime.now().toUtc().subtract(const Duration(hours: 1));
    final last = await NairaEntry.db.findFirstRow(session, where: (t) => t.authUserId.equals(user) & t.memo.equals('WYRD Lift (free)') & (t.createdAt > since));
    if (last != null) {
      final wait = 60 - DateTime.now().toUtc().difference(last.createdAt).inMinutes;
      return jsonEncode({'error': 'One WYRD Lift an hour -- the next one in $wait min. A danfo can go on credit meanwhile.'});
    }
    final r = await Bank.post(session, user, key: 'lift:${user.uuid}:${DateTime.now().millisecondsSinceEpoch ~/ 60000}', amount: 0, kind: 'ride',
        counter: 'city:transport', memo: 'WYRD Lift (free)');
    return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'paid': 0, 'lift': true, 'receipt': Bank.receipt(r.entry!)});
  }

  /// A ride cancelled before it got you there: the latest WYRD Ride or flight (within 15 minutes) refunded -- in full in
  /// its first minute, 80% after (the car came part of the way).
  static Future<String> refundRide(Session session, UuidValue user) async {
    final since = DateTime.now().toUtc().subtract(const Duration(minutes: 15));
    final e = await NairaEntry.db.findFirstRow(session,
        where: (t) => t.authUserId.equals(user) & (t.kind.equals('ride') | t.kind.equals('air')) & t.status.equals('posted') & (t.createdAt > since) & (t.amount < 0),
        orderBy: (t) => t.id.desc());
    if (e == null) return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'refund': 0});
    final full = DateTime.now().toUtc().difference(e.createdAt) < const Duration(seconds: 60);
    final back = full ? -e.amount : (-e.amount * 0.8).round();
    final r = await Bank.post(session, user, key: 'refund:${e.id}', amount: back, kind: 'refund', counter: e.counter,
        memo: '${e.memo} cancelled: ${full ? 'full refund' : '80% back'}');
    if (!r.repeat) {
      await NairaEntry.db.updateRow(session, e.copyWith(status: 'reversed'));
      await NairaEntry.db.updateRow(session, r.entry!.copyWith(reverses: e.id));
    }
    return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'refund': r.repeat ? 0 : back, 'receipt': Bank.receipt(r.entry!)});
  }

  /// the goodwill rule: this much a week refunded on a dispute, no questions
  static const goodwill = 1000;

  /// A charge disputed from the receipts: refunded at once if it's small enough for the week's goodwill, otherwise
  /// queued for the owner's review. [ref] is the receipt's R-code; [reason]: not_delivered | wrong_amount | other.
  static Future<String> dispute(Session session, UuidValue user, String ref, String reason) async {
    if (!{'not_delivered', 'wrong_amount', 'other'}.contains(reason)) return jsonEncode({'error': 'Pick a reason.'});
    final id = int.tryParse(ref.replaceFirst('R-', '').toLowerCase(), radix: 36);
    final e = id == null ? null : await NairaEntry.db.findById(session, id);
    if (e == null || e.authUserId != user) return jsonEncode({'error': 'No such receipt.'});
    if (e.amount >= 0 || e.status != 'posted' || e.kind == 'plan') return jsonEncode({'error': 'Only charges can be disputed.'});
    if (DateTime.now().toUtc().difference(e.createdAt) > const Duration(days: 7)) return jsonEncode({'error': 'Receipts can be disputed for 7 days.'});
    if (await NairaDispute.db.findFirstRow(session, where: (t) => t.entryId.equals(e.id!)) != null) return jsonEncode({'error': 'You\'ve disputed this one already.'});
    final weekAgo = DateTime.now().toUtc().subtract(const Duration(days: 7));
    final used = (await NairaDispute.db.find(session, where: (t) => t.authUserId.equals(user) & t.status.equals('refunded') & (t.createdAt > weekAgo)))
        .map((d) => d.refundEntryId).whereType<int>().toList();
    var usedNaira = 0;
    for (final rid in used) { usedNaira += (await NairaEntry.db.findById(session, rid))?.amount ?? 0; }
    final now = DateTime.now().toUtc();
    if (usedNaira + (-e.amount) <= goodwill) {
      final r = await Bank.post(session, user, key: 'dispute:${e.id}', amount: -e.amount, kind: 'refund', counter: e.counter, memo: 'Refund: ${e.memo} (disputed)');
      await NairaEntry.db.updateRow(session, e.copyWith(status: 'reversed'));
      await NairaEntry.db.updateRow(session, r.entry!.copyWith(reverses: e.id));
      await NairaDispute.db.insertRow(session, NairaDispute(authUserId: user, entryId: e.id!, reason: reason, status: 'refunded', refundEntryId: r.entry!.id, createdAt: now));
      return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'status': 'refunded', 'refund': -e.amount, 'receipt': Bank.receipt(r.entry!)});
    }
    await NairaDispute.db.insertRow(session, NairaDispute(authUserId: user, entryId: e.id!, reason: reason, status: 'queued', createdAt: now));
    return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'status': 'queued'});
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
    final r = await Bank.post(session, user, key: 'street:$id:$today:${user.uuid}', amount: pay, kind: 'mission', counter: 'city:treasury', memo: 'Street job paid');
    if (r.repeat) return jsonEncode({..._wallet(await Bank.fresh(session, user)), 'paid': 0, 'note': 'Already paid today.'});
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(paidToday: jsonEncode({'day': today, 'ids': ids}), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({..._wallet(c), 'paid': pay, 'receipt': Bank.receipt(r.entry!)});
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
    final r = await Bank.post(session, user, key: 'guide:$step:${user.uuid}', amount: bonus, kind: 'guide', counter: 'city:treasury', memo: 'Guide: $step');
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(guideDone: jsonEncode(list), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({'guide': list, 'paid': r.repeat ? 0 : bonus, 'naira': r.balance});
  }

  /// Skip the guide (counts every step done, pays nothing more).
  static Future<String> skip(Session session, UuidValue user) async {
    var c = await WalletService.settle(session, user);
    c = await Bank.save(session, c.copyWith(guideDone: jsonEncode(steps.keys.toList()), updatedAt: DateTime.now().toUtc()));
    return jsonEncode({'guide': done(c), 'paid': 0, 'naira': c.naira});
  }
}
