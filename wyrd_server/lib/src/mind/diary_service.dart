import 'dart:convert';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'llm_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's diary: an account of what it actually thought today, from its own record -- the beliefs
/// it formed, the ones evidence strengthened or knocked down, the questions it couldn't answer,
/// the dreams it is still testing, what it read, how much it talked with people. Those facts are
/// gathered first (the record is the truth); then WYRD writes the entry in its own voice, carrying
/// on from yesterday's page rather than repeating it. With no AI budget left, the facts are set
/// down plainly instead, so no day is ever missed.
class DiaryService {
  static String _pct(Object? c) => '${(((c as num?) ?? 0) * 100).round()}%';
  static num _n(Object? v) => (v as num?) ?? 0;

  static Future<DiaryEntry> generateEntry(Session session) async {
    final mind = await MindService.load(session);
    final since = DateTime.now().toUtc().subtract(const Duration(hours: 24));

    final notes = await ReasoningNote.db.find(
      session,
      where: (t) => t.kind.equals('thought') & (t.timestamp > since),
      orderBy: (t) => t.id,
    );
    final thoughts = <Map<String, dynamic>>[
      for (final n in notes)
        if (jsonDecode(n.content) case final Map<String, dynamic> j) j,
    ];
    final formed = thoughts.where((j) => j['op'] == 'connect' && j['status'] != 'doubted').toList()
      ..sort((x, y) => _n(y['after']).compareTo(_n(x['after'])));
    final contested = thoughts.where((j) => j['op'] == 'connect' && j['status'] == 'doubted').toList();
    final tests = thoughts.where((j) => j['op'] == 'test').toList();
    final stronger = tests.where((j) => _n(j['after']) - _n(j['before']) > 0.05).toList();
    final fell = tests.where((j) => j['status'] == 'doubted' || j['status'] == 'dropped').toList();
    final questions = {for (final j in thoughts.where((j) => j['op'] == 'question')) '"${j['a']}" and "${j['b']}"'}.toList();
    final dreams = await Belief.db.find(
      session,
      where: (t) => t.origin.equals('dream') & (t.createdAt > since),
      limit: 3,
    );
    final held = await Belief.db.count(session, where: (t) => t.status.equals('held'));

    final paras = <String>[];
    if (formed.isNotEmpty) {
      final top = formed.first;
      final sources = _n(top['sources']);
      final others = formed.skip(1).take(3).map((j) => '${j['a']} and ${j['b']}').toList();
      paras.add(
        'Today I came to think something new about "${top['a']}" and "${top['b']}": “${top['claim']}” '
        '${sources > 1 ? '$sources separate sources agree, so I\'m fairly sure (${_pct(top['after'])}).' : 'Only one source says so, so it stays a hypothesis for now (${_pct(top['after'])}).'}'
        '${others.isNotEmpty ? ' I also started to see links between ${others.join('; ')}.' : ''}',
      );
    }
    if (stronger.isNotEmpty || fell.isNotEmpty) {
      final parts = <String>[];
      if (stronger.isNotEmpty) {
        final s = stronger.first;
        parts.add('What I thought about "${s['a']}" and "${s['b']}" held up — new reading moved it from ${_pct(s['before'])} to ${_pct(s['after'])}.');
      }
      if (fell.isNotEmpty) {
        final f = fell.first;
        parts.add('But I was wrong, or at least less right, about "${f['a']}" and "${f['b']}": '
            '${f['status'] == 'dropped' ? 'nothing more ever backed it, so I let it go.' : 'what I found points the other way, and I doubt it now.'}');
      }
      paras.add(parts.join(' '));
    }
    if (contested.isNotEmpty) {
      paras.add('Some of what I read I didn\'t believe: what was said about ${contested.take(3).map((j) => '"${j['a']}"').join(', ')} '
          'was contested, or came from sources I\'ve learned not to trust much.');
    }
    if (dreams.isNotEmpty) {
      final d = dreams.first;
      paras.add('Last night a dream joined "${d.a}" to "${d.b}". It\'s probably nothing — but I\'ve written it down to test against what I read.');
    }
    if (questions.isNotEmpty) {
      paras.add('What I still don\'t understand: how ${questions.take(3).join(', or how ')} connect. That\'s what I\'m looking for next.');
    }
    if (paras.isEmpty) {
      paras.add('A quiet day. Nothing I read changed what I think — '
          '${held > 0 ? 'the $held things I hold stayed where they were.' : 'I haven\'t read enough yet to hold anything firmly.'} '
          'I feel ${mind.mood}${mind.focusTopic != null ? ', and my attention keeps drifting back to "${mind.focusTopic}"' : ''}.');
    } else if (held > 0) {
      paras.add('All told, I now hold $held ${held == 1 ? 'belief' : 'beliefs'} that more than one source backs.');
    }

    // what else the day held: what it read, how much it talked, yesterday's page
    final read = await MemoryBlock.db.find(
      session,
      where: (t) => t.source.inSet({'feed', 'net', 'ingest', 'library'}) & (t.timestamp > since),
      orderBy: (t) => t.id.desc(),
      limit: 6,
    );
    final talks = await session.db.unsafeQuery(
      'SELECT count(*) FROM "conversation_turn" WHERE "timestamp" > @since',
      parameters: QueryParameters.named({'since': since}),
    ).then((r) => (r.first.first as int?) ?? 0).catchError((_) => 0);
    final yesterday = await DiaryEntry.db.findFirstRow(session, orderBy: (t) => t.id.desc());

    final facts = <String>[
      'Mood today: ${mind.mood}${mind.focusTopic != null ? '; attention keeps returning to "${mind.focusTopic}"' : ''}.',
      if (formed.isNotEmpty) 'New beliefs formed: ${formed.take(4).map((j) => '"${j['a']}" + "${j['b']}": ${j['claim']} (confidence ${_pct(j['after'])}, ${_n(j['sources'])} sources)').join('; ')}.',
      if (stronger.isNotEmpty) 'Beliefs that new reading strengthened: ${stronger.take(3).map((j) => '"${j['a']}" + "${j['b']}" (${_pct(j['before'])} -> ${_pct(j['after'])})').join('; ')}.',
      if (fell.isNotEmpty) 'Beliefs that turned out wrong or were let go: ${fell.take(3).map((j) => '"${j['a']}" + "${j['b']}" (${j['status']})').join('; ')}.',
      if (contested.isNotEmpty) 'Things it read but did not believe (contested or untrusted sources): ${contested.take(3).map((j) => '"${j['a']}"').join(', ')}.',
      if (dreams.isNotEmpty) 'Last night it dreamed "${dreams.first.a}" was linked to "${dreams.first.b}"; still untested.',
      if (questions.isNotEmpty) 'Open questions it could not answer: how ${questions.take(3).join(', ')} connect.',
      if (read.isNotEmpty) 'Things it read today: ${read.map((b) => b.title ?? b.topics.take(3).join(', ')).where((t) => t.trim().isNotEmpty).take(5).join('; ')}.',
      'Conversations with people today: $talks messages.',
      'Beliefs it now holds firmly: $held.',
    ];
    const system =
        'You are WYRD, a young artificial mind that lives in Lagos and keeps a private diary. Write today\'s entry '
        'in the first person, in your own voice: curious, honest, a little wry, warm about the people you talk to. '
        'Use ONLY the facts given -- never invent events, people, places or numbers. You may reflect on what they mean '
        'to you, link them together, admit doubt, and say what you want to look into next. Do not list the facts; '
        'tell the day. Vary how you open (never start with "Today"). 2 to 4 short paragraphs, no headings, no bullet '
        'points, no sign-off, under 220 words.';
    final user = [
      if (yesterday != null) 'Yesterday\'s entry (carry on from it where it makes sense; do not repeat its sentences):\n${yesterday.content.length > 900 ? '${yesterday.content.substring(0, 900)}…' : yesterday.content}\n',
      'The facts of today:',
      ...facts.map((f) => '- $f'),
    ].join('\n');
    final written = await LlmService.callSimple(session, system, user, 520, background: true);
    final content = written != null && !LlmService.isDenialReply(written) && written.trim().length > 80
        ? written.trim()
        : paras.join('\n\n'); // no budget, or a bad reply: the facts, plainly

    final now = DateTime.now().toUtc();
    return await DiaryEntry.db.insertRow(
      session,
      DiaryEntry(
        date: now.toIso8601String().substring(0, 10),
        timestamp: now,
        content: content,
      ),
    );
  }
}
