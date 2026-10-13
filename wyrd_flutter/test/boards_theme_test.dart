import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wyrd_flutter/screens/games_tab.dart';
import 'package:wyrd_flutter/theme.dart';

/// Every board drawn by day and by night: nothing overflows, and the images (goldens) show the
/// pieces readable on both grounds.
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  final c4 = List.filled(42, -1)..[38] = 0..[31] = 1;
  final rev = List.filled(64, -1)..[27] = 1..[36] = 1..[28] = 0..[35] = 0;
  final ttt = List.filled(9, -1)..[4] = 0..[0] = 1;
  final boards = {
    'c4': (7, 6, c4),
    'rev': (8, 8, rev),
    'ttt': (3, 3, ttt),
  };

  for (final night in [false, true]) {
    for (final e in boards.entries) {
      testWidgets('${e.key} by ${night ? 'night' : 'day'}', (tester) async {
        WyrdColors.night.value = night;
        await tester.binding.setSurfaceSize(const Size(440, 440));
        final (cols, rows, b) = e.value;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              backgroundColor: WyrdColors.bg,
              body: Center(
                child: SizedBox(
                  width: 400,
                  child: RepaintBoundary(
                    child: GridBoard(
                      state: jsonEncode({'b': b, 't': 0}),
                      cols: cols,
                      rows: rows,
                      me: 0,
                      enabled: true,
                      kind: e.key,
                      last: null,
                      onTap: (_) {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(GridBoard),
          matchesGoldenFile('goldens/${e.key}_${night ? 'night' : 'day'}.png'),
        );
      });
    }
  }
}
