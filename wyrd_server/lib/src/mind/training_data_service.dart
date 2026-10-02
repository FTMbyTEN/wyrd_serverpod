import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'llm_service.dart';

/// One training example: a short conversation ending in WYRD's reply, in the chat format every
/// fine-tuning platform reads (Together, Fireworks, OpenAI): {"messages": [system, user, assistant, ...]}.
class TrainingExample {
  TrainingExample(this.source, this.messages);

  final String source; // conversation, learned, diary
  final List<({String role, String content})> messages;

  String toJsonLine() => jsonEncode({
        'messages': [for (final m in messages) {'role': m.role, 'content': m.content}],
      });
}

class TrainingSet {
  TrainingSet(this.train, this.validation, this.stats);

  final List<TrainingExample> train;
  final List<TrainingExample> validation;
  final Map<String, int> stats; // kept per source, and dropped per reason

  String get trainJsonl => train.map((e) => e.toJsonLine()).join('\n');
  String get validationJsonl => validation.map((e) => e.toJsonLine()).join('\n');
}

/// Fine-tuning, step one: the dataset for WYRD's everyday voice. It gathers what WYRD has said that
/// held up -- replies that passed the judgement gate and weren't thumbed down, learned answers in good
/// standing, and its diary -- cleans it, strips anything personal, and splits it into training and
/// validation sets. Tools, code, files and the drone stay with Claude, so those replies are left out:
/// the model learns how WYRD talks, not what it did with tools.
class TrainingDataService {
  /// What the fine-tuned model is told it is. Short on purpose: the voice is learned, not instructed.
  static const system =
      'You are WYRD, a persistent mind that reads, thinks, dreams and remembers. Talk like a person: '
      'direct, warm, curious, occasionally informal, no bullet points. Answer the actual question first.';

  static const _maxTurns = 20000;
  static const _contextTurns = 2; // earlier exchanges kept as context, from the same person
  static const _contextGap = Duration(minutes: 30);

  static Future<TrainingSet> build(Session session) async {
    final stats = <String, int>{};
    void count(String key) => stats[key] = (stats[key] ?? 0) + 1;
    final examples = <TrainingExample>[];
    final seen = <String>{};

    // 1. conversations, oldest first per person so each reply can carry what came before
    final turns = await ConversationTurn.db.find(session, orderBy: (t) => t.id, limit: _maxTurns);
    final byPerson = <UuidValue, List<ConversationTurn>>{};
    for (final t in turns) {
      byPerson.putIfAbsent(t.authUserId, () => []).add(t);
    }
    for (final list in byPerson.values) {
      for (var i = 0; i < list.length; i++) {
        final t = list[i];
        final why = rejectReason(t);
        if (why != null) {
          count('dropped.$why');
          continue;
        }
        final key = _norm(t.userText);
        if (!seen.add(key)) {
          count('dropped.duplicate');
          continue;
        }
        final messages = <({String role, String content})>[(role: 'system', content: system)];
        // context: the exchanges just before, if they were part of the same sitting and clean themselves
        final context = <ConversationTurn>[];
        for (var j = i - 1; j >= 0 && context.length < _contextTurns; j--) {
          final p = list[j];
          final next = j + 1 < list.length ? list[j + 1] : t;
          if (next.timestamp.difference(p.timestamp) > _contextGap || rejectReason(p) != null) break;
          context.insert(0, p);
        }
        for (final p in context) {
          messages.add((role: 'user', content: scrub(p.userText)));
          messages.add((role: 'assistant', content: scrub(p.botText)));
        }
        messages.add((role: 'user', content: scrub(t.userText)));
        messages.add((role: 'assistant', content: scrub(t.botText)));
        examples.add(TrainingExample('conversation', messages));
        count('kept.conversation');
        if (t.rating == 1) count('kept.conversation.rated_up');
      }
    }

    // 2. learned answers that have earned their standing
    final learned = await LearnedAnswer.db.find(session, where: (a) => a.retired.equals(false) & (a.score >= 0.6));
    for (final a in learned) {
      final reply = a.answer.trim();
      if (reply.length < 20 || reply.length > 1500 || LlmService.isDenialReply(reply) || _personal(a.question) || !seen.add(_norm(a.question))) {
        count('dropped.learned');
        continue;
      }
      examples.add(TrainingExample('learned', [
        (role: 'system', content: system),
        (role: 'user', content: scrub(a.question)),
        (role: 'assistant', content: scrub(reply)),
      ]));
      count('kept.learned');
    }

    // 3. the diary: WYRD's voice when it's talking about its own day
    final diary = await DiaryEntry.db.find(session, orderBy: (d) => d.id);
    for (final d in diary) {
      final text = d.content.trim();
      if (text.length < 80) {
        count('dropped.diary');
        continue;
      }
      examples.add(TrainingExample('diary', [
        (role: 'system', content: system),
        (role: 'user', content: 'Write your diary entry for ${d.date}.'),
        (role: 'assistant', content: scrub(text)),
      ]));
      count('kept.diary');
    }

    // a stable split: an example lands in validation by a hash of its content, so re-exports agree
    final train = <TrainingExample>[], validation = <TrainingExample>[];
    for (final e in examples) {
      (_bucket(e.toJsonLine()) < 5 ? validation : train).add(e);
    }
    stats['train'] = train.length;
    stats['validation'] = validation.length;
    return TrainingSet(train, validation, stats);
  }

