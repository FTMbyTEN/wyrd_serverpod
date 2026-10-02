import 'dart:math';

import 'package:chess/chess.dart' as ch;
import 'package:test/test.dart';
import 'package:wyrd_server/src/games/chess_engine.dart';
import 'package:wyrd_server/src/games/game_service.dart';

void main() {
  test('at full strength it finds mate in one', () {
    // white: Kg1, Ra1; black: Kg8 behind its pawns -- Ra8 is mate
    const fen = '6k1/5ppp/8/8/8/8/8/R5K1 w - - 0 1';
    expect(ChessEngine.bestMove(fen, 6, rng: Random(1)), 'Ra8#');
  });

  test('it takes a queen left hanging', () {
    // black queen on d4 undefended, white knight on f3 attacks it
    const fen = '4k3/8/8/8/3q4/5N2/8/4K3 w - - 0 1';
    expect(ChessEngine.bestMove(fen, 5, rng: Random(1)), 'Nxd4');
  });

  test('every level answers the opening with a legal move, quickly', () {
    for (var level = 1; level <= 6; level++) {
      final watch = Stopwatch()..start();
      final san = ChessEngine.bestMove(ch.Chess.DEFAULT_POSITION, level, rng: Random(level));
      watch.stop();
      expect(san, isNotNull);
      expect(ch.Chess().move(san), isTrue);
      expect(watch.elapsedMilliseconds, lessThan(4000), reason: 'level $level took ${watch.elapsedMilliseconds} ms');
    }
  });

  test('levels follow rating', () {
    expect(ChessEngine.levelFor(600), 1);
    expect(ChessEngine.levelFor(1000), 3);
    expect(ChessEngine.levelFor(2500), 6);
  });

  test('Elo: beating a stronger level gains more than beating a weaker one', () {
    final up = GameService.elo(1000, 1400, 1, games: 20) - 1000;
    final down = GameService.elo(1000, 700, 1, games: 20) - 1000;
    expect(up, greaterThan(down));
    expect(GameService.elo(1000, 1000, 0.5, games: 20), closeTo(1000, 0.01));
  });
}
