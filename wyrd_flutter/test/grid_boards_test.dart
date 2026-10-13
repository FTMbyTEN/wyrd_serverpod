import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wyrd_flutter/screens/games_tab.dart';

/// Connect Four, Reversi and Tic-tac-toe draw from the server's positions, and a tap is the move the
/// server expects (a column, or a square).
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Widget host(Widget child) => MaterialApp(
    home: Scaffold(
      body: Center(child: SizedBox(width: 400, child: child)),
    ),
  );

  testWidgets('Connect Four: a tap anywhere in a column plays that column', (
    tester,
  ) async {
    final sent = <int>[];
    final state = jsonEncode({'b': List.filled(42, -1), 't': 0});
    await tester.pumpWidget(
      host(
        GridBoard(
          state: state,
          cols: 7,
          rows: 6,
          me: 0,
          enabled: true,
          kind: 'c4',
          last: null,
          onTap: sent.add,
        ),
      ),
    );
    final o = tester.getTopLeft(find.byType(GridBoard));
    await tester.tapAt(o + const Offset(3 * 400 / 7 + 20, 300));
    expect(sent.map((i) => i % 7), [3]);
  });

  testWidgets('Reversi: only legal squares take a tap', (tester) async {
    final sent = <int>[];
    final b = List.filled(64, -1);
    b[27] = 1;
    b[36] = 1;
    b[28] = 0;
    b[35] = 0;
    final state = jsonEncode({'b': b, 't': 0});
    await tester.pumpWidget(
      host(
        GridBoard(
          state: state,
          cols: 8,
          rows: 8,
          me: 0,
          enabled: true,
          kind: 'rev',
          last: null,
          onTap: sent.add,
        ),
      ),
    );
    final o = tester.getTopLeft(find.byType(GridBoard));
    Offset at(int i) => o + Offset((i % 8) * 50 + 25, (i ~/ 8) * 50 + 25);
    await tester.tapAt(at(0)); // not legal
    await tester.tapAt(at(19)); // legal for the first player: flanks 27
    expect(sent, [19]);
  });

  testWidgets('Tic-tac-toe: X and O drawn, a tap plays its square', (
    tester,
  ) async {
    final sent = <int>[];
    final state = jsonEncode({
      'b': [0, -1, -1, -1, 1, -1, -1, -1, -1],
      't': 0,
    });
    await tester.pumpWidget(
      host(
        GridBoard(
          state: state,
          cols: 3,
          rows: 3,
          me: 0,
          enabled: true,
          kind: 'ttt',
          last: '4',
          onTap: sent.add,
        ),
      ),
    );
    expect(find.text('X'), findsOneWidget);
    expect(find.text('O'), findsOneWidget);
    final o = tester.getTopLeft(find.byType(GridBoard));
    await tester.tapAt(o + const Offset(400 * 2.5 / 3, 400 * 2.5 / 3));
    expect(sent, [8]);
  });
}
