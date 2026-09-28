import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/mind/rating_vote_service.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given capped rating votes', (sessionBuilder, endpoints) {
    final me = UuidValue.fromString('77777777-7777-4777-8777-777777777777');
    final other = UuidValue.fromString('88888888-8888-4888-8888-888888888888');

    test('one person rating many times can only move a thing up to their cap', () async {
      final s = sessionBuilder.build();
      var total = 0.0;
      for (var i = 0; i < 10; i++) {
        total += await RatingVoteService.apply(s, me, 'source', 'example.com', 1, limit: 1);
      }
      expect(total, 1.0);
      // a changed mind can swing the full range, but no further
      total += await RatingVoteService.apply(s, me, 'source', 'example.com', -5, limit: 1);
      expect(total, -1.0);
      // someone else has their own vote
      expect(await RatingVoteService.apply(s, other, 'source', 'example.com', 1, limit: 1), 1.0);
    });

    test('a brand-new account counts half', () async {
      final s = sessionBuilder.build();
      final now = DateTime.now().toUtc();
      await UserProfile.db.insertRow(s, UserProfile(authUserId: me, facts: const [], visitCount: 1, firstSeen: now, lastSeen: now));
      expect(await RatingVoteService.weightFor(s, me), 0.5);
    });
  });
}
