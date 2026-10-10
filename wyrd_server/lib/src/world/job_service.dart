import 'dart:convert';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';
import 'bank.dart';

import 'story_service.dart';
import 'wallet_service.dart';

/// Jobs with real play: a timed delivery across town, a danfo driven stop to stop, a chase after a
/// phone snatcher. The server issues each one, times it, and pays it -- the game reports what
/// happened (distance, passengers) and the server checks it was possible in the time taken.
class JobService {
  static final _lastChase = <String, DateTime>{};
  static const types = {'delivery', 'danfo', 'chase'};
  static final Map<String, ({String id, String type, DateTime at})> _open = {};
  static final _rnd = math.Random();

  /// Start a job: returns {id, type, limitS}. One job at a time; starting another drops the last.
  static String start(UuidValue user, String type) {
    if (!types.contains(type)) return jsonEncode({'error': 'No such job.'});
    final id = '${DateTime.now().millisecondsSinceEpoch}${_rnd.nextInt(1 << 20)}';
    _open[user.uuid] = (id: id, type: type, at: DateTime.now().toUtc());
    return jsonEncode({'id': id, 'type': type, 'limitS': type == 'chase' ? 90 : null});
  }

  /// Finish a job. [dist]: metres covered (delivery: pickup to drop-off); [passengers]: danfo
  /// passengers carried; [limitS]: the delivery's time limit, as the game showed it. Pays, or {error}.
  static Future<String> finish(Session session, UuidValue user, String id, int dist, int passengers, int limitS) async {
    final j = _open[user.uuid];
    if (j == null || j.id != id) return jsonEncode({'error': 'That job is no longer open.'});
    _open.remove(user.uuid);
    final secs = DateTime.now().toUtc().difference(j.at).inMilliseconds / 1000;
    int pay;
    String note;
    switch (j.type) {
      case 'delivery':
        final d = dist.clamp(0, 4000);
        if (d < 100) return jsonEncode({'error': 'Too short to pay.'});
        if (secs < d / 45) return jsonEncode({'error': 'Nobody is that fast.'}); // even the hover-car tops out
        final limit = limitS.clamp(60, 900);
        if (secs > limit + 15) return jsonEncode({'error': 'Too late -- the customer gave up.'});
        final bonus = ((1 - secs / limit) * 1000).clamp(0, 1000).round();
        pay = 600 + d + bonus;
        note = bonus > 0 ? 'On time, with a ₦$bonus tip.' : 'Delivered.';
      case 'danfo':
        final p = passengers.clamp(0, 18);
        if (secs < p * 4) return jsonEncode({'error': 'Passengers need time to board.'});
        pay = p * 250;
        note = '$p passengers carried.';
      default: // chase
        // one paid chase every two minutes, so a script can't farm the reward
        final last = _lastChase[user.uuid];
        if (last != null && DateTime.now().toUtc().difference(last) < const Duration(minutes: 2)) return jsonEncode({'error': 'The streets are quiet -- no thief for a moment.'});
        if (secs > 95) return jsonEncode({'error': 'The thief got away.'});
        if (secs < 3) return jsonEncode({'error': 'Too quick to be true.'});
        pay = 3000;
        _lastChase[user.uuid] = DateTime.now().toUtc();
        note = 'Phone recovered. The owner is grateful.';
    }
    var c = await WalletService.settle(session, user);
    // your career: experience from every job, and more pay for the work it is about
    final (bonus, story) = StoryService.careerBonus(c, j.type, pay);
    if (bonus > 0) { pay += bonus; note = '$note Your trade adds ₦$bonus.'; }
    final r = await Bank.post(session, user, key: 'job:${j.id}', amount: pay, kind: 'job', counter: 'city:treasury',
        memo: {'delivery': 'Delivery', 'danfo': 'Danfo run', 'chase': 'Phone recovered'}[j.type] ?? 'Job');
    if (r.repeat) return jsonEncode({'error': 'That job was already paid.'});
    c = await Bank.save(session, (await Bank.fresh(session, user)).copyWith(
      story: story ?? c.story,
      standing: (c.standing + (j.type == 'chase' ? 2 : 1)).clamp(-100, 100),
      missionsDone: c.missionsDone + 1,
      updatedAt: DateTime.now().toUtc()));
    final w = jsonDecode(await WalletService.wallet(session, user)) as Map<String, dynamic>;
    return jsonEncode({...w, 'paid': pay, 'note': note, 'receipt': Bank.receipt(r.entry!)});
  }
}
