import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// A person's chats in Dialogue Link. The current chat is the one they used most recently: every
/// message goes into it and WYRD's reply sees only its history. Starting a new chat or opening an
/// old one makes that one current, so nothing else needs to know which chat is open.
class ChatList {
  /// Their current chat, made on first need. The first time, turns from before chats existed are
  /// gathered into it as their earlier conversation.
  static Future<Chat> current(Session session, UuidValue user) async {
    final latest = await Chat.db.findFirstRow(session, where: (t) => t.authUserId.equals(user), orderBy: (t) => t.updatedAt.desc());
    if (latest != null) return latest;
    final now = DateTime.now().toUtc();
    final first = await ConversationTurn.db.findFirstRow(session, where: (t) => t.authUserId.equals(user), orderBy: (t) => t.id);
    final chat = await Chat.db.insertRow(
      session,
      Chat(authUserId: user, title: first == null ? null : 'Earlier conversation', createdAt: first?.timestamp ?? now, updatedAt: now),
    );
    if (first != null) {
      await session.db.unsafeExecute(
        'UPDATE "conversation_turn" SET "chatId" = @c WHERE "authUserId" = CAST(@u AS uuid) AND "chatId" IS NULL',
        parameters: QueryParameters.named({'c': chat.id, 'u': user.uuid}),
      );
    }
    return chat;
  }

  /// A new, empty chat, now current (the current one, if it's still empty, is reused).
  static Future<Chat> start(Session session, UuidValue user) async {
    final now = DateTime.now().toUtc();
    final cur = await current(session, user);
    final used = await ConversationTurn.db.count(session, where: (t) => t.chatId.equals(cur.id));
    if (used == 0) return Chat.db.updateRow(session, cur.copyWith(updatedAt: now));
    return Chat.db.insertRow(session, Chat(authUserId: user, createdAt: now, updatedAt: now));
  }

  /// Makes one of their chats current again.
  static Future<Chat> open(Session session, UuidValue user, int id) async {
    final chat = await Chat.db.findById(session, id);
    if (chat == null || chat.authUserId != user) throw Exception('No such chat.');
    return Chat.db.updateRow(session, chat.copyWith(updatedAt: DateTime.now().toUtc()));
  }

  /// After a message in [chat]: it stays current, and gets its title from the first message.
  static Future<void> used(Session session, Chat chat, String said) async {
    final words = said.replaceAll(RegExp(r'^📎 [^\n]+\n+'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
    await Chat.db.updateRow(
      session,
      chat.copyWith(
        updatedAt: DateTime.now().toUtc(),
        title: chat.title ?? (words.isEmpty ? null : words.length > 48 ? '${words.substring(0, 47).trimRight()}…' : words),
      ),
    );
  }

  /// Their chats, most recent first, with how many messages each has and when it was last used.
  static Future<List<Map<String, dynamic>>> list(Session session, UuidValue user, {int limit = 50}) async {
    final cur = await current(session, user);
    final rows = await session.db.unsafeQuery(
      'SELECT c."id", c."title", c."updatedAt", COUNT(t."id") AS turns FROM "chat" c '
      'LEFT JOIN "conversation_turn" t ON t."chatId" = c."id" '
      'WHERE c."authUserId" = CAST(@u AS uuid) GROUP BY c."id" ORDER BY c."updatedAt" DESC LIMIT @n',
      parameters: QueryParameters.named({'u': user.uuid, 'n': limit}),
    );
    return [
      for (final r in rows)
        {
          'id': r[0],
          'title': r[1] ?? 'New chat',
          'updatedAt': (r[2] as DateTime).toIso8601String(),
          'turns': (r[3] as num).toInt(),
          'current': r[0] == cur.id,
        },
    ];
  }
}
