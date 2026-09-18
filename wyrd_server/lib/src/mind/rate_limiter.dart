/// Ports server.js's rateLimited -- an in-memory sliding-window limiter. Per-process state is
/// fine here for the same reason it was fine in Node: this is a soft abuse guard, not a
/// security boundary, and Serverpod (like the Node process) typically runs as a single
/// instance for this project.
class RateLimiter {
  static final Map<String, List<DateTime>> _buckets = {};
  static DateTime _lastCleanup = DateTime.now();

  /// Returns true if [key] has exceeded [limit] hits within the trailing [window].
  static bool isLimited(String key, int limit, Duration window) {
    final now = DateTime.now();
    _cleanupIfDue(now);

    final hits = (_buckets[key] ?? []).where((t) => now.difference(t) < window).toList();
    hits.add(now);
    _buckets[key] = hits;
    return hits.length > limit;
  }

  static void _cleanupIfDue(DateTime now) {
    if (now.difference(_lastCleanup) < const Duration(minutes: 5)) return;
    _lastCleanup = now;
    final cutoff = now.subtract(const Duration(minutes: 15));
    _buckets.removeWhere((key, hits) {
      hits.retainWhere((t) => t.isAfter(cutoff));
      return hits.isEmpty;
    });
  }
}
