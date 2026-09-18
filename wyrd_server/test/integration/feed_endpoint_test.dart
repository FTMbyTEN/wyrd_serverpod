import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Feed endpoint', (sessionBuilder, endpoints) {
    test(
      'when triggering a tick then it ingests a real item (Wikipedia or Hacker News), stores '
      'a memory block, and updates Mind',
      () async {
        final ran = await endpoints.feed.trigger(sessionBuilder);
        expect(ran, isTrue);

        final blocks = await endpoints.memory.getMemory(sessionBuilder);
        expect(blocks, hasLength(1));
        expect(blocks.single.source, 'net');
        expect(blocks.single.title, isNotEmpty);

        final recent = await endpoints.feed.getRecent(sessionBuilder);
        expect(recent, hasLength(1));

        final mind = await endpoints.mind.getMind(sessionBuilder);
        expect(mind.lastEvent, 'ingest');
      },
      // Hits real Wikipedia/Hacker News over the network -- skip if this environment has no
      // outbound internet access rather than failing the whole suite on that basis.
      timeout: Timeout(Duration(seconds: 20)),
    );
  });
}
