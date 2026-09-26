import 'dart:convert';

import '../generated/protocol.dart';
import 'drone_config.dart';
import 'package:serverpod/serverpod.dart';

/// What the drone bridge (drone/bridge in the consciousness-bot repo) calls. The bridge isn't a
/// user, so instead of a login it presents the shared secret set with
/// `scloud password set droneBridgeToken <long random value>` (same value in the bridge's
/// WYRD_BRIDGE_TOKEN). Without that secret configured, every call is refused.
class DroneBridgeEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Upserts the drone's latest telemetry and hands back the oldest waiting mission (marking it
  /// sent), or null. Called every ~2s.
  Future<DroneMission?> report(
    Session session,
    String token,
    DroneState state,
  ) async {
    _authorize(session, token);
    final now = DateTime.now().toUtc();
    final existing = await DroneState.db.findFirstRow(
      session,
      where: (t) => t.droneId.equals(state.droneId),
    );
    final row = state.copyWith(updatedAt: now);
    if (existing == null) {
      await DroneState.db.insertRow(session, row.copyWith(id: null));
    } else {
      await DroneState.db.updateRow(session, row.copyWith(id: existing.id));
    }

    // an abort always jumps the queue
    final waiting = await DroneMission.db.find(
      session,
      where: (t) =>
          t.droneId.equals(state.droneId) & t.status.equals('pending'),
      orderBy: (t) => t.id,
    );
    if (waiting.isEmpty) return null;
    final next = waiting.firstWhere(
      (m) => m.kind == 'abort',
      orElse: () => waiting.first,
    );
    return DroneMission.db.updateRow(
      session,
      next.copyWith(status: 'sent', updatedAt: now),
    );
  }

  /// The bridge reporting what happened to a mission: running, done, aborted, or rejected (its
  /// own safety check refused it).
  Future<void> missionUpdate(
    Session session,
    String token,
    int missionId,
    String status,
    String? reason,
  ) async {
    _authorize(session, token);
    if (!const {'running', 'done', 'aborted', 'rejected'}.contains(status)) {
      throw ArgumentError('unknown mission status "$status"');
    }
    final mission = await DroneMission.db.findById(session, missionId);
    if (mission == null) return;
    await DroneMission.db.updateRow(
      session,
      mission.copyWith(
        status: status,
        reason: reason,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  void _authorize(Session session, String token) {
    final expected = DroneConfig.bridgeToken(session);
    if (expected.length < 16 ||
        !_constantTimeEquals(utf8.encode(token), utf8.encode(expected))) {
      throw Exception('drone bridge not authorized');
    }
  }

  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
