import 'self_config_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's SELF_MODIFY_CHECK_MS/SELF_MODIFY_MIN_GAP_MS pair (checked every 2h, but
/// only ever actually acts every 4h+, via a manual lastSelfModifyAt guard). Serverpod's
/// recurring FutureCall already guarantees one execution per scheduled interval, so that
/// guard collapses to just scheduling directly on the 4-hour interval.
class SelfConfigFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    await SelfConfigService.attemptSelfModification(session);
  }
}
