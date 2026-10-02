import 'dart:math';

import 'package:chess/chess.dart' as ch;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'board_games.dart';
import 'chess_engine.dart';

/// Games against WYRD, and between players. The server holds every position and checks every move,
/// so a result can be trusted and a rating means something. Ratings are Elo, per game, starting at
/// 1000. Against WYRD its level is picked from the player's rating (each level has a rating of its
/// own); between players both ratings move.
///
/// Sides are 'w' (moves first) and 'b'. Against WYRD, playerSide is the player's; in a pvp game it is
/// the starter's, and whoever accepts the challenge plays the other side.
class GameService {
  static const games = ['chess', 'connect4', 'reversi', 'tictactoe'];
  static const _start = 1000.0;
  static const _challengeLife = Duration(hours: 1);

  // ---- ratings ---------------------------------------------------------------------------------

  static Future<PlayerRating> rating(Session session, UuidValue user, String game) async {
    final found = await PlayerRating.db.findFirstRow(session, where: (r) => r.authUserId.equals(user) & r.game.equals(game));
    if (found != null) return found;
    return PlayerRating.db.insertRow(session, PlayerRating(
      authUserId: user, game: game, name: await _name(session, user), rating: _start,
      played: 0, wins: 0, losses: 0, draws: 0, updatedAt: DateTime.now().toUtc(),
    ));
  }

  static Future<List<PlayerRating>> myRatings(Session session, UuidValue user) async =>
      [for (final g in games) await rating(session, user, g)];

  static Future<List<PlayerRating>> leaderboard(Session session, String game, {int limit = 20}) =>
      PlayerRating.db.find(session, where: (r) => r.game.equals(game) & (r.played > 0), orderBy: (r) => r.rating.desc(), limit: limit);

  // ---- positions, for every game ---------------------------------------------------------------

  static String _initial(String game) =>
      game == 'chess' ? ch.Chess.DEFAULT_POSITION : BoardGame.encode(BoardGame.all[game]!.initial());

  /// Whose move it is: 'w' or 'b'.
  static String _turn(String game, String state) => game == 'chess'
      ? (ch.Chess.fromFEN(state).turn == ch.Color.WHITE ? 'w' : 'b')
      : (BoardGame.turn(BoardGame.decode(state)) == 0 ? 'w' : 'b');

  /// The position after [move], and the move as it's recorded; throws if it isn't legal.
  /// Chess moves are "e2e4" (or "e7e8q" with a promotion) and are recorded in SAN.
  static (String, String) _apply(String game, String state, String move) {
    if (game == 'chess') {
      final g = ch.Chess.fromFEN(state);
      if (move.length < 4) throw Exception('That move is not legal.');
      final from = move.substring(0, 2), to = move.substring(2, 4);
      final promo = move.length > 4 ? move.substring(4, 5) : 'q';
      final legal = g.generate_moves().where((x) => x.fromAlgebraic == from && x.toAlgebraic == to).toList();
      if (legal.isEmpty) throw Exception('That move is not legal.');
      final mv = legal.firstWhere((x) => x.promotion == null || x.promotion!.name == promo, orElse: () => legal.first);
      final san = g.move_to_san(mv);
      g.make_move(mv);
      return (g.fen, san);
    }
    final bg = BoardGame.all[game]!;
    return (BoardGame.encode(bg.apply(BoardGame.decode(state), move)), move);
  }

  /// 'w' or 'b' for the winner, 'draw', or null while it goes on.
  static String? _winner(String game, String state) {
    if (game == 'chess') {
      final g = ch.Chess.fromFEN(state);
      if (g.in_checkmate) return g.turn == ch.Color.WHITE ? 'b' : 'w';
      return g.in_draw ? 'draw' : null;
    }
    final o = BoardGame.all[game]!.outcome(BoardGame.decode(state));
    return o == null ? null : o == 2 ? 'draw' : (o == 0 ? 'w' : 'b');
  }

