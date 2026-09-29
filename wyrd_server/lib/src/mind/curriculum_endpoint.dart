import '../generated/protocol.dart';
import 'curriculum_service.dart';
import 'public_cache.dart';
import 'package:serverpod/serverpod.dart';

/// Ports /api/curriculum from server.js. Public/unauthenticated, matching Node.
class CurriculumEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<CurriculumStatus> getStatus(Session session) =>
      PublicCache.get(session, 'curriculum.getStatus', const Duration(seconds: 60), () => _getStatus(session));

  Future<CurriculumStatus> _getStatus(Session session) async {
    return await CurriculumService.status(session);
  }
}
