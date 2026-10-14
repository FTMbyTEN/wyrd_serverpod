import 'dart:ui' show PlatformDispatcher, Brightness;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens from the main app's theme.ts -- Warm Lagos: cream and sand grounds, terracotta
/// for what's live or yours, Adire indigo, ochre and palm green; and its night, the same colours
/// after dark. Day or night is chosen once at start-up from the device's setting, as the main app
/// does. The token names are kept from the green era, as there: `green*` are the ink levels,
/// `mint*` headline text, and `signal` the one accent.
class WyrdColors {
  /// Night: from the device's setting at start-up, then the header's sun/moon button.
  static final night = ValueNotifier<bool>(
    PlatformDispatcher.instance.platformBrightness == Brightness.dark,
  );
  static bool get dark => night.value;

  /// The accent WYRD was asked to use (customize_app), in place of terracotta; and the text size.
  static final accent = ValueNotifier<Color?>(null);
  static final textScale = ValueNotifier<double>(1);

  static Color _p(int day, int night) => Color(dark ? night : day);

  static Color get bg => _p(0xFFF7EFE2, 0xFF14110E);
  static Color get panelBg => _p(0xFFFFFAF2, 0xFF1D1915);
  static Color get green => _p(0xFF2A1F17, 0xFFF1E6D6); // ink
  static Color get greenDim => _p(0xFF7A6656, 0xFFB09C88); // muted ink
  static Color get greenBorder => _p(0xFFD9C7AC, 0xFF3B322A);
  static Color get greenBorderDim => _p(0xFFEADBC4, 0xFF2A241F);
  static Color get mint => _p(0xFF2A1F17, 0xFFF4EADB); // headlines
  static Color get mintBright => _p(0xFF3A2D22, 0xFFE9DDCB);
  static Color get danger => _p(0xFFB83A26, 0xFFEE6A4E);
  static Color get signal =>
      accent.value ?? _p(0xFFC4572E, 0xFFE5743F); // terracotta
  static Color get signalSoft => accent.value != null
      ? accent.value!.withValues(alpha: dark ? 0.16 : 0.1)
      : (dark ? const Color(0x29E5743F) : const Color(0x1AC4572E));
  static Color get onSignal => _p(0xFFFFFAF2, 0xFFFFF6EA);
  static Color get indigo => _p(0xFF24316B, 0xFF9AA8F2);
  static Color get ochre => _p(0xFFE2A32B, 0xFFEDB54A);
  static Color get palm => _p(0xFF2F6B4C, 0xFF58AE7E);
  static Color get sand => _p(0xFFEEDFC8, 0xFF2A241F);
  static Color get card => _p(0xFFFFFAF2, 0xFF1D1915);

  // glass: pop-ups, the bars, cards over the brain
  static Color get glassBg =>
      dark ? const Color(0xB31D1915) : const Color(0x94FFFAF2);
  static Color get glassBorder =>
      dark ? const Color(0x1FFFFFFF) : const Color(0xB8FFFFFF);
  static Color get barBg =>
      dark ? const Color(0xD11D1915) : const Color(0xD1F7EFE2);
  static Color get shadow => _p(0xFF2A1F17, 0xFF000000);
}

/// The main app's two typefaces: VT323 for big readouts, Share Tech Mono for everything else.
class WyrdText {
  /// Chess pieces and other symbols the two typefaces don't have (the web build has no system
  /// symbol font to fall back on, so they'd show as empty boxes).
  static List<String> get symbolFallback => [
    GoogleFonts.notoSansSymbols2().fontFamily!,
  ];

  static TextStyle display({
    double fontSize = 18,
    Color? color,
    double shadowRadius =
        0, // kept for old call sites: Warm Lagos type doesn't glow
  }) {
    return GoogleFonts.vt323(
      fontSize: fontSize,
      color: color ?? WyrdColors.mint,
    ).copyWith(fontFamilyFallback: symbolFallback);
  }

  /// The main app's reading face (Georgia on the web there; Noto Serif here, which the web build
  /// can load): diary pages, facts, headlines read in the feed.
  static TextStyle serif({double fontSize = 15, Color? color}) =>
      GoogleFonts.notoSerif(
        fontSize: fontSize,
        color: color ?? WyrdColors.mint,
      ).copyWith(fontFamilyFallback: symbolFallback);

  static TextStyle mono({
    double fontSize = 13,
    Color? color,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.shareTechMono(
      fontSize: fontSize,
      color: color ?? WyrdColors.mint,
      letterSpacing: letterSpacing,
    ).copyWith(fontFamilyFallback: symbolFallback);
  }
}

/// A soft card, like the main app's: rounded, a hairline border, a faint shadow.
BoxDecoration wyrdCard({double radius = 20, Color? color, Color? border}) =>
    BoxDecoration(
      color: color ?? WyrdColors.card,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border ?? WyrdColors.greenBorder),
      boxShadow: [
        BoxShadow(
          color: WyrdColors.shadow.withValues(
            alpha: WyrdColors.dark ? 0.3 : 0.06,
          ),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    );

ThemeData buildWyrdTheme() {
  final scheme = ColorScheme(
    brightness: WyrdColors.dark ? Brightness.dark : Brightness.light,
    primary: WyrdColors.signal,
    onPrimary: WyrdColors.onSignal,
    primaryContainer: WyrdColors.signalSoft,
    onPrimaryContainer: WyrdColors.mint,
    secondary: WyrdColors.indigo,
    onSecondary: WyrdColors.onSignal,
    error: WyrdColors.danger,
    onError: WyrdColors.onSignal,
    errorContainer: WyrdColors.danger.withValues(alpha: 0.12),
    onErrorContainer: WyrdColors.danger,
    surface: WyrdColors.bg,
    onSurface: WyrdColors.mint,
    surfaceContainerHighest: WyrdColors.sand,
    outline: WyrdColors.greenBorder,
  );
  final base = WyrdColors.dark ? ThemeData.dark() : ThemeData.light();
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: WyrdColors.bg,
    textTheme:
        GoogleFonts.shareTechMonoTextTheme(
          base.textTheme,
        ).apply(
          bodyColor: WyrdColors.mint,
          displayColor: WyrdColors.mint,
          fontFamilyFallback: WyrdText.symbolFallback,
        ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: WyrdColors.barBg,
      surfaceTintColor: Colors.transparent,
      indicatorColor: WyrdColors.signal,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? WyrdColors.onSignal
              : WyrdColors.greenDim,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => WyrdText.mono(
          fontSize: 10,
          color: states.contains(WidgetState.selected)
              ? WyrdColors.signal
              : WyrdColors.greenDim,
          letterSpacing: 1,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: WyrdColors.card,
      hintStyle: WyrdText.mono(color: WyrdColors.greenDim),
      labelStyle: WyrdText.mono(color: WyrdColors.greenDim),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: WyrdColors.greenBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: WyrdColors.signal, width: 1.5),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: WyrdColors.signal,
        foregroundColor: WyrdColors.onSignal,
        shape: const StadiumBorder(),
        textStyle: WyrdText.mono(fontSize: 13, letterSpacing: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: WyrdColors.signal,
        foregroundColor: WyrdColors.onSignal,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: WyrdColors.signal),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: WyrdColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: WyrdColors.signal,
    ),
    dividerTheme: DividerThemeData(color: WyrdColors.greenBorder),
  );
}
