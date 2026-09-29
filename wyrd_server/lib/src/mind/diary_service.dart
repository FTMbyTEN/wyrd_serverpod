import 'dart:convert';

import '../generated/protocol.dart';
import 'mind_service.dart';
import 'package:serverpod/serverpod.dart';

/// WYRD's diary: an account of what it actually thought today, written from its own record --
/// the beliefs it formed, the ones evidence strengthened or knocked down, the questions it
/// couldn't answer, the dreams it is still testing. It used to hand dashboard numbers to an LLM
/// to narrate, which read like anyone's diary; this reads like its own, and needs no API.
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

    final now = DateTime.now().toUtc();
    return await DiaryEntry.db.insertRow(
      session,
      DiaryEntry(
        date: now.toIso8601String().substring(0, 10),
        timestamp: now,
        content: paras.join('\n\n'),
      ),
    );
  }
}
