import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Chats in Dialogue Link: a new chat starts empty, an old one can be reopened, and turns from
/// before chats existed are gathered into an "Earlier conversation".
void main() {
  withServerpod('Given Dialogue Link chats', (sessionBuilder, endpoints) {
    const id = '99999999-9999-4999-8999-999999999999';
    final me = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo(id, {}));

    test('new chat, history per chat, reopen, and the earlier conversation', () async {
      // a turn from before chats existed
      await ConversationTurn.db.insertRow(
        sessionBuilder.build(),
        ConversationTurn(authUserId: UuidValue.fromString(id), userText: 'old hello', botText: 'old reply', timestamp: DateTime.now().toUtc()),
      );
      var history = await endpoints.chat.getHistory(me);
      expect(history.map((t) => t.userText), ['old hello']);

      await endpoints.chat.sendMessage(me, 'Tell me about Lagos');
      expect((await endpoints.chat.getHistory(me)).length, 2);

      await endpoints.chat.newChat(me);
      expect(await endpoints.chat.getHistory(me), isEmpty);
      await endpoints.chat.newChat(me); // an empty chat is reused, not piled up
      await endpoints.chat.sendMessage(me, 'What is jollof rice?');
      history = await endpoints.chat.getHistory(me);
      expect(history.map((t) => t.userText), ['What is jollof rice?']);

      final chats = (jsonDecode(await endpoints.chat.chats(me)) as List).cast<Map<String, dynamic>>();
      expect(chats.length, 2);
      expect(chats.first['title'], 'What is jollof rice?');
      expect(chats.first['current'], isTrue);
      expect(chats.last['title'], 'Earlier conversation');
      expect(chats.last['turns'], 2);

      await endpoints.chat.openChat(me, chats.last['id'] as int);
      expect((await endpoints.chat.getHistory(me)).map((t) => t.userText), ['old hello', 'Tell me about Lagos']);

      // someone else's chat can't be opened
      final other = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo('12121212-1212-4212-8212-121212121212', {}));
      expect(() => endpoints.chat.openChat(other, chats.first['id'] as int), throwsA(anything));
    });

  });

  // (simultaneous requests can't run under the per-test rollback, so this group keeps its data)
  withServerpod('Given a first load', (sessionBuilder, endpoints) {
    test('two requests at once make one chat, not two', () async {
      final fresh = sessionBuilder.copyWith(authentication: AuthenticationOverride.authenticationInfo('34343434-3434-4434-8434-343434343434', {}));
      await ConversationTurn.db.insertRow(
        sessionBuilder.build(),
        ConversationTurn(authUserId: UuidValue.fromString('34343434-3434-4434-8434-343434343434'), userText: 'hi', botText: 'hello', timestamp: DateTime.now().toUtc()),
      );
      await Future.wait([endpoints.chat.chats(fresh), endpoints.chat.getHistory(fresh), endpoints.chat.chats(fresh)]);
      final n = await Chat.db.count(sessionBuilder.build(), where: (t) => t.authUserId.equals(UuidValue.fromString('34343434-3434-4434-8434-343434343434')));
      expect(n, 1);
    });
  }, rollbackDatabase: RollbackDatabase.disabled);
}
