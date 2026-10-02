import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../drone/drone_service.dart';
import 'training_data_service.dart';

/// The fine-tuning dataset, for WYRD's owner only (the operator account): what would be trained on,
/// and the files themselves, ready to upload to a fine-tuning platform.
class TrainingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> _owner(Session session) async {
    final who = session.authenticated?.userIdentifier;
    if (who == null || !await DroneService.isOperator(session, UuidValue.fromString(who))) {
      throw Exception('Only the owner can export training data.');
    }
  }

  /// How many examples there are per source, and how many were dropped for each reason, as JSON.
  Future<String> stats(Session session) async {
    await _owner(session);
    final set = await TrainingDataService.build(session);
    return jsonEncode(set.stats);
  }

  /// One split as JSON Lines: [part] is 'train' or 'validation'.
  Future<String> export(Session session, String part) async {
    await _owner(session);
    final set = await TrainingDataService.build(session);
    session.log('[training] exported $part: ${set.stats}');
    return part == 'validation' ? set.validationJsonl : set.trainJsonl;
  }
}
