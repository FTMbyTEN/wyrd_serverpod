import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/gate_shape_service.dart';
import 'package:wyrd_server/src/mind/tick_schedule.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Status and GateShape endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    test('status reports the real tick intervals and no turbo', () async {
      final status = await endpoints.status.getStatus(sessionBuilder);
      expect(status.turboActive, isFalse);
      expect(status.reasoningCycleMs, TickSchedule.reasoning.inMilliseconds);
      expect(status.lexiconCycleMs, TickSchedule.lexicon.inMilliseconds);
      expect(status.feedCycleMs, TickSchedule.feed.inMilliseconds);
    });

    test(
      'without an LLM, consecutive gate shapes are valid and never repeat a family back to back',
      () async {
        String? lastType;
        for (var i = 0; i < 6; i++) {
          final shape = await endpoints.gateShape.next(sessionBuilder);
          expect(GateShapeService.types, contains(shape.type));
          expect(shape.freqX, inInclusiveRange(1, 12));
          expect(shape.label, isNotEmpty);
          expect(shape.type, isNot(lastType));
          lastType = shape.type;
        }
      },
    );
  });
}
