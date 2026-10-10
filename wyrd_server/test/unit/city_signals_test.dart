import 'package:test/test.dart';
import 'package:wyrd_server/src/generated/protocol.dart';
import 'package:wyrd_server/src/world/city_signals.dart';

void main() {
  CitySignal row(int day, String kind, String place, int times, [double total = 0]) =>
      CitySignal(hour: DateTime.utc(2026, 10, day, 14), kind: kind, place: place, times: times, total: total);

  test('a week of tallies becomes dated questions and answers', () {
    final stats = <String, int>{};
    final ex = CitySignals.examplesFrom([
      row(5, 'crash', 'Ikorodu Road', 5), row(6, 'crash', 'Ojuelegba Road', 2), row(7, 'redlight', 'Broad Street / Joseph Street', 3),
      row(7, 'queue', 'Broad Street / Joseph Street', 2, 14), row(8, 'ride', 'Victoria Island', 4, 18), row(8, 'caught', 'Marina', 1),
      row(9, 'call', 'Family connections', 1), // (not about the roads)
    ], (k) => stats[k] = (stats[k] ?? 0) + 1);
    for (final e in ex) {
      print('${e.messages[1].content.replaceAll('\n', ' | ')}\n  -> ${e.messages[2].content}');
    }
    expect(ex, isNotEmpty);
    expect(ex.every((e) => e.source == 'city'), isTrue);
    expect(ex.first.messages[1].content, contains('week of 5 Oct 2026'));
    expect(ex.any((e) => e.messages[2].content.contains('Family')), isFalse);
  });

  test('a thin week is left out', () {
    final stats = <String, int>{};
    expect(CitySignals.examplesFrom([row(12, 'crash', 'Ikorodu Road', 2)], (k) => stats[k] = (stats[k] ?? 0) + 1), isEmpty);
    expect(stats['dropped.city.thin_week'], 1);
  });
}
