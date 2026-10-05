import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'agent_service.dart';

/// WYRD's agent tasks: give it a goal, watch it work, approve or decline what it wants to do.
class AgentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static UuidValue _user(Session session) => UuidValue.fromString(session.authenticated!.userIdentifier);

  /// A new task. [everyHours]: null for once, otherwise it runs again on that schedule.
  Future<AgentTask> create(Session session, String goal, int? everyHours) => AgentService.create(session, _user(session), goal, everyHours: everyHours);
  Future<List<AgentTask>> mine(Session session) => AgentService.mine(session, _user(session));
  Future<List<AgentStep>> steps(Session session, int taskId) => AgentService.steps(session, _user(session), taskId);
  Future<AgentTask> decide(Session session, int taskId, bool approve) => AgentService.decide(session, _user(session), taskId, approve);
  Future<AgentTask> cancel(Session session, int taskId) => AgentService.cancel(session, _user(session), taskId);
  Future<AgentTask> runNow(Session session, int taskId) => AgentService.runNow(session, _user(session), taskId);
  Future<AgentTask> markRead(Session session, int taskId) => AgentService.markRead(session, _user(session), taskId);
}
