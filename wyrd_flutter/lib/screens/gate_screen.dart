import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/gate_vortex.dart';
import 'auth_panel.dart';

/// The gate, as in the main app (GateScreen.tsx): WYRD's dust vortex on the cream ground and its
/// wordmark glitching between words. A tap on it enters -- the dust blooms, and the sign-in card
/// rises out of it; its × goes back to the closed gate.
class GateScreen extends StatefulWidget {
  const GateScreen({super.key});

  @override
  State<GateScreen> createState() => _GateScreenState();
}

const _words = [
  'WYRD',
  'WHAT COMES TO BE',
  'FATE',
  'CLICK TO SIGN IN',
  'WELCOME',
];

class _GateScreenState extends State<GateScreen> {
  final _vortex = GlobalKey<GateVortexState>();
  bool _open = false;

  void _enter() {
    _vortex.currentState?.setIntensity(1);
    _vortex.currentState?.scatter(true); // the stage clears for sign-in
    Timer(const Duration(milliseconds: 380), () {
      _vortex.currentState?.setIntensity(0);
      if (mounted) setState(() => _open = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the gate is always the cream of a Lagos afternoon, as in the main app
      backgroundColor: const Color(0xFFF7EFE2),
      body: Stack(
        children: [
          Positioned.fill(child: GateVortex(key: _vortex)),
          if (!_open)
            Center(
              child: GestureDetector(
                onTap: _enter,
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _GlitchWord(),
                ),
              ),
            ),
          if (_open)
            Positioned.fill(
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.easeOutCubic,
                      builder: (context, t, child) => Opacity(
                        opacity: t,
                        child: Transform.translate(
                          offset: Offset(0, 18 * (1 - t)),
                          child: Transform.scale(
                            scale: 0.985 + 0.015 * t,
                            child: child,
                          ),
                        ),
                      ),
                      child: AuthPanel(
                        onClose: () {
                          _vortex.currentState?.scatter(false);
                          setState(() => _open = false);
                        },
                        onActivity: () => _vortex.currentState?.burst(),
                      ),
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

/// WYRD's wordmark in Adire indigo with a strong orange-gold glow, now and then glitching into
/// another of its words.
class _GlitchWord extends StatefulWidget {
  const _GlitchWord();

  @override
  State<_GlitchWord> createState() => _GlitchWordState();
}

class _GlitchWordState extends State<_GlitchWord> {
  final _rng = Random();
  int _i = 0;
  String? _scramble;
  Timer? _cycle, _glitch;

  @override
  void initState() {
    super.initState();
    _cycle = Timer.periodic(const Duration(milliseconds: 2600), (_) => _next());
  }

  void _next() {
    // a few frames of scrambled glyphs, then the next word
    var frames = 0;
    final target = _words[(_i + 1) % _words.length];
    _glitch?.cancel();
    _glitch = Timer.periodic(const Duration(milliseconds: 55), (t) {
      if (!mounted) return t.cancel();
      frames++;
      if (frames > 6) {
        t.cancel();
        setState(() {
          _i = (_i + 1) % _words.length;
          _scramble = null;
        });
        return;
      }
      const glyphs = '#%&@*+=/<>?!WYRD0123456789';
      setState(() {
        _scramble = String.fromCharCodes([
          for (var k = 0; k < target.length; k++)
            target[k] == ' '
                ? 32
                : glyphs.codeUnitAt(_rng.nextInt(glyphs.length)),
        ]);
      });
    });
  }

  @override
  void dispose() {
    _cycle?.cancel();
    _glitch?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = _scramble ?? _words[_i];
    final size = MediaQuery.of(context).size.width < 500 ? 40.0 : 52.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        word,
        textAlign: TextAlign.center,
        style: WyrdText.display(fontSize: size, color: const Color(0xFF24316B))
            .copyWith(
              letterSpacing: 9,
              shadows: const [
                Shadow(color: Color(0xFFF58C1E), blurRadius: 28),
                Shadow(color: Color(0xCCF58C1E), blurRadius: 14),
                Shadow(color: Color(0x99F58C1E), blurRadius: 6),
              ],
            ),
      ),
    );
  }
}