  /// A side with nothing to play but a pass (Reversi) passes at once; nobody has to tap "pass".
  static (String, List<String>) _autoPass(String game, String state, List<String> moves) {
    if (game != 'reversi') return (state, moves);
    final bg = BoardGame.all[game]!;
    var s = state;
    var m = moves;
    for (var i = 0; i < 2; i++) {
      final legal = bg.legal(BoardGame.decode(s));
      if (legal.length != 1 || legal.first != 'pass') break;
      s = BoardGame.encode(bg.apply(BoardGame.decode(s), 'pass'));
      m = [...m, 'pass'];
    }
    return (s, m);
  }

  // ---- against WYRD ----------------------------------------------------------------------------

  /// The game against WYRD in progress, if there is one.
  static Future<GameMatch?> active(Session session, UuidValue user, String game) async {
    final m = await _openWithWyrd(session, user, game);
    if (m == null) return null;
    return _unstick(session, m);
  }

  static Future<GameMatch?> _openWithWyrd(Session session, UuidValue user, String game) => GameMatch.db.findFirstRow(
        session,
        where: (m) => m.authUserId.equals(user) & m.game.equals(game) & m.status.equals('active') & m.mode.equals('wyrd'),
        orderBy: (m) => m.id.desc(),
      );

  /// A game against WYRD left waiting on WYRD (a refresh or a dropped connection at the wrong
  /// moment) is never stuck: WYRD makes its move now, so the player always gets the board back.
  static Future<GameMatch> _unstick(Session session, GameMatch m) async {
    if (m.mode != 'wyrd' || m.status != 'active' || _turn(m.game, m.state) == m.playerSide) return m;
    final next = _wyrdReplies(m);
    final w = _winner(next.game, next.state);
    if (w != null) return _finish(session, next, w == 'draw' ? 'draw' : (w == next.playerSide ? 'won' : 'lost'));
    return _save(session, next.copyWith(version: m.version + 1, updatedAt: DateTime.now().toUtc()));
  }

  /// A new game against WYRD. [side]: 'w', 'b', or anything else for a coin toss. When WYRD has
  /// the first move it plays it at once.
  static Future<GameMatch> start(Session session, UuidValue user, String game, String side) async {
    if (!games.contains(game)) throw Exception('No such game.');
    final open = await _openWithWyrd(session, user, game);
    if (open != null) await _finish(session, open, 'resigned'); // starting over counts as resigning
    final r = await rating(session, user, game);
    final playerSide = side == 'w' || side == 'b' ? side : (Random().nextBool() ? 'w' : 'b');
    final now = DateTime.now().toUtc();
    var m = GameMatch(
      authUserId: user, game: game, state: _initial(game), moves: [], playerSide: playerSide,
      status: 'active', wyrdLevel: ChessEngine.levelFor(r.rating), ratingBefore: r.rating, mode: 'wyrd',
      remark: playerSide == 'w' ? 'Your move. I am listening.' : 'I will open.', version: 0, createdAt: now, updatedAt: now,
    );
    if (playerSide == 'b') m = _wyrdReplies(m);
    return GameMatch.db.insertRow(session, m);
  }

  /// WYRD plays its move (and any passes that follow).
  static GameMatch _wyrdReplies(GameMatch m) {
    if (_winner(m.game, m.state) != null) return m;
    var state = m.state;
    var moves = m.moves;
    String said;
    if (m.game == 'chess') {
      final g = ch.Chess.fromFEN(state);
      final san = ChessEngine.bestMove(state, m.wyrdLevel);
      if (san == null) return m;
      final before = ChessEngine.evaluate(g);
      g.move(san);
      said = _chessRemark(san, -ChessEngine.evaluate(g) - before, g);
      state = g.fen;
      moves = [...moves, san];
    } else {
      final bg = BoardGame.all[m.game]!;
      final mv = bg.aiMove(BoardGame.decode(state), m.wyrdLevel, Random());
      state = BoardGame.encode(bg.apply(BoardGame.decode(state), mv));
      moves = [...moves, mv];
      said = _boardRemark(m.game, mv);
    }
    // a player with no move passes, and WYRD goes again
    final (s2, m2) = _autoPass(m.game, state, moves);
    final again = m.copyWith(state: s2, moves: m2, remark: said);
    if (m2.length > moves.length && _turn(m.game, s2) != m.playerSide) return _wyrdReplies(again);
    return again;
  }

