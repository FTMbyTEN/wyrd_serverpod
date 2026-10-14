import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wyrd_flutter/theme.dart';
import 'package:wyrd_flutter/widgets/glass.dart';

/// The glass over a busy, colourful page, by day and by night: what the pop-ups look like.
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);
  for (final night in [false, true]) {
    testWidgets('glass by ${night ? 'night' : 'day'}', (tester) async {
      WyrdColors.night.value = night;
      await tester.binding.setSurfaceSize(const Size(480, 320));
      await tester.pumpWidget(
        MaterialApp(
          home: RepaintBoundary(
            child: Stack(
              children: [
                Container(color: WyrdColors.bg),
                for (var i = 0; i < 6; i++)
                  Positioned(
                    left: 20.0 + i * 75,
                    top: 40.0 + (i % 3) * 70,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: [WyrdColors.signal, WyrdColors.ochre, WyrdColors.palm, WyrdColors.indigo][i % 4],
                      ),
                    ),
                  ),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 200,
                    child: Glass(child: const SizedBox.expand()),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(RepaintBoundary).first,
        matchesGoldenFile('goldens/glass_${night ? 'night' : 'day'}.png'),
      );
    });
  }
}
