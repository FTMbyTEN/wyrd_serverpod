import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens ported 1:1 from the React Native app's theme.ts -- the terminal-green
/// "restricted node" aesthetic. Keeping the same hex values so the two frontends stay visually
/// identical rather than just conceptually aligned.
class WyrdColors {
  static const bg = Color(0xFF07090A);
  static const panelBg = Color(0xFF000000);
  static const green = Color(0xFF00FF41);
  static const greenDim = Color(0xFF0A9C2F);
  static const greenBorder = Color(0xFF0E5C22);
  static const greenBorderDim = Color(0xFF063D13);
  static const mint = Color(0xFFBAFFC9);
  static const mintBright = Color(0xFF6FFFB0);
  static const danger = Color(0xFFFF3B3B);
}

/// Ports theme.ts's fonts: VT323 for big terminal readouts, Share Tech Mono for body/labels.
class WyrdText {
  static TextStyle display({double fontSize = 18, Color color = WyrdColors.mint, double shadowRadius = 0}) {
    return GoogleFonts.vt323(
      fontSize: fontSize,
      color: color,
      shadows: shadowRadius > 0 ? [Shadow(color: WyrdColors.green, blurRadius: shadowRadius)] : null,
    );
  }

  static TextStyle mono({double fontSize = 13, Color color = WyrdColors.mint, double letterSpacing = 0}) {
    return GoogleFonts.shareTechMono(fontSize: fontSize, color: color, letterSpacing: letterSpacing);
  }
}

ThemeData buildWyrdTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: WyrdColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: WyrdColors.green,
      surface: WyrdColors.bg,
      onSurface: WyrdColors.mint,
    ),
    textTheme: GoogleFonts.shareTechMonoTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: WyrdColors.mint,
      displayColor: WyrdColors.mint,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: WyrdColors.panelBg,
      indicatorColor: WyrdColors.green.withValues(alpha: 0.18),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(color: states.contains(WidgetState.selected) ? WyrdColors.green : WyrdColors.greenDim),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => WyrdText.mono(
          fontSize: 9,
          color: states.contains(WidgetState.selected) ? WyrdColors.green : WyrdColors.greenDim,
          letterSpacing: 1,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: WyrdText.mono(color: WyrdColors.greenDim),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: WyrdColors.greenBorder)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: WyrdColors.green)),
    ),
  );
}
