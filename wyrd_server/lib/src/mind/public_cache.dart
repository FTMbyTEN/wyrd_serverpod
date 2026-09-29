import 'package:serverpod/serverpod.dart';

/// A short-lived shared cache for public, non-personal answers (WYRD's mind, alerts, diary,
/// growth, word stats…). Every open app polls these; without it each poll re-ran several
/// database round trips. Concurrent callers share one computation, failures are never kept,
/// memory is bounded, and anything that changes the shared state on request (a manual trigger)
/// calls [clear] so its result shows at once. Off in tests, which read straight after writing.
class PublicCache {
  static final _entries = <String, (DateTime, Future<Object?>)>{};

  static Future<T> get<T>(Session session, String key, Duration ttl, Future<T> Function() compute) {
    if (session.serverpod.runMode == 'test') return compute();
    final hit = _entries[key];
    if (hit != null && DateTime.now().difference(hit.$1) < ttl) return hit.$2.then((v) => v as T);
    if (_entries.length >= 400) _entries.remove(_entries.keys.first); // oldest first, bounded memory
    final future = compute();
    _entries[key] = (DateTime.now(), future);
    future.catchError((Object _) {
      _entries.remove(key); // never cache a failure
      return null as T;
    });
    return future;
  }

  /// Forgets everything cached (after something changed WYRD's shared state).
  static void clear() => _entries.clear();
}
