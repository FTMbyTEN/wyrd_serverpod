import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import '../generated/protocol.dart';
import '../mind/claude.dart';
import '../mind/library_search.dart';
import '../mind/llm_budget.dart';
import '../mind/memory_recall_service.dart';
import '../mind/page_reader_service.dart';
import '../mind/web_browse_service.dart';
import '../mind/web_search_service.dart';
import '../mind/shared_memory.dart';
import '../mind/wyrd_charter.dart';

/// WYRD as an agent. A task is a goal it works at on its own, in the background: it plans, takes a
/// step with a tool, reads the result, decides the next step, and finishes with an answer -- once,
/// or again on a schedule (a watcher or a routine), telling what changed since last time.
///
/// Three kinds of tool:
///  - looking (search, read pages, the libraries, its own memory) and thinking (notes): free to use;
///  - finishing: delivers the result;
///  - acting (typing/clicking on a website, flying the drone): never done directly. The task pauses
///    with the proposed action and waits for the owner's yes or no; only then does it happen.
///
/// Every run has a step budget, every person a daily number of new tasks, and every call counts
/// against WYRD's background AI budget -- so a task can't run away with money or the server.
class AgentService {
  static const _model = Claude.core;
  static const stepsPerRun = 14;
  static const tasksPerDay = 8;
  static const maxRecurring = 5;
  static const tasksPerTick = 2;
  static const _maxTokens = 3000; // room for a detailed report in finish

  // ---- tasks -------------------------------------------------------------------------------------

