import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

/// WYRD's open chess challenge on the home screen: full strength, and never at the cost of a game
/// already on the board.
void main() {
  withServerpod('Given WYRD\'s chess challenge', (sessionBuilder, endpoints) {
    const id = '66666666-6666-4666-8666-666666666666';
    final me = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(id, {}),
    );

    test(
      'it plays at full strength, and carries on a game in progress',
      () async {
        final m = await endpoints.games.wyrdChallenge(me);
        expect(m.game, 'chess');
        expect(m.mode, 'wyrd');
        expect(m.status, 'active');
        expect(m.wyrdLevel, 6, reason: 'no easy mode');
        expect(m.remark, isNotEmpty);

        // accepting again doesn't resign the game on the board
        final again = await endpoints.games.wyrdChallenge(me);
        expect(again.id, m.id);
        final stored = await GameMatch.db.findById(
          sessionBuilder.build(),
          m.id!,
        );
        expect(stored!.status, 'active');
      },
    );

    test(
      'a gentler game already on the board is carried on, not thrown away',
      () async {
        final mine = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            '55555555-5555-4555-8555-555555555555',
            {},
          ),
        );
        final easy = await endpoints.games.start(mine, 'chess', 'w');
        final m = await endpoints.games.wyrdChallenge(mine);
        expect(m.id, easy.id);
        expect(
          (await GameMatch.db.findById(
            sessionBuilder.build(),
            easy.id!,
          ))!.status,
          'active',
        );
      },
    );
  });
}
