import 'package:serverpod/serverpod.dart';

import 'dart:convert';

import '../generated/protocol.dart';
import '../drone/drone_service.dart';
import 'character_service.dart';
import 'city_charter_service.dart';
import 'city_design_service.dart';
import 'world_authority.dart';
import 'world_stats.dart';
import 'wallet_service.dart';
import 'place_service.dart';

/// The open world's line to WYRD, its Authority.
class CityEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  /// Speak to, petition, or report to the Authority. Returns the decree as JSON (see WorldAuthority.address).
  Future<String> address(Session session, String channel, String text, String situation) =>
      WorldAuthority.address(session, _user(session), channel, text, situation);

  /// Your naira and your home (rent due is collected first), as JSON {naira, home}.
  Future<String> wallet(Session session) => WalletService.wallet(session, _user(session));

  /// Every home in the city, with whether it's taken and whether it's yours (JSON list).
  Future<String> homes(Session session) => WalletService.listHomes(session, _user(session));

  /// Rent ('rent') or buy ('own') a home. Returns the wallet, or {error}.
  Future<String> takeHome(Session session, String slug, String mode) => WalletService.takeHome(session, _user(session), slug, mode);

  /// Move out of your home.
  Future<String> leaveHome(Session session) => WalletService.leaveHome(session, _user(session));

  /// Pay a fare ('maglev' or 'danfo'); the server sets the price.
  Future<String> pay(Session session, String reason) => WalletService.pay(session, _user(session), reason);

  /// A street-board mission done: it pays (once a day each).
  Future<String> missionPaid(Session session, String id) => WalletService.missionPaid(session, _user(session), id);

  /// What you can do at a kind of place (JSON list of activities: cost or pay, healing, standing, cooldown).
  Future<String> placeActivities(Session session, String kind) async => PlaceService.list(kind);

  /// Do something at a place. Returns the wallet plus {text, delta, heal, standing}, or {error}.
  Future<String> visit(Session session, String kind, String activity, String place) =>
      PlaceService.visit(session, _user(session), kind, activity, place);

  /// The game's heartbeat (every 30 s while you play): counts you as online.
  Future<void> pulse(Session session) async => WorldStats.pulse(_user(session));

  /// Who's in the city: online now, joined, missions done, today's talk with WYRD, the leading citizens (JSON).
  Future<String> stats(Session session) => WorldStats.stats(session);

  /// Your standing with the Authority and any mission it gave you, without asking it anything.
  Future<String> status(Session session) => WorldAuthority.status(session, _user(session));

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

  /// Approve or reject one of WYRD's proposals. Approved live kinds change the game at once.
  Future<String> designDecide(Session session, int id, bool approve) async {
    await _operator(session);
    return jsonEncode(CityDesignService.toJson(await CityDesignService.decide(session, id, approve)));
  }
}
