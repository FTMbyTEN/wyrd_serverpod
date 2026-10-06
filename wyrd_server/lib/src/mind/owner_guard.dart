import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';

/// The owner's things -- WYRD's diary, its dreams, COP -- are for the operator accounts only.
/// Anyone else (signed in or not) is refused.
class OwnerGuard {
  /// Tests that exercise the owner's endpoints without an operator account switch this on.
  static bool openForTesting = false;

  static Future<void> check(Session session, [String what = 'this']) async {
    if (openForTesting) return;
    final who = session.authenticated?.userIdentifier;
    if (who == null || !await DroneService.isOperator(session, UuidValue.fromString(who))) {
      throw Exception('Only the owner can see $what.');
    }
  }
}
