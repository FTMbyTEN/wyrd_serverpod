import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';

/// TASKS, as in the main app (TasksOverlay.tsx): give WYRD something to work on -- once, hourly,
/// daily or weekly -- and follow what it's doing; open a task for its full report, and answer it
/// when it asks before acting. The server runs every task (agent/agent_service.dart).
class TasksScreen extends StatefulWidget {
  final bool embedded; // inside a glass panel: no page header
  const TasksScreen({super.key, this.embedded = false});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

const _examples = [
  'News on gold and BTC this week, with prices and what moved them',
  'Every morning, check the news for drone delivery regulations in Nigeria and tell me what changed',
  'Compare the three cheapest solar inverters available in Lagos, with prices and sources',
];

class _TasksScreenState extends State<TasksScreen> {
  List<AgentTask> _tasks = [];
  bool _loading = true;
  String _filter = 'ALL';
  int? _every; // hours; null = once
  final _goal = TextEditingController();
  bool _starting = false;
  String? _error;
  AgentTask? _open;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _load();
    // a working task changes as it goes: look again every few seconds
    _poll = Timer.periodic(const Duration(seconds: 6), (_) => _load());
  }

  @override
  void dispose() {
    _poll?.cancel();
    _goal.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final ts = await client.agent.mine();
      if (!mounted) return;
      setState(() {
        _tasks = ts;
        if (_open != null) {
          _open = ts.where((t) => t.id == _open!.id).firstOrNull ?? _open;
        }
      });
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _start() async {
    final goal = _goal.text.trim();
    if (goal.length < 8 || _starting) return;
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      final t = await client.agent.create(goal, _every);
      _goal.clear();
      _every = null;
      await _load();
      // straight to the new task, to watch it work, as in the main app
      if (mounted) setState(() => _open = t);
    } catch (e) {
      // the server says why (too short, today's limit, too many routines): show its words
      final m = e is ServerpodClientException ? e.message : e.toString();
      if (mounted) {
        setState(
          () => _error =
              m
                  .replaceFirst(
                    RegExp(r'^(Exception|ServerpodClientException):s*'),
                    '',
                  )
                  .trim()
                  .isEmpty
              ? "Couldn't start that task just now."
              : m.replaceFirst(
                  RegExp(r'^(Exception|ServerpodClientException):s*'),
                  '',
                ),
        );
      }
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  bool _working(AgentTask t) => t.status == 'running' || t.status == 'queued';
  bool _needsYou(AgentTask t) => t.status == 'waiting_approval';

  List<AgentTask> get _shown => switch (_filter) {
    'NEEDS YOU' => _tasks.where(_needsYou).toList(),
    'ROUTINES' => _tasks.where((t) => t.everyHours != null).toList(),
    'DONE' => _tasks.where((t) => t.status == 'done').toList(),
    _ => _tasks,
  };

  @override
  Widget build(BuildContext context) {
    final working = _tasks.where(_working).length;
    final body = _body();
    if (widget.embedded) return body;
    return Scaffold(
      backgroundColor: WyrdColors.bg,
      appBar: AppBar(
        backgroundColor: WyrdColors.barBg,
        surfaceTintColor: Colors.transparent,
        foregroundColor: WyrdColors.mint,
        titleSpacing: 0,
        title: Row(
          children: [
            Icon(Icons.auto_awesome_outlined, color: WyrdColors.signal),
            const SizedBox(width: 10),
            Text('>_ TASKS', style: WyrdText.display(fontSize: 26)),
          ],
        ),
      ),
      body: body,
    );
  }

  Widget _body() {
    final working = _tasks.where(_working).length;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: _open != null
            ? _TaskDetail(
                task: _open!,
                onBack: () => setState(() => _open = null),
                onChanged: _load,
              )
            : _loading
            ? Center(
                child: CircularProgressIndicator(color: WyrdColors.signal),
              )
            : ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Row(
                    children: [
                      Text('TASKS', style: WyrdText.display(fontSize: 30)),
                      const Spacer(),
                      if (working > 0)
                        _badge('$working WORKING', WyrdColors.signal),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _composer(),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _error!,
                        style: WyrdText.mono(
                          fontSize: 12,
                          color: WyrdColors.danger,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  for (final e in _examples)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _goal.text = e),
                        child: Text(
                          '↳ $e',
                          style: WyrdText.mono(
                            fontSize: 11.5,
                            color: WyrdColors.signal,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (final f in [
                        'ALL',
                        'NEEDS YOU',
                        'ROUTINES',
                        'DONE',
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () => setState(() => _filter = f),
                            child: Text(
                              '$f ${switch (f) {
                                'NEEDS YOU' => _tasks.where(_needsYou).length,
                                'ROUTINES' => _tasks.where((t) => t.everyHours != null).length,
                                'DONE' => _tasks.where((t) => t.status == 'done').length,
                                _ => _tasks.length,
                              }}',
                              style: WyrdText.mono(
                                fontSize: 10.5,
                                color: _filter == f
                                    ? WyrdColors.signal
                                    : WyrdColors.greenDim,
                              ).copyWith(letterSpacing: 1.2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_shown.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Nothing here yet. Give WYRD something to work on above.',
                        textAlign: TextAlign.center,
                        style: WyrdText.mono(
                          fontSize: 12,
                          color: WyrdColors.greenDim,
                        ),
                      ),
                    ),
                  for (final t in _shown) _card(t),
                ],
              ),
      ),
    );
  }

  Widget _composer() => Container(
    padding: const EdgeInsets.all(12),
    decoration: wyrdCard(radius: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _goal,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _start(),
          minLines: 2,
          maxLines: 5,
          style: WyrdText.mono(fontSize: 13.5),
          decoration: InputDecoration(
            hintText: 'Give WYRD something to work on…',
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintStyle: WyrdText.mono(
              fontSize: 13.5,
              color: WyrdColors.greenDim,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final (label, hours) in const [
              ('ONCE', null),
              ('HOURLY', 1),
              ('DAILY', 24),
              ('WEEKLY', 168),
            ])
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _every = hours),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _every == hours
                          ? WyrdColors.green
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: WyrdColors.greenBorder),
                    ),
                    child: Text(
                      label,
                      style: WyrdText.mono(
                        fontSize: 10,
                        color: _every == hours
                            ? WyrdColors.bg
                            : WyrdColors.greenDim,
                      ).copyWith(letterSpacing: 1.2),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _start,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: WyrdColors.signal.withValues(
                    alpha: _goal.text.trim().length < 8 ? 0.45 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _starting ? '…' : 'START',
                  style: WyrdText.mono(
                    fontSize: 11,
                    color: WyrdColors.onSignal,
                  ).copyWith(letterSpacing: 1.6),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _card(AgentTask t) {
    final (label, colour) = _statusOf(t);
    final preview = (t.result ?? t.notes ?? '')
        .replaceAll(RegExp(r'[#*_`>]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          setState(() => _open = t);
          if (t.unread) client.agent.markRead(t.id!).ignore();
        },
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: wyrdCard(
            radius: 18,
            border: _needsYou(t) ? WyrdColors.ochre : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _badge(label, colour),
                  const SizedBox(width: 8),
                  Text(
                    _working(t)
                        ? 'step ${t.stepsUsed} of ${t.maxSteps}'
                        : _date(t.lastRunAt ?? t.updatedAt),
                    style: WyrdText.mono(
                      fontSize: 10.5,
                      color: WyrdColors.greenDim,
                    ),
                  ),
                  if (t.unread) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: WyrdColors.signal,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                t.goal,
                style: WyrdText.mono(fontSize: 13.5).copyWith(height: 1.4),
              ),
              if (_working(t)) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: t.maxSteps == 0
                        ? null
                        : (t.stepsUsed / t.maxSteps).clamp(0.05, 1.0),
                    minHeight: 3,
                    backgroundColor: WyrdColors.greenBorderDim,
                    valueColor: AlwaysStoppedAnimation(WyrdColors.signal),
                  ),
                ),
              ],
              if (preview.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: WyrdText.mono(
                    fontSize: 11.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(height: 1.5),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

(String, Color) _statusOf(AgentTask t) => switch (t.status) {
  'running' || 'queued' => ('WORKING', WyrdColors.signal),
  'waiting_approval' => ('NEEDS YOU', WyrdColors.ochre),
  'scheduled' => ('ROUTINE', WyrdColors.indigo),
  'done' => ('DONE', WyrdColors.palm),
  'failed' => ('FAILED', WyrdColors.danger),
  'cancelled' => ('STOPPED', WyrdColors.greenDim),
  _ => (t.status.toUpperCase(), WyrdColors.greenDim),
};

Widget _badge(String text, Color colour) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
  decoration: BoxDecoration(
    color: colour,
    borderRadius: BorderRadius.circular(999),
  ),
  child: Text(
    text,
    style: WyrdText.mono(
      fontSize: 9.5,
      color: WyrdColors.onSignal,
    ).copyWith(letterSpacing: 1.2),
  ),
);

String _date(DateTime t) {
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
  final l = t.toLocal();
  return '${m[l.month - 1]} ${l.day}';
}

/// One task: its status, its full report, and -- while it waits -- the action it wants to take,
/// with Approve and Decline.
class _TaskDetail extends StatelessWidget {
  final AgentTask task;
  final VoidCallback onBack;
  final Future<void> Function() onChanged;
  const _TaskDetail({
    required this.task,
    required this.onBack,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = task;
    final (label, colour) = _statusOf(t);
    String? pending;
    if (t.pendingAction != null) {
      try {
        final a = jsonDecode(t.pendingAction!) as Map<String, dynamic>;
        pending =
            (a['summary'] ?? a['description'] ?? a['action'] ?? t.pendingAction)
                .toString();
      } catch (_) {
        pending = t.pendingAction;
      }
    }
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: wyrdCard(radius: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onBack,
                child: Text(
                  '‹ ALL TASKS',
                  style: WyrdText.mono(
                    fontSize: 11,
                    color: WyrdColors.signal,
                  ).copyWith(letterSpacing: 1.6),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _badge(label, colour),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      t.lastRunAt == null
                          ? 'started ${_date(t.createdAt)}'
                          : 'last run ${_date(t.lastRunAt!)} · ${t.runs} ${t.runs == 1 ? 'run' : 'runs'}',
                      style: WyrdText.mono(
                        fontSize: 10.5,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                t.goal,
                style: WyrdText.display(fontSize: 30).copyWith(height: 1.1),
              ),
              if (pending != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: WyrdColors.ochre.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: WyrdColors.ochre),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WYRD WANTS TO',
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: WyrdColors.ochre,
                        ).copyWith(letterSpacing: 1.6),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pending,
                        style: WyrdText.mono(
                          fontSize: 13,
                        ).copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () async {
                              await client.agent.decide(t.id!, true);
                              await onChanged();
                            },
                            child: const Text('APPROVE'),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () async {
                              await client.agent.decide(t.id!, false);
                              await onChanged();
                            },
                            child: const Text('DECLINE'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Text(
                'REPORT',
                style: WyrdText.mono(
                  fontSize: 10,
                  color: WyrdColors.signal,
                ).copyWith(letterSpacing: 1.8),
              ),
              const SizedBox(height: 8),
              if ((t.result ?? '').isEmpty)
                Text(
                  t.status == 'running' || t.status == 'queued'
                      ? 'WYRD is working on it — step ${t.stepsUsed} of ${t.maxSteps}.'
                      : 'No report yet.',
                  style: WyrdText.mono(
                    fontSize: 12.5,
                    color: WyrdColors.greenDim,
                  ),
                )
              else
                ..._markdown(t.result!),
              const SizedBox(height: 18),
              Row(
                children: [
                  if (t.status == 'running' ||
                      t.status == 'queued' ||
                      t.status == 'scheduled' ||
                      t.status == 'waiting_approval')
                    TextButton(
                      onPressed: () async {
                        await client.agent.cancel(t.id!);
                        await onChanged();
                      },
                      child: Text(
                        'STOP',
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.danger,
                        ),
                      ),
                    ),
                  if (t.status != 'running' && t.status != 'queued')
                    TextButton(
                      onPressed: () async {
                        await client.agent.runNow(t.id!);
                        await onChanged();
                      },
                      child: Text(
                        'RUN AGAIN',
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.signal,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A report's markdown, the way the main app shows it: headings, bullets, numbered lists, bold.
List<Widget> _markdown(String md) {
  final out = <Widget>[];
  for (final raw in md.split('\n')) {
    final line = raw.trimRight();
    if (line.trim().isEmpty) {
      out.add(const SizedBox(height: 8));
      continue;
    }
    final h = RegExp(r'^(#{1,4})\s+(.*)$').firstMatch(line);
    if (h != null) {
      out.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            h.group(2)!.replaceAll('**', ''),
            style: WyrdText.mono(
              fontSize: h.group(1)!.length <= 2 ? 15 : 13.5,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      );
      continue;
    }
    final bullet = RegExp(r'^\s*[-*•]\s+(.*)$').firstMatch(line);
    final number = RegExp(r'^\s*(\d+)[.)]\s+(.*)$').firstMatch(line);
    final lead = bullet != null
        ? '·'
        : number != null
        ? '${number.group(1)}.'
        : null;
    final text = bullet?.group(1) ?? number?.group(2) ?? line;
    final body = Text.rich(
      TextSpan(children: _inline(text)),
      style: WyrdText.mono(fontSize: 13).copyWith(height: 1.6),
    );
    out.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: lead == null
            ? body
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                    child: Text(
                      lead,
                      style: WyrdText.mono(
                        fontSize: 13,
                        color: WyrdColors.greenDim,
                      ).copyWith(height: 1.6),
                    ),
                  ),
                  Expanded(child: body),
                ],
              ),
      ),
    );
  }
  return out;
}

List<TextSpan> _inline(String s) {
  final spans = <TextSpan>[];
  final parts = s.split('**');
  for (var i = 0; i < parts.length; i++) {
    if (parts[i].isEmpty) continue;
    spans.add(
      TextSpan(
        text: parts[i],
        style: i.isOdd ? const TextStyle(fontWeight: FontWeight.bold) : null,
      ),
    );
  }
  return spans;
}
