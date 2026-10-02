import 'dart:math';

import 'package:chess/chess.dart' as ch;

/// WYRD's chess: alpha-beta search over material and piece-square tables. Strength comes from two
/// dials -- how far it looks ahead, and how often it settles for a near-best move instead of the
/// best -- so it can meet a beginner or press a strong player. No AI calls: free and fast.
class ChessEngine {
  static const _value = {'p': 100, 'n': 320, 'b': 330, 'r': 500, 'q': 900, 'k': 0};

  // piece-square tables, from white's side, a8..h1 (index 0 = a8)
  static const _pst = <String, List<int>>{
    'p': [0, 0, 0, 0, 0, 0, 0, 0, 50, 50, 50, 50, 50, 50, 50, 50, 10, 10, 20, 30, 30, 20, 10, 10, 5, 5, 10, 25, 25, 10, 5, 5, 0, 0, 0, 20, 20, 0, 0, 0, 5, -5, -10, 0, 0, -10, -5, 5, 5, 10, 10, -20, -20, 10, 10, 5, 0, 0, 0, 0, 0, 0, 0, 0],
    'n': [-50, -40, -30, -30, -30, -30, -40, -50, -40, -20, 0, 0, 0, 0, -20, -40, -30, 0, 10, 15, 15, 10, 0, -30, -30, 5, 15, 20, 20, 15, 5, -30, -30, 0, 15, 20, 20, 15, 0, -30, -30, 5, 10, 15, 15, 10, 5, -30, -40, -20, 0, 5, 5, 0, -20, -40, -50, -40, -30, -30, -30, -30, -40, -50],
    'b': [-20, -10, -10, -10, -10, -10, -10, -20, -10, 0, 0, 0, 0, 0, 0, -10, -10, 0, 5, 10, 10, 5, 0, -10, -10, 5, 5, 10, 10, 5, 5, -10, -10, 0, 10, 10, 10, 10, 0, -10, -10, 10, 10, 10, 10, 10, 10, -10, -10, 5, 0, 0, 0, 0, 5, -10, -20, -10, -10, -10, -10, -10, -10, -20],
    'r': [0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 10, 10, 10, 10, 10, 5, -5, 0, 0, 0, 0, 0, 0, -5, -5, 0, 0, 0, 0, 0, 0, -5, -5, 0, 0, 0, 0, 0, 0, -5, -5, 0, 0, 0, 0, 0, 0, -5, -5, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, 5, 5, 0, 0, 0],
    'q': [-20, -10, -10, -5, -5, -10, -10, -20, -10, 0, 0, 0, 0, 0, 0, -10, -10, 0, 5, 5, 5, 5, 0, -10, -5, 0, 5, 5, 5, 5, 0, -5, 0, 0, 5, 5, 5, 5, 0, -5, -10, 5, 5, 5, 5, 5, 0, -10, -10, 0, 5, 0, 0, 0, 0, -10, -20, -10, -10, -5, -5, -10, -10, -20],
    'k': [-30, -40, -40, -50, -50, -40, -40, -30, -30, -40, -40, -50, -50, -40, -40, -30, -30, -40, -40, -50, -50, -40, -40, -30, -30, -40, -40, -50, -50, -40, -40, -30, -20, -30, -30, -40, -40, -30, -30, -20, -10, -20, -20, -20, -20, -20, -20, -10, 20, 20, 0, 0, 0, 0, 20, 20, 20, 30, 10, 0, 0, 10, 30, 20],
  };

  /// Depth and slack per level (1 gentle .. 6 full strength). Slack: how many centipawns below the
  /// best a move may be and still be picked; it's what makes the low levels beatable and human.
  static const _depth = [1, 1, 2, 2, 3, 3];
  static const _slack = [220, 120, 90, 45, 25, 0];

  /// The rating each level plays at, for Elo.
  static double levelRating(int level) => 600.0 + (level.clamp(1, 6) - 1) * 260;

  /// The level that gives a player of [rating] a fair game.
  static int levelFor(double rating) => (((rating - 600) / 260).round() + 1).clamp(1, 6);

  /// WYRD's move in SAN, or null if the game is over.
  static String? bestMove(String fen, int level, {Random? rng}) {
    final r = rng ?? Random();
    final game = ch.Chess.fromFEN(fen);
    if (game.game_over) return null;
    final lv = level.clamp(1, 6) - 1;
    final depth = _depth[lv];
    final moves = _ordered(game, game.generate_moves());
    final scored = <(ch.Move, int)>[];
    var best = -1 << 30;
    for (final m in moves) {
      game.make_move(m);
      // a move cut off by the window scores just under the threshold, so it never ties with a real one
      final s = -_search(game, depth - 1, -1 << 30, -(best - _slack[lv]) + 1);
      game.undo_move();
      scored.add((m, s));
      if (s > best) best = s;
    }
    final ok = scored.where((e) => e.$2 >= best - _slack[lv]).toList();
    final pick = ok.isEmpty ? scored.first : ok[r.nextInt(ok.length)];
    return game.move_to_san(pick.$1);
  }

  static int _search(ch.Chess g, int depth, int alpha, int beta) {
    if (depth <= 0) return _quiesce(g, alpha, beta, 3);
    final moves = g.generate_moves();
    if (moves.isEmpty) return g.in_check ? -100000 - depth : 0;
    for (final m in _ordered(g, moves)) {
      g.make_move(m);
      final s = -_search(g, depth - 1, -beta, -alpha);
      g.undo_move();
      if (s >= beta) return beta;
      if (s > alpha) alpha = s;
    }
    return alpha;
  }

  // keep looking while captures are on the board, so it doesn't hang pieces at the horizon
  static int _quiesce(ch.Chess g, int alpha, int beta, int left) {
    final stand = evaluate(g);
    if (left == 0 || stand >= beta) return stand >= beta ? beta : stand;
    if (stand > alpha) alpha = stand;
    final captures = g.generate_moves().where((m) => m.captured != null).toList();
    for (final m in _ordered(g, captures)) {
      g.make_move(m);
      final s = -_quiesce(g, -beta, -alpha, left - 1);
      g.undo_move();
      if (s >= beta) return beta;
      if (s > alpha) alpha = s;
    }
    return alpha;
  }

  // captures first, most valuable victim by least valuable attacker
  static List<ch.Move> _ordered(ch.Chess g, List<ch.Move> moves) {
    int key(ch.Move m) => m.captured == null ? 0 : 10 * _value[m.captured!.name]! - _value[m.piece.name]! ~/ 10 + 1000;
    return [...moves]..sort((a, b) => key(b) - key(a));
  }

  /// The position from the side to move's point of view, in centipawns.
  static int evaluate(ch.Chess g) {
    var score = 0;
    for (var sq = 0; sq < 128; sq++) {
      if (sq & 0x88 != 0) continue;
      final p = g.board[sq];
      if (p == null) continue;
      final rank = sq >> 4, file = sq & 7; // rank 0 = 8th rank
      final white = p.color == ch.Color.WHITE;
      final idx = white ? rank * 8 + file : (7 - rank) * 8 + file;
      final v = _value[p.type.name]! + _pst[p.type.name]![idx];
      score += white ? v : -v;
    }
    return g.turn == ch.Color.WHITE ? score : -score;
  }
}
