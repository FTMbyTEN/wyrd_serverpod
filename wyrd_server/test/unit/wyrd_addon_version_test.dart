import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';

void main() {
  test('an older WYRD player (it made games stutter) is taken out and rewritten', () {
    const old = '<html><body><script>game()</script><script data-wyrd-learns>if (window.WYRD_LEARNS) slow();</script>\n</body></html>';
    expect(CustomGames.needsAddOn(old), isTrue);
    expect(
      CustomGames.withoutAddOn(old),
      '<html><body><script>game()</script></body></html>',
    );
    const current = '<html><body><script data-wyrd-learns="2">if (window.WYRD_LEARNS) smooth();</script></body></html>';
    expect(CustomGames.needsAddOn(current), isFalse);
    expect(CustomGames.needsAddOn('<html><body><script>game()</script></body></html>'), isTrue);
  });
}