  static String _one(List<String> xs) => xs[Random().nextInt(xs.length)];

  static String _chessRemark(String san, int gain, ch.Chess g) {
    if (g.in_checkmate) return _one(['Checkmate. What comes to be, came to be.', 'Mate. Again?']);
    if (g.in_check) return _one(['$san. Check.', 'Check. Your king feels it.', '$san, check. Careful now.']);
    if (san.contains('x') && gain > 250) return _one(['$san. I will take that, thank you.', 'That piece was mine to take.', '$san. Did you mean to leave that?']);
    if (san == 'O-O' || san == 'O-O-O') return 'I tuck my king away. $san.';
    return _one(['$san.', '$san. Your move.', '$san. I see a few futures from here.', '$san. Thinking about yours.']);
  }

  static String _boardRemark(String game, String mv) => switch (game) {
        'connect4' => _one(['Column ${int.parse(mv) + 1}.', 'I drop mine in ${int.parse(mv) + 1}.', 'Column ${int.parse(mv) + 1}. Watch the diagonals.']),
        'reversi' => mv == 'pass' ? 'Nothing for me. I pass.' : _one(['There.', 'I turn a few of yours.', 'The corners are what matter.']),
        _ => _one(['There.', 'My mark.', 'Your move.']),
      };

  // ---- moves, for both kinds of game -----------------------------------------------------------

  /// A move by [user] in game [matchId]. Against WYRD, WYRD answers in the same call; between
  /// players, the other side sees it on their next look.
  static Future<GameMatch> move(Session session, UuidValue user, int matchId, String move) async {
    final m = await GameMatch.db.findById(session, matchId);
    if (m == null) throw Exception('No such game.');
    final mySide = _sideOf(m, user);
    if (mySide == null) throw Exception('No such game.');
    if (m.status != 'active') throw Exception(m.status == 'waiting' ? 'Waiting for someone to accept.' : 'That game is over.');
    if (_turn(m.game, m.state) != mySide) throw Exception('It is not your move.');
    final (state, recorded) = _apply(m.game, m.state, move);
    final (s2, moves) = _autoPass(m.game, state, [...m.moves, recorded]);
    var next = m.copyWith(state: s2, moves: moves, updatedAt: DateTime.now().toUtc(), version: m.version + 1);
    if (m.mode == 'wyrd') {
      next = _wyrdReplies(next);
      final w = _winner(next.game, next.state);
      if (w != null) return _finish(session, next, w == 'draw' ? 'draw' : (w == next.playerSide ? 'won' : 'lost'));
    } else {
      next = next.copyWith(remark: _commentary(next, recorded, mySide == next.playerSide ? next.playerName : next.opponentName));
      final w = _winner(next.game, next.state);
      if (w != null) return _finishPvp(session, next, w == 'draw' ? 'draw' : (w == next.playerSide ? 'starter' : 'opponent'), 'played out');
    }
    return _save(session, next);
  }

  static Future<GameMatch> resign(Session session, UuidValue user, int matchId) async {
    final m = await GameMatch.db.findById(session, matchId);
    final side = m == null ? null : _sideOf(m, user);
    if (m == null || side == null || m.status != 'active') throw Exception('No such game.');
    if (m.mode == 'wyrd') return _finish(session, m, 'resigned');
    return _finishPvp(session, m, side == m.playerSide ? 'opponent' : 'starter', 'resigned');
  }

