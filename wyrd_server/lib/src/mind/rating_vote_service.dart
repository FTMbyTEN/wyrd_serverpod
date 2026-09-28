import 'dart:math';

import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Caps one person's influence on what everyone shares. Each person has a single standing vote
/// per learned answer, source and topic, kept within [-limit, limit]; rating more replies only
/// moves that vote, never past the cap. New accounts (under [_newAccount]) count half.
class RatingVoteService {
  static const _newAccount = Duration(days: 3);

  /// How much a person's say is worth: half for a brand-new account.
  static Future<double> weightFor(Session session, UuidValue authUserId) async {
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId));
    if (profile == null) return 0.5;
    return DateTime.now().toUtc().difference(profile.firstSeen) < _newAccount ? 0.5 : 1.0;
  }

  /// Moves [authUserId]'s vote on ([kind], [key]) by [delta], clamped to [-limit, limit], and
  /// returns how much the shared total should actually change (0 once they've hit the cap).
  static Future<double> apply(
    Session session,
    UuidValue authUserId,
    String kind,
    String key,
    double delta, {
    required double limit,
  }) async {
    if (delta == 0 || key.isEmpty) return 0;
    final existing = await RatingVote.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.kind.equals(kind) & t.key.equals(key),
    );
    final old = existing?.value ?? 0.0;
    final next = max(-limit, min(limit, old + delta));
    if (next == old) return 0;
    if (existing == null) {
      await RatingVote.db.insertRow(session, RatingVote(authUserId: authUserId, kind: kind, key: key, value: next));
    } else {
      await RatingVote.db.updateRow(session, existing.copyWith(value: next));
    }
    return next - old;
  }
}
