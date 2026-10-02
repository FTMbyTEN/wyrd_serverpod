import 'package:serverpod/serverpod.dart';

/// The two drone secrets, read from Serverpod passwords:
///   droneBridgeToken   -- shared secret the bridge presents (use a long random value)
///   droneOperatorEmail -- the accounts with drone access (comma-separated emails): only they see
///                         the drone at all, plan flights and abort
/// Tests set the overrides instead of needing entries in config/passwords.yaml.
class DroneConfig {
  static String? bridgeTokenForTesting;
  static String? operatorEmailForTesting;

  static String bridgeToken(Session session) =>
      bridgeTokenForTesting ?? session.passwords['droneBridgeToken'] ?? '';

  static Set<String> operatorEmails(Session session) =>
      (operatorEmailForTesting ?? session.passwords['droneOperatorEmail'] ?? '')
          .split(',')
          .map((e) => e.trim().toLowerCase())
          .where((e) => e.isNotEmpty)
          .toSet();
}
