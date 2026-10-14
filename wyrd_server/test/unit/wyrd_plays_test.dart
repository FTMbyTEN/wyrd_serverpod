import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';

void main() {
  test('a game opens with WYRD at the controls from the moment it loads', () {
    const game =
        '<!doctype html><html><head><title>x</title></head><body><script>if (window.WYRD_PLAYS) bot();</script></body></html>';
    final played = CustomGames.withWyrdPlaying(game);
    expect(
      played,
      contains('<head><script>window.WYRD_PLAYS=true</script><title>'),
    );
    expect(
      played.indexOf('WYRD_PLAYS=true'),
      lessThan(played.indexOf('bot()')),
    );
    expect(CustomGames.playGameTool['name'], 'play_game');
  });
}
