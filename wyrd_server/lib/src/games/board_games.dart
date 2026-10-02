import 'dart:convert';
import 'dart:math';

/// The board games besides chess, behind one shape: a position is JSON {"b": [cells], "t": side to
/// move}, cells are -1 (empty), 0 (first player) or 1 (second); a move is a short string. The server
/// applies every move through here, so nothing a client sends can bend the rules.
abstract class BoardGame {
  String get name;

  /// The opening position.
  Map<String, dynamic> initial();

  /// The moves the side to move may make.
  List<String> legal(Map<String, dynamic> s);

  /// The position after [move]; throws if it isn't legal.
  Map<String, dynamic> apply(Map<String, dynamic> s, String move);

  /// 0 or 1 when that side has won, 2 for a draw, null while it goes on.
  int? outcome(Map<String, dynamic> s);

  /// WYRD's move at [level] (1 gentle .. 6 full strength).
  String aiMove(Map<String, dynamic> s, int level, Random r);

  static final all = <String, BoardGame>{'tictactoe': TicTacToe(), 'connect4': ConnectFour(), 'reversi': Reversi()};

  static Map<String, dynamic> decode(String state) => jsonDecode(state) as Map<String, dynamic>;
  static String encode(Map<String, dynamic> s) => jsonEncode(s);
  static List<int> board(Map<String, dynamic> s) => (s['b'] as List).cast<int>();
  static int turn(Map<String, dynamic> s) => s['t'] as int;
}

/// Picks among moves scored by a search: at full strength the best, lower down sometimes a
/// near-best one, so the gentle levels make human mistakes.
String _choose(List<(String, double)> scored, int level, Random r) {
  scored.sort((a, b) => b.$2.compareTo(a.$2));
  const slack = [0.9, 0.6, 0.4, 0.22, 0.1, 0.0]; // how far below the best a move may be (0..1 of the spread)
  final best = scored.first.$2, worst = scored.last.$2;
  final spread = max(1e-9, best - worst);
  final ok = scored.where((m) => best - m.$2 <= slack[level.clamp(1, 6) - 1] * spread).toList();
  return ok[r.nextInt(ok.length)].$1;
}

// ---- Tic-tac-toe -------------------------------------------------------------------------------

class TicTacToe extends BoardGame {
  @override
  String get name => 'tictactoe';
  static const _lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];

  @override
  Map<String, dynamic> initial() => {'b': List.filled(9, -1), 't': 0};

  @override
  List<String> legal(Map<String, dynamic> s) {
    if (outcome(s) != null) return [];
    final b = BoardGame.board(s);
    return [for (var i = 0; i < 9; i++) if (b[i] == -1) '$i'];
  }

  @override
  Map<String, dynamic> apply(Map<String, dynamic> s, String move) {
    if (!legal(s).contains(move)) throw Exception('That square is taken.');
    final b = [...BoardGame.board(s)];
    final t = BoardGame.turn(s);
    b[int.parse(move)] = t;
    return {'b': b, 't': 1 - t};
  }

  @override
  int? outcome(Map<String, dynamic> s) {
    final b = BoardGame.board(s);
    for (final l in _lines) {
      if (b[l[0]] != -1 && b[l[0]] == b[l[1]] && b[l[1]] == b[l[2]]) return b[l[0]];
    }
    return b.contains(-1) ? null : 2;
  }

  // perfect play by full search (the board is tiny)
  double _score(Map<String, dynamic> s, int me) {
    final o = outcome(s);
    if (o != null) return o == 2 ? 0 : (o == me ? 1 : -1);
    final mine = BoardGame.turn(s) == me;
    var best = mine ? -2.0 : 2.0;
    for (final m in legal(s)) {
      final v = _score(apply(s, m), me) * 0.95; // sooner wins are better
      best = mine ? max(best, v) : min(best, v);
    }
    return best;
  }

  @override
  String aiMove(Map<String, dynamic> s, int level, Random r) {
    final me = BoardGame.turn(s);
    return _choose([for (final m in legal(s)) (m, _score(apply(s, m), me))], level, r);
  }
}

// ---- Connect Four ------------------------------------------------------------------------------

