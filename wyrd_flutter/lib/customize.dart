import 'dart:convert';
import 'dart:ui' show PlatformDispatcher, Brightness;

import 'package:flutter/material.dart';

import 'theme.dart';

/// A change WYRD made to the app (customize_app), applied as its reply arrives, as in the main
/// app: day or night, the accent colour, the text size, or a place to open -- the shell listens to
/// [openRequest] and opens it.
final openRequest = ValueNotifier<String?>(null);

void applyCustomize(String json) {
  try {
    final c = jsonDecode(json) as Map<String, dynamic>;
    final setting = c['setting'] as String? ?? '';
    final value = c['value'] as String? ?? '';
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
      case 'open':
        openRequest.value = null;
        openRequest.value = value;
    }
  } catch (_) {}
}
