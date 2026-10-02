import '../generated/protocol.dart';
import 'drone_service.dart';
import 'package:serverpod/serverpod.dart';

/// The app's side of the drone, for operators only -- the accounts whose emails are set with
/// `scloud password set droneOperatorEmail a@example.com,b@example.com`. Nobody else can watch, plan
/// or abort, and the app doesn't show them the drone at all. The logic lives in DroneService, shared
/// with WYRD's chat tool.
class DroneEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DroneState?> getState(Session session) async {
    await _requireOperator(session);
    return DroneService.getState(session);
  }

  Future<List<DroneMission>> getMissions(Session session, {int limit = 20}) async {
    await _requireOperator(session);
    return DroneMission.db.find(
        session,
        where: (t) => t.droneId.equals(DroneService.droneId),
        orderBy: (t) => t.id.desc(),
        limit: limit.clamp(1, 100),
      );
  }

  Future<bool> isOperator(Session session) => DroneService.isOperator(session, _userId(session));

  /// WYRD plans a flight from [instruction]; see DroneService.plan.
  Future<DronePlanResult> plan(Session session, String instruction) async {
    await _requireOperator(session);
    return DroneService.plan(session, instruction, _userId(session));
  }

  /// Cancels whatever is flying and brings the drone home. Always allowed for the operator.
  Future<DroneMission> abort(Session session) async {
    await _requireOperator(session);
    return DroneService.abort(session, _userId(session));
  }

  static UuidValue _userId(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  static Future<void> _requireOperator(Session session) async {
    if (!await DroneService.isOperator(session, _userId(session))) {
      throw Exception('only the drone operator can do that');
    }
  }
}
