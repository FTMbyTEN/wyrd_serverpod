import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'user_fact_service.dart';

/// One memory of each person, shared by every part of WYRD. Chat (Dialogue Link), the task agent
/// and the city (NAIJA 2099's Authority) used to keep their own: chat its facts, a task only its own
/// result, the city its notes on a citizen -- so WYRD in one place didn't know what it had learned
/// or done for the same person in another.
///
/// It lives in the person's profile facts (so the You tab shows it, the data export carries it and
/// deleting the account removes it), each tagged by what it is:
///  - things they said about themselves -- picked out of chat automatically, or [told] to WYRD on
///    purpose ("remember that...");
///  - things that happened between them and WYRD: a [task] finished, a [city] mission done.
/// [about] puts it together, with what's going on now (their open tasks, their standing in the
/// city), for whichever part of WYRD is answering them.
class SharedMemory {
  /// told to WYRD on purpose ("remember: my sister's birthday is...")
  static const told = 'told';

  /// a task WYRD finished for them
  static const task = 'task';

  /// something they did in NAIJA 2099
  static const city = 'city';

  static const _events = {task, city};
  static const _maxEvents = 24;

  static bool isEvent(UserFact f) => _events.contains(f.category);

  /// Remembers [text] about this person. A [told] fact that's already known is reinforced rather
  /// than repeated. An event with the same [key] as an earlier one (a recurring task's latest run)
  /// replaces it. Returns false when there was nothing to keep.
  static Future<bool> remember(
    Session session,
    UuidValue user,
    String text, {
    String category = told,
    String? key,
  }) async {
    final t = _clip(text.trim().replaceAll(RegExp(r'\s+'), ' '), 240);
    if (t.length < 3) return false;
    final now = DateTime.now().toUtc();
    final fact = UserFact(
      text: t,
      category: category,
      timestamp: now,
      lastMentioned: now,
    );
    if (!_events.contains(category)) {
      await UserFactService.addFacts(session, user, [fact]);
      return true;
    }
    final profile = await UserFactService.loadOrCreateProfile(session, user);
    var facts = [
      for (final f in profile.facts)
        if (!(key != null && isEvent(f) && f.text.startsWith(key))) f,
      fact,
    ];
    final events = facts.where(isEvent).toList();
    if (events.length > _maxEvents) {
      final drop = events.take(events.length - _maxEvents).toSet();
      facts = facts.where((f) => !drop.contains(f)).toList();
    }
    await UserProfile.db.updateRow(session, profile.copyWith(facts: facts));
    return true;
  }

  /// Forgets what matches [what]: at least half the words of it that mean something ("my sister's
  /// birthday" finds "Their sister Adaeze turns 30 on 4 November"). Returns what it forgot.
  static Future<List<String>> forget(
    Session session,
    UuidValue user,
    String what,
  ) async {
    final words = _words(what);
    if (words.isEmpty) return const [];
    final profile = await UserFactService.loadOrCreateProfile(session, user);
    final gone = <String>[];
    final kept = <UserFact>[];
    for (final f in profile.facts) {
      final has = _words(f.text);
      if (words.where(has.contains).length * 2 >= words.length) {
        gone.add(f.text);
      } else {
        kept.add(f);
      }
    }
    if (gone.isNotEmpty) {
      await UserProfile.db.updateRow(session, profile.copyWith(facts: kept));
    }
    return gone;
  }

