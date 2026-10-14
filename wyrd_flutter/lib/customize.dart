import 'dart:convert';
import 'dart:ui' show PlatformDispatcher, Brightness;

import 'package:flutter/material.dart';

import 'theme.dart';
import 'widgets/frame/page_text_stub.dart'
    if (dart.library.js_interop) 'widgets/frame/page_text_web.dart';

/// A change WYRD made to the app (customize_app), applied as its reply arrives, as in the main
/// app: day or night, the accent colour, the text size, or a place to open -- the shell listens to
/// [openRequest] and opens it.
final openRequest = ValueNotifier<String?>(null);

/// The order of the game cards WYRD was asked for (customize_app "games_order"), by name.
final gamesOrder = ValueNotifier<List<String>>(const []);

/// [items] in [gamesOrder]'s order; those it doesn't name keep their place after.
List<T> inGamesOrder<T>(List<T> items, String Function(T) name) {
  final order = [for (final n in gamesOrder.value) n.trim().toLowerCase()];
  int rank(T t) {
    final i = order.indexOf(name(t).toLowerCase());
    return i < 0 ? order.length : i;
  }

  final indexed = [for (var i = 0; i < items.length; i++) (i, items[i])];
  indexed.sort((a, b) {
    final r = rank(a.$2).compareTo(rank(b.$2));
    return r != 0 ? r : a.$1.compareTo(b.$1);
  });
  return [for (final e in indexed) e.$2];
}

/// What WYRD changed before, back from this browser at start-up (main.dart).
void restoreCustomize() {
  for (final s in ['theme', 'accent', 'text_size', 'games_order']) {
    final v = loadLocal('wyrd.custom.$s');
    if (v != null)
      applyCustomize(jsonEncode({'setting': s, 'value': v}), keep: false);
  }
}

void applyCustomize(String json, {bool keep = true}) {
  try {
    final c = jsonDecode(json) as Map<String, dynamic>;
    final setting = c['setting'] as String? ?? '';
    final value = c['value'] as String? ?? '';
    // (games_order keeps the names' case for matching; everything else is lower case)
    // kept in this browser, so the change is still there next visit (a place to open isn't)
    if (keep && setting != 'open') saveLocal('wyrd.custom.$setting', value);
    switch (setting) {
      case 'theme':
        WyrdColors.night.value =
            value == 'dark' ||
            (value == 'auto' &&
                PlatformDispatcher.instance.platformBrightness ==
                    Brightness.dark);
      case 'accent':
        final hex = int.tryParse(value.replaceFirst('#', ''), radix: 16);
        WyrdColors.accent.value = hex == null ? null : Color(0xFF000000 | hex);
      case 'text_size':
        WyrdColors.textScale.value = switch (value) {
          'small' => 0.9,
          'large' => 1.12,
          'huge' => 1.25,
          _ => 1.0,
        };
      case 'games_order':
        gamesOrder.value = [
          for (final n in value.split(','))
            if (n.trim().isNotEmpty) n.trim(),
        ];
      case 'open':
        openRequest.value = null;
        openRequest.value = value;
    }
  } catch (_) {}
}
