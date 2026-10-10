import 'package:serverpod/serverpod.dart';

import 'dart:convert';

import '../generated/protocol.dart';
import '../drone/drone_service.dart';
import 'character_service.dart';
import 'city_charter_service.dart';
import 'city_design_service.dart';
import 'world_authority.dart';
import 'world_stats.dart';
import 'city_wire.dart';
import 'city_signals.dart';
import 'wallet_service.dart';
import 'bank.dart';
import 'story_service.dart';
import 'place_service.dart';
import 'job_service.dart';

/// The open world's line to WYRD, its Authority.
class CityEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  // Anything that moves someone's naira runs one at a time for that person: two requests sent
  // together can't both read the old balance and both pay out.
  static final _queues = <String, Future<void>>{};
  static Future<String> _money(Session session, Future<String> Function(UuidValue user) work) {
    final user = _user(session);
    final before = _queues[user.uuid] ?? Future.value();
    final run = before.catchError((_) {}).then((_) => work(user));
    final done = run.then((_) {}, onError: (_) {});
    _queues[user.uuid] = done;
    done.whenComplete(() { if (identical(_queues[user.uuid], done)) _queues.remove(user.uuid); });
    return run;
  }

  /// Speak to, petition, or report to the Authority. Returns the decree as JSON (see WorldAuthority.address).
  Future<String> address(Session session, String channel, String text, String situation) =>
      WorldAuthority.address(session, _user(session), channel, text, situation);

  /// Your naira and your home (rent due is collected first), as JSON {naira, home}.
  Future<String> wallet(Session session) => WalletService.wallet(session, _user(session));

  /// Every home in the city, with whether it's taken and whether it's yours (JSON list).
  Future<String> homes(Session session) => WalletService.listHomes(session, _user(session));

  /// Rent ('rent') or buy ('own') a home. Returns the wallet, or {error}.
  Future<String> takeHome(Session session, String slug, String mode) => _money(session, (u) => WalletService.takeHome(session, u, slug, mode));

  /// Move out of your home.
  Future<String> leaveHome(Session session) => _money(session, (u) => WalletService.leaveHome(session, u));

  /// Pay a fare ('maglev' or 'danfo'); the server sets the price.
  Future<String> pay(Session session, String reason) => _money(session, (u) => WalletService.pay(session, u, reason));

  /// A street-board mission done: it pays (once a day each).
  Future<String> missionPaid(Session session, String id) => _money(session, (u) => WalletService.missionPaid(session, u, id));

  /// What you can do at a kind of place (JSON list of activities: cost or pay, healing, standing, cooldown).
  Future<String> placeActivities(Session session, String kind) async => PlaceService.list(kind);

  /// Do something at a place. Returns the wallet plus {text, delta, heal, standing}, or {error}.
  Future<String> visit(Session session, String kind, String activity, String place) =>
      _money(session, (u) => PlaceService.visit(session, u, kind, activity, place));

  /// Start a job ('delivery', 'danfo' or 'chase'). Returns {id, type, limitS}.
  Future<String> jobStart(Session session, String type) async => JobService.start(_user(session), type);

  /// Finish a job: the server checks the timing and pays. Returns the wallet plus {paid, note}, or {error}.
  Future<String> jobFinish(Session session, String id, int dist, int passengers, int limitS) =>
      _money(session, (u) => JobService.finish(session, u, id, dist, passengers, limitS));

  /// The first-time guide: mark a step done (pays its bonus once). Returns {guide, paid, naira}, or {error}.
  Future<String> guideMark(Session session, String step) => GuideService.mark(session, _user(session), step);

  /// Skip the first-time guide.
  Future<String> guideSkip(Session session) => GuideService.skip(session, _user(session));

  /// The game's heartbeat (every 30 s while you play): counts you as online.
  Future<void> pulse(Session session) async => WorldStats.pulse(_user(session));

  /// Who's in the city: online now, joined, missions done, today's talk with WYRD, the leading citizens (JSON).
  Future<String> stats(Session session) => WorldStats.stats(session, _user(session));

  /// Your standing with the Authority and any mission it gave you, without asking it anything.
  Future<String> status(Session session) => WorldAuthority.status(session, _user(session));

  /// WYRD's live wire: what's happened in the city since item [since] (0: the latest few), for every player. See CityWire.
  Future<String> wire(Session session, int since) => CityWire.since(session, since);

  /// What the city saw around you, for WYRD to learn from: anonymous tallies, and only if you agreed to let WYRD
  /// learn from your play. [batch]: JSON list of {k, p, n, v}. See CitySignals.
  Future<String> signals(Session session, String batch) => CitySignals.record(session, _user(session), batch);

  /// WYRD's charter for the city (how it means to deal with players, in its words) and the
  /// missions on its board open to you, as JSON: {charter, author, writtenAt, missions}.
  Future<String> charter(Session session) async {
    final c = await CityCharterService.current(session);
    final me = await WorldAuthority.citizen(session, _user(session));
    return jsonEncode({
      'charter': c.charter, 'author': c.author, 'writtenAt': c.writtenAt.toIso8601String(),
      'missions': await CityDesignService.board(session, me.standing),
    });
  }

  /// The live design (approved tuning, NPC lines, events, missions) the game applies, as JSON.
  Future<String> design(Session session) async => jsonEncode(await CityDesignService.live(session));

  // ---- the design studio: the owner designs the game with WYRD (operators only) ----
  Future<void> _operator(Session session) async {
    if (!await DroneService.isOperator(session, _user(session))) throw Exception('The design studio is for the owner.');
  }

  /// Help train WYRD with your play (or stop): asked once in the game, changeable any time.
  Future<String> setTraining(Session session, bool optIn) => WorldAuthority.setTraining(session, _user(session), optIn);

  /// Your character (JSON), or 'null' if you haven't made one yet.
  Future<String> myCharacter(Session session) => CharacterService.get(session, _user(session));

  /// Save your character from the creator (JSON): base, name, proportions, skin, outfit hue, neon.
  Future<String> saveCharacter(Session session, String character) => CharacterService.save(session, _user(session), character);

  /// Is this person allowed in the design studio?
  Future<bool> canDesign(Session session) => DroneService.isOperator(session, _user(session));

  /// Say something to WYRD about the game; it answers as co-designer and may propose changes. JSON: {reply, proposals}.
  Future<String> designChat(Session session, String text) async {
    await _operator(session);
    return CityDesignService.chat(session, text);
  }

  /// The design log, newest first, as JSON.
  Future<String> designNotes(Session session) async {
    await _operator(session);
    return jsonEncode([for (final n in await CityDesignService.notes(session)) CityDesignService.toJson(n)]);
  }

  /// Cancel your WYRD Ride or flight before it got you there: the fare back (all of it in the first minute, 80% after).
  Future<String> refundRide(Session session) => _money(session, (u) => WalletService.refundRide(session, u));

  /// Dispute a charge on your receipts ([ref]: its R-code; [reason]: not_delivered | wrong_amount | other).
  Future<String> dispute(Session session, String ref, String reason) => _money(session, (u) => WalletService.dispute(session, u, ref, reason));

  /// Your latest receipts, newest first (JSON list of {ref, kind, memo, amount, balance, at, reversed}).
  Future<String> receipts(Session session) async => jsonEncode(await Bank.receipts(session, _user(session)));

  /// The books checked (owner only): every player whose ledger doesn't add up to their balance; an empty list is all well.
  Future<String> ledgerAudit(Session session) async {
    await _operator(session);
    return jsonEncode(await Bank.audit(session));
  }

  /// Your story: reputation by district, faction and circle, and your missions (JSON).
  Future<String> story(Session session) => StoryService.get(session, _user(session));

  /// Take one step in a story mission (e.g. 'tomato', 'route:mile12'); the server checks and pays it.
  Future<String> storyAct(Session session, String mission, String move) => _money(session, (u) => StoryService.act(session, u, mission, move));

  /// Approve or reject one of WYRD's proposals. Approved live kinds change the game at once.
  Future<String> designDecide(Session session, int id, bool approve) async {
    await _operator(session);
    return jsonEncode(CityDesignService.toJson(await CityDesignService.decide(session, id, approve)));
  }
}
