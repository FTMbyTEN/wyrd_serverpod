import 'dart:math';

import 'package:test/test.dart';
import 'package:wyrd_server/src/games/board_games.dart';

void main() {
  final r = Random(3);

  group('Tic-tac-toe', () {
    final g = TicTacToe();
    test('wins are found on rows, columns and diagonals, and a full board is a draw', () {
      expect(g.outcome({'b': [0, 0, 0, 1, 1, -1, -1, -1, -1], 't': 1}), 0);
      expect(g.outcome({'b': [1, 0, -1, 1, 0, -1, 1, -1, -1], 't': 0}), 1);
      expect(g.outcome({'b': [0, 1, 0, 0, 1, 1, 1, 0, 0], 't': 1}), 2);
    });
    test('at full strength it takes a win and blocks a loss', () {
      expect(g.aiMove({'b': [0, 0, -1, 1, 1, -1, -1, -1, -1], 't': 0}, 6, r), '2'); // win the top row
      expect(g.aiMove({'b': [0, 0, -1, 1, -1, -1, -1, -1, -1], 't': 1}, 6, r), '2'); // block it
    });
    test('a taken square is refused', () {
      expect(() => g.apply({'b': [0, -1, -1, -1, -1, -1, -1, -1, -1], 't': 1}, '0'), throwsException);
    });
  });

  group('Connect Four', () {
    final g = ConnectFour();
    test('discs fall to the bottom and a full column is refused', () {
      var s = g.initial();
      s = g.apply(s, '3');
      expect(BoardGame.board(s)[5 * 7 + 3], 0);
      for (var i = 0; i < 5; i++) {
        s = g.apply(s, '3');
      }
      expect(() => g.apply(s, '3'), throwsException);
    });
    test('at full strength it completes four and blocks four', () {
      // first player has three in the bottom row (0,1,2): playing 3 wins
      final b = List.filled(42, -1);
      b[35] = 0; b[36] = 0; b[37] = 0; b[28] = 1; b[29] = 1;
      expect(g.aiMove({'b': b, 't': 0}, 6, r), '3');
      expect(g.aiMove({'b': b, 't': 1}, 6, r), '3'); // the second player must block there
    });
  });

  group('Reversi', () {
    final g = Reversi();
    test('the opening has four legal moves, and a move flips', () {
      final s = g.initial();
      expect(g.legal(s).length, 4);
      final after = g.apply(s, g.legal(s).first);
      expect(BoardGame.board(after).where((v) => v == 0).length, 4); // 2 + the new disc + 1 flipped
    });
    test('every level answers with a legal move', () {
      final s = g.initial();
      for (var level = 1; level <= 6; level++) {
        expect(g.legal(s), contains(g.aiMove(s, level, r)));
      }
    });
  });
}
