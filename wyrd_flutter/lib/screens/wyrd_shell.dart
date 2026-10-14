import 'dart:math';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../client.dart';
import '../customize.dart';
import 'dialogue_screen.dart';
import '../theme.dart';
import '../widgets/glass_panel.dart';
import 'alerts_panel.dart';
import 'cop_tab.dart';
import 'journal_tab.dart';
import 'games_tab.dart';
import 'tasks_screen.dart';
import 'wyrd_tab.dart';
import 'you_tab.dart';

/// The app's frame, as in the main app: a header (WYRD's face mark, its name and three colours, the
/// sun/moon button), and the sections -- a bottom bar on phones whose active tab is a filled
/// terracotta tile, a left side bar of pills on desktop. COP is shown to the owner only.
class WyrdShell extends StatefulWidget {
  const WyrdShell({super.key});

  @override
  State<WyrdShell> createState() => _WyrdShellState();
}

class _WyrdShellState extends State<WyrdShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    openRequest.addListener(_openPlace); // a place WYRD was asked to take them
    client.drone
        .isOperator()
        .then((yes) {
          if (mounted) setState(() => ownerAccess.value = yes);
        })
        .catchError((_) {});
  }

  // pages: 0 WYRD, 1 Journal, 2 Games, 3 You -- the bar shows WYRD · Apps · You, as the main app,
  // with Journal and Games inside the Apps pop-up
  static const _wyrd = 0, _journal = 1, _games = 2, _you = 3;

  @override
  void dispose() {
    openRequest.removeListener(_openPlace);
    super.dispose();
  }

  /// A place WYRD was asked to take them (customize_app "open").
  void _openPlace() {
    final place = openRequest.value;
    if (place == null || !mounted) return;
    switch (place) {
      case 'wyrd' || 'brain':
        setState(() => _index = _wyrd);
      case 'journal':
        setState(() => _index = _journal);
      case 'games':
        setState(() => _index = _games);
      case 'you':
        _tap(2);
      case 'tasks':
        openGlassPanel(
          context,
          title: 'TASKS',
          icon: Icons.auto_awesome_outlined,
          side: GlassSide.left,
          child: const TasksScreen(embedded: true),
        );
      case 'alerts':
        openGlassPanel(
          context,
          title: 'ALERTS',
          icon: Icons.notifications_none,
          child: const AlertsPanel(),
        );
    }
  }

  // where they are, told to WYRD with each message from the ASK WYRD button
  static const _screens = [
    'the home screen (WYRD tab: its brain, last thought, Dialogue Link, chess challenge)',
    'the Journal (diary, dreams, reasoning, feed)',
    'the Games tab (chess, Connect Four, Reversi, Tic-tac-toe, leaderboard, and YOUR GAMES that WYRD programmed for them)',
    'the You page (profile, memories, settings)',
  ];

  /// ASK WYRD: Dialogue Link from anywhere, knowing the screen they called it from.
  void _askWyrd() => openGlassPanel(
    context,
    title: 'DIALOGUE_LINK',
    icon: Icons.forum_outlined,
    side: GlassSide.right,
    maxWidth: 760,
    child: DialogueScreen(embedded: true, screen: _screens[_index]),
  );

  void _tap(int bar) {
    if (bar == 1) {
      _openApps();
    } else if (bar == 2) {
      // YOU: a glass pop-up over the page, like Apps, Dialogue Link and Tasks
      openGlassPanel(
        context,
        title: 'YOU',
        icon: Icons.person_outline,
        maxWidth: 760,
        child: const YouTab(),
      );
    } else {
      setState(() => _index = _wyrd);
    }
  }

  /// APPS: a glass pop-up over the page with the apps as tiles, as in the main app.
  void _openApps() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.25),
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (ctx, _, _) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: Material(
                  color: WyrdColors.glassBg,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: WyrdColors.glassBorder),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'APPS',
                              style: WyrdText.mono(
                                fontSize: 10,
                                color: WyrdColors.greenDim,
                              ).copyWith(letterSpacing: 2.4),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: WyrdColors.greenDim,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              for (final (page, icon, name, blurb) in [
                                (
                                  _journal,
                                  Icons.menu_book_outlined,
                                  'Journal',
                                  'Diary, dreams, reasoning',
                                ),
                                (
                                  _games,
                                  Icons.sports_esports_outlined,
                                  'Games',
                                  'Chess and three more',
                                ),
                              ])
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Navigator.of(ctx).pop();
                                        setState(() => _index = page);
                                      },
                                      child: Ink(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _index == page
                                              ? WyrdColors.signalSoft
                                              : WyrdColors.glassBg,
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                          border: Border.all(
                                            color: WyrdColors.glassBorder,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              icon,
                                              size: 28,
                                              color: WyrdColors.signal,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              name,
                                              style: WyrdText.mono(
                                                fontSize: 13.5,
                                              ),
                                            ),
                                            Text(
                                              blurb,
                                              style: WyrdText.mono(
                                                fontSize: 9.5,
                                                color: WyrdColors.greenDim,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      transitionBuilder: (_, anim, _, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final owner = ownerAccess.value;
    final bar = <({String label, IconData icon, Widget page})>[
      (
        label: 'WYRD',
        icon: Icons.psychology_alt_outlined,
        page: const SizedBox(),
      ),
      (label: 'Apps', icon: Icons.apps_rounded, page: const SizedBox()),
      (label: 'You', icon: Icons.person_outline, page: const SizedBox()),
    ];
    final barIndex = _index == _wyrd
        ? 0
        : _index == _you
        ? 2
        : 1;
    final desktop = MediaQuery.of(context).size.width >= 900;
    final body = IndexedStack(
      index: _index,
      children: [
        WyrdTab(onPlayChess: () => setState(() => _index = _games)),
        const JournalTab(),
        const GamesTab(),
        const YouTab(),
      ],
    );

    return Scaffold(
      backgroundColor: WyrdColors.bg,
      // ASK WYRD: a glass button over every page, as in the main app
      floatingActionButton: _AskWyrd(onTap: _askWyrd),
      body: SafeArea(
        child: Column(
          children: [
            _Header(owner: owner),
            Expanded(
              child: desktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SideBar(items: bar, index: barIndex, onTap: _tap),
                        Expanded(child: body),
                      ],
                    )
                  : body,
            ),
            if (!desktop) _BottomBar(items: bar, index: barIndex, onTap: _tap),
          ],
        ),
      ),
    );
  }
}

