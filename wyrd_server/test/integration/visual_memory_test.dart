import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/photo_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given WYRD\'s visual memory', (sessionBuilder, endpoints) {
    const meId = '66666666-6666-4666-8666-666666666666';
    final me = UuidValue.fromString(meId);
    final other = UuidValue.fromString('77777777-7777-4777-8777-777777777777');
    final authed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(meId, {}),
    );

    test('a person only ever gets their own sightings, newest first, and chat knows the last one', () async {
      final session = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await Sighting.db.insert(session, [
        Sighting(authUserId: me, timestamp: now.subtract(const Duration(hours: 3)), description: 'You in a green hoodie at a desk.'),
        Sighting(authUserId: me, timestamp: now.subtract(const Duration(minutes: 20)), description: 'You in a red shirt, smiling.'),
        Sighting(authUserId: other, timestamp: now, description: 'Someone else entirely.'),
      ]);

      final mine = await endpoints.photo.getSightings(authed, limit: 5);
      expect(mine.map((s) => s.description), ['You in a red shirt, smiling.', 'You in a green hoodie at a desk.']);

      final line = await PhotoService.sightAwareness(session, me);
      expect(line, contains('red shirt'));
      expect(line, contains('20 min ago'));
      expect(line, isNot(contains('Someone else')));

      final never = await PhotoService.sightAwareness(session, UuidValue.fromString('88888888-8888-4888-8888-888888888888'));
      expect(never, contains("haven't seen them yet"));
    });
  });
}
