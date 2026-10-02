import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given games between players', (sessionBuilder, endpoints) {
    final ada = UuidValue.fromString('00000000-0000-4000-8000-0000000000a1');
    final ben = UuidValue.fromString('00000000-0000-4000-8000-0000000000b2');
    final asAda = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ada.uuid, {}));
    final asBen = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(ben.uuid, {}));

    test('a challenge is accepted, played out move by move, and both ratings move', () async {
      final posted = await endpoints.games.challenge(asAda, 'tictactoe');
      expect(posted.status, 'waiting');
      expect(await endpoints.games.openChallenges(asAda, 'tictactoe'), isEmpty); // not your own
      final open = await endpoints.games.openChallenges(asBen, 'tictactoe');
      expect(open.single.id, posted.id);

      var g = await endpoints.games.accept(asBen, posted.id!);
      expect(g.status, 'active');
      // whoever has 'w' moves first
      final first = g.playerSide == 'w' ? asAda : asBen;
      final second = g.playerSide == 'w' ? asBen : asAda;

      // nothing new since this version: the cheap check says so
      expect(await endpoints.games.poll(second, g.id!, g.version), isNull);
      await expectLater(endpoints.games.move(second, g.id!, '4'), throwsException); // not their turn

      // first takes the top row: 0, 1, 2 (second plays 3, 4)
      g = await endpoints.games.move(first, g.id!, '0');
      final seen = await endpoints.games.poll(second, g.id!, g.version - 1);
      expect(seen?.moves, ['0']); // the other side sees the move
      g = await endpoints.games.move(second, g.id!, '3');
      g = await endpoints.games.move(first, g.id!, '1');
      g = await endpoints.games.move(second, g.id!, '4');
      g = await endpoints.games.move(first, g.id!, '2');
      expect(g.status, 'over');
      expect(g.result, startsWith(g.playerSide == 'w' ? 'starter' : 'opponent'));

      final winner = (await endpoints.games.myRatings(first)).firstWhere((r) => r.game == 'tictactoe');
      final loser = (await endpoints.games.myRatings(second)).firstWhere((r) => r.game == 'tictactoe');
      expect(winner.rating, greaterThan(1000));
      expect(loser.rating, lessThan(1000));
      expect(winner.wins, 1);
    });

    test("a game left waiting on WYRD (a refresh mid-move) is unstuck when it's reopened", () async {
      final g = await endpoints.games.start(asAda, 'tictactoe', 'w');
      // as if the player's move was saved but WYRD's reply was lost: it's WYRD's turn
      await GameMatch.db.updateRow(sessionBuilder.build(), g.copyWith(state: '{"b":[0,-1,-1,-1,-1,-1,-1,-1,-1],"t":1}', moves: ['0']));
      final back = await endpoints.games.active(asAda, 'tictactoe');
      expect(back!.moves.length, 2); // WYRD has moved
      expect(back.viewerSide, 'w');
      expect(back.state, contains('"t":0')); // and it's the player's turn again
    });

    test('against WYRD, every board game answers a move', () async {
      for (final game in ['connect4', 'reversi', 'tictactoe']) {
        var g = await endpoints.games.start(asAda, game, 'w');
        final first = switch (game) { 'connect4' => '3', 'reversi' => '19', _ => '4' };
        g = await endpoints.games.move(asAda, g.id!, first);
        expect(g.moves.length, greaterThanOrEqualTo(2), reason: '$game: WYRD replied');
      }
    });
  });
}
