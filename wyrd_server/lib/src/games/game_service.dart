import 'dart:math';

import 'package:chess/chess.dart' as ch;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'chess_engine.dart';

/// Games against WYRD. The server holds every position and checks every move, so a result can be
/// trusted and a rating means something. Ratings are Elo, per game, starting at 1000; WYRD's level is
/// picked from the player's rating so each game is a fair fight, and each level has a rating of its own.
class GameService {
  static const games = ['chess'];
  static const _start = 1000.0;

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

  /// The game in progress, if there is one.
  static Future<GameMatch?> active(Session session, UuidValue user, String game) =>
      GameMatch.db.findFirstRow(session, where: (m) => m.authUserId.equals(user) & m.game.equals(game) & m.status.equals('active'), orderBy: (m) => m.id.desc());

  /// A new chess game. [side]: 'w', 'b', or anything else for a coin toss. When WYRD has white it moves first.
  static Future<GameMatch> startChess(Session session, UuidValue user, String side) async {
    final open = await active(session, user, 'chess');
    if (open != null) await _finish(session, open, 'resigned'); // starting over counts as resigning
    final r = await rating(session, user, 'chess');
    final playerSide = side == 'w' || side == 'b' ? side : (Random().nextBool() ? 'w' : 'b');
    final now = DateTime.now().toUtc();
    var m = GameMatch(
      authUserId: user, game: 'chess', state: ch.Chess.DEFAULT_POSITION, moves: [], playerSide: playerSide,
      status: 'active', wyrdLevel: ChessEngine.levelFor(r.rating), ratingBefore: r.rating,
      remark: playerSide == 'w' ? 'Your move. I am listening.' : 'I will open.', createdAt: now, updatedAt: now,
    );
    if (playerSide == 'b') m = _wyrdReplies(m, ch.Chess.fromFEN(m.state));
    return GameMatch.db.insertRow(session, m);
  }

  /// The player's move ([from], [to], optional [promotion] like 'q'); WYRD answers in the same call.
  static Future<GameMatch> moveChess(Session session, UuidValue user, int matchId, String from, String to, String? promotion) async {
    final m = await _own(session, user, matchId);
    final g = ch.Chess.fromFEN(m.state);
    final turn = g.turn == ch.Color.WHITE ? 'w' : 'b';
    if (turn != m.playerSide) throw Exception('It is not your move.');
    final legal = g.generate_moves().where((x) => x.fromAlgebraic == from && x.toAlgebraic == to).toList();
    if (legal.isEmpty) throw Exception('That move is not legal.');
    final mv = legal.firstWhere((x) => x.promotion == null || x.promotion!.name == (promotion ?? 'q'), orElse: () => legal.first);
    final san = g.move_to_san(mv);
    g.make_move(mv);
    var next = m.copyWith(state: g.fen, moves: [...m.moves, san], updatedAt: DateTime.now().toUtc());
    if (!g.game_over) next = _wyrdReplies(next, g);
    final over = _outcome(g, next.playerSide);
    if (over != null) return _finish(session, next, over);
    return GameMatch.db.updateRow(session, next);
  }

  static Future<GameMatch> resign(Session session, UuidValue user, int matchId) async =>
      _finish(session, await _own(session, user, matchId), 'resigned');

  static GameMatch _wyrdReplies(GameMatch m, ch.Chess g) {
    final san = ChessEngine.bestMove(g.fen, m.wyrdLevel);
    if (san == null) return m;
    final before = ChessEngine.evaluate(g);
    g.move(san);
    final after = -ChessEngine.evaluate(g); // from WYRD's side
    return m.copyWith(state: g.fen, moves: [...m.moves, san], remark: _remark(san, after - before, g));
  }

  static String _remark(String san, int gain, ch.Chess g) {
    final r = Random();
    String one(List<String> xs) => xs[r.nextInt(xs.length)];
    if (g.in_checkmate) return one(['Checkmate. What comes to be, came to be.', 'Mate. Again?']);
    if (g.in_check) return one(['$san. Check.', 'Check. Your king feels it.', '$san, check. Careful now.']);
    if (san.contains('x') && gain > 250) return one(['$san. I will take that, thank you.', 'That piece was mine to take.', '$san. Did you mean to leave that?']);
    if (san == 'O-O' || san == 'O-O-O') return 'I tuck my king away. $san.';
    return one(['$san.', '$san. Your move.', '$san. I see a few futures from here.', '$san. Thinking about yours.']);
  }

  /// 'won' / 'lost' / 'draw' from the player's side, or null while it goes on.
  static String? _outcome(ch.Chess g, String playerSide) {
    if (g.in_checkmate) {
      final loser = g.turn == ch.Color.WHITE ? 'w' : 'b';
      return loser == playerSide ? 'lost' : 'won';
    }
    if (g.in_draw) return 'draw';
    return null;
  }

  static Future<GameMatch> _finish(Session session, GameMatch m, String status) async {
    final r = await rating(session, m.authUserId, m.game);
    final score = status == 'won' ? 1.0 : status == 'draw' ? 0.5 : 0.0;
    final next = elo(r.rating, ChessEngine.levelRating(m.wyrdLevel), score, games: r.played);
    await PlayerRating.db.updateRow(session, r.copyWith(
      rating: next, played: r.played + 1,
      wins: r.wins + (score == 1 ? 1 : 0), losses: r.losses + (score == 0 ? 1 : 0), draws: r.draws + (score == 0.5 ? 1 : 0),
      updatedAt: DateTime.now().toUtc(),
    ));
    final remark = switch (status) {
      'won' => 'You beat me. I will remember how.',
      'lost' => m.remark ?? 'Mate.',
      'draw' => 'A draw. Neither of us gave way.',
      _ => 'You resigned. The board remembers.',
    };
    return GameMatch.db.updateRow(session, m.copyWith(status: status, ratingAfter: next, remark: remark, updatedAt: DateTime.now().toUtc()));
  }

  /// Elo: K is high while a player is new, so their rating finds its level quickly.
  static double elo(double player, double opponent, double score, {required int games}) {
    final k = games < 10 ? 40.0 : games < 30 ? 24.0 : 16.0;
    final expected = 1 / (1 + pow(10, (opponent - player) / 400));
    return (player + k * (score - expected)).clamp(100, 3000).toDouble();
  }

  static Future<GameMatch> _own(Session session, UuidValue user, int id) async {
    final m = await GameMatch.db.findById(session, id);
    if (m == null || m.authUserId != user) throw Exception('No such game.');
    if (m.status != 'active') throw Exception('That game is over.');
    return m;
  }

  static Future<String> _name(Session session, UuidValue user) async {
    final p = await UserProfile.db.findFirstRow(session, where: (t) => t.authUserId.equals(user));
    final n = p?.username?.trim();
    if (n != null && n.isNotEmpty) return n;
    final e = p?.email;
    return e != null && e.contains('@') ? e.split('@').first : 'player';
  }
}
