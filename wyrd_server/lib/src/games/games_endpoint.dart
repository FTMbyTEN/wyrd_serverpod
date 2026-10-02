import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'game_service.dart';

/// Games: against WYRD (chess, Connect Four, Reversi, Tic-tac-toe) and between players, with
/// ratings and a leaderboard per game. Every game sent back carries viewerSide: the side of the
/// person asking, so the app knows which way round to draw the board.
class GamesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  static GameMatch _view(Session session, GameMatch m) => m.copyWith(viewerSide: GameService.sideOf(m, _user(session)));
  static GameMatch? _maybe(Session session, GameMatch? m) => m == null ? null : _view(session, m);
  static List<GameMatch> _all(Session session, List<GameMatch> ms) => [for (final m in ms) _view(session, m)];

  Future<List<PlayerRating>> myRatings(Session session) => GameService.myRatings(session, _user(session));

  Future<List<PlayerRating>> leaderboard(Session session, String game) => GameService.leaderboard(session, game);

  /// The game against WYRD in progress for [game], if any.
  Future<GameMatch?> active(Session session, String game) async => _maybe(session, await GameService.active(session, _user(session), game));

  /// A new game against WYRD. [side]: 'w', 'b' or 'random'.
  Future<GameMatch> start(Session session, String game, String side) async =>
      _view(session, await GameService.start(session, _user(session), game, side));

  /// A move in any game: chess "e2e4" (or "e7e8q"), Connect Four a column "0".."6", Tic-tac-toe a
  /// square "0".."8", Reversi a square "0".."63".
  Future<GameMatch> move(Session session, int matchId, String move) async =>
      _view(session, await GameService.move(session, _user(session), matchId, move));

  Future<GameMatch> resign(Session session, int matchId) async => _view(session, await GameService.resign(session, _user(session), matchId));

  // kept for the app version that only knew chess
  Future<GameMatch> startChess(Session session, String side) => start(session, 'chess', side);
  Future<GameMatch> moveChess(Session session, int matchId, String from, String to, String? promotion) =>
      move(session, matchId, '$from$to${promotion ?? ''}');

  // ---- player vs player ----
  Future<GameMatch> challenge(Session session, String game) async => _view(session, await GameService.challenge(session, _user(session), game));
  Future<List<GameMatch>> openChallenges(Session session, String game) async =>
      _all(session, await GameService.openChallenges(session, _user(session), game));
  Future<GameMatch> accept(Session session, int matchId) async => _view(session, await GameService.accept(session, _user(session), matchId));
  Future<void> cancel(Session session, int matchId) => GameService.cancel(session, _user(session), matchId);
  Future<List<GameMatch>> myPvp(Session session) async => _all(session, await GameService.myPvp(session, _user(session)));

  /// The game if it changed since [version], else null -- answered from memory almost always.
  Future<GameMatch?> poll(Session session, int matchId, int version) async =>
      _maybe(session, await GameService.poll(session, _user(session), matchId, version));
}
