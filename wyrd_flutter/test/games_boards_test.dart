import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wyrd_flutter/screens/games_tab.dart';

/// The game boards draw from the server's positions, and a tap becomes the move the server expects.
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Widget host(Widget child) => MaterialApp(
    home: Scaffold(
      body: Center(child: SizedBox(width: 400, child: child)),
    ),
  );

  testWidgets(
    'chess: a piece shows where it can go, and a tap there is the move',
    (tester) async {
      final sent = <String>[];
      await tester.pumpWidget(
        host(
          ChessBoardView(
            fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
            side: 'w',
            enabled: true,
            onMove: sent.add,
          ),
        ),
      );
      expect(find.text('♚'), findsNWidgets(2));
      expect(find.text('♟'), findsNWidgets(16));

      // the board is 400 wide: each square 50; e2 is file 5, rank 2 (row 7 from the top)
      final origin = tester.getTopLeft(find.byType(ChessBoardView));
      Offset at(int file, int row) =>
          origin + Offset(file * 50 + 25, row * 50 + 25);
      await tester.tapAt(at(4, 6)); // e2
      await tester.pump();
      await tester.tapAt(at(4, 4)); // e4
      await tester.pump();
      expect(sent, ['e2e4']);
    },
  );

  testWidgets('chess from black: the board turns round', (tester) async {
    final sent = <String>[];
    await tester.pumpWidget(
      host(
        ChessBoardView(
          fen: 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1',
          side: 'b',
          enabled: true,
          onMove: sent.add,
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(ChessBoardView));
    Offset at(int col, int row) =>
        origin + Offset(col * 50 + 25, row * 50 + 25);
    // from black's side, e7 is column 3 (h..a), row 6 (rank 1 at the top)
    await tester.tapAt(at(3, 6));
    await tester.pump();
    await tester.tapAt(at(3, 4)); // e5
    await tester.pump();
    expect(sent, ['e7e5']);
  });
}