class ConnectFour extends BoardGame {
  static const cols = 7, rows = 6;
  @override
  String get name => 'connect4';

  @override
  Map<String, dynamic> initial() => {'b': List.filled(cols * rows, -1), 't': 0};

  @override
  List<String> legal(Map<String, dynamic> s) {
    if (outcome(s) != null) return [];
    final b = BoardGame.board(s);
    return [for (var c = 0; c < cols; c++) if (b[c] == -1) '$c']; // the top cell of the column is free
  }

  @override
  Map<String, dynamic> apply(Map<String, dynamic> s, String move) {
    final c = int.tryParse(move) ?? -1;
    if (!legal(s).contains('$c')) throw Exception('That column is full.');
    final b = [...BoardGame.board(s)];
    final t = BoardGame.turn(s);
    for (var r = rows - 1; r >= 0; r--) {
      if (b[r * cols + c] == -1) {
        b[r * cols + c] = t;
        break;
      }
    }
    return {'b': b, 't': 1 - t};
  }

  @override
  int? outcome(Map<String, dynamic> s) {
    final b = BoardGame.board(s);
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final p = b[r * cols + c];
        if (p == -1) continue;
        for (final (dr, dc) in const [(0, 1), (1, 0), (1, 1), (1, -1)]) {
          var n = 1;
          while (n < 4) {
            final rr = r + dr * n, cc = c + dc * n;
            if (rr < 0 || rr >= rows || cc < 0 || cc >= cols || b[rr * cols + cc] != p) break;
            n++;
          }
          if (n == 4) return p;
        }
      }
    }
    return b.contains(-1) ? null : 2;
  }

  // every window of four, scored by how much of it one side holds
  double _eval(List<int> b, int me) {
    var score = 0.0;
    for (var r = 0; r < rows; r++) {
      if (b[r * cols + 3] == me) score += 3; // the centre column is worth having
      for (var c = 0; c < cols; c++) {
        for (final (dr, dc) in const [(0, 1), (1, 0), (1, 1), (1, -1)]) {
          final er = r + dr * 3, ec = c + dc * 3;
          if (er < 0 || er >= rows || ec < 0 || ec >= cols) continue;
          var mine = 0, theirs = 0;
          for (var k = 0; k < 4; k++) {
            final v = b[(r + dr * k) * cols + c + dc * k];
            if (v == me) mine++;
            else if (v == 1 - me) theirs++;
          }
          if (theirs == 0) score += const [0, 1, 4, 20, 1000][mine];
          if (mine == 0) score -= const [0, 1, 5, 25, 1000][theirs];
        }
      }
    }
    return score;
  }

  double _search(Map<String, dynamic> s, int depth, double a, double b, int me) {
    final o = outcome(s);
    if (o != null) return o == 2 ? 0 : (o == me ? 100000.0 + depth : -100000.0 - depth);
    if (depth == 0) return _eval(BoardGame.board(s), me);
    final mine = BoardGame.turn(s) == me;
    // centre columns first: better moves earlier make the search cut far more
    final moves = legal(s)..sort((x, y) => (int.parse(x) - 3).abs() - (int.parse(y) - 3).abs());
    for (final m in moves) {
      final v = _search(apply(s, m), depth - 1, a, b, me);
      if (mine) { a = max(a, v); } else { b = min(b, v); }
      if (a >= b) break;
    }
    return mine ? a : b;
  }

  @override
  String aiMove(Map<String, dynamic> s, int level, Random r) {
    final me = BoardGame.turn(s);
    const depth = [1, 2, 3, 4, 5, 6];
    final d = depth[level.clamp(1, 6) - 1];
    return _choose([for (final m in legal(s)) (m, _search(apply(s, m), d - 1, -1e12, 1e12, me))], level, r);
  }
}

// ---- Reversi -----------------------------------------------------------------------------------

