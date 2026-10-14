import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';

void main() {
  test('the WYRD LEARNS add-on is spliced in before </body>, tagged, and only a real one', () {
    const game = '<html><body><canvas></canvas><script>game()</script></body></html>';
    final out = CustomGames.withPlayAddOn(
      game,
      'Here:\n<script>if (window.WYRD_LEARNS) { learn(); }</script>\nDone.',
    );
    expect(
      out,
      '<html><body><canvas></canvas><script>game()</script>'
      '<script data-wyrd-learns="2">if (window.WYRD_LEARNS) { learn(); }</script>\n</body></html>',
    );
    expect(CustomGames.withPlayAddOn(game, '<script>nothing()</script>'), isNull);
    expect(CustomGames.withPlayAddOn(game, 'no script at all'), isNull);
  });

  test('WYRD starts from what it learned: best, rounds and strategy go in with the game', () {
    final html = CustomGames.withWyrdPlaying('<html><head></head><body></body></html>');
    expect(html, contains('window.WYRD_LEARNS={"best":0,"rounds":0,"params":null}'));
  });
}
