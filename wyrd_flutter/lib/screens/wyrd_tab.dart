import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wyrd_client/wyrd_client.dart';
import '../widgets/frame/page_text_stub.dart'
    if (dart.library.js_interop) '../widgets/frame/page_text_web.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/glass.dart';
import '../widgets/brain_canvas.dart';
import '../widgets/holo.dart';
import '../widgets/glass_panel.dart';
import 'dialogue_screen.dart';
import 'games_tab.dart';

/// WYRD's home, as in the main app: its brain across the top (ENTER 3D, or a tap, looks inside),
/// then its last thought, the Dialogue Link bar and WYRD's open chess challenge. On a wide screen
/// the brain takes the left and the cards a column on the right, under a greeting.
class WyrdTab extends StatefulWidget {
  final VoidCallback? onPlayChess;
  const WyrdTab({super.key, this.onPlayChess});

  @override
  State<WyrdTab> createState() => _WyrdTabState();
}

class _WyrdTabState extends State<WyrdTab> {
  Mind? _mind;
  int _activitySignal = 0;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _loadMind();
    // poll, so background ticks (reasoning, self-questions, reading) show up as brain activity
    _pollTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _loadMind(),
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadMind() async {
    try {
      final mind = await client.mind.getMind();
      if (!mounted) return;
      setState(() {
        if (_mind != null && _mind!.updatedAt != mind.updatedAt) {
          _activitySignal++;
        }
        _mind = mind;
      });
    } catch (_) {
      // the readouts keep the last known values
    }
  }

  String get _greeting {
    final h = DateTime.now().hour;
    return h < 12
        ? 'Good morning'
        : h < 17
        ? 'Good afternoon'
        : 'Good evening';
  }