  /// Everything WYRD knows of this person, from every part of it.
  static Future<PersonMemory> about(Session session, UuidValue user) async {
    final profile = await UserFactService.loadOrCreateProfile(session, user);
    final facts = UserFactService.mostRelevantFacts(
      profile.facts.where((f) => !isEvent(f)).toList(),
      15,
    ).map((f) => f.text).toList();
    final events =
        (profile.facts.where(isEvent).toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp)))
            .take(6)
            .map((f) => '${_day(f.timestamp)}: ${f.text}')
            .toList();
    final open = await AgentTask.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(user) &
          t.status.inSet({
            'queued',
            'running',
            'waiting_approval',
            'scheduled',
          }),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 4,
    );
    final c = await WorldCitizen.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(user),
    );
    final callMe = profile.username?.trim();
    return PersonMemory(
      name: callMe == null || callMe.isEmpty ? null : callMe,
      facts: facts,
      events: events,
      tasks: [
        for (final t in open)
          '"${_clip(t.goal, 90)}" -- ${switch (t.status) {
            'waiting_approval' => 'waiting for their yes to an action',
            'scheduled' => 'runs again ${_when(t.nextRunAt)}',
            'running' => 'working on it now',
            _ => 'about to start',
          }}',
      ],
      city: c == null || (c.missionsDone == 0 && c.record == null)
          ? null
          : 'standing ${c.standing}/100, ${c.missionsDone} '
                '${c.missionsDone == 1 ? 'mission' : 'missions'} done'
                '${c.record == null ? '' : '; what you noted of them there: ${_tail(c.record!, 300)}'}',
    );
  }

  static String _day(DateTime t) {
    final d = DateTime.now().toUtc().difference(t).inDays;
    if (d <= 0) return 'today';
    if (d == 1) return 'yesterday';
    if (d < 7) return '$d days ago';
    const m = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${t.day} ${m[t.month - 1]}';
  }

  static String _when(DateTime t) {
    final h = t.difference(DateTime.now().toUtc()).inHours;
    return h <= 0
        ? 'soon'
        : h < 24
        ? 'in about $h h'
        : 'in ${(h / 24).round()} days';
  }

  static const _stop = {
    'the',
    'and',
    'that',
    'this',
    'with',
    'about',
    'what',
    'my',
    'me',
    'you',
    'your',
    'forget',
    'remember',
    'please',
    'for',
    'from',
    'is',
    'are',
    'was',
    'its',
    "it's",
  };
  static Set<String> _words(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r"['’]s\b"), '')
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.length >= 3 && !_stop.contains(w))
      .toSet();

  static String _clip(String s, int n) =>
      s.length <= n ? s : '${s.substring(0, n - 1).trimRight()}…';
  static String _tail(String s, int n) =>
      s.length <= n ? s : '…${s.substring(s.length - n + 1)}';
}

/// Dialogue Link's way to keep or drop something in the shared memory, on the person's word.
class MemoryTools {
  static const rememberTool = {
    'name': 'remember',
    'description':
        'Keep something this person told you about themselves or their life, so you know it in every chat, in '
        'your tasks and in the city: a name, a date, a preference, a plan. Use it when they ask you to remember '
        'something, or tell you something clearly worth keeping. One short self-contained fact per call, written '
        'about them in the third person ("Their sister Adaeze turns 30 on 4 November 2026"), with dates in full.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'fact': {
          'type': 'string',
          'description': 'The fact, short and self-contained.',
        },
      },
      'required': ['fact'],
    },
  };

  static const forgetTool = {
    'name': 'forget',
    'description':
        'Forget something you kept about this person, when they ask you to. Give the words that identify it '
        '("sister birthday").',
    'input_schema': {
      'type': 'object',
      'properties': {
        'what': {'type': 'string'},
      },
      'required': ['what'],
    },
  };

  static const names = {'remember', 'forget'};

  /// Does it, and says what happened, for the model.
  static Future<String> use(
    Session session,
    UuidValue user,
    String name,
    Map<String, dynamic> input,
  ) async {
    if (name == 'forget') {
      final gone = await SharedMemory.forget(
        session,
        user,
        input['what'] as String? ?? '',
      );
      return gone.isEmpty
          ? 'Nothing you keep matched that, so there was nothing to forget. Tell them, and ask what exactly.'
          : 'Forgotten (${gone.length}): ${gone.join(' | ')}';
    }
    final ok = await SharedMemory.remember(
      session,
      user,
      input['fact'] as String? ?? '',
    );
    return ok
        ? 'Kept. You will know this in every chat, your tasks and the city; they can see or delete it in the You tab.'
        : 'Nothing to keep: the fact was empty.';
  }
}

/// What WYRD knows of one person, put together for a prompt.
class PersonMemory {
  const PersonMemory({
    required this.name,
    required this.facts,
    required this.events,
    required this.tasks,
    required this.city,
  });

  final String? name;
  final List<String> facts;
  final List<String> events;
  final List<String> tasks;
  final String? city;

  bool get isEmpty =>
      name == null &&
      facts.isEmpty &&
      events.isEmpty &&
      tasks.isEmpty &&
      city == null;

  /// The prompt block: one memory, whichever part of WYRD is speaking.
  String lines() => [
    if (name != null) 'They want to be called "$name".',
    if (facts.isNotEmpty)
      'What they have told you about themselves: ${facts.join(' | ')}',
    if (events.isNotEmpty)
      'What you have done together lately: ${events.join(' | ')}',
    if (tasks.isNotEmpty)
      'Tasks you are working on for them: ${tasks.join(' | ')}',
    if (city != null)
      'In NAIJA 2099 (the game, where you are its Authority): $city',
  ].join('\n');
}
