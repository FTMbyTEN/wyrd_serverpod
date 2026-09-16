import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Ports GET /api/mind from the Node backend (server.js `publicMind`). This first pass proves
/// the model -> generate -> endpoint -> client pipeline works for WYRD's real data shape; the
/// actual mind state (mood/curiosity/confidence ticks, digest tracking against real memory) still
/// lives only in the Node server's in-memory/JSON-file state and has not been ported yet — that's
/// a much larger piece (the autonomous reasoning/self-questioning/curriculum ticks that keep it
/// updated) than one endpoint. [getMind] returns a realistic placeholder shape, not live state.
class MindEndpoint extends Endpoint {
  Future<Mind> getMind(Session session) async {
    return Mind(
      mood: 'dormant',
      focusTopic: null,
      activeGoal: null,
      curiosity: 0.2,
      confidence: 0.5,
      digest: DigestInfo(
        totalTopics: 0,
        answeredTopics: 0,
        backlog: 0,
        percent: 0,
        ratePerMin: null,
        etaMinutes: null,
        etaAt: null,
      ),
      lastEvent: null,
      explorationCount: 0,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
