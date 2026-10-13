import 'package:flutter/material.dart';

import '../theme.dart';

/// The main app's card language (Warm Lagos): a soft rounded card on the cream (or the night's
/// warm brown), a hairline border and a faint shadow. The names are kept from the green era's
/// holographic panels, so the screens didn't change. [glow] is kept for old call sites.
class HoloFrame extends StatelessWidget {
  final Widget child;
  final double glow;
  final bool beam;
  final bool groundLight;

  const HoloFrame({
    super.key,
    required this.child,
    this.glow = 0.45,
    this.beam = true,
    this.groundLight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: wyrdCard(radius: 20),
      child: child,
    );
  }
}

/// A labelled readout card: a small spaced label, the value in the display face, and an optional
/// hairline meter in terracotta -- the main app's Vital.
class HoloReadout extends StatelessWidget {
  final String label;
  final String value;
  final double? pct;
  final double? glow;
  final bool big;

  const HoloReadout({
    super.key,
    required this.label,
    required this.value,
    this.pct,
    this.glow,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(big ? 14 : 11),
      decoration: wyrdCard(
        radius: 18,
        color: WyrdColors.glassBg,
        border: WyrdColors.glassBorder,
      ),
      child: Column(
        crossAxisAlignment: big
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: WyrdText.mono(
              fontSize: big ? 9 : 8.5,
              color: WyrdColors.greenDim,
            ).copyWith(letterSpacing: 2),
          ),
          const SizedBox(height: 2),
          Text(value, style: WyrdText.display(fontSize: big ? 32 : 24)),
          if (pct != null) ...[
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  value: (pct! / 100).clamp(0, 1),
                  backgroundColor: WyrdColors.greenBorderDim,
                  valueColor: AlwaysStoppedAnimation(WyrdColors.signal),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A pill button, as in the main app: terracotta outline (filled when [filled]), or danger red.
class HoloButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String tone;
  final bool filled;

  const HoloButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.tone = 'green',
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = tone == 'danger' ? WyrdColors.danger : WyrdColors.signal;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: filled ? color : Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: WyrdText.mono(
              fontSize: 11,
              color: filled ? WyrdColors.onSignal : color,
            ).copyWith(letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
