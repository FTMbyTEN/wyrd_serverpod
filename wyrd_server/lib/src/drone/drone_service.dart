import 'dart:convert';

import '../generated/protocol.dart';
import 'drone_config.dart';
import 'drone_planner.dart';
import 'drone_safety.dart';
import 'package:serverpod/serverpod.dart';

/// Drone operations shared by the DRONE tab (DroneEndpoint) and WYRD's chat tool
/// (plan_drone_flight), so both go through exactly the same planner and safety checks.
class DroneService {
  /// One drone for now; the tables are keyed by droneId so a fleet needs no migration.
  static const droneId = 'wyrd-1';

  static Future<DroneState?> getState(Session session) =>
      DroneState.db.findFirstRow(session, where: (t) => t.droneId.equals(droneId));

  /// True if [userId] signs in with the droneOperatorEmail account.
  // who has drone access, remembered for a few minutes: the app asks often (the tab, every poll),
  // and one cached answer per person keeps that from ever touching the database
  static final _access = <String, ({bool ok, DateTime at})>{};
  static const _accessFor = Duration(minutes: 5);

  static Future<bool> isOperator(Session session, UuidValue userId) async {
    final operators = DroneConfig.operatorEmails(session);
    if (operators.isEmpty) return false;
    final hit = _access[userId.uuid];
    if (hit != null && DateTime.now().difference(hit.at) < _accessFor) return hit.ok;
    final rows = await session.db.unsafeQuery(
      'SELECT lower("email") FROM "serverpod_auth_idp_email_account" WHERE "authUserId" = @id',
      parameters: QueryParameters.named({'id': userId.uuid}),
    );
    final ok = rows.any((r) => operators.contains(r[0]));
    if (_access.length > 5000) _access.clear();
    _access[userId.uuid] = (ok: ok, at: DateTime.now());
    return ok;
  }

  /// For tests: forget remembered access.
  static void forgetAccess() => _access.clear();

  /// WYRD plans a flight from [instruction]. The plan is stored (and flown) only if it passes
  /// DroneSafety; otherwise the reason comes back and nothing happens. Callers check that
  /// [createdBy] is the operator.
  static Future<DronePlanResult> plan(Session session, String instruction, UuidValue createdBy) async {
    final text = instruction.trim();
    if (text.isEmpty) return DronePlanResult(accepted: false, reason: 'say what the flight should do');

    final state = await getState(session);
    // Cheap preconditions first, so no AI budget is spent on a flight that can't happen.
    final precondition = DroneSafety.checkPlan([
      {'type': 'rtl'},
    ], state);
    if (precondition != null) return DronePlanResult(accepted: false, reason: precondition);

    final active = await DroneMission.db.findFirstRow(
      session,
      where: (t) => t.droneId.equals(droneId) & t.status.inSet({'pending', 'sent', 'running'}),
    );
    if (active != null) {
      return DronePlanResult(accepted: false, reason: 'a flight is already in progress — abort it first');
    }

    final ({String summary, List<Map<String, dynamic>> steps}) planned;
    try {
      planned = await DronePlanner.plan(session, text, state!);
    } catch (e) {
      return DronePlanResult(accepted: false, reason: e.toString().replaceFirst('Exception: ', ''));
    }

    final problem = DroneSafety.checkPlan(planned.steps, state);
    if (problem != null) {
      return DronePlanResult(accepted: false, reason: 'plan refused by safety check: $problem');
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
        createdBy: createdBy,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return DronePlanResult(accepted: true, mission: mission);
  }

  /// Cancels whatever is flying and brings the drone home. Callers check the operator.
  static Future<DroneMission> abort(Session session, UuidValue createdBy) async {
    final now = DateTime.now().toUtc();
    // anything not yet picked up is superseded
    final waiting = await DroneMission.db.find(
      session,
      where: (t) => t.droneId.equals(droneId) & t.status.equals('pending'),
    );
    for (final m in waiting) {
      await DroneMission.db.updateRow(session, m.copyWith(status: 'aborted', reason: 'superseded by abort', updatedAt: now));
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
        createdBy: createdBy,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
}
