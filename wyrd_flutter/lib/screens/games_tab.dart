import 'dart:convert';

import 'package:chess/chess.dart' as ch;
import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/holo.dart';

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
  Map<String, int> _ratings = {};

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  Future<void> _loadRatings() async {
    try {
      final rs = await client.games.myRatings();
      if (mounted) {
        setState(
          () => _ratings = {for (final r in rs) r.game: r.rating.round()},
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
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
            'Every game is rated. WYRD plays at your level, and says what it thinks of your moves.',
            style: WyrdText.mono(
              fontSize: 12,
              color: WyrdColors.greenDim,
            ).copyWith(height: 1.5),
          ),
          const SizedBox(height: 16),
          for (final g in _games)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
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
                    padding: const EdgeInsets.all(16),
                    decoration: wyrdCard(),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: WyrdColors.signalSoft,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            g.glyph,
                            style: TextStyle(
                              fontSize: 24,
                              color: WyrdColors.signal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                g.name,
                                style: WyrdText.display(fontSize: 26),
                              ),
                              Text(
                                g.blurb,
                                style: WyrdText.mono(
                                  fontSize: 11.5,
                                  color: WyrdColors.greenDim,
                                ).copyWith(height: 1.4),
                              ),
                              if (_ratings[g.key] != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'RATING ${_ratings[g.key]}',
                                    style: WyrdText.mono(
                                      fontSize: 9.5,
                                      color: WyrdColors.signal,
                                    ).copyWith(letterSpacing: 1.4),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          'PLAY →',
                          style: WyrdText.mono(
                            fontSize: 11,
                            color: WyrdColors.signal,
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
    );
  }
}

/// One game against WYRD: the board, whose move it is, WYRD's line, and the controls.
class GameRoom extends StatefulWidget {
  final String game;
  final String name;
  const GameRoom({super.key, required this.game, required this.name});

  @override
  State<GameRoom> createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  GameMatch? _match;
  bool _loading = true;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final m = await client.games.active(widget.game);
      if (mounted) setState(() => _match = m);
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = "Couldn't reach WYRD just now. Try again in a moment.",
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _run(Future<GameMatch> Function() call) async {
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
    }
  }

  String get _side => _match?.viewerSide ?? _match?.playerSide ?? 'w';

  bool get _myTurn {
    final m = _match;
    if (m == null || m.status != 'active') return false;
    if (m.game == 'chess') {
      final turn = ch.Chess.fromFEN(m.state).turn == ch.Color.WHITE ? 'w' : 'b';
      return turn == _side;
    }
    final s = jsonDecode(m.state) as Map<String, dynamic>;
    return ((s['t'] as num?)?.toInt() ?? 0) == (_side == 'w' ? 0 : 1);
  }

  String get _status {
    final m = _match!;
    return switch (m.status) {
      'won' => 'YOU WON',
      'lost' => 'WYRD WON',
      'draw' => 'A DRAW',
      'resigned' => 'YOU RESIGNED',
      _ =>
        _busy
            ? 'WYRD IS THINKING…'
            : _myTurn
            ? 'YOUR MOVE'
            : 'WYRD TO MOVE',
    };
  }

  @override
  Widget build(BuildContext context) {
    final m = _match;
    return Scaffold(
      backgroundColor: WyrdColors.bg,
      appBar: AppBar(
        backgroundColor: WyrdColors.barBg,
        surfaceTintColor: Colors.transparent,
        foregroundColor: WyrdColors.mint,
        title: Text(widget.name, style: WyrdText.display(fontSize: 28)),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator(color: WyrdColors.signal))
          : LayoutBuilder(
              builder: (context, box) {
                final boardSize = (box.maxWidth - 32).clamp(200.0, 520.0);
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (m == null || m.status != 'active') _startPanel(m),
                    if (m != null) ...[
                      _remark(m),
                      const SizedBox(height: 12),
                      Center(
                        child: SizedBox(
                          width: boardSize,
                          child: _board(m, boardSize),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (m.status == 'active')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 160,
                              child: HoloButton(
                                label: 'RESIGN',
                                tone: 'danger',
                                onPressed: () =>
                                    _run(() => client.games.resign(m.id!)),
                              ),
                            ),
                          ],
                        ),
                    ],
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: WyrdText.mono(
                            fontSize: 12,
                            color: WyrdColors.danger,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }

  /// A new game: your side, and for chess WYRD's open challenge at full strength.
  Widget _startPanel(GameMatch? last) {
    Widget side(String label, String s, {bool filled = false}) => Expanded(
      child: HoloButton(
        label: label,
        filled: filled,
        onPressed: () => _run(() => client.games.start(widget.game, s)),
      ),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: wyrdCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            last == null ? 'NEW GAME' : 'PLAY AGAIN',
            style: WyrdText.mono(
              fontSize: 9.5,
              color: WyrdColors.greenDim,
            ).copyWith(letterSpacing: 1.6),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              side('GO FIRST', 'w'),
              const SizedBox(width: 8),
              side('RANDOM', 'random', filled: true),
              const SizedBox(width: 8),
              side('GO SECOND', 'b'),
            ],
          ),
          if (widget.game == 'chess') ...[
            const SizedBox(height: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _run(() => client.games.wyrdChallenge()),
                child: Ink(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: WyrdColors.dark
                        ? const Color(0xFF221B2E)
                        : const Color(0xFF2A1F17),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '♚',
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFFFFF6EA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OPEN CHALLENGE · FROM WYRD',
                              style: WyrdText.mono(
                                fontSize: 8.5,
                                color: const Color(0xFFE8A88A),
                              ).copyWith(letterSpacing: 1.6),
                            ),
                            Text(
                              'Full strength. No easy mode.',
                              style: WyrdText.display(
                                fontSize: 22,
                                color: const Color(0xFFFFF6EA),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'ACCEPT',
                        style: WyrdText.mono(
                          fontSize: 11,
                          color: WyrdColors.signal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// WYRD's last line, how strong it's playing, and whose move it is.
  Widget _remark(GameMatch m) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: wyrdCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'WYRD · ${_levels[m.wyrdLevel.clamp(1, 6)]}',
                style: WyrdText.mono(
                  fontSize: 9.5,
                  color: WyrdColors.signal,
                ).copyWith(letterSpacing: 1.4),
              ),
              const Spacer(),
              Text(
                _status,
                style: WyrdText.mono(
                  fontSize: 9.5,
                  color: WyrdColors.greenDim,
                ).copyWith(letterSpacing: 1.4),
              ),
            ],
          ),
          if ((m.remark ?? '').isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              '"${m.remark}"',
              style: WyrdText.mono(fontSize: 13.5).copyWith(height: 1.5),
            ),
          ],
          if (m.status != 'active' && m.ratingAfter != null) ...[
            const SizedBox(height: 6),
            Text(
              'Rating ${m.ratingBefore.round()} → ${m.ratingAfter!.round()}',
              style: WyrdText.mono(fontSize: 11.5, color: WyrdColors.greenDim),
            ),
          ],
        ],
      ),
    );
  }

  Widget _board(GameMatch m, double size) {
    final play = _myTurn && !_busy;
    void send(String move) => _run(() => client.games.move(m.id!, move));
    return switch (m.game) {
      'chess' => ChessBoardView(
        fen: m.state,
        side: _side,
        enabled: play,
        onMove: send,
      ),
      'connect4' => _GridBoard(
        state: m.state,
        cols: 7,
        rows: 6,
        side: _side,
        enabled: play,
        discs: true,
        onTap: (i) => send('${i % 7}'),
      ),
      'reversi' => _GridBoard(
        state: m.state,
        cols: 8,
        rows: 8,
        side: _side,
        enabled: play,
        discs: true,
        onTap: (i) => send('$i'),
      ),
      _ => _GridBoard(
        state: m.state,
        cols: 3,
        rows: 3,
        side: _side,
        enabled: play,
        discs: false,
        onTap: (i) => send('$i'),
      ),
    };
  }
}

/// Connect Four, Reversi and Tic-tac-toe: a grid of cells, -1 empty, 0 the first player, 1 the
/// second. Your pieces are terracotta, WYRD's indigo.
class _GridBoard extends StatelessWidget {
  final String state;
  final int cols, rows;
  final String side;
  final bool enabled;
  final bool discs;
  final void Function(int index) onTap;

  const _GridBoard({
    required this.state,
    required this.cols,
    required this.rows,
    required this.side,
    required this.enabled,
    required this.discs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final b = ((jsonDecode(state) as Map<String, dynamic>)['b'] as List)
        .map((e) => (e as num).toInt())
        .toList();
    final me = side == 'w' ? 0 : 1;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: wyrdCard(
        radius: 18,
        color: discs ? WyrdColors.sand : WyrdColors.card,
      ),
      child: AspectRatio(
        aspectRatio: cols / rows,
        child: GridView.count(
          crossAxisCount: cols,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          children: [
            for (var i = 0; i < cols * rows; i++)
              InkWell(
                borderRadius: BorderRadius.circular(discs ? 999 : 12),
                onTap: enabled ? () => onTap(i) : null,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: discs
                        ? (b[i] == -1
                              ? WyrdColors.bg
                              : b[i] == me
                              ? WyrdColors.signal
                              : WyrdColors.indigo)
                        : WyrdColors.bg,
                    shape: discs ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: discs ? null : BorderRadius.circular(12),
                    border: Border.all(color: WyrdColors.greenBorder),
                  ),
                  child: discs || b[i] == -1
                      ? null
                      : Text(
                          b[i] == 0 ? '✕' : '○',
                          style: TextStyle(
                            fontSize: 40,
                            color: b[i] == me
                                ? WyrdColors.signal
                                : WyrdColors.indigo,
                          ),
                        ),
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

  const ChessBoardView({
    super.key,
    required this.fen,
    required this.side,
    required this.enabled,
    required this.onMove,
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
    final light = WyrdColors.dark
        ? const Color(0xFF3D332B)
        : const Color(0xFFFFFAF2);
    final darkSq = WyrdColors.dark
        ? const Color(0xFF28211C)
        : const Color(0xFFE6D3B5);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
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