class Reversi extends BoardGame {
  @override
  String get name => 'reversi';
  static const _dirs = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
  // corners are gold, the squares next to them are traps
  static const _weight = [
    100, -20, 10, 5, 5, 10, -20, 100, -20, -50, -2, -2, -2, -2, -50, -20, 10, -2, -1, -1, -1, -1, -2, 10, 5, -2, -1, -1, -1, -1, -2, 5,
    5, -2, -1, -1, -1, -1, -2, 5, 10, -2, -1, -1, -1, -1, -2, 10, -20, -50, -2, -2, -2, -2, -50, -20, 100, -20, 10, 5, 5, 10, -20, 100,
  ];

  @override
  Map<String, dynamic> initial() {
    final b = List.filled(64, -1);
    b[27] = 1; b[36] = 1; b[28] = 0; b[35] = 0; // the four in the middle (first player is dark)
    return {'b': b, 't': 0};
  }

  List<int> _flips(List<int> b, int i, int t) {
    if (b[i] != -1) return const [];
    final out = <int>[];
    final r0 = i ~/ 8, c0 = i % 8;
    for (final (dr, dc) in _dirs) {
      final run = <int>[];
      var r = r0 + dr, c = c0 + dc;
      while (r >= 0 && r < 8 && c >= 0 && c < 8 && b[r * 8 + c] == 1 - t) {
        run.add(r * 8 + c);
        r += dr; c += dc;
      }
      if (run.isNotEmpty && r >= 0 && r < 8 && c >= 0 && c < 8 && b[r * 8 + c] == t) out.addAll(run);
    }
    return out;
  }

  List<String> _placements(List<int> b, int t) => [for (var i = 0; i < 64; i++) if (_flips(b, i, t).isNotEmpty) '$i'];

  @override
  List<String> legal(Map<String, dynamic> s) {
    if (outcome(s) != null) return [];
    final m = _placements(BoardGame.board(s), BoardGame.turn(s));
    return m.isEmpty ? ['pass'] : m; // with no move, a side must pass
  }

  @override
  Map<String, dynamic> apply(Map<String, dynamic> s, String move) {
    if (!legal(s).contains(move)) throw Exception("That move doesn't flip anything.");
    final b = [...BoardGame.board(s)];
    final t = BoardGame.turn(s);
    if (move != 'pass') {
      final i = int.parse(move);
      for (final f in _flips(b, i, t)) {
        b[f] = t;
      }
      b[i] = t;
    }
    return {'b': b, 't': 1 - t};
  }

  @override
  int? outcome(Map<String, dynamic> s) {
    final b = BoardGame.board(s);
    if (_placements(b, 0).isNotEmpty || _placements(b, 1).isNotEmpty) return null;
    final dark = b.where((v) => v == 0).length, light = b.where((v) => v == 1).length;
    return dark == light ? 2 : (dark > light ? 0 : 1);
  }

  double _eval(List<int> b, int me) {
    var s = 0.0;
    for (var i = 0; i < 64; i++) {
      if (b[i] == me) s += _weight[i];
      else if (b[i] == 1 - me) s -= _weight[i];
    }
    return s + 3.0 * (_placements(b, me).length - _placements(b, 1 - me).length); // room to move matters
  }

  double _search(Map<String, dynamic> s, int depth, double a, double b, int me) {
    final o = outcome(s);
    if (o != null) {
      final bd = BoardGame.board(s);
      final diff = bd.where((v) => v == me).length - bd.where((v) => v == 1 - me).length;
      // a finished game: winning beats any position, and by more discs is better still
      return o == 2 ? 0 : (o == me ? 10000.0 : -10000.0) + diff * 10;
    }
    if (depth == 0) return _eval(BoardGame.board(s), me);
    final mine = BoardGame.turn(s) == me;
    for (final m in legal(s)) {
      final v = _search(apply(s, m), depth - 1, a, b, me);
      if (mine) { a = max(a, v); } else { b = min(b, v); }
      if (a >= b) break;
    }
    return mine ? a : b;
  }

  @override
  String aiMove(Map<String, dynamic> s, int level, Random r) {
    final me = BoardGame.turn(s);
    const depth = [1, 1, 2, 3, 3, 4];
    final d = depth[level.clamp(1, 6) - 1];
    return _choose([for (final m in legal(s)) (m, _search(apply(s, m), d - 1, -1e12, 1e12, me))], level, r);
  }
}
