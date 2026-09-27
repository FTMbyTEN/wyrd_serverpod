/// How often each recurring background tick runs. Scheduled in server.dart and reported by
/// StatusEndpoint, so the two can't drift apart.
class TickSchedule {
  static const growthSnapshot = Duration(minutes: 30);
  static const diaryCheck = Duration(minutes: 10);
  static const reasoning = Duration(seconds: 30);
  static const selfQuestion = Duration(seconds: 30);
  // every synthesis tick is an LLM call; hourly keeps it inside the daily budget (was 90s)
  static const synthesis = Duration(hours: 1);
  static const feed = Duration(seconds: 60);
  static const selfConfig = Duration(hours: 4);
  static const lexicon = Duration(seconds: 30);
  static const dreamIdleCheck = Duration(minutes: 15);

  static final _lastRun = <String, DateTime>{};

  /// Lets a tick run only if it hasn't run in the last ~80% of its interval on this server.
  /// Recurring future calls are stored in the database, and a deploy can briefly leave an old
  /// server re-adding its entries after the new one cleared them (see server.dart); duplicates
  /// then fire, see a recent run and skip, instead of multiplying background work and AI spend.
  static bool claim(String name, Duration every) {
    final now = DateTime.now();
    final last = _lastRun[name];
    if (last != null && now.difference(last) < every * 0.8) return false;
    _lastRun[name] = now;
    return true;
  }
}
