import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';
import 'package:wyrd_server/src/mind/code_agent_service.dart';

void main() {
  test(
    'asking for a game goes to the code writer, which can build it into the Games tab',
    () {
      for (final ask in [
        'make me a Ludo game',
        'Add a snake game to my games',
        'can you program an Ayo game for me',
        'design a racing game with danfos',
      ]) {
        expect(CodeAgentService.isCodeRequest(ask), isTrue, reason: ask);
      }
      expect(
        CodeAgentService.isCodeRequest('who won the game last night?'),
        isFalse,
      );
      expect(CustomGames.buildGameTool['name'], 'build_game');
    },
  );

  test(
    'the game is the HTML document in the reply, and only a complete one',
    () {
      const doc = '<!DOCTYPE html><html><script>go()</script></html>';
      expect(CustomGames.extractHtml('Here:\n```html\n$doc\n```\nEnjoy'), doc);
      expect(CustomGames.extractHtml('<html><p>no script</p></html>'), isNull);
      expect(CustomGames.extractHtml('<!doctype html><html><script>'), isNull);
    },
  );
}
