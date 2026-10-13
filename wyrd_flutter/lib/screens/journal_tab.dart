import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';

/// JOURNAL, as in the main app (JournalTab.tsx): "What WYRD lived today" -- a masthead, folder tabs
/// for its Diary, Dreams, Reasoning and Feed; the diary as a page of lined paper with a red margin
/// and punched holes, beside twelve weeks of entries and an index; WYRD writes one entry a day.
class JournalTab extends StatefulWidget {
  const JournalTab({super.key});

  @override
  State<JournalTab> createState() => _JournalTabState();
}

const _months = [
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
const _longMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
const _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class _JournalTabState extends State<JournalTab> {
  List<DiaryEntry> _diary = [];
  List<DreamEntry> _dreams = [];
  List<ReasoningNote> _notes = [];
  List<FeedIngest> _feed = [];
  Mind? _mind;
  bool _loading = true;
  int _tab = 0;
  int _selected = 0; // index into _diary (newest first)

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    Future<T?> safe<T>(Future<T> f) =>
        f.then<T?>((v) => v).catchError((_) => null);
    final r = await Future.wait<Object?>([
      safe(client.diary.getEntries(limit: 120)),
      safe(client.dream.getEntries(limit: 40)),
      safe(client.reasoning.getNotes(limit: 60)),
      safe(client.feed.getRecent()),
      safe(client.mind.getMind()),
    ]);
    if (!mounted) return;
    setState(() {
      _diary = ((r[0] as List<DiaryEntry>?) ?? [])
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      _dreams = ((r[1] as List<DreamEntry>?) ?? [])
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      _notes = ((r[2] as List<ReasoningNote>?) ?? [])
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      _feed = (r[3] as List<FeedIngest>?) ?? [];
      _mind = r[4] as Mind?;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    final now = DateTime.now();
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          'JOURNAL',
          style: WyrdText.mono(
            fontSize: 10,
            color: WyrdColors.signal,
          ).copyWith(letterSpacing: 2),
        ),
        Text('What WYRD lived today', style: WyrdText.display(fontSize: 36)),
        const SizedBox(height: 8),
        Container(height: 2, color: WyrdColors.green),
        const SizedBox(height: 2),
        Container(height: 1, color: WyrdColors.green),
        const SizedBox(height: 6),
        DefaultTextStyle(
          style: WyrdText.mono(
            fontSize: 9.5,
            color: WyrdColors.greenDim,
          ).copyWith(letterSpacing: 1.4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VOL. 1 · NO. ${_diary.length}'),
                    const Text('A MIND, KEPT IN ITS OWN WORDS'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_days[now.weekday - 1].toUpperCase()}, ${_longMonths[now.month - 1].toUpperCase()} ${now.day}, ${now.year}',
                  ),
                  Text(
                    'MOOD · ${(_mind?.mood ?? '—').toUpperCase()}${_mind?.focusTopic == null ? '' : ' · THINKING ABOUT ${_mind!.focusTopic!.toUpperCase()}'}',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(height: 1, color: WyrdColors.greenBorder),
        const SizedBox(height: 18),
        _folderTabs(),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: WyrdColors.card,
            border: Border.all(color: WyrdColors.greenBorder),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: _loading
              ? Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: CircularProgressIndicator(color: WyrdColors.signal),
                  ),
                )
              : switch (_tab) {
                  0 => _diaryView(wide),
                  1 => _dreamsView(),
                  2 => _notesView(),
                  _ => _feedView(),
                },
        ),
      ],
    );
  }

  Widget _folderTabs() {
    final tabs = [
      (Icons.edit_outlined, 'DIARY', _diary.length),
      (Icons.nightlight_outlined, 'DREAMS', _dreams.length),
      (Icons.account_tree_outlined, 'REASONING', _notes.length),
      (Icons.rss_feed, 'FEED', _feed.length),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < tabs.length; i++)
            GestureDetector(
              onTap: () => setState(() => _tab = i),
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: i == _tab ? 12 : 9,
                ),
                decoration: BoxDecoration(
                  color: i == _tab ? WyrdColors.card : WyrdColors.sand,
                  border: Border(
                    top: BorderSide(
                      color: i == _tab
                          ? WyrdColors.signal
                          : WyrdColors.greenBorderDim,
                    ),
                    left: BorderSide(
                      color: i == _tab
                          ? WyrdColors.signal
                          : WyrdColors.greenBorderDim,
                    ),
                    right: BorderSide(
                      color: i == _tab
                          ? WyrdColors.signal
                          : WyrdColors.greenBorderDim,
                    ),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      tabs[i].$1,
                      size: 15,
                      color: i == _tab ? WyrdColors.mint : WyrdColors.greenDim,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tabs[i].$2,
                      style: WyrdText.mono(
                        fontSize: 10.5,
                        color: i == _tab
                            ? WyrdColors.mint
                            : WyrdColors.greenDim,
                      ).copyWith(letterSpacing: 1.6),
                    ),
                    if (i == _tab && tabs[i].$3 > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: WyrdColors.signal,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${tabs[i].$3}',
                          style: WyrdText.mono(
                            fontSize: 9,
                            color: WyrdColors.onSignal,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ---- the diary ----------------------------------------------------------------------------

  Widget _diaryView(bool wide) {
    if (_diary.isEmpty)
      return _empty(
        'No diary entry yet — WYRD writes one each day once it has lived a little.',
      );
    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_heatmap(), const SizedBox(height: 16), _index()],
    );
    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _dayStrip(),
        const SizedBox(height: 12),
        _paper(_diary[_selected]),
      ],
    );
    return wide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 240, child: left),
              const SizedBox(width: 18),
              Expanded(child: right),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [right, const SizedBox(height: 18), left],
          );
  }

  Set<String> get _entryDays => {
    for (final e in _diary) _key(e.timestamp.toLocal()),
  };
  static String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';

  int get _streak {
    final days = _entryDays;
    var d = DateTime.now();
    var n = 0;
    if (!days.contains(_key(d))) d = d.subtract(const Duration(days: 1));
    while (days.contains(_key(d))) {
      n++;
      d = d.subtract(const Duration(days: 1));
    }
    return n;
  }

  /// Twelve weeks of entries, a square a day (columns are weeks, rows Monday to Sunday).
  Widget _heatmap() {
    final days = _entryDays;
    final today = DateTime.now();
    final start = today.subtract(Duration(days: 7 * 11 + today.weekday - 1));
    final sel = _key(_diary[_selected].timestamp.toLocal());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'THE LAST 12 WEEKS',
              style: WyrdText.mono(
                fontSize: 9,
                color: WyrdColors.greenDim,
              ).copyWith(letterSpacing: 1.4),
            ),
            const Spacer(),
            Text(
              '$_streak-DAY STREAK',
              style: WyrdText.mono(
                fontSize: 9,
                color: WyrdColors.greenDim,
              ).copyWith(letterSpacing: 1.4),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 12 / 7,
          child: Row(
            children: [
              for (var w = 0; w < 12; w++)
                Expanded(
                  child: Column(
                    children: [
                      for (var d = 0; d < 7; d++)
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              final day = start.add(Duration(days: w * 7 + d));
                              final k = _key(day);
                              final future = day.isAfter(today);
                              return Container(
                                margin: const EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  color: future
                                      ? Colors.transparent
                                      : k == sel
                                      ? WyrdColors.signal
                                      : days.contains(k)
                                      ? const Color(0xFFE8A88A)
                                      : WyrdColors.greenBorderDim,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            for (final (c, l) in [
              (WyrdColors.greenBorderDim, 'no entry'),
              (const Color(0xFFE8A88A), 'an entry'),
              (WyrdColors.signal, 'reading'),
            ]) ...[
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(color: c, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              Text(
                l,
                style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim),
              ),
              const SizedBox(width: 10),
            ],
          ],
        ),
      ],
    );
  }

  Widget _index() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'INDEX · ${_diary.length} ENTRIES',
        style: WyrdText.mono(
          fontSize: 9,
          color: WyrdColors.greenDim,
        ).copyWith(letterSpacing: 1.4),
      ),
      const SizedBox(height: 6),
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _diary.length,
          itemBuilder: (_, i) {
            final e = _diary[i];
            final on = i == _selected;
            final t = e.timestamp.toLocal();
            return GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: on ? WyrdColors.signal : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: WyrdColors.greenBorderDim),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      child: Text(
                        '${_months[t.month - 1].toUpperCase()} ${t.day.toString().padLeft(2, '0')}',
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: on ? WyrdColors.onSignal : WyrdColors.greenDim,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.content.split('\n').first,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: WyrdText.serif().copyWith(
                          fontSize: 13.5,
                          color: on ? WyrdColors.onSignal : WyrdColors.mint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );

  /// The last seven entries as days to pick from; the open one lit.
  Widget _dayStrip() {
    final n = _diary.length < 7 ? _diary.length : 7;
    final shown = _diary.take(n).toList().reversed.toList();
    return Row(
      children: [
        for (final e in shown)
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selected = _diary.indexOf(e)),
              child: Builder(
                builder: (_) {
                  final on = _diary.indexOf(e) == _selected;
                  final t = e.timestamp.toLocal();
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: on
                          ? WyrdColors.indigo.withValues(
                              alpha: WyrdColors.dark ? 0.9 : 1,
                            )
                          : WyrdColors.bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: on ? WyrdColors.indigo : WyrdColors.greenBorder,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _days[t.weekday - 1].substring(0, 3),
                          style: WyrdText.mono(
                            fontSize: 10,
                            color: on
                                ? (WyrdColors.dark
                                      ? WyrdColors.bg
                                      : WyrdColors.onSignal)
                                : WyrdColors.greenDim,
                          ),
                        ),
                        Text(
                          '${t.day}',
                          style: WyrdText.display(
                            fontSize: 24,
                            color: on
                                ? (WyrdColors.dark
                                      ? WyrdColors.bg
                                      : WyrdColors.onSignal)
                                : WyrdColors.mint,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  /// An entry on lined paper: a red margin, punched holes, the date and a "№" stamp, a drop cap.
  Widget _paper(DiaryEntry e) {
    final t = e.timestamp.toLocal();
    final no = _diary.length - _diary.indexOf(e);
    final text = e.content.trim();
    return Container(
      decoration: BoxDecoration(
        color: WyrdColors.dark
            ? const Color(0xFF221C17)
            : const Color(0xFFFDFBF6),
        border: Border.all(color: WyrdColors.greenBorderDim),
        boxShadow: [
          BoxShadow(
            color: WyrdColors.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _LinedPaper(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(72, 20, 22, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _days[t.weekday - 1].toUpperCase(),
                          style: WyrdText.mono(
                            fontSize: 9.5,
                            color: WyrdColors.greenDim,
                          ).copyWith(letterSpacing: 1.6),
                        ),
                        Text(
                          '${_longMonths[t.month - 1]} ${t.day}, ${t.year}',
                          style: WyrdText.display(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: 0.06,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: WyrdColors.green, width: 1.2),
                      ),
                      child: Column(
                        children: [
                          Text('№ $no', style: WyrdText.mono(fontSize: 13)),
                          Text(
                            '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}',
                            style: WyrdText.mono(
                              fontSize: 8.5,
                              color: WyrdColors.greenDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (text.isNotEmpty)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: text.substring(0, 1),
                        style: WyrdText.serif().copyWith(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: WyrdColors.mint,
                          height: 1,
                        ),
                      ),
                      TextSpan(text: text.substring(1)),
                    ],
                  ),
                  style: WyrdText.serif().copyWith(
                    fontSize: 16.5,
                    height: 1.45,
                    color: WyrdColors.mint,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- dreams, reasoning, feed ----------------------------------------------------------------

  Widget _dreamsView() {
    if (_dreams.isEmpty)
      return _empty(
        'No dreams yet — they only surface after a real idle stretch.',
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final d in _dreams.take(30))
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            decoration: BoxDecoration(
              color: WyrdColors.indigo.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(color: WyrdColors.indigo, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _stamp(d.timestamp),
                  style: WyrdText.mono(
                    fontSize: 9.5,
                    color: WyrdColors.indigo,
                  ).copyWith(letterSpacing: 1.4),
                ),
                const SizedBox(height: 6),
                Text(
                  d.content,
                  style: WyrdText.serif().copyWith(
                    fontSize: 15.5,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    color: WyrdColors.mint,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _notesView() {
    if (_notes.isEmpty) return _empty('No reasoning yet.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final n in _notes.take(40))
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: WyrdColors.greenBorderDim),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2, right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: WyrdColors.signalSoft,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    n.kind.toUpperCase(),
                    style: WyrdText.mono(
                      fontSize: 8.5,
                      color: WyrdColors.signal,
                    ).copyWith(letterSpacing: 1.2),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n.content,
                        style: WyrdText.mono(
                          fontSize: 12.5,
                        ).copyWith(height: 1.5),
                      ),
                      Text(
                        _stamp(n.timestamp),
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: WyrdColors.greenDim,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _feedView() {
    if (_feed.isEmpty) return _empty('Nothing read yet.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final f in _feed.take(40))
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: WyrdColors.greenBorderDim),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      f.feedSource.toUpperCase(),
                      style: WyrdText.mono(
                        fontSize: 9,
                        color: WyrdColors.signal,
                      ).copyWith(letterSpacing: 1.4),
                    ),
                    const Spacer(),
                    Text(
                      _stamp(f.timestamp),
                      style: WyrdText.mono(
                        fontSize: 9,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  f.title,
                  style: WyrdText.serif().copyWith(
                    fontSize: 15,
                    height: 1.4,
                    color: WyrdColors.mint,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _empty(String text) => Padding(
    padding: const EdgeInsets.all(30),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: WyrdText.mono(
        fontSize: 12,
        color: WyrdColors.greenDim,
      ).copyWith(height: 1.5),
    ),
  );

  static String _stamp(DateTime t) {
    final l = t.toLocal();
    return '${_months[l.month - 1].toUpperCase()} ${l.day} · ${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }
}

/// Ruled lines, a red margin and three punched holes, under the diary page.
class _LinedPaper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final line = Paint()
      ..color = WyrdColors.greenBorderDim
      ..strokeWidth = 1;
    for (var y = 96.0; y < s.height - 8; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(s.width, y), line);
    }
    final margin = Paint()
      ..color = const Color(0xFFD9534F).withValues(alpha: 0.55)
      ..strokeWidth = 1.2;
    canvas.drawLine(const Offset(58, 0), Offset(58, s.height), margin);
    canvas.drawLine(const Offset(62, 0), Offset(62, s.height), margin);
    final hole = Paint()..color = WyrdColors.bg;
    final rim = Paint()
      ..color = WyrdColors.greenBorder
      ..style = PaintingStyle.stroke;
    for (final f in [0.18, 0.5, 0.82]) {
      final c = Offset(26, s.height * f);
      canvas.drawCircle(c, 7, hole);
      canvas.drawCircle(c, 7, rim);
    }
  }

  @override
  bool shouldRepaint(_LinedPaper old) => false;
}