/// WYRD's face mark: the scan lines of a face in a circle (the main app's icon).
class FaceMark extends StatelessWidget {
  final double size;
  const FaceMark({super.key, this.size = 34});

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: WyrdColors.card,
      border: Border.all(color: WyrdColors.greenBorder),
    ),
    child: CustomPaint(painter: _FacePainter(WyrdColors.green)),
  );
}

class _FacePainter extends CustomPainter {
  final Color ink;
  _FacePainter(this.ink);

  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..strokeWidth = max(1, s.width / 34)
      ..strokeCap = StrokeCap.round;
    const bands = 11;
    for (var i = 0; i < bands; i++) {
      final t = (i + 0.5) / bands; // top to bottom
      final y = s.height * (0.2 + 0.6 * t);
      // an oval, a little narrower at the chin
      final half =
          s.width *
          0.26 *
          sqrt(max(0, 1 - pow((t - 0.45) * 2, 2))) *
          (t > 0.6 ? 0.85 : 1);
      p.color = ink.withValues(alpha: 0.35 + 0.4 * (1 - (t - 0.45).abs() * 2));
      canvas.drawLine(
        Offset(s.width / 2 - half, y),
        Offset(s.width / 2 + half, y),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(_FacePainter old) => old.ink != ink;
}

class _Header extends StatelessWidget {
  final bool owner;
  const _Header({required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: WyrdColors.barBg,
        border: Border(bottom: BorderSide(color: WyrdColors.greenBorderDim)),
      ),
      child: Row(
        children: [
          const FaceMark(),
          const SizedBox(width: 10),
          Text(
            'WYRD',
            style: WyrdText.display(fontSize: 28, color: WyrdColors.indigo),
          ),
          const SizedBox(width: 6),
          for (final c in [
            WyrdColors.signal,
            WyrdColors.ochre,
            WyrdColors.palm,
          ])
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
          const Spacer(),
          // TASKS: what WYRD is working on for you, as the main app's header pill
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () => openGlassPanel(
              context,
              title: 'TASKS',
              icon: Icons.auto_awesome_outlined,
              side: GlassSide.left,
              child: const TasksScreen(embedded: true),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: WyrdColors.glassBg,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: WyrdColors.greenBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_outlined,
                    size: 15,
                    color: WyrdColors.green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'TASKS',
                    style: WyrdText.mono(
                      fontSize: 11,
                    ).copyWith(letterSpacing: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // COP: WYRD's self-changes, independently reviewed -- the owner's only
          if (owner) ...[
            InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () => openGlassPanel(
                context,
                title: 'COP',
                icon: Icons.shield_outlined,
                maxWidth: 720,
                child: const CopTab(),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: WyrdColors.glassBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: WyrdColors.greenBorder),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 15,
                      color: WyrdColors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'COP',
                      style: WyrdText.mono(
                        fontSize: 11,
                      ).copyWith(letterSpacing: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // ALERTS: the bell, as in the main app -- a glass pop-up of what WYRD wants you to know
          _RoundButton(
            icon: Icons.notifications_none_rounded,
            label: 'Alerts',
            onTap: () => openGlassPanel(
              context,
              title: 'ALERTS',
              icon: Icons.notifications_none_rounded,
              maxWidth: 520,
              child: const AlertsPanel(),
            ),
          ),
          const SizedBox(width: 8),
          // day / night, as the main app's header button
          _RoundButton(
            icon: WyrdColors.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            label: WyrdColors.dark ? 'Switch to day' : 'Switch to night',
            onTap: () => WyrdColors.night.value = !WyrdColors.dark,
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Tooltip(
    message: label,
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: WyrdColors.glassBg,
          border: Border.all(color: WyrdColors.greenBorder),
        ),
        child: Icon(icon, size: 18, color: WyrdColors.green),
      ),
    ),
  );
}

/// Phones: the sections along the bottom; the active one a filled terracotta tile, wider than the rest.
class _BottomBar extends StatelessWidget {
  final List<({String label, IconData icon, Widget page})> items;
  final int index;
  final void Function(int) onTap;
  const _BottomBar({
    required this.items,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      decoration: BoxDecoration(
        color: WyrdColors.barBg,
        border: Border(top: BorderSide(color: WyrdColors.greenBorderDim)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              flex: i == index ? 3 : 2,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: i == index ? WyrdColors.signal : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 20,
                        color: i == index
                            ? WyrdColors.onSignal
                            : WyrdColors.greenDim,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        i == index
                            ? items[i].label.toUpperCase()
                            : items[i].label,
                        style: WyrdText.mono(
                          fontSize: 10,
                          color: i == index
                              ? WyrdColors.onSignal
                              : WyrdColors.greenDim,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Desktop: the sections as pills down the left, the active one filled terracotta.
class _SideBar extends StatelessWidget {
  final List<({String label, IconData icon, Widget page})> items;
  final int index;
  final void Function(int) onTap;
  const _SideBar({
    required this.items,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WyrdColors.barBg,
        border: Border(right: BorderSide(color: WyrdColors.greenBorderDim)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: i == index ? WyrdColors.signal : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        items[i].icon,
                        size: 18,
                        color: i == index
                            ? WyrdColors.onSignal
                            : WyrdColors.greenDim,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        i == index
                            ? items[i].label.toUpperCase()
                            : items[i].label,
                        style: WyrdText.mono(
                          fontSize: 12.5,
                          color: i == index
                              ? WyrdColors.onSignal
                              : WyrdColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The ASK WYRD button: frosted glass, the accent's chat mark and its name.
class _AskWyrd extends StatelessWidget {
  final VoidCallback onTap;
  const _AskWyrd({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: BoxDecoration(
            color: WyrdColors.glassBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: WyrdColors.greenBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.forum_outlined, size: 20, color: WyrdColors.signal),
              const SizedBox(width: 8),
              Text(
                'ASK WYRD',
                style: WyrdText.mono(
                  fontSize: 11,
                  color: WyrdColors.mint,
                ).copyWith(letterSpacing: 1.6),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
