import 'package:test/test.dart';
import 'package:wyrd_server/src/mind/growth_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Growth endpoint', (sessionBuilder, endpoints) {
    test(
      'when no snapshots exist then getSnapshots returns an empty list',
      () async {
        final snapshots = await endpoints.growth.getSnapshots(sessionBuilder);
        expect(snapshots, isEmpty);
      },
    );

    test(
      'when a snapshot is taken then getSnapshots returns it with real Mind/Memory/Lexicon state',
      () async {
        final session = sessionBuilder.build();
        final taken = await GrowthService.takeSnapshot(session);
        expect(taken.blockCount, 0);
        expect(taken.vocabCount, 0);

        final snapshots = await endpoints.growth.getSnapshots(sessionBuilder);
        expect(snapshots, hasLength(1));
        expect(snapshots.single.id, taken.id);
      },
    );
  });
}
