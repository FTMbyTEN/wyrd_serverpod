import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../customize.dart';
import '../theme.dart';
import '../widgets/frame/frame_stub.dart'
    if (dart.library.js_interop) '../widgets/frame/frame_web.dart';
import '../widgets/glass_panel.dart';
import 'dialogue_screen.dart';
import '../widgets/frame/page_text_stub.dart'
    if (dart.library.js_interop) '../widgets/frame/page_text_web.dart';

/// YOUR GAMES: the games WYRD programmed on request (save_game), as in the main app. Each plays
/// full screen in a sandboxed frame; "+ New game" opens Dialogue Link with the request drafted.
class YourGames extends StatefulWidget {
  final int columns;
  const YourGames({super.key, required this.columns});

  @override
  State<YourGames> createState() => _YourGamesState();
}

class _YourGamesState extends State<YourGames> {
  List<CustomGame> _games = [];
  int? _confirm;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _load();
    gamesOrder.addListener(_reorder); // WYRD rearranged the cards
    // WYRD writes a game in the background: look again every few seconds, so a new one appears
    // (and a building one turns playable) without leaving the page
    _poll = Timer.periodic(const Duration(seconds: 6), (_) => _load());
  }

  @override
  void dispose() {
    _poll?.cancel();
    gamesOrder.removeListener(_reorder);
    super.dispose();
  }

  void _reorder() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    try {
      final g = await client.games.myGames();
      if (mounted) setState(() => _games = g);
    } catch (_) {}
  }

  Future<void> _ask(String draft) async {
    await openGlassPanel(
      context,
      title: 'DIALOGUE_LINK',
      icon: Icons.forum_outlined,
      side: GlassSide.right,
      maxWidth: 760,
      child: DialogueScreen(
        prompt: draft,
        embedded: true,
        page: pageText(),
        screen:
            'the Games tab (chess, Connect Four, Reversi, Tic-tac-toe, leaderboard, and YOUR GAMES that WYRD programmed for them)',
      ),
    );
    _load(); // a game WYRD just made shows straight away
  }

  /// WATCH WYRD PLAY: straight in if the game has WYRD's play mode; else it's added (the tile shows
  /// "programming" for a minute, then the same button plays).
  Future<void> _watchWyrd(CustomGame g) async {
    if (g.html.contains('WYRD_PLAYS')) {
      _play(g, wyrd: true);
      return;
    }
    try {
      final next = await client.games.readyForWyrd(g.id!);
      if (next != null && mounted) {
        setState(
          () => _games = [for (final c in _games) c.id == next.id ? next : c],
        );
      }
    } catch (_) {}
  }

  Future<void> _delete(CustomGame g) async {
    setState(() {
      _confirm = null;
      _games = _games.where((x) => x.id != g.id).toList();
    });
    try {
      await client.games.deleteGame(g.id!);
    } catch (_) {
      _load();
    }
  }

  /// [html] with WYRD at the controls from the moment it loads (the game's WYRD PLAYS mode).
  static String _wyrdPlaying(String html) {
    const flag = '<script>window.WYRD_PLAYS=true</script>';
    final i = html.toLowerCase().indexOf('<head>');
    return i < 0
        ? '$flag$html'
        : '${html.substring(0, i + 6)}$flag${html.substring(i + 6)}';
  }

  void _play(CustomGame g, {bool wyrd = false}) => Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: WyrdColors.bg,
          title: Text(g.title, style: WyrdText.display(fontSize: 24)),
        ),
        body: LayoutBuilder(
          builder: (_, c) => sandboxFrame(
            key:
                'game-${g.id}-${g.updatedAt.millisecondsSinceEpoch}${wyrd ? '-wyrd' : ''}',
            html: wyrd ? _wyrdPlaying(g.html) : g.html,
            height: c.maxHeight,
          ),
        ),
      ),
    ),
  );

  Widget _chip(String label, VoidCallback onTap, {Color? color}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: WyrdColors.greenBorderDim),
          ),
          child: Text(
            label,
            style: WyrdText.mono(
              fontSize: 10,
              color: color ?? WyrdColors.greenDim,
            ).copyWith(letterSpacing: 1.2),
          ),
        ),
      );

  Widget _pending(CustomGame g) => Container(
    padding: const EdgeInsets.all(14),
    decoration: wyrdCard(radius: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (g.status == 'building')
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: WyrdColors.signal,
                ),
              )
            else
              Icon(Icons.auto_awesome, size: 20, color: WyrdColors.greenDim),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                g.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: WyrdText.display(
                  fontSize: 24,
                  color: WyrdColors.greenDim,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          g.status == 'building'
              ? 'WYRD IS PROGRAMMING IT… A MINUTE OR TWO'
              : "COULDN'T FINISH IT. ASK WYRD AGAIN.",
          style: WyrdText.mono(
            fontSize: 11,
            color: g.status == 'building'
                ? WyrdColors.signal
                : WyrdColors.greenDim,
          ),
        ),
        const Spacer(),
        if (g.status == 'failed')
          Row(
            children: [
              _chip(
                'TRY AGAIN',
                () => _ask('Make me a game: ${g.title}. ${g.blurb}'),
              ),
              const SizedBox(width: 8),
              _chip('✕', () => _delete(g)),
            ],
          ),
      ],
    ),
  );

  Widget _card(CustomGame g) => g.status != null
      ? _pending(g)
      : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _play(g),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: wyrdCard(radius: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 20,
                      color: WyrdColors.signal,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        g.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: WyrdText.display(fontSize: 24),
                      ),
                    ),
                    Text(
                      'PLAY ›',
                      style: WyrdText.mono(
                        fontSize: 11,
                        color: WyrdColors.signal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  g.blurb,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: WyrdText.mono(
                    fontSize: 11.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(height: 1.4),
                ),
                const Spacer(),
                Row(
                  children: _confirm == g.id
                      ? [
                          _chip(
                            'DELETE IT',
                            () => _delete(g),
                            color: WyrdColors.signal,
                          ),
                          const SizedBox(width: 8),
                          _chip('KEEP', () => setState(() => _confirm = null)),
                        ]
                      : [
                          // the game's own WYRD PLAYS mode: WYRD at the controls, you watching
                          _chip(
                            'WATCH WYRD PLAY',
                            () => _watchWyrd(g),
                            color: WyrdColors.signal,
                          ),
                          const SizedBox(width: 8),
                          _chip(
                            'CHANGE IT',
                            () => _ask('Change my game "${g.title}": '),
                          ),
                          const SizedBox(width: 8),
                          _chip('✕', () => setState(() => _confirm = g.id)),
                        ],
                ),
              ],
            ),
          ),
        );

  Widget _newGame() => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => _ask('Make me a game: '),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: wyrdCard(radius: 16, border: WyrdColors.signal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '+ New game',
            style: WyrdText.display(fontSize: 26, color: WyrdColors.signal),
          ),
          const SizedBox(height: 4),
          Text(
            'Snake, Ludo, Ayo, a danfo racer, a quiz: say what you want and WYRD programs it.',
            style: WyrdText.mono(
              fontSize: 11.5,
              color: WyrdColors.greenDim,
            ).copyWith(height: 1.4),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'YOUR GAMES · PROGRAMMED BY WYRD',
        style: WyrdText.mono(
          fontSize: 10,
          color: WyrdColors.signal,
        ).copyWith(letterSpacing: 2),
      ),
      const SizedBox(height: 2),
      Text(
        'Ask WYRD for any game and it writes it, saves it here, and you play it. Ask again to change it.',
        style: WyrdText.mono(
          fontSize: 12,
          color: WyrdColors.greenDim,
        ).copyWith(height: 1.5),
      ),
      const SizedBox(height: 10),
      GridView.count(
        crossAxisCount: widget.columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: widget.columns == 1 ? 2.6 : 2.3,
        children: [
          for (final g in inGamesOrder(_games, (g) => g.title)) _card(g),
          _newGame(),
        ],
      ),
    ],
  );
}
