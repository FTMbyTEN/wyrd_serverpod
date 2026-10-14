import 'dart:ui' show ColorFilter, ImageFilter;

import 'package:flutter/material.dart';

import '../theme.dart';

/// WYRD's glass, in one place, for every pop-up, panel and floating button:
///  - a deep blur that also lifts the colour of what's behind it (real frosted glass picks up the
///    colours under it rather than greying them);
///  - a tint that is lighter at the top edge and deeper below, so the pane has a lit edge and depth;
///  - a fine rim that catches the light, and a soft shadow that lifts it off the page.
ImageFilter glassFilter([double sigma = 28]) => ImageFilter.compose(
  outer: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
  inner: const ColorFilter.matrix(_saturate),
);

// colour saturation x1.5 (the standard luminance-weighted matrix)
const _saturate = <double>[
  1.394, -0.358, -0.036, 0, 0, //
  -0.106, 1.142, -0.036, 0, 0,
  -0.106, -0.358, 1.464, 0, 0,
  0, 0, 0, 1, 0,
];

/// The glass's fill and rim, for a pane already clipped and blurred with [glassFilter].
BoxDecoration glassDecoration(double radius) {
  final dark = WyrdColors.dark;
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0, 0.09, 0.55, 1],
      colors: dark
          ? const [
              Color(0x33FFF3E0), // the lit top edge
              Color(0x7A1D1915),
              Color(0x8C1D1915),
              Color(0xA6171310),
            ]
          : const [
              Color(0xE6FFFFFF),
              Color(0x8CFFFAF2),
              Color(0x99FFFAF2),
              Color(0xB3F7EFE2),
            ],
    ),
    border: Border.all(
      color: dark ? const Color(0x2EFFF3E0) : const Color(0xCCFFFFFF),
    ),
  );
}

/// The shadow that lifts a glass pane off the page.
List<BoxShadow> glassShadow({double lift = 1}) => [
  BoxShadow(
    color: Colors.black.withValues(alpha: WyrdColors.dark ? 0.45 : 0.16),
    blurRadius: 60 * lift,
    spreadRadius: -14,
    offset: Offset(0, 16 * lift),
  ),
  BoxShadow(
    color: Colors.black.withValues(alpha: WyrdColors.dark ? 0.25 : 0.06),
    blurRadius: 8 * lift,
    offset: Offset(0, 2 * lift),
  ),
];

/// A glass pane: shadow, clip, blur and fill around [child].
class Glass extends StatelessWidget {
  final Widget child;
  final double radius;
  final double sigma;
  final double lift;
  final BoxShape shape;
  const Glass({
    super.key,
    required this.child,
    this.radius = 24,
    this.sigma = 28,
    this.lift = 1,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    final r = shape == BoxShape.circle ? 999.0 : radius;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r),
        boxShadow: glassShadow(lift: lift),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r),
        child: BackdropFilter(
          filter: glassFilter(sigma),
          child: DecoratedBox(
            decoration: glassDecoration(r),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The page behind a glass pop-up, softly blurred, so the pane stands in front of it.
Widget glassVeil() => IgnorePointer(
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: const SizedBox.expand(),
  ),
);
