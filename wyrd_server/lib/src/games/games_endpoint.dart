import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'game_service.dart';

/// Games against WYRD: ratings, the leaderboard, and chess.
class GamesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  Future<List<PlayerRating>> myRatings(Session session) => GameService.myRatings(session, _user(session));

  Future<List<PlayerRating>> leaderboard(Session session, String game) => GameService.leaderboard(session, game);

  Future<GameMatch?> active(Session session, String game) => GameService.active(session, _user(session), game);

  Future<GameMatch> startChess(Session session, String side) => GameService.startChess(session, _user(session), side);

  Future<GameMatch> moveChess(Session session, int matchId, String from, String to, String? promotion) =>
      GameService.moveChess(session, _user(session), matchId, from, to, promotion);

  Future<GameMatch> resign(Session session, int matchId) => GameService.resign(session, _user(session), matchId);
}
