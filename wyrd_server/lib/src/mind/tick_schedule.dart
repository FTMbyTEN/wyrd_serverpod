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
}
