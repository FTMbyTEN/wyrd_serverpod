import '../generated/protocol.dart';
import 'memory_recall_service.dart';
import 'page_reader_service.dart';
import 'topic_service.dart';
import 'package:serverpod/serverpod.dart';

/// Conversation continuity: a message is understood in the light of the conversation it
/// belongs to. "Tell me more", "and its population?", "continue", "what about the second one?"
/// carry no subject of their own; the subject is whatever the two of them were just discussing.
///
///  - [isFollowUp] recognises messages that lean on the conversation;
///  - [threadTopics] is the subject of the last few exchanges, newest weighted most;
///  - the per-person [ChatThread] keeps that subject and what WYRD was last reading for them,
///    across sessions, so "continue reading" picks up where it stopped.
class ThreadService {
  static const _staleAfter = Duration(hours: 48);

  static final _leading = RegExp(
    r"^\s*(and|but|so|also|then|what about|how about|more|tell me more|go on|keep going|continue|carry on|next|why|how come|really|same|again|the (first|second|third|last|other|next|previous) one)\b",
    caseSensitive: false,
  );
  static final _refers = RegExp(
    r"\b(it|its|it's|that|this|these|those|they|them|their|he|him|his|she|her|there|the (book|article|story|page|chapter|one|same|drone|flight|map|picture|photo))\b",
    caseSensitive: false,
  );

  /// True when [text] leans on the conversation for its meaning.
  static bool isFollowUp(String text, {bool hasHistory = true}) {
    if (!hasHistory) return false;
    final ideas = MemoryRecallService.contentTopics(TopicService.extractTopics(text)).where(TopicService.isIdea).toList();
    if (_leading.hasMatch(text)) return true;
    if (_refers.hasMatch(text) && ideas.length <= 2) return true;
    // no subject of its own ("why?", "really?"); a short question that names its subject
    // ("What is entropy?") stands on its own
    return ideas.isEmpty;
  }

  /// The subject of the recent exchanges ([turns] newest first), strongest first.
  static List<String> threadTopics(List<ConversationTurn> turns, {int limit = 6}) {
    final weight = <String, double>{};
    for (var i = 0; i < turns.length && i < 3; i++) {
      final w = 1.0 / (i + 1); // the latest exchange counts most
      final t = turns[i];
      for (final topic in TopicService.extractTopics(t.userText).where(TopicService.isIdea)) {
        weight[topic] = (weight[topic] ?? 0) + 2 * w; // what the person asked about counts double
      }
      for (final topic in TopicService.extractTopics(t.botText).where(TopicService.isIdea)) {
        weight[topic] = (weight[topic] ?? 0) + w;
      }
    }
    final ranked = weight.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return ranked.take(limit).map((e) => e.key).toList();
  }

  /// The topics to recall with: the message's own, plus the thread's when it's a follow-up.
  static List<String> effectiveTopics(List<String> own, List<String> thread, {required bool followUp}) =>
      followUp ? {...own, ...thread}.toList() : own;

  static Future<ChatThread?> load(Session session, UuidValue authUserId) =>
      ChatThread.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId));

  /// Lines for the prompt, so WYRD knows what's being continued.
  static List<String> promptLines(ChatThread? thread, {required bool followUp, required List<String> threadTopics}) {
    final fresh = thread != null && DateTime.now().toUtc().difference(thread.updatedAt) < _staleAfter;
    final subject = threadTopics.isNotEmpty ? threadTopics : (fresh ? thread.subject : const <String>[]);
    return [
      if (followUp && subject.isNotEmpty)
        'This message continues your conversation: when they say "it", "that", "more" or leave the subject '
            'out, they most likely mean what you were just discussing (${subject.take(5).join(', ')}). '
            'Answer in that light instead of asking what they mean, unless it is genuinely ambiguous.',
      if (fresh && thread.lastReadUrl != null)
        'You were last reading "${thread.lastReadTitle ?? thread.lastReadUrl}" for them (${thread.lastReadUrl})'
            '${thread.nextOffset != null ? '; the next part starts at offset ${thread.nextOffset} — use read_page with that offset if they want you to continue' : '; you had reached the end'}.',
    ];
  }

  /// Remembers the conversation's subject and, if WYRD read something, where it stopped.
  static Future<void> update(Session session, UuidValue authUserId, {required List<String> subject, PageSlice? lastRead}) async {
    final now = DateTime.now().toUtc();
    final existing = await load(session, authUserId);
    final next = (existing ?? ChatThread(authUserId: authUserId, subject: const [], updatedAt: now)).copyWith(
      subject: subject.isNotEmpty ? subject.take(8).toList() : existing?.subject ?? const [],
      lastReadUrl: lastRead?.url ?? existing?.lastReadUrl,
      lastReadTitle: lastRead != null ? lastRead.title : existing?.lastReadTitle,
      nextOffset: lastRead != null ? lastRead.nextOffset : existing?.nextOffset,
      updatedAt: now,
    );
    if (existing == null) {
      await ChatThread.db.insertRow(session, next);
    } else {
      await ChatThread.db.updateRow(session, next);
    }
  }
}
