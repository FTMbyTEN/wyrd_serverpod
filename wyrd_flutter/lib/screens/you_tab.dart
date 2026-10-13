import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart'
    hide UserProfile;
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/glass_panel.dart';
import 'cop_tab.dart';

/// YOU, as in the main app (YouTab.tsx): who you are to WYRD -- your name, how long you've been
/// together and how WYRD feels today -- six numbers, when you talk, what WYRD knows about you (the
/// one memory it shares across chat, tasks and the city, each with a ✕ to forget it), then settings
/// and your data.
class YouTab extends StatefulWidget {
  const YouTab({super.key});

  @override
  State<YouTab> createState() => _YouTabState();
}

class _YouTabState extends State<YouTab> {
  UserProfile? _profile;
  Mind? _mind;
  List<ConversationTurn> _turns = [];
  List<ReadingItem> _reading = [];
  QuizStats? _quiz;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final r = await Future.wait([
        client.profile.getProfile(),
        client.mind.getMind(),
        client.chat.getHistory(limit: 200),
      ]);
      // your desk and your quiz score: extras, the page shows without them
      final reading = await client.library.list().catchError(
        (_) => <ReadingItem>[],
      );
      QuizStats? quiz;
      try {
        quiz = await client.library.quizStats();
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        _profile = r[0] as UserProfile;
        _mind = r[1] as Mind;
        _turns = r[2] as List<ConversationTurn>;
        _reading = reading;
        _quiz = quiz;
        _error = false;
      });
    } catch (_) {
      if (mounted) setState(() => _error = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _editName() async {
    final c = TextEditingController(text: _profile?.username ?? '');
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'What should WYRD call you?',
          style: WyrdText.display(fontSize: 26),
        ),
        content: TextField(
          controller: c,
          autofocus: true,
          maxLength: 40,
          style: WyrdText.mono(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, c.text.trim()),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    try {
      final p = await client.profile.setUsername(name);
      if (mounted) setState(() => _profile = p);
    } catch (_) {}
  }

  Future<void> _forget(String text) async {
    try {
      final p = await client.profile.forgetFact(text);
      if (mounted) setState(() => _profile = p);
    } catch (_) {}
  }

  Future<void> _export() async {
    try {
      final export = await client.account.exportData();
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Your data', style: WyrdText.display(fontSize: 26)),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: SelectableText(
                const JsonEncoder.withIndent('  ').convert(export.toJson()),
                style: WyrdText.mono(fontSize: 11),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('CLOSE'),
            ),
          ],
        ),
      );
    } catch (_) {}
  }

  Future<void> _delete() async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Delete your data?',
          style: WyrdText.display(fontSize: 26, color: WyrdColors.danger),
        ),
        content: Text(
          'This permanently deletes your conversations, what WYRD learned about you, your reading and your quizzes. '
          'It can’t be undone. Your login stays.',
          style: WyrdText.mono(fontSize: 13).copyWith(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: WyrdColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
    if (yes != true) return;
    try {
      await client.account.deleteMyData();
      await _load();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Center(child: CircularProgressIndicator(color: WyrdColors.signal));
    if (_error || _profile == null) {
      return Center(
        child: Text(
          "Couldn't load your profile just now. Try again in a moment.",
          style: WyrdText.mono(fontSize: 12.5, color: WyrdColors.greenDim),
        ),
      );
    }
    final p = _profile!;
    final days = DateTime.now().difference(p.firstSeen).inDays + 1;
    final name = (p.username?.trim().isNotEmpty ?? false)
        ? p.username!.trim()
        : (p.email ?? '—').split('@').first;
    final wide = MediaQuery.of(context).size.width >= 700;
    final stats = [
      ('${_turns.length}', 'MESSAGES', WyrdColors.palm),
      ('${p.facts.length}', 'THINGS IT KNOWS', WyrdColors.indigo),
      ('$days', 'DAYS TOGETHER', WyrdColors.signal),
      ('${p.visitCount}', 'VISITS', WyrdColors.palm),
      ('${_reading.length}', 'ON YOUR DESK', WyrdColors.indigo),
      (
        _quiz == null || _quiz!.total == 0
            ? '—'
            : '${(_quiz!.correct * 100 / _quiz!.total).round()}%',
        'QUIZ SCORE',
        WyrdColors.signal,
      ),
    ];
    // your picture, as in the main app (a small square image, kept as a data URL)
    Widget? picture;
    final av = p.avatar;
    if (av != null && av.contains(',')) {
      try {
        picture = Image.memory(
          base64Decode(av.split(',').last),
          fit: BoxFit.cover,
        );
      } catch (_) {}
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // who you are to WYRD
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: WyrdColors.signal, width: 3),
                  color: WyrdColors.sand,
                ),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                child:
                    picture ??
                    Text(
                      name.isEmpty ? '?' : name[0].toUpperCase(),
                      style: WyrdText.display(
                        fontSize: 44,
                        color: WyrdColors.signal,
                      ),
                    ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOU, TO WYRD',
                      style: WyrdText.mono(
                        fontSize: 9.5,
                        color: WyrdColors.signal,
                      ).copyWith(letterSpacing: 2),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: WyrdText.display(fontSize: 40),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _editName,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'edit',
                              style: WyrdText.mono(
                                fontSize: 11,
                                color: WyrdColors.greenDim,
                              ).copyWith(decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (p.email != null)
                      Text(
                        p.email!,
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.greenDim,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Together since ${_longDate(p.firstSeen)} — WYRD is feeling ${_mind?.mood ?? 'curious'} today.',
                      style: WyrdText.serif(
                        fontSize: 15,
                      ).copyWith(height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: wide ? 3 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: wide ? 3.2 : 2.2,
            children: [
              for (final (value, label, colour) in stats)
                Container(
                  decoration: wyrdCard(radius: 18),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        style: WyrdText.display(fontSize: 30, color: colour),
                      ),
                      Text(
                        label,
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: WyrdColors.greenDim,
                        ).copyWith(letterSpacing: 1.6),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          _section(
            'WHEN YOU TALK',
            _turns.isEmpty ? null : 'your last ${_turns.length} messages',
          ),
          _activity(),
          _section(
            'WHAT WYRD KNOWS ABOUT YOU',
            '${p.facts.length} ${p.facts.length == 1 ? 'memory' : 'memories'} · one memory in chat, tasks and the city · private to you',
          ),
          if (p.facts.isEmpty)
            Text(
              'Nothing yet. Tell WYRD about yourself in Dialogue Link — your name, what you study, what you love — and it will remember, privately.',
              style: WyrdText.mono(
                fontSize: 12,
                color: WyrdColors.greenDim,
              ).copyWith(height: 1.5),
            )
          else
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [for (final f in p.facts) _factCard(f, wide)],
            ),
          if (_reading.isNotEmpty) ...[
            _section('YOUR READING', null),
            for (final i in _reading.take(8))
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        i.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: WyrdText.serif(fontSize: 14.5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: _progress(i),
                          minHeight: 4,
                          backgroundColor: WyrdColors.greenBorderDim,
                          valueColor: AlwaysStoppedAnimation(
                            WyrdColors.signal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 44,
                      child: Text(
                        '${(_progress(i) * 100).round()}%',
                        textAlign: TextAlign.right,
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.greenDim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          _section('SETTINGS', null),
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: wyrdCard(radius: 16),
            child: Row(
              children: [
                Icon(
                  WyrdColors.dark
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: WyrdColors.signal,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Appearance', style: WyrdText.mono(fontSize: 13.5)),
                      Text(
                        'Light, dark, or the same as your device',
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.greenDim,
                        ),
                      ),
                    ],
                  ),
                ),
                // Auto / Light / Dark, as in the main app
                for (final (label, mode) in const [
                  ('AUTO', null),
                  ('LIGHT', false),
                  ('DARK', true),
                ])
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => WyrdColors.night.value =
                        mode ??
                        (WidgetsBinding
                                .instance
                                .platformDispatcher
                                .platformBrightness ==
                            Brightness.dark),
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: mode == WyrdColors.dark
                            ? WyrdColors.signal
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: WyrdColors.greenBorder),
                      ),
                      child: Text(
                        label,
                        style: WyrdText.mono(
                          fontSize: 9.5,
                          color: mode == WyrdColors.dark
                              ? WyrdColors.onSignal
                              : WyrdColors.greenDim,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (ownerAccess.value)
            _setting(
              Icons.shield_outlined,
              'COP oversight',
              'Every change WYRD made to itself, independently reviewed',
              () => openGlassPanel(
                context,
                title: 'COP',
                icon: Icons.shield_outlined,
                maxWidth: 720,
                child: const CopTab(),
              ),
            ),
          _section('YOUR DATA', null),
          _setting(
            Icons.inventory_2_outlined,
            'Export my data',
            'Conversations, facts, reading and quizzes',
            _export,
          ),
          _setting(
            Icons.delete_outline,
            'Delete my data',
            'Erase everything WYRD kept about you. Your login stays.',
            _delete,
            danger: true,
          ),
          _setting(
            Icons.logout,
            'Sign out',
            'Leave WYRD on this device',
            () => client.authSessionManager.signOutDevice(),
          ),
          const SizedBox(height: 14),
          Text(
            'Your conversations, facts and reading are private to you. WYRD’s mind, diary and dreams are shared by everyone.',
            style: WyrdText.mono(
              fontSize: 11,
              color: WyrdColors.greenDim,
            ).copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _section(String title, String? note) => Padding(
    padding: const EdgeInsets.only(top: 22, bottom: 10),
    child: Container(
      padding: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: WyrdColors.greenBorderDim)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: WyrdText.mono(
              fontSize: 10,
              color: WyrdColors.signal,
            ).copyWith(letterSpacing: 2),
          ),
          const Spacer(),
          if (note != null)
            Flexible(
              child: Text(
                note,
                textAlign: TextAlign.right,
                style: WyrdText.mono(fontSize: 9.5, color: WyrdColors.greenDim),
              ),
            ),
        ],
      ),
    ),
  );

  /// When you talk: your messages over the hours of the day, as small bars.
  Widget _activity() {
    if (_turns.isEmpty) {
      return Text(
        'No conversations yet. Your rhythm with WYRD will show here.',
        style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
      );
    }
    final hours = List.filled(24, 0);
    for (final t in _turns) {
      hours[t.timestamp.toLocal().hour]++;
    }
    final peak = hours.reduce((a, b) => a > b ? a : b).clamp(1, 1 << 30);
    final peakHour = hours.indexOf(hours.reduce((a, b) => a > b ? a : b));
    // how many days running you've talked, counting back from today (or yesterday)
    final days = {
      for (final t in _turns) DateUtils.dateOnly(t.timestamp.toLocal()),
    };
    var d = DateUtils.dateOnly(DateTime.now());
    if (!days.contains(d)) d = d.subtract(const Duration(days: 1));
    var streak = 0;
    while (days.contains(d)) {
      streak++;
      d = d.subtract(const Duration(days: 1));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 64,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var h = 0; h < 24; h++)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    height: 4 + 56 * hours[h] / peak,
                    decoration: BoxDecoration(
                      color: hours[h] == 0
                          ? WyrdColors.greenBorderDim
                          : WyrdColors.signal,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final l in ['00', '06', '12', '18', '24'])
              Text(
                l,
                style: WyrdText.mono(fontSize: 9, color: WyrdColors.greenDim),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'You talk most around ${peakHour.toString().padLeft(2, '0')}:00'
          '${streak > 1 ? ', and you’ve talked $streak days running' : ''}.',
          style: WyrdText.serif(fontSize: 15),
        ),
      ],
    );
  }

  /// How far into a reading you are (books in parts count each part), as in the main app.
  static double _progress(ReadingItem i) {
    final within = i.total == 0
        ? 1.0
        : ((i.nextOffset ?? i.total) / i.total).clamp(0.0, 1.0);
    final parts = i.source == 'openstax' || i.source == 'wikisource';
    return parts
        ? (((i.partIndex ?? 0) + within) / max(1, i.partCount ?? 1)).clamp(
            0.0,
            1.0,
          )
        : within;
  }

  Widget _factCard(UserFact f, bool wide) {
    final label = switch (f.category) {
      'task' => 'A TASK FOR YOU',
      'city' => 'NAIJA 2099',
      'told' => 'YOU TOLD WYRD',
      _ => f.category.toUpperCase(),
    };
    return SizedBox(
      width: wide ? 230 : double.infinity,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: WyrdColors.card,
          border: Border(
            top: BorderSide(color: WyrdColors.green, width: 2),
            left: BorderSide(color: WyrdColors.greenBorderDim),
            right: BorderSide(color: WyrdColors.greenBorderDim),
            bottom: BorderSide(color: WyrdColors.greenBorderDim),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: WyrdText.mono(
                      fontSize: 8.5,
                      color: WyrdColors.greenDim,
                    ).copyWith(letterSpacing: 1.6),
                  ),
                ),
                GestureDetector(
                  onTap: () => _forget(f.text),
                  child: Text(
                    '✕',
                    style: WyrdText.mono(
                      fontSize: 11,
                      color: WyrdColors.greenDim,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              f.text,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: WyrdText.serif(fontSize: 15).copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setting(
    IconData icon,
    String title,
    String detail,
    VoidCallback onTap, {
    bool danger = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: wyrdCard(radius: 16),
        child: Row(
          children: [
            Icon(icon, color: danger ? WyrdColors.danger : WyrdColors.signal),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: WyrdText.mono(
                      fontSize: 13.5,
                      color: danger ? WyrdColors.danger : WyrdColors.mint,
                    ),
                  ),
                  Text(
                    detail,
                    style: WyrdText.mono(
                      fontSize: 11,
                      color: WyrdColors.greenDim,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: WyrdColors.greenDim),
          ],
        ),
      ),
    ),
  );
}

String _longDate(DateTime t) {
  const m = [
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
  final l = t.toLocal();
  return '${m[l.month - 1]} ${l.day}, ${l.year}';
}
