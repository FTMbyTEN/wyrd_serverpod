import 'dart:convert';

import '../generated/protocol.dart';
import 'drone_config.dart';
import 'drone_planner.dart';
import 'drone_safety.dart';
import 'package:serverpod/serverpod.dart';

/// The app's side of the drone. Any signed-in user can watch it; only the operator -- the
/// account whose email is set with `scloud password set droneOperatorEmail you@example.com` --
/// can plan flights or abort.
class DroneEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// One drone for now; the tables are keyed by droneId so a fleet needs no migration.
  static const droneId = 'wyrd-1';

  Future<DroneState?> getState(Session session) => DroneState.db.findFirstRow(
    session,
    where: (t) => t.droneId.equals(droneId),
  );

  Future<List<DroneMission>> getMissions(Session session, {int limit = 20}) =>
      DroneMission.db.find(
        session,
        where: (t) => t.droneId.equals(droneId),
        orderBy: (t) => t.id.desc(),
        limit: limit.clamp(1, 100),
      );

  Future<bool> isOperator(Session session) => _isOperator(session);

  /// WYRD plans a flight from [instruction]. The plan is stored (and flown) only if it passes
  /// DroneSafety; otherwise the reason comes back and nothing happens.
  Future<DronePlanResult> plan(Session session, String instruction) async {
    await _requireOperator(session);
    final text = instruction.trim();
    if (text.isEmpty) {
      return DronePlanResult(
        accepted: false,
        reason: 'say what the flight should do',
      );
    }

    final state = await getState(session);
    // Cheap preconditions first, so no AI budget is spent on a flight that can't happen.
    final precondition = DroneSafety.checkPlan([
      {'type': 'rtl'},
    ], state);
    if (precondition != null) {
      return DronePlanResult(accepted: false, reason: precondition);
    }

    final active = await DroneMission.db.findFirstRow(
      session,
      where: (t) =>
          t.droneId.equals(droneId) &
          t.status.inSet({'pending', 'sent', 'running'}),
    );
    if (active != null) {
      return DronePlanResult(
        accepted: false,
        reason: 'a flight is already in progress — abort it first',
      );
    }

    final ({String summary, List<Map<String, dynamic>> steps}) planned;
    try {
      planned = await DronePlanner.plan(session, text, state!);
    } catch (e) {
      return DronePlanResult(
        accepted: false,
        reason: e.toString().replaceFirst('Exception: ', ''),
      );
    }

    final problem = DroneSafety.checkPlan(planned.steps, state);
    if (problem != null) {
      return DronePlanResult(
        accepted: false,
        reason: 'plan refused by safety check: $problem',
      );
    }

    final now = DateTime.now().toUtc();
    final mission = await DroneMission.db.insertRow(
      session,
      DroneMission(
        droneId: droneId,
        kind: 'mission',
        instruction: text,
        summary: planned.summary,
        stepsJson: jsonEncode(planned.steps),
        status: 'pending',
        createdBy: _userId(session),
        createdAt: now,
        updatedAt: now,
      ),
    );
    return DronePlanResult(accepted: true, mission: mission);
  }

  /// Cancels whatever is flying and brings the drone home. Always allowed for the operator.
  Future<DroneMission> abort(Session session) async {
    await _requireOperator(session);
    final now = DateTime.now().toUtc();
    // anything not yet picked up is superseded
    final waiting = await DroneMission.db.find(
      session,
      where: (t) => t.droneId.equals(droneId) & t.status.equals('pending'),
    );
    for (final m in waiting) {
      await DroneMission.db.updateRow(
        session,
        m.copyWith(
          status: 'aborted',
          reason: 'superseded by abort',
          updatedAt: now,
        ),
      );
    }
    return DroneMission.db.insertRow(
      session,
      DroneMission(
        droneId: droneId,
        kind: 'abort',
        instruction: 'abort',
        summary: 'Abort and return home',
        stepsJson: jsonEncode([
          {'type': 'rtl'},
        ]),
        status: 'pending',
        createdBy: _userId(session),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static UuidValue _userId(Session session) =>
      UuidValue.fromString(session.authenticated!.userIdentifier);

  static Future<bool> _isOperator(Session session) async {
    final operator = DroneConfig.operatorEmail(session);
    if (operator.isEmpty) return false;
    final rows = await session.db.unsafeQuery(
      'SELECT lower("email") FROM "serverpod_auth_idp_email_account" WHERE "authUserId" = @id',
      parameters: QueryParameters.named({'id': _userId(session).uuid}),
    );
    return rows.any((r) => r[0] == operator);
  }

  static Future<void> _requireOperator(Session session) async {
    if (!await _isOperator(session)) {
      throw Exception('only the drone operator can do that');
    }
  }
}
