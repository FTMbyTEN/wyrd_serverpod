import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../drone/drone_service.dart';

/// Who is in NAIJA 2099: players online now (a heartbeat from the game every 30 s; online = seen in
/// the last 90 s), how many have joined (made a character), missions done, what WYRD has been told
/// today, and the city's leading citizens. Presence is kept in memory -- it's live, not history.
class WorldStats {
  static final Map<String, DateTime> _seen = {};
  static const _window = Duration(seconds: 90);

  /// The game says "still here".
  static void pulse(UuidValue user) => _seen[user.uuid] = DateTime.now().toUtc();

  static int online() {
    final cutoff = DateTime.now().toUtc().subtract(_window);
    _seen.removeWhere((_, t) => t.isBefore(cutoff));
    return _seen.length;
  }

  /// [user]: who's asking -- how many people have joined (and the rest of the sign-up numbers) is
  /// for WYRD's owner only; players see who's online, missions, talk and the leaders.
  static Future<String> stats(Session session, UuidValue user) async {
    final owner = await DroneService.isOperator(session, user);
    final now = DateTime.now().toUtc();
    final dayAgo = now.subtract(const Duration(hours: 24));
    final joined = await PlayerCharacter.db.count(session);
    final joinedToday = await PlayerCharacter.db.count(session, where: (t) => t.createdAt > dayAgo);
    final citizens = await WorldCitizen.db.find(session, limit: 2000)
      ..sort((a, b) => b.standing.compareTo(a.standing));
    final missions = citizens.fold<int>(0, (a, c) => a + c.missionsDone);
    final talksToday = await GameExchange.db.count(session, where: (t) => t.createdAt > dayAgo);
    final ama = await PlayerCharacter.db.count(session, where: (t) => t.base.equals('ama'));
    // the leading citizens, by the names they chose in the city
    final top = citizens.take(5).toList();
    final chars = top.isEmpty
        ? <PlayerCharacter>[]
        : await PlayerCharacter.db.find(session, where: (t) => t.authUserId.inSet(top.map((c) => c.authUserId).toSet()));
    final nameOf = {for (final c in chars) c.authUserId.uuid: c.name};
    return jsonEncode({
      'online': online(),
      if (owner) 'joined': joined,
      if (owner) 'joinedToday': joinedToday,
      if (owner) 'citizens': citizens.length,
      'missionsDone': missions,
      'talksToday': talksToday,
      if (owner) 'bodies': {'ten': joined - ama, 'ama': ama},
      'owner': owner,
      'leaders': [
        for (final c in top) {'name': nameOf[c.authUserId.uuid] ?? 'A citizen', 'standing': c.standing, 'missions': c.missionsDone},
      ],
      'at': now.toIso8601String(),
    });
  }
}
