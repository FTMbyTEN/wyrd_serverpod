import 'dart:math';

import 'package:flutter/material.dart';

import '../client.dart';
import '../theme.dart';
import 'cop_tab.dart';
import 'diary_tab.dart';
import 'feed_tab.dart';
import 'games_tab.dart';
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
  List<String> _labels = const [];

  @override
  void initState() {
    super.initState();
    client.drone
        .isOperator()
        .then((yes) {
          if (mounted) setState(() => ownerAccess.value = yes);
        })
        .catchError((_) {});
  }

  void _go(String label) {
    final i = _labels.indexOf(label);
    if (i >= 0) setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    final owner = ownerAccess.value;
    final sections = <({String label, IconData icon, Widget page})>[
      (
        label: 'WYRD',
        icon: Icons.psychology_alt_outlined,
        page: WyrdTab(onPlayChess: () => _go('Games')),
      ),
      (
        label: 'Games',
        icon: Icons.sports_esports_outlined,
        page: const GamesTab(),
      ),
      (
        label: 'Journal',
        icon: Icons.menu_book_outlined,
        page: const DiaryTab(),
      ),
      (label: 'Feed', icon: Icons.rss_feed, page: const FeedTab()),
      if (owner)
        (label: 'COP', icon: Icons.shield_outlined, page: const CopTab()),
      (label: 'You', icon: Icons.person_outline, page: const YouTab()),
    ];
    _labels = [for (final s in sections) s.label];
    final index = _index.clamp(0, sections.length - 1);
    final desktop = MediaQuery.of(context).size.width >= 900;
    final body = IndexedStack(
      index: index,
      children: [for (final s in sections) s.page],
    );

    return Scaffold(
      backgroundColor: WyrdColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: desktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SideBar(
                          items: sections,
                          index: index,
                          onTap: (i) => setState(() => _index = i),
                        ),
                        Expanded(child: body),
                      ],
                    )
                  : body,
            ),
            if (!desktop)
              _BottomBar(
                items: sections,
                index: index,
                onTap: (i) => setState(() => _index = i),
              ),
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
  const _Header();

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
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
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
