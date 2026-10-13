import 'package:test/test.dart';
import 'package:wyrd_server/src/games/custom_games.dart';
import 'package:wyrd_server/src/mind/code_agent_service.dart';

void main() {
  test('asking for a game goes to the code writer, which can save it to the Games tab', () {
    for (final ask in [
      'make me a Ludo game',
      'Add a snake game to my games',
      'can you program an Ayo game for me',
      'design a racing game with danfos',
    ]) {
      expect(CodeAgentService.isCodeRequest(ask), isTrue, reason: ask);
    }
    expect(CodeAgentService.isCodeRequest('who won the game last night?'), isFalse);
    expect(CustomGames.saveGameTool['name'], 'save_game');
  });
}