  Future<void> _openDialogue([String? prompt]) async {
    // Dialogue Link: glass, sliding in from the right (a pop-up on phones), as in the main app
    await openGlassPanel(
      context,
      title: 'DIALOGUE_LINK',
      icon: Icons.forum_outlined,
      side: GlassSide.right,
      maxWidth: 760,
      child: DialogueScreen(
        prompt: prompt,
        embedded: true,
        page: pageText(),
        screen:
            'the home screen (WYRD tab: its brain, last thought, Dialogue Link box, chess challenge)',
      ),
    );
    _loadMind();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    final cards = <Widget>[
      _lastThought(),
      const SizedBox(height: 10),
      _DialogueLauncher(onOpen: _openDialogue),
      const SizedBox(height: 10),
      const _ChessChallenge(),
    ];
    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _brain()),
          Container(
            width: 400,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: WyrdColors.greenBorderDim),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(_greeting, style: WyrdText.display(fontSize: 36)),
                Text(
                  'WYRD has been thinking while you were away.',
                  style: WyrdText.mono(
                    fontSize: 12,
                    color: WyrdColors.greenDim,
                  ),
                ),
                const SizedBox(height: 14),
                ...cards,
              ],
            ),
          ),
        ],
      );
    }
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 320, child: _brain()),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cards,
          ),
        ),
      ],
    );
  }

  /// The brain, its mood, ENTER 3D, and the hint underneath.
  Widget _brain() {
    final mind = _mind;
    return GestureDetector(
      onTap: _lookInside,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: WyrdColors.greenBorderDim)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BrainCanvas(activitySignal: _activitySignal),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MOOD',
                    style: WyrdText.mono(
                      fontSize: 9,
                      color: WyrdColors.greenDim,
                    ).copyWith(letterSpacing: 3),
                  ),
                  Text(
                    mind?.mood ?? '—',
                    style: WyrdText.display(fontSize: 46),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: _lookInside,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: WyrdColors.glassBg,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: WyrdColors.green.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.blur_on, size: 18, color: WyrdColors.signal),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ENTER 3D',
                            style: WyrdText.mono(
                              fontSize: 11,
                            ).copyWith(letterSpacing: 1.6),
                          ),
                          Text(
                            'BRAIN_3D ↗',
                            style: WyrdText.mono(
                              fontSize: 7.5,
                              color: WyrdColors.greenDim,
                            ).copyWith(letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Text(
                'TAP THE BRAIN TO LOOK INSIDE',
                textAlign: TextAlign.center,
                style: WyrdText.mono(
                  fontSize: 8.5,
                  color: WyrdColors.greenBorder,
                ).copyWith(letterSpacing: 2.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// BRAIN_3D: a glass pop-up over the home screen with what's going on inside WYRD.
  void _lookInside() {
    final mind = _mind;
    final curPct = (mind?.curiosity ?? 0) * 100;
    final confPct = (mind?.confidence ?? 0) * 100;
    final digestPct = (mind?.digest.percent ?? 0).toDouble();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.18),
      transitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (context, _, _) => SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900, maxHeight: 640),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: glassFilter(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: glassDecoration(24),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 6, 6),
                            child: Row(
                              children: [
                                Icon(Icons.blur_on, color: WyrdColors.signal),
                                const SizedBox(width: 8),
                                Text(
                                  'BRAIN_3D',
                                  style: WyrdText.display(fontSize: 26),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(
                                    Icons.close,
                                    color: WyrdColors.greenDim,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: BrainCanvas(
                                    activitySignal: _activitySignal,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 16,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MOOD',
                                        style: WyrdText.mono(
                                          fontSize: 9,
                                          color: WyrdColors.greenDim,
                                        ).copyWith(letterSpacing: 2.2),
                                      ),
                                      Text(
                                        mind?.mood ?? '—',
                                        style: WyrdText.display(fontSize: 34),
                                      ),
                                      Text(
                                        'focus · ${mind?.focusTopic ?? 'nothing yet'}',
                                        style: WyrdText.mono(
                                          fontSize: 11,
                                          color: WyrdColors.greenDim,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: HoloReadout(
                                    label: 'CURIOSITY',
                                    value: '${curPct.round()}%',
                                    pct: curPct,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: HoloReadout(
                                    label: 'DIGESTED',
                                    value: '${digestPct.round()}%',
                                    pct: digestPct,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: HoloReadout(
                                    label: 'CONFIDENCE',
                                    value: '${confPct.round()}%',
                                    pct: confPct,
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
      ),
      // it springs in from a little smaller and lower, overshooting a touch, as in the main app
      transitionBuilder: (context, anim, _, child) {
        final spring = CurvedAnimation(
          parent: anim,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
        );
        final fade = CurvedAnimation(parent: anim, curve: Curves.easeOut);
        return FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: Tween(begin: 0.86, end: 1.0).animate(spring),
            child: child,
          ),
        );
      },
    );
  }

  Widget _lastThought() => Container(
    padding: const EdgeInsets.all(14),
    decoration: wyrdCard(radius: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('LAST THOUGHT'),
        const SizedBox(height: 8),
        Text(
          _mind?.activeGoal ?? 'still forming one.',
          style: WyrdText.mono(fontSize: 13.5).copyWith(height: 1.55),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _eyebrow(String text, {Color? color}) => Row(
  children: [
    Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: WyrdColors.signal,
        shape: BoxShape.circle,
      ),
    ),
    const SizedBox(width: 7),
    Text(
      text,
      style: WyrdText.mono(
        fontSize: 9,
        color: color ?? WyrdColors.greenDim,
      ).copyWith(letterSpacing: 1.8),
    ),
  ],
);

/// The Dialogue Link bar: WYRD's prompts typing themselves out, and the way into the conversation.
class _DialogueLauncher extends StatefulWidget {
  final void Function([String? prompt]) onOpen;
  const _DialogueLauncher({required this.onOpen});

  @override
  State<_DialogueLauncher> createState() => _DialogueLauncherState();
}

class _DialogueLauncherState extends State<_DialogueLauncher> {
  static const _prompts = [
    'what did you learn today?',
    'what are you thinking about right now?',
    'remember that my exam is on Friday',
    'draw me a chart of the naira this week',
  ];
  int _p = 0;
  int _chars = 0;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(milliseconds: 70), (_) {
      if (!mounted) return;
      setState(() {
        final full = _prompts[_p].length;
        if (_chars < full + 30) {
          _chars++; // type it out, then hold a moment
        } else {
          _p = (_p + 1) % _prompts.length;
          _chars = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = _prompts[_p];
    final shown = text.substring(0, _chars.clamp(0, text.length));
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => widget.onOpen(),
      child: Ink(
        padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
        decoration: wyrdCard(
          radius: 18,
          color: WyrdColors.dark
              ? const Color(0xFF221A14)
              : const Color(0xFFFFF4E8),
          border: WyrdColors.signal.withValues(alpha: 0.7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eyebrow(
              'DIALOGUE_LINK · WYRD IS LISTENING',
              color: WyrdColors.ochre,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '> $shown${_chars % 14 < 7 ? '|' : ' '}',
                    style: WyrdText.mono(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: WyrdColors.signal,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: WyrdColors.onSignal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// WYRD's open challenge: chess at full strength, one tap to the board.
class _ChessChallenge extends StatefulWidget {
  const _ChessChallenge();

  @override
  State<_ChessChallenge> createState() => _ChessChallengeState();
}

class _ChessChallengeState extends State<_ChessChallenge> {
  bool _busy = false;

  Future<void> _accept() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await client.games.wyrdChallenge();
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const GameRoom(game: 'chess', name: 'Chess'),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't start the game just now.")),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const cream = Color(0xFFFFF6EA);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: _accept,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: WyrdColors.dark
              ? const Color(0xFF221B2E)
              : const Color(0xFF2A1F17),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: WyrdColors.dark
                ? const Color(0x59C792EA)
                : const Color(0xFF2A1F17),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: WyrdColors.signal.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
              child: const Text(
                '♚',
                style: TextStyle(fontSize: 26, color: cream),
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
                    'Beat me at chess.',
                    style: WyrdText.display(fontSize: 22, color: cream),
                  ),
                  Text(
                    'Full strength. No easy mode.',
                    style: WyrdText.mono(
                      fontSize: 11.5,
                      color: const Color(0xFFCDBBA6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: WyrdColors.signal,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                _busy ? '…' : 'ACCEPT ♟',
                style: WyrdText.mono(
                  fontSize: 10.5,
                  color: WyrdColors.onSignal,
                ).copyWith(letterSpacing: 1.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
