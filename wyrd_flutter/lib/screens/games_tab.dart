import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:chess/chess.dart' as ch;
import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import 'your_games.dart';

/// Games against WYRD: chess, Connect Four, Reversi and Tic-tac-toe, rated, with WYRD's line on
/// every move. The server holds every position and checks every move (games_endpoint.dart); this
/// screen only draws the board and sends taps. NAIJA 2099 lives in the main app, not here.
class GamesTab extends StatefulWidget {
  const GamesTab({super.key});

  @override
  State<GamesTab> createState() => _GamesTabState();
}

const _games = [
  (
    key: 'chess',
    name: 'Chess',
    blurb:
        'WYRD matches its strength to your rating, or plays you at full strength.',
    glyph: '♚',
  ),
  (
    key: 'connect4',
    name: 'Connect Four',
    blurb: 'Four in a row, before the other side gets there.',
    glyph: '●',
  ),
  (
    key: 'reversi',
    name: 'Reversi',
    blurb: 'Flip the board your way. Corners are everything.',
    glyph: '◐',
  ),
  (
    key: 'tictactoe',
    name: 'Tic-tac-toe',
    blurb: 'Quick. At full strength WYRD never loses.',
    glyph: '✕',
  ),
];

const _levels = [
  '',
  'GENTLE',
  'EASY',
  'STEADY',
  'SHARP',
  'STRONG',
  'FULL STRENGTH',
];

class _GamesTabState extends State<GamesTab> {
  Map<String, PlayerRating> _mine = {};
  List<PlayerRating> _board = [];
  String _boardGame = 'chess';

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  Future<void> _loadRatings() async {
    try {
      final rs = await client.games.myRatings();
      final b = await client.games.leaderboard(_boardGame);
      if (mounted) {
        setState(() {
          _mine = {for (final r in rs) r.game: r};
          _board = b;
        });
      }
    } catch (_) {}
  }