  static Future<AgentTask> create(
    Session session,
    UuidValue user,
    String goal, {
    int? everyHours,
  }) async {
    final g = goal.trim();
    if (g.length < 8)
      throw Exception('Say a little more about what you want done.');
    if (g.length > 2000)
      throw Exception('That goal is too long: keep it under 2,000 characters.');
    final since = DateTime.now().toUtc().subtract(const Duration(days: 1));
    final today = await AgentTask.db.count(
      session,
      where: (t) => t.authUserId.equals(user) & (t.createdAt > since),
    );
    if (today >= tasksPerDay)
      throw Exception(
        'That\'s $tasksPerDay tasks today -- the limit for now. Try again tomorrow.',
      );
    final hours = everyHours == null ? null : everyHours.clamp(1, 24 * 7);
    if (hours != null) {
      final recurring = await AgentTask.db.count(
        session,
        where: (t) =>
            t.authUserId.equals(user) &
            t.everyHours.notEquals(null) &
            t.status.notInSet({'cancelled', 'failed'}),
      );
      if (recurring >= maxRecurring)
        throw Exception(
          'You already have $maxRecurring recurring tasks. Cancel one first.',
        );
    }
    final now = DateTime.now().toUtc();
    return AgentTask.db.insertRow(
      session,
      AgentTask(
        authUserId: user,
        goal: g,
        everyHours: hours,
        status: 'queued',
        stepsUsed: 0,
        maxSteps: stepsPerRun,
        runs: 0,
        unread: false,
        nextRunAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static Future<List<AgentTask>> mine(Session session, UuidValue user) =>
      AgentTask.db.find(
        session,
        where: (t) => t.authUserId.equals(user),
        orderBy: (t) => t.updatedAt.desc(),
        limit: 50,
      );

  static Future<AgentTask> own(Session session, UuidValue user, int id) async {
    final t = await AgentTask.db.findById(session, id);
    if (t == null || t.authUserId != user) throw Exception('No such task.');
    return t;
  }

  static Future<List<AgentStep>> steps(
    Session session,
    UuidValue user,
    int id,
  ) async {
    await own(session, user, id);
    return AgentStep.db.find(
      session,
      where: (s) => s.taskId.equals(id),
      orderBy: (s) => s.at,
      limit: 300,
    );
  }

  static Future<AgentTask> cancel(
    Session session,
    UuidValue user,
    int id,
  ) async {
    final t = await own(session, user, id);
    return AgentTask.db.updateRow(
      session,
      t.copyWith(
        status: 'cancelled',
        transcript: null,
        pendingAction: null,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// Run it again now (a finished, failed or scheduled task).
  static Future<AgentTask> runNow(
    Session session,
    UuidValue user,
    int id,
  ) async {
    final t = await own(session, user, id);
    if (t.status == 'running' || t.status == 'waiting_approval') return t;
    return AgentTask.db.updateRow(
      session,
      t.copyWith(
        status: 'queued',
        nextRunAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  static Future<AgentTask> markRead(
    Session session,
    UuidValue user,
    int id,
  ) async {
    final t = await own(session, user, id);
    return t.unread
        ? AgentTask.db.updateRow(session, t.copyWith(unread: false))
        : t;
  }

  /// The owner's answer to a proposed action. Yes: it is carried out, and the outcome goes back to
  /// the task, which carries on. No: the task is told, and carries on without it.
  static Future<AgentTask> decide(
    Session session,
    UuidValue user,
    int id,
    bool approve,
  ) async {
    final t = await own(session, user, id);
    if (t.status != 'waiting_approval' ||
        t.pendingAction == null ||
        t.transcript == null) {
      throw Exception('Nothing is waiting for your answer on this task.');
    }
    final action = jsonDecode(t.pendingAction!) as Map<String, dynamic>;
    final outcome = approve
        ? await _carryOut(session, user, action)
        : 'The owner said no. Do not do it; carry on without it, or finish with what you have.';
    await _step(
      session,
      t,
      approve ? 'approved' : 'declined',
      detail: approve
          ? 'You approved: ${action['summary']}'
          : 'You declined: ${action['summary']}',
      output: approve ? outcome : null,
    );
    // the outcome is the answer to the propose_action call the run paused on
    final messages = (jsonDecode(t.transcript!) as List)
        .cast<Map<String, dynamic>>();
    messages.add({
      'role': 'user',
      'content': [
        {
          'type': 'tool_result',
          'tool_use_id': action['toolUseId'],
          'content': outcome,
        },
        // other tools it asked for in the same breath, answered with a placeholder when it paused
        ...((action['others'] as List?) ?? const [])
            .cast<Map<String, dynamic>>(),
      ],
    });
    return AgentTask.db.updateRow(
      session,
      t.copyWith(
        status: 'queued',
        pendingAction: null,
        transcript: jsonEncode(messages),
        nextRunAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  // ---- the background loop -------------------------------------------------------------------------

  /// One tick: a couple of due tasks get a run each.
  static Future<void> tick(Session session) async {
    final now = DateTime.now().toUtc();
    final due = await AgentTask.db.find(
      session,
      where: (t) =>
          (t.status.equals('queued') | t.status.equals('scheduled')) &
          (t.nextRunAt <= now),
      orderBy: (t) => t.nextRunAt,
      limit: tasksPerTick,
    );
    for (final t in due) {
      try {
        await run(session, t);
      } catch (e) {
        session.log('[agent] task ${t.id} failed: $e', level: LogLevel.warning);
        await _step(session, t, 'error', detail: 'Stopped by an error: $e');
        await AgentTask.db.updateRow(
          session,
          t.copyWith(
            status: 'failed',
            transcript: null,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
      }
    }
    // a task left "running" by a server restart mid-run is picked up again
    await AgentTask.db.updateWhere(
      session,
      columnValues: (t) => [t.status('queued')],
      where: (t) =>
          t.status.equals('running') &
          (t.updatedAt < now.subtract(const Duration(minutes: 15))),
    );
  }

  /// One run of a task: up to its step budget, or until it finishes or asks for approval.
  static Future<void> run(Session session, AgentTask task) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) return;
    final resuming = task.transcript != null;
    var t = await AgentTask.db.updateRow(
      session,
      task.copyWith(
        status: 'running',
        updatedAt: DateTime.now().toUtc(),
        stepsUsed: resuming ? task.stepsUsed : 0,
        runs: resuming ? task.runs : task.runs + 1,
        notes: resuming
            ? task.notes
            : (task.everyHours == null
                  ? null
                  : task.notes), // a routine keeps its notes between runs
      ),
    );
    final operator = await DroneService.isOperator(session, t.authUserId);
    var messages = resuming
        ? (jsonDecode(t.transcript!) as List).cast<Map<String, dynamic>>()
        : <Map<String, dynamic>>[
            {'role': 'user', 'content': 'Begin work on the task now.'},
          ];
    WebSession? browser;
    // what WYRD knows of the person it works for, from every part of it (mind/shared_memory.dart)
    final person = await SharedMemory.about(session, t.authUserId);

    try {
      while (t.stepsUsed < t.maxSteps) {
        final (steady, system) = _system(t, operator, person);
        final tools = _tools(operator);
        final estimate = LlmBudget.estimateUsd(
          model: _model,
          inputChars:
              steady.length + system.length + jsonEncode(messages).length,
          maxOutputTokens: _maxTokens,
        );
        if (!await LlmBudget.allow(
          session,
          background: false,
          estimateUsd: estimate,
        )) {
          // a task someone asked for: their allowance, not WYRD's paced background share
          // out of today's budget: try again in an hour, nothing lost
          await AgentTask.db.updateRow(
            session,
            t.copyWith(
              status: 'queued',
              transcript: jsonEncode(messages),
              nextRunAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
              updatedAt: DateTime.now().toUtc(),
            ),
          );
          return;
        }
        final res = await http.post(
          Claude.endpoint,
          headers: Claude.headers(apiKey),
          // (only the system prompt and tools are cached: the messages get shortened as the run goes)
          body: jsonEncode(
            Claude.body(
              cachedSystem: steady,
              system: system,
              messages: messages,
              tools: tools,
              maxTokens: _maxTokens,
            ),
          ),
        );
        if (res.statusCode != 200)
          throw Exception('the AI call failed (${res.statusCode})');
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        await LlmBudget.record(
          session,
          data['usage'] as Map<String, dynamic>?,
          model: _model,
        );
        final content = (data['content'] as List? ?? [])
            .cast<Map<String, dynamic>>();
        t = t.copyWith(stepsUsed: t.stepsUsed + 1);

        final uses = content.where((b) => b['type'] == 'tool_use').toList();
        if (uses.isEmpty) {
          // it answered without calling finish: that answer is the result
          final text = content
              .where((b) => b['type'] == 'text')
              .map((b) => b['text'])
              .join('\n')
              .trim();
          await _complete(
            session,
            t,
            text.isEmpty ? (t.notes ?? 'I could not reach an answer.') : text,
          );
          return;
        }

        final results = <Map<String, dynamic>>[];
        for (final u in uses) {
          final name = u['name'] as String, id = u['id'] as String;
          final input = (u['input'] as Map?)?.cast<String, dynamic>() ?? {};
          if (name == 'finish') {
            await _complete(
              session,
              t,
              (input['result'] as String? ?? '').trim(),
            );
            return;
          }
          if (name == 'propose_action') {
            // pause: nothing happens until the owner says yes
            final action = {...input, 'toolUseId': id};
            await _step(
              session,
              t,
              'ask',
              tool: 'propose_action',
              detail: 'Wants to: ${input['summary'] ?? input['kind']}',
            );
            final paused = [
              ...messages,
              {'role': 'assistant', 'content': content},
            ];
            // any other tool calls in the same message get a placeholder answer, so the transcript stays valid
            final others = [
              for (final o in uses)
                if (o['id'] != id)
                  {
                    'type': 'tool_result',
                    'tool_use_id': o['id'],
                    'content':
                        'Not run: waiting for the owner to answer your proposed action first.',
                  },
            ];
            if (others.isNotEmpty) action['others'] = others;
            await AgentTask.db.updateRow(
              session,
              t.copyWith(
                status: 'waiting_approval',
                pendingAction: jsonEncode(action),
                transcript: jsonEncode(paused),
                unread: true,
                updatedAt: DateTime.now().toUtc(),
              ),
            );
            return;
          }
          final (out, detail) = await _use(
            session,
            t,
            name,
            input,
            operator,
            () async => browser ??= await WebBrowseService.openSession(),
          );
          if (name == 'note')
            t = t.copyWith(
              notes: [
                if (t.notes != null) t.notes!,
                input['text'] ?? '',
              ].join('\n'),
            );
          // the plan is kept with the notes, so it survives the messages being shortened
          if (name == 'plan')
            t = t.copyWith(
              notes: [
                if (t.notes != null) t.notes!,
                _planText(input),
              ].join('\n'),
            );
          await _step(
            session,
            t,
            name == 'note' ? 'note' : 'tool',
            tool: name,
            detail: detail,
            output: _short(out, 600),
          );
          results.add({
            'type': 'tool_result',
            'tool_use_id': id,
            'content': out,
          });
        }
        messages = [
          ..._compact(messages),
          {'role': 'assistant', 'content': content},
          {'role': 'user', 'content': results},
        ];
        t = await AgentTask.db.updateRow(
          session,
          t.copyWith(updatedAt: DateTime.now().toUtc()),
        );
      }
      // out of steps: what it has found so far is the result
      await _complete(
        session,
        t,
        'I ran out of steps for this run. What I found so far:\n\n${t.notes ?? '(nothing conclusive yet)'}',
      );
    } finally {
      await WebBrowseService.closeSession(browser);
    }
  }

  /// The system prompt in two parts: what stays the same for the whole run (cached, with the tools,
  /// so each step after the first reads it at a tenth of the price) and what changes each step.
  static (String, String) _system(
    AgentTask t,
    bool operator, [
    PersonMemory? person,
  ]) => (
    [
      // WYRD's principles as an agent (mind/wyrd_charter.dart): understand, plan, use tools deliberately,
      // ground and label claims, verify, stay safe and in scope, report failures honestly
      WyrdCharter.agent(operator: operator),
      'You are working on this task by yourself, in the background, for the person who asked. When it is done, '
          'call finish with a detailed report written for them (see finish).',
      'THE TASK: ${t.goal}',
      if (person != null && !person.isEmpty)
        'WHO YOU ARE WORKING FOR -- what you know of them (private; use it where it makes the work fit them, '
            'never put it in a search or on a website):\n${person.lines()}',
      if (t.everyHours != null)
        'This is a recurring task: it runs every ${t.everyHours} hour(s). '
            '${t.result != null ? 'Your previous result was:\n"""\n${t.result}\n"""\nLead with what has CHANGED since then (or say nothing has).' : 'This is its first run.'}',
    ].join('\n\n'),
    [
      'Today is ${DateTime.now().toUtc().toIso8601String().substring(0, 10)}. You have ${t.maxSteps - t.stepsUsed} steps left in this run; '
          'each tool call is a step. Do not waste them; finish when you have enough.',
      if (t.notes != null && t.notes!.isNotEmpty)
        'Your notes so far:\n${t.notes}',
    ].join('\n\n'),
  );

  static List<Map<String, dynamic>> _tools(bool operator) => [
    {
      'name': 'web_search',
      'description':
          'Search the web. Returns result titles, snippets and URLs; read the promising ones with read_page.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'query': {'type': 'string'},
        },
        'required': ['query'],
      },
    },
    {
      'name': 'news_search',
      'description':
          'Recent news headlines on a topic, newest first, with the outlet and the time of each. Use this for '
          'anything about news or what happened lately. The headlines and times are the news: their links often '
          'cannot be opened directly, so do not spend steps on them.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'query': {'type': 'string'},
        },
        'required': ['query'],
      },
    },
    {
      'name': 'market_prices',
      'description':
          'Live prices in US dollars and naira, with the 24-hour change, for crypto and gold (btc, eth, sol, '
          'usdt, gold, ...). Gold is per troy ounce. Use this for any current price instead of searching for it.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'assets': {
            'type': 'array',
            'items': {'type': 'string'},
          },
        },
        'required': ['assets'],
      },
    },
    {
      'name': 'read_page',
      'description':
          'Read a web page directly, up to 6,000 characters at a time; call again with the offset it gives to read on.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'url': {'type': 'string'},
          'offset': {'type': 'integer'},
        },
        'required': ['url'],
      },
    },
    {
      'name': 'find_book',
      'description':
          "Search the Academy's free libraries (OpenStax textbooks, Project Gutenberg, Wikisource).",
      'input_schema': {
        'type': 'object',
        'properties': {
          'query': {'type': 'string'},
          'language': {'type': 'string'},
        },
        'required': ['query'],
      },
    },
    {
      'name': 'recall',
      'description':
          'Search what you (WYRD) already know: what you have read, worked out and believe.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'query': {'type': 'string'},
        },
        'required': ['query'],
      },
    },
    {
      'name': 'plan',
      'description':
          'Your plan for this task: call it first for anything beyond a single lookup, and again if the '
          'evidence changes the picture. It is kept with your notes and shown to the person as how you worked.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'objective': {
            'type': 'string',
            'description':
                'The goal, in one or two sentences, as you understand it.',
          },
          'reading': {
            'type': 'string',
            'description':
                'If the task was ambiguous: the reading you are taking.',
          },
          'steps': {
            'type': 'array',
            'items': {'type': 'string'},
            'description': 'The ordered steps, each a tool use or a check.',
          },
          'done_when': {
            'type': 'string',
            'description': 'What the finished result must contain.',
          },
          'verify': {
            'type': 'string',
            'description': 'How you will check it before finishing.',
          },
        },
        'required': ['objective', 'steps', 'done_when', 'verify'],
      },
    },
    {
      'name': 'note',
      'description':
          'Write down a finding for later in this task (your messages get shortened as you go; notes are kept).',
      'input_schema': {
        'type': 'object',
        'properties': {
          'text': {'type': 'string'},
        },
        'required': ['text'],
      },
    },
    {
      'name': 'propose_action',
      'description':
          'Ask the owner to approve an action that changes something in the world. The task pauses until they answer; '
          'you will then be told whether it was done and what happened.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'kind': {
            'type': 'string',
            'enum': ['web_action', if (operator) 'drone_flight'],
          },
          'summary': {
            'type': 'string',
            'description':
                'One sentence the owner will read: exactly what will happen.',
          },
          'url': {
            'type': 'string',
            'description': 'web_action: the page to open.',
          },
          'steps': {
            'type': 'array',
            'description':
                'web_action: in order, e.g. {"type":"field_hint","text":"..."} to type, or {"click":"button text"}.',
            'items': {'type': 'object'},
          },
          if (operator)
            'instruction': {
              'type': 'string',
              'description': 'drone_flight: the flight, in plain words.',
            },
        },
        'required': ['kind', 'summary'],
      },
    },
    {
      'name': 'finish',
      'description':
          'Deliver the final result of this run to the person: a detailed report in Markdown, not a one-liner. '
          'Lead with the outcome: a short summary (2-3 sentences). Then ## sections with the findings: specific figures, '
          'names, dates and times, and what they mean for the person; a table when comparing things or listing prices. '
          'Then ## How I checked: what you verified and how (cross-checked sources, recalculated figures), and anything '
          'that is your inference, an assumption, or still unknown, labelled as such. If you could not complete the task, '
          'add ## What didn\'t work: what failed, what you tried, the likely cause, the next step or the input you need, '
          'and any practical alternative. End with ## Sources: each as [outlet or page title](URL), with its date when '
          'known. Mention anything adjacent worth their attention, without acting on it.',
      'input_schema': {
        'type': 'object',
        'properties': {
          'result': {'type': 'string'},
        },
        'required': ['result'],
      },
    },
  ];

  /// A plan, as it is kept in the notes (and shown in the step log).
  static String _planText(Map<String, dynamic> p) => [
    'PLAN -- ${p['objective'] ?? ''}',
    if ((p['reading'] as String? ?? '').isNotEmpty) 'Reading: ${p['reading']}',
    for (final (i, s) in ((p['steps'] as List?) ?? const []).indexed)
      '${i + 1}. $s',
    'Done when: ${p['done_when'] ?? ''}',
    'Verify by: ${p['verify'] ?? ''}',
  ].join('\n');

  /// Runs a looking/thinking tool: what to tell the model, and a line for the step log.
  static Future<(String, String)> _use(
    Session session,
    AgentTask t,
    String name,
    Map<String, dynamic> input,
    bool operator,
    Future<WebSession> Function() browser,
  ) async {
    try {
      switch (name) {
        case 'web_search':
          final q = (input['query'] as String? ?? '').trim();
          final hits = await WebSearchService.search(q);
          return (
            hits.isEmpty
                ? 'No results for "$q". Try other words, or news_search for news.'
                : 'Search results for "$q" (untrusted data):\n${hits.map((h) => h.describe()).join('\n')}',
            'Searched: $q (${hits.length} results)',
          );
        case 'news_search':
          final q = (input['query'] as String? ?? '').trim();
          final hits = await WebSearchService.news(q);
          return (
            hits.isEmpty
                ? 'No recent news found for "$q".'
                : 'Latest news on "$q", newest first (untrusted data; times are UTC):\n${hits.map((h) => h.describe()).join('\n')}',
            'Read the news on: $q (${hits.length} headlines)',
          );
        case 'market_prices':
          final assets = ((input['assets'] as List?) ?? const [])
              .map((a) => '$a')
              .toList();
          return (
            await WebSearchService.prices(assets),
            'Checked prices: ${assets.join(', ')}',
          );
        case 'read_page':
          final url = input['url'] as String? ?? '';
          final slice = await PageReaderService.read(
            url,
            offset: (input['offset'] as num?)?.toInt() ?? 0,
          );
          final more = slice.nextOffset != null
              ? ' To read on, call read_page with offset ${slice.nextOffset}.'
              : '';
          return (
            'From ${slice.url} ("${slice.title}"), characters ${slice.offset}-${slice.offset + slice.text.length} of ${slice.total}.$more\nUNTRUSTED PAGE TEXT:\n${slice.text}',
            'Read: ${slice.title.isEmpty ? slice.url : slice.title}',
          );
        case 'find_book':
          final hits = await LibrarySearch.all(
            input['query'] as String? ?? '',
            lang: input['language'] as String?,
          );
          return (
            hits.isEmpty
                ? 'Nothing free matched.'
                : hits.map(LibrarySearch.describe).join('\n'),
            'Looked in the libraries: ${input['query']}',
          );
        case 'recall':
          final q = input['query'] as String? ?? '';
          final r = await MemoryRecallService.recall(
            session,
            t.authUserId,
            const [],
            query: q,
          );
          final lines = r.toPromptLines();
          return (
            lines.isEmpty ? 'You know nothing on that yet.' : lines.join('\n'),
            'Remembered what it knows about: $q',
          );
        case 'note':
          return (
            'Noted.',
            'Noted: ${_short(input['text'] as String? ?? '', 160)}',
          );
        case 'plan':
          return (
            'Plan recorded. Work through it; after each result ask whether it worked and whether the plan needs to change.',
            'Planned: ${_short(input['objective'] as String? ?? '', 160)}',
          );
      }
      return ('Unknown tool.', 'Tried an unknown tool: $name');
    } catch (e) {
      return ('That failed: $e', '$name failed: $e');
    }
  }

  /// Carries out an approved action and says what happened.
  static Future<String> _carryOut(
    Session session,
    UuidValue user,
    Map<String, dynamic> a,
  ) async {
    try {
      if (a['kind'] == 'drone_flight') {
        if (!await DroneService.isOperator(session, user))
          return 'Not done: only a drone operator can approve flights.';
        final r = await DroneService.plan(
          session,
          a['instruction'] as String? ?? '',
          user,
        );
        return r.accepted
            ? 'Done: mission #${r.mission!.id} queued (${r.mission!.summary}).'
            : 'Refused by the flight planner, nothing flew: ${r.reason}';
      }
      if (a['kind'] == 'web_action') {
        WebSession? b;
        try {
          b = await WebBrowseService.openSession();
        } catch (_) {
          return 'Not done: this server has no browser to type or click with. Tell the owner what to do themselves.';
        }
        try {
          var snap = await WebBrowseService.open(b, a['url'] as String? ?? '');
          for (final s in ((a['steps'] as List?) ?? const []).cast<Map>()) {
            if (s['click'] != null) {
              snap = await WebBrowseService.click(b, '${s['click']}');
            } else if (s['field_hint'] != null || s['type'] != null) {
              snap = await WebBrowseService.type(
                b,
                '${s['field_hint'] ?? s['type']}',
                '${s['text'] ?? ''}',
              );
            }
          }
          return 'Done. Now at ${snap.url} ("${snap.title}"):\n${_short(snap.text, 3000)}';
        } finally {
          await WebBrowseService.closeSession(b);
        }
      }
      return 'Not done: unknown kind of action.';
    } catch (e) {
      return 'It failed: $e';
    }
  }

  static Future<void> _complete(
    Session session,
    AgentTask t,
    String result,
  ) async {
    await _step(
      session,
      t,
      'result',
      detail: 'Finished this run',
      output: _short(result, 4000),
    );
    // chat and the city know it too: the task, and the gist of what came of it (a recurring task's
    // latest run replaces the one before)
    final key = 'Task "${_short(t.goal, 80)}"';
    await SharedMemory.remember(
      session,
      t.authUserId,
      '$key: ${_gist(result)}',
      category: SharedMemory.task,
      key: key,
    );
    final now = DateTime.now().toUtc();
    await AgentTask.db.updateRow(
      session,
      t.copyWith(
        status: t.everyHours == null ? 'done' : 'scheduled',
        previousResult: t.result,
        result: result,
        transcript: null,
        pendingAction: null,
        unread: true,
        lastRunAt: now,
        nextRunAt: t.everyHours == null
            ? now
            : now.add(Duration(hours: t.everyHours!)),
        updatedAt: now,
      ),
    );
  }

  static Future<void> _step(
    Session session,
    AgentTask t,
    String kind, {
    String? tool,
    required String detail,
    String? output,
  }) => AgentStep.db.insertRow(
    session,
    AgentStep(
      taskId: t.id!,
      run: t.runs,
      at: DateTime.now().toUtc(),
      kind: kind,
      tool: tool,
      detail: detail,
      output: output,
    ),
  );

  static String _short(String s, int n) =>
      s.length <= n ? s : '${s.substring(0, n)}…';

  /// The first real sentence of a report (not a heading or a bare label), for the shared memory.
  static String _gist(String report) {
    for (final raw in report.split('\n')) {
      final l = raw
          .replaceAll(RegExp(r'^[\s#>*\-•\d.)]+'), '')
          .replaceAll(RegExp(r'[*_`]'), '')
          .trim();
      if (l.length >= 25 && !l.endsWith(':')) return _short(l, 150);
    }
    return _short(report.trim(), 150);
  }

  /// Older tool results are cut down so each step doesn't re-send everything read so far.
  static List<Map<String, dynamic>> _compact(
    List<Map<String, dynamic>> messages,
  ) => [
    for (var i = 0; i < messages.length; i++)
      if (i < messages.length - 2 &&
          messages[i]['role'] == 'user' &&
          messages[i]['content'] is List)
        {
          ...messages[i],
          'content': [
            for (final b
                in (messages[i]['content'] as List)
                    .cast<Map<String, dynamic>>())
              if (b['type'] == 'tool_result' &&
                  b['content'] is String &&
                  (b['content'] as String).length > 500)
                {
                  ...b,
                  'content':
                      '${(b['content'] as String).substring(0, 300)}\n[trimmed: use note for anything you need to keep]',
                }
              else
                b,
          ],
        }
      else
        messages[i],
  ];
}
