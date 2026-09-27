import 'lexicon_service.dart';
import 'tick_schedule.dart';
import 'package:serverpod/serverpod.dart';

/// Ports server.js's lexicon interval (learn one new word per tick). Scheduled recurring from
/// server.dart.
class LexiconFutureCall extends FutureCall {
  Future<void> tick(Session session) async {
    if (!TickSchedule.claim('lexicon', TickSchedule.lexicon)) return;
    await LexiconService.tick(session);
  }
}