  Future<void> _showBoard(String game) async {
    setState(() => _boardGame = game);
    try {
      final b = await client.games.leaderboard(game);
      if (mounted) setState(() => _board = b);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w >= 1100
        ? 3
        : w >= 640
        ? 2
        : 1;
    return Container(
      color: WyrdColors.bg,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'GAMES',
            style: WyrdText.mono(
              fontSize: 10,
              color: WyrdColors.signal,
            ).copyWith(letterSpacing: 2),
          ),
          Text('Play WYRD', style: WyrdText.display(fontSize: 40)),
          Text(
            'Every game is rated. Play WYRD at your level, or challenge another person while WYRD keeps score.',
            style: WyrdText.mono(
              fontSize: 12,
              color: WyrdColors.greenDim,
            ).copyWith(height: 1.5),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: cols,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: cols == 1 ? 3.2 : 3.0,
            children: [for (final g in _games) _card(g)],
          ),
          const SizedBox(height: 22),
          YourGames(columns: cols),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: WyrdColors.greenBorderDim),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  size: 15,
                  color: WyrdColors.signal,
                ),
                const SizedBox(width: 6),
                Text(
                  'LEADERBOARD',
                  style: WyrdText.mono(
                    fontSize: 10,
                    color: WyrdColors.signal,
                  ).copyWith(letterSpacing: 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [
              for (final g in _games)
                GestureDetector(
                  onTap: () => _showBoard(g.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _boardGame == g.key
                          ? WyrdColors.signal
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: _boardGame == g.key
                            ? WyrdColors.signal
                            : WyrdColors.greenBorder,
                      ),
                    ),
                    child: Text(
                      g.name.toUpperCase(),
                      style: WyrdText.mono(
                        fontSize: 9.5,
                        color: _boardGame == g.key
                            ? WyrdColors.onSignal
                            : WyrdColors.greenDim,
                      ).copyWith(letterSpacing: 1.2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (_board.isEmpty)
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'No one rated here yet. Be the first.',
                style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
              ),
            ),
          for (final (i, r) in _board.take(10).indexed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: i == 0 ? WyrdColors.signalSoft : WyrdColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: WyrdColors.greenBorderDim),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${i + 1}',
                      style: WyrdText.display(
                        fontSize: 20,
                        color: WyrdColors.signal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(r.name, style: WyrdText.mono(fontSize: 13)),
                  ),
                  Text(
                    '${r.wins}W ${r.losses}L  ',
                    style: WyrdText.mono(
                      fontSize: 10.5,
                      color: WyrdColors.greenDim,
                    ),
                  ),
                  Text(
                    '${r.rating.round()}',
                    style: WyrdText.display(fontSize: 22),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _card(({String key, String name, String blurb, String glyph}) g) {
    final r = _mine[g.key];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GameRoom(game: g.key, name: g.name),
            ),
          );
          _loadRatings();
        },
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: wyrdCard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: WyrdColors.signalSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      g.glyph,
                      style: TextStyle(fontSize: 20, color: WyrdColors.signal),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(g.name, style: WyrdText.display(fontSize: 24)),
                  ),
                  Text(
                    'PLAY →',
                    style: WyrdText.mono(
                      fontSize: 10.5,
                      color: WyrdColors.signal,
                    ).copyWith(letterSpacing: 1.2),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  g.blurb,
                  style: WyrdText.mono(
                    fontSize: 11.5,
                    color: WyrdColors.greenDim,
                  ).copyWith(height: 1.4),
                ),
              ),
              Text(
                r == null
                    ? 'NOT RATED YET'
                    : 'RATING ${r.rating.round()} · ${r.wins}W ${r.losses}L',
                style: WyrdText.mono(
                  fontSize: 9.5,
                  color: r == null ? WyrdColors.greenDim : WyrdColors.mint,
                ).copyWith(letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One game, as in the main app: VS WYRD (WYRD plays and talks about your moves) or VS PLAYER
/// (post a challenge, accept one, or carry on a game under way). The board on the left, and beside
/// it WYRD's line, the game's tags, the result and -- for chess -- the moves.
class GameRoom extends StatefulWidget {
  final String game;
  final String name;
  const GameRoom({super.key, required this.game, required this.name});

  @override
  State<GameRoom> createState() => _GameRoomState();
}

const _result = {
  'won': 'YOU WON',
  'lost': 'YOU LOST',
  'draw': 'DRAW',
  'resigned': 'RESIGNED',
};

class _GameRoomState extends State<GameRoom> {
  String _mode = 'wyrd';
  GameMatch? _match;
  List<GameMatch> _open = [];
  List<GameMatch> _mine = [];
  bool _loading = true;
  bool _busy = false;
  String? _error;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (_mode == 'wyrd') {
        _match = await client.games.active(widget.game);
      } else {
        _match = null;
        await _loadLobby();
      }
    } catch (_) {
      _error = "Couldn't reach WYRD just now. Try again in a moment.";
    }
    if (mounted) setState(() => _loading = false);
    _watch();
  }

  Future<void> _loadLobby() async {
    final r = await Future.wait([
      client.games.openChallenges(widget.game),
      client.games.myPvp(),
    ]);
    if (!mounted) return;
    setState(() {
      _open = r[0];
      _mine = r[1].where((m) => m.game == widget.game).toList();
      _match ??= _mine.where((m) => m.status == 'waiting').firstOrNull;
    });
  }

  /// Against a person: look for their move (or for someone accepting) every few seconds.
  void _watch() {
    _poll?.cancel();
    final m = _match;
    if (_mode != 'pvp' || m == null || m.status == 'over') return;
    if (m.status == 'active' && _myTurn) return;
    _poll = Timer.periodic(const Duration(milliseconds: 2500), (_) async {
      final cur = _match;
      if (cur == null) return;
      try {
        final next = await client.games.poll(cur.id!, cur.version);
        if (next != null && mounted) {
          setState(() => _match = next);
          _watch();
        }
      } catch (_) {}
    });
  }

  Future<void> _run(Future<GameMatch?> Function() call) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final m = await call();
      if (mounted) setState(() => _match = m);
    } catch (e) {
      final msg = e.toString();
      if (mounted) {
        setState(
          () => _error =
              msg.contains('legal') ||
                  msg.contains('taken') ||
                  msg.contains('full')
              ? "That move isn't legal."
              : "Couldn't reach WYRD just now. Try again in a moment.",
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
      _watch();
    }
  }

  String get _side => _match?.viewerSide ?? _match?.playerSide ?? 'w';

  String _turnOf(GameMatch m) {
    if (m.game == 'chess')
      return ch.Chess.fromFEN(m.state).turn == ch.Color.WHITE ? 'w' : 'b';
    final s = jsonDecode(m.state) as Map<String, dynamic>;
    return ((s['t'] as num?)?.toInt() ?? 0) == 0 ? 'w' : 'b';
  }

  bool get _myTurn =>
      _match != null && _match!.status == 'active' && _turnOf(_match!) == _side;

  String _sideName(String side) {
    final first = side != 'b';
    return switch (widget.game) {
      'chess' => first ? 'WHITE' : 'BLACK',
      'reversi' => first ? 'DARK' : 'LIGHT',
      'tictactoe' => first ? 'X' : 'O',
      _ => first ? 'COBALT' : 'INK',
    };
  }

  String? get _resultText {
    final m = _match;
    if (m == null) return null;
    if (m.mode == 'pvp') {
      if (m.status != 'over') return null;
      final r = m.result ?? '';
      if (r.startsWith('draw')) return 'DRAW';
      final starterWon = r.startsWith('starter');
      final iAmStarter = _side == m.playerSide;
      return starterWon == iAmStarter ? 'YOU WON' : 'YOU LOST';
    }
    return _result[m.status];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WyrdColors.bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, box) {
            final wide = box.maxWidth >= 860;
            final boardSize = wide
                ? min(520.0, box.maxWidth - 32 - 320)
                : (box.maxWidth - 32).clamp(200.0, 520.0);
            final board = _boardArea(boardSize);
            final side = _sidePanel();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    '‹ ARCADE',
                    style: WyrdText.mono(
                      fontSize: 11,
                      color: WyrdColors.signal,
                    ).copyWith(letterSpacing: 1.6),
                  ),
                ),
                const SizedBox(height: 6),
                Text(widget.name, style: WyrdText.display(fontSize: 38)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (final (m, label) in const [
                      ('wyrd', 'VS WYRD'),
                      ('pvp', 'VS PLAYER'),
                    ])
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_mode == m) return;
                          setState(() => _mode = m);
                          _load();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _mode == m
                                ? WyrdColors.signal
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: _mode == m
                                  ? WyrdColors.signal
                                  : WyrdColors.greenBorder,
                            ),
                          ),
                          child: Text(
                            label,
                            style: WyrdText.mono(
                              fontSize: 10.5,
                              color: _mode == m
                                  ? WyrdColors.onSignal
                                  : WyrdColors.greenDim,
                            ).copyWith(letterSpacing: 1.2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_loading)
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: WyrdColors.signal,
                      ),
                    ),
                  )
                else if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: boardSize, child: board),
                      const SizedBox(width: 24),
                      Expanded(child: side),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: SizedBox(width: boardSize, child: board),
                      ),
                      const SizedBox(height: 16),
                      side,
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _boardArea(double size) {
    final m = _match;
    if (m == null || m.status == 'waiting') {
      return Container(
        height: widget.game == 'connect4' ? size * 6 / 7 : size,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: WyrdColors.card,
          border: Border.all(color: WyrdColors.greenBorderDim),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.name.toUpperCase(),
              style: WyrdText.display(fontSize: 36),
            ),
            const SizedBox(height: 6),
            Text(
              m?.status == 'waiting'
                  ? 'Your challenge is posted. The board opens when someone accepts.'
                  : _mode == 'wyrd'
                  ? 'Choose your side to begin.'
                  : 'Post a challenge, or accept one.',
              textAlign: TextAlign.center,
              style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
            ),
            if (m?.status == 'waiting') ...[
              const SizedBox(height: 12),
              CircularProgressIndicator(color: WyrdColors.signal),
            ],
          ],
        ),
      );
    }
    final play = _myTurn && !_busy;
    void send(String move) => _run(() => client.games.move(m.id!, move));
    final last = m.moves.isEmpty ? null : m.moves.last;
    final me = _side == 'w' ? 0 : 1;
    return switch (m.game) {
      'chess' => ChessBoardView(
        fen: m.state,
        side: _side,
        enabled: play,
        onMove: send,
        moves: m.moves,
      ),
      'connect4' => GridBoard(
        state: m.state,
        cols: 7,
        rows: 6,
        me: me,
        enabled: play,
        kind: 'c4',
        last: last,
        onTap: (i) => send('${i % 7}'),
      ),
      'reversi' => GridBoard(
        state: m.state,
        cols: 8,
        rows: 8,
        me: me,
        enabled: play,
        kind: 'rev',
        last: last,
        onTap: (i) => send('$i'),
      ),
      _ => GridBoard(
        state: m.state,
        cols: 3,
        rows: 3,
        me: me,
        enabled: play,
        kind: 'ttt',
        last: last,
        onTap: (i) => send('$i'),
      ),
    };
  }

  Widget _tag(String text, {bool on = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: on ? WyrdColors.signal : Colors.transparent,
      border: Border.all(
        color: on ? WyrdColors.signal : WyrdColors.greenBorder,
      ),
    ),
    child: Text(
      text,
      style: WyrdText.mono(
        fontSize: 9.5,
        color: on ? WyrdColors.onSignal : WyrdColors.greenDim,
      ).copyWith(letterSpacing: 1.2),
    ),
  );

  Widget _btn(
    String label,
    VoidCallback onTap, {
    bool primary = false,
    bool danger = false,
  }) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: _busy ? null : onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary ? WyrdColors.signal : Colors.transparent,
        border: Border.all(
          color: danger
              ? WyrdColors.danger
              : primary
              ? WyrdColors.signal
              : WyrdColors.greenBorder,
        ),
      ),
      child: Text(
        label,
        style: WyrdText.mono(
          fontSize: 10.5,
          color: primary
              ? WyrdColors.onSignal
              : danger
              ? WyrdColors.danger
              : WyrdColors.mint,
        ).copyWith(letterSpacing: 1.2),
      ),
    ),
  );

  Widget _sidePanel() {
    final m = _match;
    final result = _resultText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (m != null) ...[
          Container(
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: WyrdColors.signal, width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 5, right: 8),
                  decoration: BoxDecoration(
                    color: _busy ? WyrdColors.ochre : WyrdColors.signal,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    _busy && m.mode == 'wyrd'
                        ? 'WYRD is thinking…'
                        : (m.remark ?? ''),
                    style: WyrdText.mono(fontSize: 13).copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (m.mode == 'wyrd')
                _tag('WYRD · ${_levels[m.wyrdLevel.clamp(1, 6)]}')
              else
                _tag(
                  '${(m.playerName ?? '?').toUpperCase()} vs ${(m.opponentName ?? '…').toUpperCase()}',
                ),
              _tag('YOU PLAY ${_sideName(_side)}'),
              if (m.status == 'active')
                _tag(_myTurn ? 'YOUR MOVE' : 'THEIR MOVE', on: _myTurn),
              if (m.game == 'reversi' && m.status != 'waiting')
                _tag(_reversiCount(m.state)),
            ],
          ),
          if (result != null) ...[
            const SizedBox(height: 12),
            Text(result, style: WyrdText.display(fontSize: 32)),
            if (m.mode == 'wyrd' && m.ratingAfter != null)
              Text(
                'Rating ${m.ratingAfter!.round()} (${m.ratingAfter! >= m.ratingBefore ? '+' : ''}${(m.ratingAfter! - m.ratingBefore).round()})',
                style: WyrdText.mono(fontSize: 12, color: WyrdColors.greenDim),
              ),
          ],
          if (m.game == 'chess' && m.moves.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              constraints: const BoxConstraints(maxHeight: 180),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: WyrdColors.greenBorderDim),
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < m.moves.length; i += 2)
                      Text(
                        '${i ~/ 2 + 1}. ${m.moves[i]}${i + 1 < m.moves.length ? '  ${m.moves[i + 1]}' : ''}',
                        style: WyrdText.mono(fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
        ],
        if (_mode == 'wyrd') ...[
          if (m == null || m.status != 'active') ...[
            Text(
              'NEW GAME',
              style: WyrdText.mono(
                fontSize: 9.5,
                color: WyrdColors.greenDim,
              ).copyWith(letterSpacing: 1.6),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _btn(
                    'GO FIRST',
                    () => _run(() => client.games.start(widget.game, 'w')),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _btn(
                    'RANDOM',
                    () => _run(() => client.games.start(widget.game, 'random')),
                    primary: true,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _btn(
                    'GO SECOND',
                    () => _run(() => client.games.start(widget.game, 'b')),
                  ),
                ),
              ],
            ),
            if (widget.game == 'chess') ...[
              const SizedBox(height: 10),
              _btn(
                'ACCEPT WYRD’S CHALLENGE · FULL STRENGTH',
                () => _run(() => client.games.wyrdChallenge()),
              ),
            ],
          ],
        ] else
          _lobby(),
        if (m != null && m.status == 'active') ...[
          const SizedBox(height: 10),
          _btn(
            'RESIGN',
            () => _run(() => client.games.resign(m.id!)),
            danger: true,
          ),
        ],
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              _error!,
              style: WyrdText.mono(fontSize: 12, color: WyrdColors.danger),
            ),
          ),
      ],
    );
  }

  /// Against a person: post a challenge, accept one, or pick up a game under way.
  Widget _lobby() {
    final waiting = _match?.status == 'waiting'
        ? _match
        : _mine.where((m) => m.status == 'waiting').firstOrNull;
    final ongoing = _mine
        .where((m) => m.status == 'active' && m.id != _match?.id)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (waiting != null)
          Row(
            children: [
              Expanded(flex: 2, child: _btn('CHALLENGE POSTED', () {})),
              const SizedBox(width: 6),
              Expanded(
                child: _btn('CANCEL', () async {
                  await _run(() async {
                    await client.games.cancel(waiting.id!);
                    return null;
                  });
                  await _loadLobby();
                }),
              ),
            ],
          )
        else
          _btn(
            'POST A CHALLENGE',
            () => _run(() => client.games.challenge(widget.game)),
            primary: true,
          ),
        if (ongoing.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'YOUR GAMES',
            style: WyrdText.mono(
              fontSize: 9.5,
              color: WyrdColors.greenDim,
            ).copyWith(letterSpacing: 1.6),
          ),
          for (final g in ongoing)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() => _match = g);
                _watch();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: WyrdColors.greenBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'vs ${g.viewerSide == g.playerSide ? g.opponentName : g.playerName}',
                        style: WyrdText.mono(fontSize: 12),
                      ),
                    ),
                    _tag(
                      _turnOf(g) == g.viewerSide ? 'YOUR MOVE' : 'WAITING',
                      on: _turnOf(g) == g.viewerSide,
                    ),
                  ],
                ),
              ),
            ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                'OPEN CHALLENGES · ${widget.name.toUpperCase()}',
                style: WyrdText.mono(
                  fontSize: 9.5,
                  color: WyrdColors.greenDim,
                ).copyWith(letterSpacing: 1.6),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _loadLobby,
              child: Text(
                'REFRESH',
                style: WyrdText.mono(fontSize: 10, color: WyrdColors.signal),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (_open.isEmpty)
          Text(
            'No open challenges right now. Post one and someone can take you on.',
            style: WyrdText.mono(
              fontSize: 11.5,
              color: WyrdColors.greenDim,
            ).copyWith(height: 1.5),
          ),
        for (final o in _open)
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: WyrdColors.greenBorder),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${o.playerName ?? 'player'} · ${o.ratingBefore.round()}',
                    style: WyrdText.mono(fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: _btn(
                    'ACCEPT',
                    () => _run(() => client.games.accept(o.id!)),
                    primary: true,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static String _reversiCount(String state) {
    final b = ((jsonDecode(state) as Map<String, dynamic>)['b'] as List).map(
      (e) => (e as num).toInt(),
    );
    return '${b.where((v) => v == 0).length} : ${b.where((v) => v == 1).length}';
  }
}

/// Connect Four, Reversi and Tic-tac-toe, as the main app draws them (Boards.tsx): the first player
/// terracotta (or dark, in Reversi), the second indigo (or light); the last move marked; in
/// Reversi, dots on the squares you can play.
class GridBoard extends StatelessWidget {
  final String state;
  final int cols, rows;
  final int me; // 0: you play first
  final bool enabled;
  final String kind; // c4, rev, ttt
  final String? last;
  final void Function(int index) onTap;

  const GridBoard({
    required this.state,
    required this.cols,
    required this.rows,
    required this.me,
    required this.enabled,
    required this.kind,
    required this.last,
    required this.onTap,
  });

  static const _dirs = [
    (-1, -1),
    (-1, 0),
    (-1, 1),
    (0, -1),
    (0, 1),
    (1, -1),
    (1, 0),
    (1, 1),
  ];

  static Set<int> _reversiMoves(List<int> b, int t) {
    final out = <int>{};
    for (var i = 0; i < 64; i++) {
      if (b[i] != -1) continue;
      final r0 = i ~/ 8, c0 = i % 8;
      for (final (dr, dc) in _dirs) {
        var r = r0 + dr, c = c0 + dc, n = 0;
        while (r >= 0 && r < 8 && c >= 0 && c < 8 && b[r * 8 + c] == 1 - t) {
          r += dr;
          c += dc;
          n++;
        }
        if (n > 0 && r >= 0 && r < 8 && c >= 0 && c < 8 && b[r * 8 + c] == t) {
          out.add(i);
          break;
        }
      }
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final s = jsonDecode(state) as Map<String, dynamic>;
    final b = (s['b'] as List).map((e) => (e as num).toInt()).toList();
    final hints = kind == 'rev' && enabled
        ? _reversiMoves(b, me)
        : const <int>{};
    // the last move as a square (Connect Four records a column: mark its top disc)
    int? lastSq = int.tryParse(last ?? '');
    if (kind == 'c4' && lastSq != null) {
      final col = lastSq;
      lastSq = null;
      for (var r = 0; r < rows; r++) {
        if (b[r * cols + col] != -1) {
          lastSq = r * cols + col;
          break;
        }
      }
    }
    final boardBg = WyrdColors.dark
        ? const Color(0xFF28211C)
        : (kind == 'ttt' ? Colors.white : const Color(0xFFEEF0F5));
    return Container(
      decoration: BoxDecoration(
        color: boardBg,
        border: Border.all(color: WyrdColors.mint),
      ),
      child: AspectRatio(
        aspectRatio: cols / rows,
        child: GridView.count(
          crossAxisCount: cols,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            for (var i = 0; i < cols * rows; i++)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: !enabled || (kind == 'rev' && !hints.contains(i))
                    ? null
                    : () => onTap(i),
                child: Container(
                  decoration: BoxDecoration(
                    color: lastSq == i
                        ? WyrdColors.signalSoft
                        : Colors.transparent,
                    border: kind == 'c4'
                        ? null
                        : Border.all(
                            color: WyrdColors.greenBorder.withValues(
                              alpha: 0.6,
                            ),
                            width: 0.5,
                          ),
                  ),
                  alignment: Alignment.center,
                  child: switch (kind) {
                    'ttt' =>
                      b[i] == -1
                          ? null
                          : FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  b[i] == 0 ? 'X' : 'O',
                                  style: WyrdText.mono(
                                    fontSize: 48,
                                    color: b[i] == 0
                                        ? WyrdColors.signal
                                        : WyrdColors.indigo,
                                  ),
                                ),
                              ),
                            ),
                    'c4' => FractionallySizedBox(
                      widthFactor: 0.78,
                      heightFactor: 0.78,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: b[i] == 0
                              ? WyrdColors.signal
                              : b[i] == 1
                              ? WyrdColors.indigo
                              : (WyrdColors.dark
                                    ? WyrdColors.bg
                                    : Colors.white),
                          border: Border.all(
                            color: b[i] == -1
                                ? WyrdColors.greenBorderDim
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    _ =>
                      b[i] != -1
                          ? FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.8,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: b[i] == 0
                                      ? WyrdColors.indigo
                                      : Colors.white,
                                  border: Border.all(color: WyrdColors.indigo),
                                ),
                              ),
                            )
                          : hints.contains(i)
                          ? FractionallySizedBox(
                              widthFactor: 0.22,
                              heightFactor: 0.22,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WyrdColors.signal.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                            )
                          : null,
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A chess board from a FEN, from your side. Tap a piece of yours to see where it can go, then a
/// highlighted square to move there (a pawn reaching the end becomes a queen).
class ChessBoardView extends StatefulWidget {
  final String fen;
  final String side;
  final bool enabled;
  final void Function(String move) onMove;
  final List<String> moves; // the game so far (SAN), to mark the last move

  const ChessBoardView({
    super.key,
    required this.fen,
    required this.side,
    required this.enabled,
    required this.onMove,
    this.moves = const [],
  });

  @override
  State<ChessBoardView> createState() => _ChessBoardViewState();
}

class _ChessBoardViewState extends State<ChessBoardView> {
  String? _picked;

  static const _glyph = {
    'k': '♚',
    'q': '♛',
    'r': '♜',
    'b': '♝',
    'n': '♞',
    'p': '♟',
  };

  @override
  void didUpdateWidget(ChessBoardView old) {
    super.didUpdateWidget(old);
    if (old.fen != widget.fen) _picked = null;
  }

  @override
  Widget build(BuildContext context) {
    final g = ch.Chess.fromFEN(widget.fen);
    final mine = widget.side == 'w' ? ch.Color.WHITE : ch.Color.BLACK;
    final targets = _picked == null
        ? <String>{}
        : {
            for (final mv in g.generate_moves())
              if (mv.fromAlgebraic == _picked) mv.toAlgebraic,
          };
    final files = widget.side == 'w'
        ? 'abcdefgh'.split('')
        : 'hgfedcba'.split('');
    final ranks = widget.side == 'w'
        ? [8, 7, 6, 5, 4, 3, 2, 1]
        : [1, 2, 3, 4, 5, 6, 7, 8];
    // the main app's board: white and cool grey by day, walnut at night
    final light = WyrdColors.dark ? const Color(0xFF3D332B) : Colors.white;
    final darkSq = WyrdColors.dark
        ? const Color(0xFF28211C)
        : const Color(0xFFE9EBF1);
    // the last move: replay the game to find where it went from and to
    final lastSqs = <String>{};
    if (widget.moves.isNotEmpty) {
      try {
        final replay = ch.Chess();
        ch.Move? lastMove;
        for (final san in widget.moves) {
          final legal = replay.generate_moves();
          lastMove = legal.firstWhere((m) => replay.move_to_san(m) == san);
          replay.make_move(lastMove);
        }
        if (lastMove != null)
          lastSqs.addAll([lastMove.fromAlgebraic, lastMove.toAlgebraic]);
      } catch (_) {}
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(color: WyrdColors.mint)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            for (var r = 0; r < 8; r++)
              Expanded(
                child: Row(
                  children: [
                    for (var f = 0; f < 8; f++)
                      Expanded(
                        child: Builder(
                          builder: (_) {
                            final sq = '${files[f]}${ranks[r]}';
                            final p = g.get(sq);
                            final isDark = (r + f) % 2 == 1;
                            final picked = _picked == sq;
                            final target = targets.contains(sq);
                            return GestureDetector(
                              onTap: !widget.enabled
                                  ? null
                                  : () {
                                      if (target) {
                                        widget.onMove('$_picked$sq');
                                        setState(() => _picked = null);
                                      } else if (p != null && p.color == mine) {
                                        setState(
                                          () => _picked = picked ? null : sq,
                                        );
                                      } else {
                                        setState(() => _picked = null);
                                      }
                                    },
                              child: Container(
                                color: picked
                                    ? WyrdColors.signal
                                    : lastSqs.contains(sq)
                                    ? Color.alphaBlend(
                                        const Color(0x292A46FF),
                                        isDark ? darkSq : light,
                                      )
                                    : (isDark ? darkSq : light),
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (p != null)
                                      FittedBox(
                                        child: Text(
                                          _glyph[p.type.name] ?? '',
                                          style: TextStyle(
                                            fontSize: 40,
                                            height: 1,
                                            color: p.color == ch.Color.WHITE
                                                ? const Color(0xFFFFFAF2)
                                                : const Color(0xFF2A1F17),
                                            shadows: [
                                              Shadow(
                                                color: p.color == ch.Color.WHITE
                                                    ? const Color(0xFF2A1F17)
                                                    : const Color(0x00000000),
                                                blurRadius: 1.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (target)
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: WyrdColors.signal.withValues(
                                            alpha: 0.75,
                                          ),
                                          shape: BoxShape.circle,
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
