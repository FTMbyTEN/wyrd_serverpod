import 'dart:convert';
import 'dart:math';

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
  NeuralNetwork? _network;
  LexiconStats? _lexicon;
  FilterReport? _filter;
  TrustReport? _trust;
  JudgementReport? _judgement;
  bool _loading = true;
  int _tab = 0;
  int _selected = 0; // index into _diary (newest first)
  int _dream = 0; // the dream shown in the sky
  final _stars = <int, List<ConceptExample>>{}; // dream id -> its stars
  int? _star; // the star tapped

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
      safe(client.reasoning.getNetwork(limit: 96)),
      safe(client.lexicon.getStats()),
      safe(client.feed.getFilterReport()),
      safe(client.feed.getTrust()),
      safe(client.feed.getJudgementReport()),
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
      _network = r[5] as NeuralNetwork?;
      _lexicon = r[6] as LexiconStats?;
      _filter = r[7] as FilterReport?;
      _trust = r[8] as TrustReport?;
      _judgement = r[9] as JudgementReport?;
      _loading = false;
    });
    if (_dreams.isNotEmpty) _loadStars(0);
  }

  /// A dream's stars: the memories it was made of.
  Future<void> _loadStars(int i) async {
    final id = _dreams[i].id;
    if (id == null || _stars.containsKey(id)) return;
    try {
      final s = await client.dream.getStars(id);
      if (mounted) setState(() => _stars[id] = s);
    } catch (_) {}
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
              behavior: HitTestBehavior.opaque,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tabs[i].$2,
                          style: WyrdText.mono(
                            fontSize: 10.5,
                            color: i == _tab
                                ? WyrdColors.mint
                                : WyrdColors.greenDim,
                          ).copyWith(letterSpacing: 1.6),
                        ),
                        Text(
                          const [
                            'what WYRD writes each day',
                            'memories recombined at night',
                            'its mind, firing',
                            'everything it takes in',
                          ][i],
                          style: WyrdText.mono(
                            fontSize: 8.5,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                      ],
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

  // ---- dreams: constellations -------------------------------------------------------------

  Widget _panelHead(String title, String blurb) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('>_ $title', style: WyrdText.display(fontSize: 24)),
      const SizedBox(height: 6),
      Text(
        blurb,
        style: WyrdText.mono(
          fontSize: 11.5,
          color: WyrdColors.greenDim,
        ).copyWith(height: 1.5),
      ),
      const SizedBox(height: 14),
    ],
  );

  Widget _dreamsView() {
    if (_dreams.isEmpty) {
      return _empty(
        'No dreams yet — they only surface after a real idle stretch.',
      );
    }
    final d = _dreams[_dream.clamp(0, _dreams.length - 1)];
    final stars = _stars[d.id] ?? const <ConceptExample>[];
    final tapped = _star != null && _star! < stars.length
        ? stars[_star!]
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _panelHead(
          'DREAMS',
          'When nobody has talked to WYRD for a while, memories from far-apart corners of its mind drift together '
              'and it dreams them. Each dream is a constellation: its stars are the memories it was made of. Tap a star '
              'to see where it came from.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 300,
            child: LayoutBuilder(
              builder: (context, box) {
                final pts = _starPoints(stars, box.maxWidth, 300, d.id ?? 0);
                return GestureDetector(
                  onTapDown: (e) {
                    for (var i = 0; i < pts.length; i++) {
                      if ((pts[i] - e.localPosition).distance < 22) {
                        setState(() => _star = i);
                        return;
                      }
                    }
                  },
                  child: CustomPaint(
                    size: Size(box.maxWidth, 300),
                    painter: _Sky(
                      pts,
                      [for (final s in stars) s.title],
                      d.id ?? 0,
                      _star,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'tap a star',
                          style: WyrdText.mono(
                            fontSize: 9.5,
                            color: const Color(0x99FFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (tapped != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: WyrdColors.indigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: WyrdColors.indigo.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A STAR · FROM ${tapped.source.toUpperCase()} · ${_stamp(tapped.timestamp)}',
                  style: WyrdText.mono(
                    fontSize: 9,
                    color: WyrdColors.indigo,
                  ).copyWith(letterSpacing: 1.4),
                ),
                const SizedBox(height: 4),
                Text(tapped.title, style: WyrdText.mono(fontSize: 13)),
                if ((tapped.snippet ?? '').isNotEmpty)
                  Text(
                    tapped.snippet!,
                    style: WyrdText.mono(
                      fontSize: 11.5,
                      color: WyrdColors.greenDim,
                    ).copyWith(height: 1.5),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Text(
          'DREAM · ${_ago(d.timestamp)} · ${stars.length} STARS',
          style: WyrdText.mono(
            fontSize: 9.5,
            color: WyrdColors.greenDim,
          ).copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 6),
        Text(
          d.content,
          style: WyrdText.mono(fontSize: 13).copyWith(
            fontStyle: FontStyle.italic,
            height: 1.75,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'EARLIER DREAMS',
          style: WyrdText.mono(
            fontSize: 9.5,
            color: WyrdColors.greenDim,
          ).copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < _dreams.length && i < 20; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                _dream = i;
                _star = null;
              });
              _loadStars(i);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: WyrdColors.card,
                border: Border.all(
                  color: i == _dream
                      ? WyrdColors.signal
                      : WyrdColors.greenBorderDim,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CustomPaint(painter: _Sky.thumb(_dreams[i].id ?? i)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _ago(_dreams[i].timestamp),
                          style: WyrdText.mono(
                            fontSize: 9,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                        Text(
                          _dreams[i].content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: WyrdText.mono(
                            fontSize: 11.5,
                          ).copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// Where a dream's stars sit in its sky: spread out, the same every time for the same dream.
  static List<Offset> _starPoints(
    List<ConceptExample> stars,
    double w,
    double h,
    int seed,
  ) {
    final rng = Random(seed);
    return [
      for (var i = 0; i < stars.length; i++)
        Offset(
          w * (0.12 + rng.nextDouble() * 0.76),
          h * (0.15 + rng.nextDouble() * 0.7),
        ),
    ];
  }

  // ---- reasoning: the neural network ------------------------------------------------------

  Widget _notesView() {
    final net = _network;
    final firing = _notes.where((n) => n.kind == 'firing').firstOrNull;
    final firedWords = firing == null
        ? const <String>[]
        : _quoted(firing.content);
    Synapse? strongest;
    for (final s in net?.synapses ?? const <Synapse>[]) {
      if (strongest == null || s.weight > strongest.weight) strongest = s;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _panelHead(
          'REASONING',
          'WYRD’s ideas are neurons. Ideas that keep turning up together wire together, and the connection grows '
              'stronger each time. Every 30 seconds one idea fires, and the signal travels along its strongest connections.',
        ),
        LayoutBuilder(
          builder: (context, box) {
            final cols = box.maxWidth >= 640 ? 4 : 2;
            final cards = [
              ('NEURONS', '${net?.neurons.length ?? 0}', 'ideas shown'),
              ('SYNAPSES', '${net?.totalSynapses ?? 0}', 'connections'),
              (
                'STRONGEST LINK',
                strongest == null ? '—' : '${strongest.a} — ${strongest.b}',
                strongest == null
                    ? ''
                    : 'strength ${strongest.weight.toStringAsFixed(2)}',
              ),
              (
                'LAST FIRING',
                firing == null ? '—' : _ago(firing.timestamp),
                firedWords.isEmpty ? '' : 'from "${firedWords.first}"',
              ),
            ];
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.6,
              children: [
                for (final (label, value, sub) in cards)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: WyrdColors.greenBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: WyrdText.mono(
                            fontSize: 8.5,
                            color: WyrdColors.greenDim,
                          ).copyWith(letterSpacing: 1.4),
                        ),
                        Text(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: WyrdText.mono(fontSize: 13),
                        ),
                        Text(
                          sub,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: WyrdText.mono(
                            fontSize: 9.5,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Container(
          height: 380,
          decoration: BoxDecoration(
            border: Border.all(color: WyrdColors.greenBorderDim),
          ),
          child: net == null || net.neurons.isEmpty
              ? _empty('No neurons yet.')
              : LayoutBuilder(
                  builder: (context, box) => CustomPaint(
                    size: Size(box.maxWidth, 380),
                    painter: _Network(net, firedWords.toSet()),
                  ),
                ),
        ),
        const SizedBox(height: 6),
        Text(
          '● neuron = an idea   — synapse = a learned connection (thicker = stronger)   ◉ = the idea that fired last',
          style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim),
        ),
        const SizedBox(height: 18),
        Text(
          'WHAT WYRD HAS BEEN THINKING',
          style: WyrdText.mono(
            fontSize: 9.5,
            color: WyrdColors.greenDim,
          ).copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 8),
        if (_notes.isEmpty) _empty('No thinking yet.'),
        for (final n in _notes.take(30)) _thought(n),
      ],
    );
  }

  static List<String> _quoted(String s) => [
    for (final m in RegExp(r'"([^"]{1,40})"').allMatches(s)) m.group(1)!,
  ];

  Widget _thought(ReasoningNote n) {
    final kind = switch (n.kind) {
      'self' => 'ASKED ITSELF',
      'firing' => 'NEURAL FIRING',
      'sleep' => 'SLEEP',
      'thought' => 'A THOUGHT',
      _ => 'REASONING',
    };
    var text = n.content;
    var words = _quoted(n.content).take(4).toList();
    var question = n.kind == 'self';
    // some notes are kept as data: show their summary and their two ideas, as the main app does
    if (text.trimLeft().startsWith('{')) {
      try {
        final j = jsonDecode(text) as Map<String, dynamic>;
        text = (j['summary'] ?? j['claim'] ?? text).toString();
        words = [
          for (final k in ['a', 'b'])
            if (j[k] is String) j[k] as String,
        ];
        question = j['op'] == 'question' || j['status'] == 'open';
      } catch (_) {}
    }
    final joiner = n.kind == 'firing' ? '→' : '?';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: WyrdColors.greenBorder),
        color: question ? WyrdColors.signalSoft : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$kind · ${_ago(n.timestamp)}',
            style: WyrdText.mono(
              fontSize: 9,
              color: WyrdColors.greenDim,
            ).copyWith(letterSpacing: 1.4),
          ),
          if (words.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (var i = 0; i < words.length; i++) ...[
                  if (i > 0)
                    Text(
                      joiner,
                      style: WyrdText.mono(
                        fontSize: 11,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: WyrdColors.green),
                      color: i == 0 && n.kind == 'firing'
                          ? WyrdColors.green
                          : Colors.transparent,
                    ),
                    child: Text(
                      words[i],
                      style: WyrdText.mono(
                        fontSize: 11,
                        color: i == 0 && n.kind == 'firing'
                            ? WyrdColors.bg
                            : WyrdColors.mint,
                      ),
                    ),
                  ),
                ],
                if (question)
                  Text(
                    'OPEN QUESTION',
                    style: WyrdText.mono(
                      fontSize: 9,
                      color: WyrdColors.greenDim,
                    ).copyWith(letterSpacing: 1.4),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Text(
            text,
            style: WyrdText.mono(fontSize: 12.5).copyWith(height: 1.55),
          ),
        ],
      ),
    );
  }

  // ---- feed: what WYRD takes in -----------------------------------------------------------

  Widget _box(String title, String? note, List<Widget> children) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      border: Border.all(color: WyrdColors.greenBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: WyrdText.mono(
                  fontSize: 9,
                  color: WyrdColors.greenDim,
                ).copyWith(letterSpacing: 1.6),
              ),
            ),
            if (note != null)
              Text(
                note,
                style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim),
              ),
          ],
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    ),
  );

  Widget _bar(
    String label,
    double frac,
    String value, {
    Color? colour,
    double labelWidth = 70,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: labelWidth,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: WyrdText.mono(fontSize: 10.5),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: frac.clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: WyrdColors.greenBorderDim,
              valueColor: AlwaysStoppedAnimation(colour ?? WyrdColors.signal),
            ),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: WyrdText.mono(fontSize: 10, color: WyrdColors.greenDim),
          ),
        ),
      ],
    ),
  );

  Widget _feedView() {
    final lex = _lexicon;
    final f = _filter;
    final t = _trust;
    final j = _judgement;
    final newest = lex?.recentWords.isNotEmpty == true
        ? lex!.recentWords.last
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (lex != null)
          _box('VOCABULARY', null, [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _thousands(lex.learned),
                  style: WyrdText.display(fontSize: 40),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'words understood',
                        style: WyrdText.mono(fontSize: 12),
                      ),
                      Text(
                        '${_thousands(lex.attempted)} looked up',
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
            Container(
              height: 2,
              color: WyrdColors.signal,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            if (newest != null)
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: WyrdColors.green, width: 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          newest.word,
                          style: WyrdText.display(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        if (newest.partOfSpeech != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            color: WyrdColors.green,
                            child: Text(
                              newest.partOfSpeech!.toUpperCase(),
                              style: WyrdText.mono(
                                fontSize: 8,
                                color: WyrdColors.bg,
                              ),
                            ),
                          ),
                        const SizedBox(width: 6),
                        Text(
                          'NEWEST',
                          style: WyrdText.mono(
                            fontSize: 8,
                            color: WyrdColors.greenDim,
                          ),
                        ),
                      ],
                    ),
                    if (newest.definition != null)
                      Text(
                        newest.definition!,
                        style: WyrdText.mono(
                          fontSize: 11.5,
                        ).copyWith(height: 1.5),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (i, w) in lex.recentWords.reversed.take(8).indexed)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: i == 0 ? WyrdColors.signal : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: i == 0
                            ? WyrdColors.signal
                            : WyrdColors.greenBorder,
                      ),
                    ),
                    child: Text(
                      w.word,
                      style: WyrdText.mono(
                        fontSize: 10.5,
                        color: i == 0 ? WyrdColors.onSignal : WyrdColors.mint,
                      ),
                    ),
                  ),
              ],
            ),
          ]),
        if (f != null)
          _box(
            'FILTER · WHAT GETS INTO WYRD’S MEMORY TODAY',
            '${f.kept + f.duplicates + f.quarantined} items looked at',
            [
              Row(
                children: [
                  for (final (n, l) in [
                    (f.kept, 'let in'),
                    (f.duplicates, 'already known, skipped'),
                    (f.quarantined, 'kept out'),
                  ])
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _thousands(n),
                            style: WyrdText.mono(fontSize: 15),
                          ),
                          Text(
                            l,
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
              const SizedBox(height: 8),
              Builder(
                builder: (_) {
                  final total = (f.kept + f.duplicates + f.quarantined).clamp(
                    1,
                    1 << 30,
                  );
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: SizedBox(
                      height: 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (f.kept * 1000 ~/ total).clamp(1, 1000),
                            child: Container(color: WyrdColors.green),
                          ),
                          Expanded(
                            flex: (f.duplicates * 1000 ~/ total).clamp(1, 1000),
                            child: Container(color: WyrdColors.greenBorderDim),
                          ),
                          Expanded(
                            flex: (f.quarantined * 1000 ~/ total).clamp(
                              1,
                              1000,
                            ),
                            child: Container(color: WyrdColors.signal),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (f.categories.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'SORTED INTO',
                  style: WyrdText.mono(
                    fontSize: 8.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(letterSpacing: 1.4),
                ),
                const SizedBox(height: 4),
                Builder(
                  builder: (_) {
                    final cats = f.categories.entries.toList()
                      ..sort((a, b) => b.value.compareTo(a.value));
                    final top = cats.first.value.clamp(1, 1 << 30);
                    return Column(
                      children: [
                        for (final c in cats)
                          _bar(c.key, c.value / top, '${c.value}'),
                      ],
                    );
                  },
                ),
              ],
              if (f.reasons.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  'WHY THINGS WERE KEPT OUT',
                  style: WyrdText.mono(
                    fontSize: 8.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(letterSpacing: 1.4),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final r in f.reasons.entries)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: WyrdColors.greenBorder),
                        ),
                        child: Text(
                          '${r.key} · ${r.value}',
                          style: WyrdText.mono(fontSize: 10),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        if (t != null)
          _box(
            'BIAS 2 · WHAT WYRD HAS LEARNED TO TRUST',
            '${t.tracked} tracked · ${t.evidence.round()} pieces of evidence',
            [
              Text(
                'Built from your thumbs up and down, the filter’s verdicts and corrections. Trusted sources rank higher when WYRD recalls what it '
                'knows; doubted ones have to work harder to get in.',
                style: WyrdText.mono(
                  fontSize: 11,
                  color: WyrdColors.greenDim,
                ).copyWith(height: 1.5),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, box) {
                  Widget list(String title, List<TrustScore> xs, Color c) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: WyrdText.mono(
                              fontSize: 8.5,
                              color: WyrdColors.greenDim,
                            ).copyWith(letterSpacing: 1.4),
                          ),
                          const SizedBox(height: 4),
                          for (final s in xs.take(6))
                            _bar(
                              s.key,
                              s.score,
                              '${(s.score * 100).round()}%',
                              colour: c,
                              labelWidth: 110,
                            ),
                        ],
                      );
                  final a = list(
                    'TRUSTED SOURCES',
                    t.trustedSources,
                    WyrdColors.green,
                  );
                  final b = list(
                    'DOUBTED SOURCES',
                    t.doubtedSources,
                    WyrdColors.signal,
                  );
                  return box.maxWidth >= 640
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: a),
                            const SizedBox(width: 18),
                            Expanded(child: b),
                          ],
                        )
                      : Column(children: [a, const SizedBox(height: 10), b]);
                },
              ),
            ],
          ),
        if (j != null)
          _box(
            'JUDGEMENT · EVERY REPLY CHECKED BEFORE IT GOES OUT',
            '${j.checked} replies this week',
            [
              Text(
                'Is it safe, honest about what it did, and backed by something WYRD knows? Unbacked specifics get a “worth '
                'double-checking” note and aren’t learned; secrets and other people’s details never leave.',
                style: WyrdText.mono(
                  fontSize: 11,
                  color: WyrdColors.greenDim,
                ).copyWith(height: 1.5),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  for (final (n, l) in [
                    (j.passed, 'sent as written'),
                    (j.softened, 'softened'),
                    (j.corrected, 'corrected'),
                    (j.blocked, 'held back'),
                  ])
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$n', style: WyrdText.mono(fontSize: 15)),
                          Text(
                            l,
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
            ],
          ),
        Text(
          'LIVE DATA FEED',
          style: WyrdText.mono(
            fontSize: 9,
            color: WyrdColors.greenDim,
          ).copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 8),
        if (_feed.isEmpty) _empty('Nothing read yet.'),
        for (final item in _feed.take(40))
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: WyrdColors.card,
              border: Border.all(color: WyrdColors.greenBorderDim),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '[${item.feedSource}]',
                      style: WyrdText.mono(
                        fontSize: 9,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _ago(item.timestamp),
                      style: WyrdText.mono(
                        fontSize: 9,
                        color: WyrdColors.greenDim,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item.title,
                  style: WyrdText.mono(fontSize: 12.5).copyWith(height: 1.4),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static String _thousands(int n) => n.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );

  static String _ago(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 1) return '${d.inSeconds}s ago';
    if (d.inHours < 1) return '${d.inMinutes}m ago';
    if (d.inDays < 1) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
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

/// A dream's night sky: a deep indigo glow, faint background stars, and the dream's stars -- its
/// memories -- joined by dotted lines, with their titles.
class _Sky extends CustomPainter {
  final List<Offset> stars;
  final List<String> labels;
  final int seed;
  final int? picked;
  final bool thumbnail;
  _Sky(this.stars, this.labels, this.seed, this.picked) : thumbnail = false;
  _Sky.thumb(this.seed)
    : stars = const [],
      labels = const [],
      picked = null,
      thumbnail = true;

  @override
  void paint(Canvas canvas, Size s) {
    final rect = Offset.zero & s;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.2, 0.3),
          radius: 1.1,
          colors: [Color(0xFF3A3F7A), Color(0xFF1B1D3D), Color(0xFF0B0C18)],
        ).createShader(rect),
    );
    final rng = Random(seed * 7 + 1);
    final dust = Paint()..color = const Color(0x99FFFFFF);
    for (var i = 0; i < (thumbnail ? 14 : 140); i++) {
      canvas.drawCircle(
        Offset(rng.nextDouble() * s.width, rng.nextDouble() * s.height),
        rng.nextDouble() * (thumbnail ? 0.6 : 1.1) + 0.2,
        dust,
      );
    }
    var pts = stars;
    if (thumbnail) {
      final r = Random(seed);
      pts = [
        for (var i = 0; i < 3; i++)
          Offset(
            s.width * (0.15 + r.nextDouble() * 0.7),
            s.height * (0.15 + r.nextDouble() * 0.7),
          ),
      ];
    }
    // the dotted lines between the dream's stars
    final line = Paint()
      ..color = const Color(0x88FFFFFF)
      ..strokeWidth = thumbnail ? 0.6 : 1;
    for (var i = 0; i + 1 < pts.length; i++) {
      final a = pts[i], b = pts[i + 1];
      final n = ((b - a).distance / (thumbnail ? 3 : 6)).ceil();
      for (var k = 0; k < n; k += 2) {
        canvas.drawLine(
          Offset.lerp(a, b, k / n)!,
          Offset.lerp(a, b, (k + 1) / n)!,
          line,
        );
      }
    }
    for (var i = 0; i < pts.length; i++) {
      final p = pts[i];
      final on = picked == i;
      canvas.drawCircle(
        p,
        thumbnail ? 2.5 : (on ? 12 : 9),
        Paint()
          ..color = (on ? const Color(0x66E5743F) : const Color(0x33FFFFFF)),
      );
      canvas.drawCircle(
        p,
        thumbnail ? 1.2 : 4,
        Paint()..color = on ? const Color(0xFFE5743F) : Colors.white,
      );
      if (!thumbnail && i < labels.length) {
        final label = labels[i].length > 34
            ? '${labels[i].substring(0, 33)}…'
            : labels[i];
        final tp = TextPainter(
          text: TextSpan(
            text: label,
            style: WyrdText.mono(fontSize: 9.5, color: const Color(0xEEFFFFFF)),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: 220);
        final dx = (p.dx - tp.width / 2).clamp(4.0, s.width - tp.width - 4);
        tp.paint(canvas, Offset(dx, p.dy + 12));
      }
    }
  }

  @override
  bool shouldRepaint(_Sky old) =>
      old.stars != stars || old.picked != picked || old.seed != seed;
}

/// WYRD's ideas as neurons: the heaviest near the middle, each a ring with its name, synapses as
/// lines (thicker = stronger), and the idea that fired last lit, with its strongest links.
class _Network extends CustomPainter {
  final NeuralNetwork net;
  final Set<String> fired;
  _Network(this.net, this.fired) : edges = _strongest(net);
  final List<Synapse> edges;

  static final _layouts = <int, Map<String, Offset>>{};

  /// Each idea's two strongest synapses.
  static List<Synapse> _strongest(NeuralNetwork net) {
    final by = <String, List<Synapse>>{};
    for (final y in net.synapses) {
      (by[y.a] ??= []).add(y);
      (by[y.b] ??= []).add(y);
    }
    final keep = <Synapse>{};
    for (final l in by.values) {
      l.sort((a, b) => b.weight.compareTo(a.weight));
      keep.addAll(l.take(2));
    }
    return keep.toList();
  }

  /// Ideas spread evenly over the space, as in the main app: a slightly jittered grid, filled in
  /// the order a walk along the strongest links reaches them, so linked ideas sit side by side.
  static Map<String, Offset> _layout(NeuralNetwork net, List<Synapse> edges) {
    final ids = [
      for (final n in [
        ...net.neurons,
      ]..sort((a, b) => b.count.compareTo(a.count)))
        n.id,
    ];
    final next = <String, List<String>>{};
    for (final y in [...edges]..sort((a, b) => b.weight.compareTo(a.weight))) {
      (next[y.a] ??= []).add(y.b);
      (next[y.b] ??= []).add(y.a);
    }
    final order = <String>[];
    final seen = <String>{};
    for (final start in ids) {
      if (seen.contains(start)) continue;
      final queue = [start];
      seen.add(start);
      while (queue.isNotEmpty) {
        final id = queue.removeAt(0);
        order.add(id);
        for (final n in next[id] ?? const <String>[]) {
          if (seen.add(n)) queue.add(n);
        }
      }
    }
    final cols = max(1, sqrt(order.length * 1.8).ceil());
    final rows = max(1, (order.length / cols).ceil());
    final rng = Random(order.length);
    final out = <String, Offset>{};
    for (var i = 0; i < order.length; i++) {
      final r = i ~/ cols;
      final c = r.isEven
          ? i % cols
          : cols - 1 - i % cols; // snake, so neighbours stay close
      out[order[i]] = Offset(
        ((c + 0.5 + (rng.nextDouble() - 0.5) * 0.7) / cols).clamp(0.0, 1.0),
        ((r + 0.5 + (rng.nextDouble() - 0.5) * 0.6) / rows).clamp(0.0, 1.0),
      );
    }
    return out;
  }

  @override
  void paint(Canvas canvas, Size s) {
    final ns = [...net.neurons]..sort((a, b) => b.count.compareTo(a.count));
    // laid out once per network (linked ideas pulled together, all ideas pushed apart), then fitted
    final unit = _layouts.putIfAbsent(
      identityHashCode(net),
      () => _layout(net, edges),
    );
    final pos = <String, Offset>{
      for (final e in unit.entries)
        e.key: Offset(
          34 + e.value.dx * (s.width - 68),
          22 + e.value.dy * (s.height - 54),
        ),
    };
    final ink = WyrdColors.green;
    var maxW = 0.0;
    for (final y in edges) {
      if (y.weight > maxW) maxW = y.weight;
    }
    for (final y in edges) {
      final a = pos[y.a], b = pos[y.b];
      if (a == null || b == null) continue;
      final hot = fired.contains(y.a) && fired.contains(y.b);
      canvas.drawLine(
        a,
        b,
        Paint()
          ..color = hot
              ? ink
              : ink.withValues(
                  alpha: 0.12 + 0.3 * (y.weight / (maxW == 0 ? 1 : maxW)),
                )
          ..strokeWidth = hot
              ? 2.6
              : 0.5 + 2 * (y.weight / (maxW == 0 ? 1 : maxW)),
      );
    }
    for (final n in ns) {
      final p = pos[n.id]!;
      final lit = fired.contains(n.id);
      canvas.drawCircle(p, lit ? 9 : 6, Paint()..color = WyrdColors.card);
      canvas.drawCircle(
        p,
        lit ? 9 : 6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = lit ? 2 : 1
          ..color = lit ? ink : ink.withValues(alpha: 0.55),
      );
      canvas.drawCircle(
        p,
        lit ? 3 : 1.6,
        Paint()..color = lit ? WyrdColors.signal : ink.withValues(alpha: 0.7),
      );
      final tp = TextPainter(
        text: TextSpan(
          text: n.id,
          style:
              WyrdText.mono(
                fontSize: 9,
                color: lit ? ink : ink.withValues(alpha: 0.8),
              ).copyWith(
                fontWeight: lit ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 110);
      tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy + 9));
    }
  }

  @override
  bool shouldRepaint(_Network old) => old.net != net || old.fired != fired;
}
