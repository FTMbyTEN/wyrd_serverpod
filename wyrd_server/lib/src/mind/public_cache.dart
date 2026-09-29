/// A short-lived shared cache for public, non-personal answers (WYRD's mind, alerts, word
/// stats). Every open app polls these; without it each poll re-ran several database round
/// trips. Concurrent callers share one computation.
class PublicCache {
  static final _entries = <String, (DateTime, Future<Object?>)>{};

  static Future<T> get<T>(String key, Duration ttl, Future<T> Function() compute) {
    final hit = _entries[key];
    if (hit != null && DateTime.now().difference(hit.$1) < ttl) return hit.$2.then((v) => v as T);
    final future = compute();
    _entries[key] = (DateTime.now(), future);
    future.catchError((Object _) {
      _entries.remove(key); // never cache a failure
      return null as T;
    });
    return future;
  }
}
