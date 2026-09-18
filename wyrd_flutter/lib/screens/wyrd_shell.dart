import 'package:flutter/material.dart';

import 'wyrd_tab.dart';
import 'diary_tab.dart';
import 'cop_tab.dart';
import 'feed_tab.dart';
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

  static const _tabs = [
    WyrdTab(),
    DiaryTab(),
    CopTab(),
    FeedTab(),
    YouTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: _tabs)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.psychology_outlined), selectedIcon: Icon(Icons.psychology), label: 'WYRD'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'DIARY'),
          NavigationDestination(icon: Icon(Icons.shield_outlined), selectedIcon: Icon(Icons.shield), label: 'COP'),
          NavigationDestination(icon: Icon(Icons.rss_feed_outlined), selectedIcon: Icon(Icons.rss_feed), label: 'FEED'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'YOU'),
        ],
      ),
    );
  }
}
