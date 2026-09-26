import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/code_agent_service.dart';

void main() {
  group('CodeAgentService.isCodeRequest', () {
    for (final text in [
      'write me a function that reverses a string',
      'build me a calculator',
      'can you write a regex for emails?',
      'how do I implement a linked list',
      'sort this list in python',
      'here is my code ```js\nconsole.log(1)\n```',
      'make a game',
    ]) {
      test('treats "$text" as a code request', () {
        expect(CodeAgentService.isCodeRequest(text), isTrue);
      });
    }

    for (final text in [
      'how are you today?',
      'tell me about the moon',
      "what's the weather in Lagos",
    ]) {
      test('treats "$text" as ordinary chat', () {
        expect(CodeAgentService.isCodeRequest(text), isFalse);
      });
    }
  });

  group('CodeAgentService.isLikelyFollowUp', () {
    test('is false for a user with no recent code reply', () {
      expect(
        CodeAgentService.isLikelyFollowUp(const Uuid().v4obj(), 'where'),
        isFalse,
      );
    });
  });
}
