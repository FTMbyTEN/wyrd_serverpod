import 'package:flutter/material.dart';

import '../client.dart';
import '../theme.dart';
import 'wyrd_tab.dart';
import 'diary_tab.dart';
import 'cop_tab.dart';
import 'feed_tab.dart';
import 'games_tab.dart';
import 'you_tab.dart';

/// The app's 5-tab navigation shell, mirroring the React Native app's IA
/// (WYRD/DIARY/COP/FEED/YOU) so the two frontends stay conceptually aligned.
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
    // COP is the owner's, as in the main app: asked once, shown only to them
    client.drone
        .isOperator()
        .then((yes) {
          if (mounted) setState(() => ownerAccess.value = yes);
        })
        .catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final owner = ownerAccess.value;
    final tabs = <(Widget, NavigationDestination)>[
      (
        const WyrdTab(),
        const NavigationDestination(
          icon: Icon(Icons.psychology_outlined),
          selectedIcon: Icon(Icons.psychology),
          label: 'WYRD',
        ),
      ),
      (
        const DiaryTab(),
        const NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: 'DIARY',
        ),
      ),
      (
        const GamesTab(),
        const NavigationDestination(
          icon: Icon(Icons.sports_esports_outlined),
          selectedIcon: Icon(Icons.sports_esports),
          label: 'GAMES',
        ),
      ),
      if (owner)
        (
          const CopTab(),
          const NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: 'COP',
          ),
        ),
      (
        const FeedTab(),
        const NavigationDestination(
          icon: Icon(Icons.rss_feed_outlined),
          selectedIcon: Icon(Icons.rss_feed),
          label: 'FEED',
        ),
      ),
      (
        const YouTab(),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'YOU',
        ),
      ),
    ];
    final index = _index.clamp(0, tabs.length - 1);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // the main app's header: WYRD's name and its three colours (terracotta, ochre, indigo)
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: WyrdColors.barBg,
                border: Border(
                  bottom: BorderSide(color: WyrdColors.greenBorderDim),
                ),
              ),
              child: Row(
                children: [
                  Text('WYRD', style: WyrdText.display(fontSize: 30)),
                  const SizedBox(width: 8),
                  for (final c in [
                    WyrdColors.signal,
                    WyrdColors.ochre,
                    WyrdColors.indigo,
                  ])
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: index,
                children: [for (final t in tabs) t.$1],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [for (final t in tabs) t.$2],
      ),
    );
  }
}
