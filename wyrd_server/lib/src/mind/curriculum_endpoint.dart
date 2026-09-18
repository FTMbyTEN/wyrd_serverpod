import '../generated/protocol.dart';
import 'curriculum_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/curriculum from server.js. Public/unauthenticated, matching Node.
class CurriculumEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<CurriculumStatus> getStatus(Session session) async {
    return await CurriculumService.status(session);
  }
}
