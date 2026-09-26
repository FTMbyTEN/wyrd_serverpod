import 'lexicon_service.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's lexicon interval (learn one new word per tick). Scheduled recurring from
/// server.dart.
class LexiconFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    await LexiconService.tick(session);
  }
}
