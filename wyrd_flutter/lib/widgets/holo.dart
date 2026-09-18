import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';

/// One soft, wavering tongue of ethereal flame -- three fully-round, overlapping blobs (never a
/// hard rectangular edge) tapering from a wide base to a soft point, quietly breathing in size,
/// opacity, and a few degrees of sway on its own independent, never-repeating-in-sync loop.
/// Ports Holo.tsx's Flame component.
class Flame extends StatefulWidget {
  final double deg;
  final int delayMs;
  final double size;
  final double glow;

  const Flame({super.key, required this.deg, required this.delayMs, required this.size, required this.glow});

  @override
  State<Flame> createState() => _FlameState();
}

class _FlameState extends State<Flame> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Each flame's up/down leg has a slightly different duration (seeded by delayMs), so no two
    // flames ever breathe in sync -- matches the RN version's per-flame timing.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400 + widget.delayMs),
      reverseDuration: Duration(milliseconds: 1600 + widget.delayMs),
    );
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        final t = curved.value;
        final swayDeg = widget.deg - 4 + t * 8;
        final scaleY = 0.82 + t * (1.15 - 0.82);
        final opacity = widget.glow * (0.55 + t * (0.95 - 0.55));
        return Opacity(
          opacity: opacity.clamp(0, 1),
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..rotateZ(swayDeg * pi / 180)
              ..scaleByDouble(1.0, scaleY, 1.0, 1.0),
            child: child,
          ),
        );
      },
      child: _flameShape(),
    );
  }

  Widget _flameShape() {
    final size = widget.size;
    Widget blob(double d, Color color, double shadowRadius) => Container(
          width: d,
          height: d,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: WyrdColors.green, blurRadius: shadowRadius)],
          ),
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(offset: Offset(0, size * 0.12), child: blob(size * 0.4, WyrdColors.mint, 6)),
        Transform.translate(offset: Offset(0, size * 0.2), child: blob(size * 0.65, WyrdColors.green, 9)),
        blob(size, WyrdColors.green, 12),
      ],
    );
  }
}

/// A soft, ethereal light burning up from the ground under a panel -- three flame tongues over
/// one soft round bed of light. Ports Holo.tsx's GroundLight.
class GroundLight extends StatelessWidget {
  final double glow;
  final double width;
  final double height;

  const GroundLight({super.key, this.glow = 0.5, this.width = 92, this.height = 46});

  @override
  Widget build(BuildContext context) {
    final g = glow.clamp(0.15, 1.0);
    const flames = [
      (deg: -14.0, delayMs: 120, size: 15.0),
      (deg: 0.0, delayMs: 380, size: 20.0),
      (deg: 13.0, delayMs: 640, size: 14.0),
    ];
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -6,
            child: Transform.scale(
              scaleX: 1.7,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: WyrdColors.green.withValues(alpha: g * 0.5),
                  shape: BoxShape.circle,
                  boxShadow: const [BoxShadow(color: WyrdColors.green, blurRadius: 16)],
                ),
              ),
            ),
          ),
          for (final f in flames) Flame(deg: f.deg, delayMs: f.delayMs, size: f.size, glow: g),
        ],
      ),
    );
  }
}

/// Shared sci-fi holographic-projection language: a thin beam rising into a glass panel, lit
/// from underneath by a soft ground light. Ports Holo.tsx's HoloFrame. [glow] (0..1) drives
/// border/shadow/light intensity.
class HoloFrame extends StatelessWidget {
  final Widget child;
  final double glow;
  final bool beam;
  final bool groundLight;

  const HoloFrame({super.key, required this.child, this.glow = 0.45, this.beam = true, this.groundLight = true});

  @override
  Widget build(BuildContext context) {
    final g = glow.clamp(0.15, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (beam) ...[
          Container(width: 1, height: 16, color: WyrdColors.green.withValues(alpha: 0.45)),
          Transform.translate(
            offset: const Offset(0, 2),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: WyrdColors.green,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: WyrdColors.green, blurRadius: 6)],
              ),
            ),
          ),
        ],
        Container(
          margin: EdgeInsets.only(top: beam ? 2 : 0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF000F04).withValues(alpha: 0.38),
            border: Border.all(color: WyrdColors.green.withValues(alpha: g)),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [BoxShadow(color: WyrdColors.green.withValues(alpha: g), blurRadius: 10)],
          ),
          child: child,
        ),
        if (groundLight) GroundLight(glow: g),
      ],
    );
  }
}

/// A compact labeled readout inside a HoloFrame -- label on top, value, optional meter. Ports
/// Holo.tsx's HoloReadout.
class HoloReadout extends StatelessWidget {
  final String label;
  final String value;
  final double? pct;
  final double? glow;
  final bool big;

  const HoloReadout({super.key, required this.label, required this.value, this.pct, this.glow, this.big = false});

  @override
  Widget build(BuildContext context) {
    final g = glow ?? (pct != null ? 0.25 + pct!.clamp(0, 100) / 100 * 0.55 : 0.45);
    return HoloFrame(
      glow: g,
      child: Padding(
        padding: EdgeInsets.all(big ? 14 : 9),
        child: Column(
          crossAxisAlignment: big ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: WyrdText.mono(fontSize: big ? 9 : 8, color: WyrdColors.greenDim).copyWith(letterSpacing: 1.5)),
            const SizedBox(height: 3),
            Text(value, style: WyrdText.display(fontSize: big ? 30 : 18, shadowRadius: 10 + g * 14)),
            if (pct != null) ...[
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    value: (pct! / 100).clamp(0, 1),
                    backgroundColor: WyrdColors.greenDim.withValues(alpha: 0.25),
                    valueColor: AlwaysStoppedAnimation(WyrdColors.green.withValues(alpha: 0.6 + g * 0.4)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A holo-styled pressable -- same glass/glow language as HoloFrame, no beam. Ports Holo.tsx's
/// HoloButton. [tone] swaps the glow color for destructive actions.
class HoloButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String tone;

  const HoloButton({super.key, required this.label, required this.onPressed, this.tone = 'green'});

  @override
  Widget build(BuildContext context) {
    final color = tone == 'danger' ? WyrdColors.danger : WyrdColors.green;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF000F04).withValues(alpha: 0.38),
            border: Border.all(color: color.withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 8)],
          ),
          child: Text(
            label,
            style: WyrdText.mono(fontSize: 9.5, color: tone == 'danger' ? WyrdColors.danger : WyrdColors.greenDim).copyWith(letterSpacing: 1),
          ),
        ),
      ),
    );
  }
}