  /// Why a turn can't teach WYRD's voice, or null when it can.
  static String? rejectReason(ConversationTurn t) {
    final user = t.userText.trim(), bot = t.botText.trim();
    if (t.rating == -1) return 'rated_down';
    if (t.judgement != null && t.judgement != 'pass') return 'failed_judgement';
    if (user.length < 2 || bot.length < 20) return 'too_short';
    if (bot.length > 1500) return 'too_long'; // long answers are files and documents: Claude's job
    if (bot.contains('```') || _codeAsk.hasMatch(user)) return 'code';
    if (_toolTalk.hasMatch(bot) || user.startsWith('[')) return 'tools';
    if (LlmService.isDenialReply(bot)) return 'denial';
    if (_secret.hasMatch(user) || _secret.hasMatch(bot)) return 'secret';
    if (_personal(user)) return 'personal';
    return null;
  }

  /// Removes what identifies anyone: emails, phone numbers, long digit runs, links with parameters.
  static String scrub(String s) => s
      .replaceAll(_email, '[email]')
      .replaceAll(_phone, '[phone]')
      .replaceAll(_url, '[link]')
      .replaceAll(_digits, '[number]')
      .trim();

  static bool _personal(String s) => _personalRe.hasMatch(s);

  static String _norm(String s) => s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();

  static int _bucket(String s) {
    var h = 0;
    for (final c in s.codeUnits) {
      h = (h * 31 + c) & 0x7fffffff;
    }
    return h % 100;
  }

  static final _email = RegExp(r'\b[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}\b');
  static final _phone = RegExp(r'(?<!\w)\+?\d[\d\s().\-]{7,}\d(?!\w)');
  static final _url = RegExp(r'https?://\S+\?\S+');
  static final _digits = RegExp(r'\b\d{9,}\b');
  static final _secret = RegExp(r'(sk-[A-Za-z0-9_\-]{16,}|pa-[A-Za-z0-9_\-]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN|eyJ[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}\.)|\bpassword\b', caseSensitive: false);
  static final _personalRe = RegExp(
    r"\b(my (name|email|phone|number|address|password|pin|bank|account|card|salary|diagnosis|doctor)|i live (at|in|on)|i'?m \d{1,2} years|i am \d{1,2} years|my (wife|husband|girlfriend|boyfriend|son|daughter|mum|mom|dad)\b)",
    caseSensitive: false,
  );
  static final _codeAsk = RegExp(r'\b(write|fix|debug|refactor) (me )?(a |the |some |this )?(code|function|script|program|bug)\b|\b(python|javascript|typescript|dart|sql|html|css)\b.*\b(code|function|error)\b', caseSensitive: false);
  static final _toolTalk = RegExp(r'\b(I(?:\x27ve| have) (opened|put|queued)|on your desk|on the globe|flight (planned|queued))\b', caseSensitive: false);
}