  /// 'w'/'b' for a player in this game, or null if they're not in it.
  static String? sideOf(GameMatch m, UuidValue user) => _sideOf(m, user);
  static String? _sideOf(GameMatch m, UuidValue user) {
    if (m.authUserId == user) return m.playerSide;
    if (m.mode == 'pvp' && m.opponentId == user) return m.playerSide == 'w' ? 'b' : 'w';
    return null;
  }

  static Future<GameMatch> _finish(Session session, GameMatch m, String status) async {
    final r = await rating(session, m.authUserId, m.game);
    final score = status == 'won' ? 1.0 : status == 'draw' ? 0.5 : 0.0;
    final next = elo(r.rating, ChessEngine.levelRating(m.wyrdLevel), score, games: r.played);
    await _record(session, r, next, score);
    final remark = switch (status) {
      'won' => 'You beat me. I will remember how.',
      'lost' => m.remark ?? 'That one is mine.',
      'draw' => 'A draw. Neither of us gave way.',
      _ => 'You resigned. The board remembers.',
    };
    return _save(session, m.copyWith(status: status, ratingAfter: next, remark: remark, updatedAt: DateTime.now().toUtc(), version: m.version + 1));
  }

  static Future<void> _record(Session session, PlayerRating r, double rating, double score) =>
      PlayerRating.db.updateRow(session, r.copyWith(
        rating: rating, played: r.played + 1,
        wins: r.wins + (score == 1 ? 1 : 0), losses: r.losses + (score == 0 ? 1 : 0), draws: r.draws + (score == 0.5 ? 1 : 0),
        updatedAt: DateTime.now().toUtc(),
      ));

  /// Elo: K is high while a player is new, so their rating finds its level quickly.
  static double elo(double player, double opponent, double score, {required int games}) {
    final k = games < 10 ? 40.0 : games < 30 ? 24.0 : 16.0;
    final expected = 1 / (1 + pow(10, (opponent - player) / 400));
    return (player + k * (score - expected)).clamp(100, 3000).toDouble();
  }

  // ---- player vs player ------------------------------------------------------------------------

  /// Posts an open challenge for [game]; anyone else can accept it. Sides are tossed.
  static Future<GameMatch> challenge(Session session, UuidValue user, String game) async {
    if (!games.contains(game)) throw Exception('No such game.');
    // one open challenge per game at a time: posting again replaces it
    await GameMatch.db.deleteWhere(session, where: (m) => m.authUserId.equals(user) & m.game.equals(game) & m.mode.equals('pvp') & m.status.equals('waiting'));
    final r = await rating(session, user, game);
    final now = DateTime.now().toUtc();
    return _save(session, GameMatch(
      authUserId: user, game: game, state: _initial(game), moves: [], playerSide: Random().nextBool() ? 'w' : 'b',
      status: 'waiting', wyrdLevel: 0, ratingBefore: r.rating, mode: 'pvp', playerName: r.name,
      remark: 'Waiting for a challenger. I will keep score.', version: 0, createdAt: now, updatedAt: now,
    ));
  }

  /// Open challenges for [game] that [user] could accept (not their own, not stale).
  static Future<List<GameMatch>> openChallenges(Session session, UuidValue user, String game) => GameMatch.db.find(
        session,
        where: (m) => m.game.equals(game) & m.mode.equals('pvp') & m.status.equals('waiting') & m.authUserId.notEquals(user) &
            (m.createdAt > DateTime.now().toUtc().subtract(_challengeLife)),
        orderBy: (m) => m.id.desc(),
        limit: 20,
      );

