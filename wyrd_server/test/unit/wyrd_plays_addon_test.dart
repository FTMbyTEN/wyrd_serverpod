import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';

void main() {
  test(
    'the WYRD PLAYS add-on is spliced in before </body>, and only a real one',
    () {
      const game =
          '<html><body><canvas></canvas><script>game()</script></body></html>';
      final out = CustomGames.withPlayAddOn(
        game,
        'Here:\n<script>if (window.WYRD_PLAYS) { play(); }</script>\nDone.',
      );
      expect(
        out,
        '<html><body><canvas></canvas><script>game()</script><script>if (window.WYRD_PLAYS) { play(); }</script>\n</body></html>',
      );
      expect(
        CustomGames.withPlayAddOn(game, '<script>nothing()</script>'),
        isNull,
      );
      expect(CustomGames.withPlayAddOn(game, 'no script at all'), isNull);
    },
  );
}
