import 'package:test/test.dart';
import 'package:wyrd_server/src/world/police_service.dart';

void main() {
  test('evidence: independent sources combine; one kind counts once', () {
    expect(PoliceService.confidence([{'source': 'unit', 'confidence': 0.85}]), closeTo(0.85, 1e-9));
    // a unit and a patrol: 1 - 0.15 * 0.1
    expect(PoliceService.confidence([{'source': 'unit', 'confidence': 0.85}, {'source': 'patrol', 'confidence': 0.9}]), closeTo(0.985, 1e-9));
    // three witnesses are one kind of evidence: never enough for a fine on their own
    final w = PoliceService.confidence([for (var i = 0; i < 3; i++) {'source': 'witness', 'confidence': 0.4}]);
    expect(w, lessThan(0.8));
  });

  test('units: about one in ten faulty in a week, found out after two days', () {
    final at = DateTime.utc(2026, 10, 10, 12);
    var faulty = 0;
    for (var i = 0; i < 1000; i++) { if (PoliceService.unitHealth('T-$i', at).$1 < 1) faulty++; }
    expect(faulty, inInclusiveRange(60, 140));
    // a faulty unit reads 0.5; whether it's known depends on how far into its week we are
    final f = [for (var i = 0; i < 1000; i++) 'T-$i'].firstWhere((u) => PoliceService.unitHealth(u, at).$1 < 1);
    final week = at.millisecondsSinceEpoch ~/ (7 * 86400000);
    final start = DateTime.fromMillisecondsSinceEpoch(week * 7 * 86400000, isUtc: true);
    expect(PoliceService.unitHealth(f, start.add(const Duration(hours: 12))).$2, isFalse);
    expect(PoliceService.unitHealth(f, start.add(const Duration(days: 3))).$2, isTrue);
  });
}