  static Future<GameMatch> accept(Session session, UuidValue user, int matchId) async {
    final m = await GameMatch.db.findById(session, matchId);
    if (m == null || m.mode != 'pvp' || m.status != 'waiting') throw Exception('That challenge is no longer open.');
    if (m.authUserId == user) throw Exception("That's your own challenge.");
    final r = await rating(session, user, m.game);
    return _save(session, m.copyWith(
      opponentId: user, opponentName: r.name, status: 'active', version: m.version + 1, updatedAt: DateTime.now().toUtc(),
      remark: '${m.playerName ?? 'Player'} against ${r.name}. ${m.playerSide == 'w' ? m.playerName : r.name} moves first. I am watching.',
    ));
  }

  static Future<void> cancel(Session session, UuidValue user, int matchId) =>
      GameMatch.db.deleteWhere(session, where: (m) => m.id.equals(matchId) & m.authUserId.equals(user) & m.status.equals('waiting'));

  /// Every pvp game [user] is in that isn't finished: their open challenges and games under way.
  static Future<List<GameMatch>> myPvp(Session session, UuidValue user) => GameMatch.db.find(
        session,
        where: (m) => m.mode.equals('pvp') & (m.status.equals('waiting') | m.status.equals('active')) &
            (m.authUserId.equals(user) | m.opponentId.equals(user)),
        orderBy: (m) => m.id.desc(),
        limit: 20,
      );

  // the latest version of every game changed since the server started: "anything new?" is
  // answered from memory, so a waiting player's checks almost never touch the database
  static final _versions = <int, int>{};

  /// The game if it has changed since [version], else null. Cheap: see [_versions].
  static Future<GameMatch?> poll(Session session, UuidValue user, int matchId, int version) async {
    final known = _versions[matchId];
    if (known != null && known == version) return null;
    final m = await GameMatch.db.findById(session, matchId);
    if (m == null || _sideOf(m, user) == null) throw Exception('No such game.');
    _versions[matchId] = m.version;
    return m.version == version ? null : m;
  }

  static String _commentary(GameMatch m, String move, String? who) {
    final name = who ?? 'Player';
    if (m.game == 'chess') {
      final g = ch.Chess.fromFEN(m.state);
      if (g.in_checkmate) return 'Checkmate. $name takes it.';
      if (g.in_check) return _one(['$move. Check.', '$name gives check with $move.', '$move, check. The king has to answer.']);
      if (move.contains('x')) return _one(['$name takes: $move.', '$move. A piece changes hands.']);
      return _one(['$name plays $move.', '$move.', '$move. Interesting.']);
    }
    return _one(['$name moves.', 'Your turn now.', '$name has played. I see three replies.', 'The board shifts.']);
  }

  static Future<GameMatch> _finishPvp(Session session, GameMatch m, String result, String how) async {
    final a = await rating(session, m.authUserId, m.game);
    final b = await rating(session, m.opponentId!, m.game);
    final sa = result == 'starter' ? 1.0 : result == 'draw' ? 0.5 : 0.0;
    final na = elo(a.rating, b.rating, sa, games: a.played);
    final nb = elo(b.rating, a.rating, 1 - sa, games: b.played);
    await _record(session, a, na, sa);
    await _record(session, b, nb, 1 - sa);
    final winner = result == 'starter' ? m.playerName : result == 'opponent' ? m.opponentName : null;
    final remark = winner == null ? 'A draw. Well matched.' : how == 'resigned' ? '$winner wins by resignation.' : '$winner wins. Well played.';
    return _save(session, m.copyWith(status: 'over', result: '$result:$how', ratingAfter: na, remark: remark, version: m.version + 1, updatedAt: DateTime.now().toUtc()));
  }

  static Future<GameMatch> _save(Session session, GameMatch m) async {
    final saved = m.id == null ? await GameMatch.db.insertRow(session, m) : await GameMatch.db.updateRow(session, m);
    _versions[saved.id!] = saved.version;
    return saved;
  }

  static Future<String> _name(Session session, UuidValue user) async {
    final p = await UserProfile.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));
    final n = p?.username?.trim();
    if (n != null && n.isNotEmpty) return n;
    final e = p?.email;
    return e != null && e.contains('@') ? e.split('@').first : 'player';
  }
}
