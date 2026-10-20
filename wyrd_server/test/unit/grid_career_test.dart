import 'dart:math';

import 'package:test/test.dart';
import 'package:wyrd_server/src/island/grid_career.dart';

void main() {
  group('Grid shifts are scored by the server from what the player did', () {
    test('turbine calls: only the right ones count', () {
      final t = {'type': 'turbine', 'units': [{'u': 1, 'right': 'keep'}, {'u': 2, 'right': 'shut'}, {'u': 3, 'right': 'reduce'}]};
      expect(GridCareer.grade(t, {'picks': {'1': 'keep', '2': 'shut', '3': 'reduce'}}).$1, 100);
      expect(GridCareer.grade(t, {'picks': {'1': 'keep', '2': 'keep', '3': 'keep'}}).$1, 33);
      expect(GridCareer.grade(t, {'score': 100}).$1, 0, reason: 'a claimed score is ignored');
    });

    test('a fault: the safe order and the right part; each slip is a strike; unfinished is 0', () {
      final t = {'type': 'fault', 'kind': 0};
      const ok = ['Open the breaker', 'Prove it dead with the tester', 'Apply the earths', 'part:Fuse, 63 A', 'Replace the blown fuse', 'Remove the earths', 'Close the breaker and restore'];
      expect(GridCareer.grade(t, {'clicks': ok}).$1, 100);
      expect(GridCareer.grade(t, {'clicks': ['Apply the earths', ...ok.take(3), 'part:Jumper cable', ...ok.skip(3)]}).$1, 64);
      expect(GridCareer.grade(t, {'clicks': ok.take(5).toList()}).$1, 0);
    });

    test('solar: dusty and cracked panels count, touching good ones costs', () {
      final t = {'type': 'solar', 'panels': ['dust', 'crack', 'ok', 'ok']};
      expect(GridCareer.grade(t, {'taps': [0, 1]}).$1, 100);
      expect(GridCareer.grade(t, {'taps': [0, 0, 0, 0]}).$1, 50, reason: 'tapping the same panel again earns nothing');
      expect(GridCareer.grade(t, {'taps': [0, 1, 2]}).$1, 92);
    });

    test('the control room: the slider log is replayed against the demand', () {
      final t = {'type': 'balance', 'title': 'Turbine 2 trips!', 'sun': 0};
      List<int> hold(int i) { // generation that matches 1050 MW of demand, picking up the trip at 20 s
        final dem = (1050 + sin(i / 6) * 30).round();
        return i < 20 ? [300, 300, 250, dem - 850] : [400, 0, 400, dem - 800];
      }
      expect(GridCareer.grade(t, {'log': [for (var i = 0; i < 90; i++) hold(i)]}).$1, 100);
      expect(GridCareer.grade(t, {'log': [for (var i = 0; i < 90; i++) [300, 300, 250, 100]]}).$1, lessThan(30), reason: 'ignoring the trip loses the band');
      expect(GridCareer.grade(t, {'log': [[400, 400, 400, 250]]}).$1, 0, reason: 'a short log is not a shift');
      expect(GridCareer.grade(t, {'log': [for (var i = 0; i < 90; i++) [99999, 99999, 99999, 99999]]}).$1,
          GridCareer.grade(t, {'log': [for (var i = 0; i < 90; i++) [400, 400, 400, 250]]}).$1, reason: 'sliders are clamped to what the plant has');
    });

    test('marshalling: the right signal for each cue', () {
      final t = {'type': 'marshal', 'cues': ['far', 'left', 'far', 'right', 'close', 'bar']};
      expect(GridCareer.grade(t, {'picks': ['straight', 'right', 'straight', 'left', 'slow', 'stop']}).$1, 100);
      expect(GridCareer.grade(t, {'picks': ['straight', 'left', 'straight', 'right', 'slow', 'stop']}).$1, 67, reason: 'turning into the drift is wrong');
    });

    test('a turnaround: all of it, in order; each wrong job a strike', () {
      const ok = GridCareer.turnaround;
      expect(GridCareer.grade({'type': 'turnaround'}, {'clicks': ok}).$1, 100);
      expect(GridCareer.grade({'type': 'turnaround'}, {'clicks': ['Refuel', ...ok]}).$1, 88);
      expect(GridCareer.grade({'type': 'turnaround'}, {'clicks': ok.take(8).toList()}).$1, 0);
    });

    test('the runway in time order, an arrival first on a tie', () {
      final t = {'type': 'atc', 'items': [{'cs': 'A1', 'kind': 'arr', 't': 60}, {'cs': 'A2', 'kind': 'arr', 't': 120}, {'cs': 'D1', 'kind': 'dep', 't': 60}, {'cs': 'D2', 'kind': 'dep', 't': 30}]};
      expect(GridCareer.grade(t, {'order': ['D2', 'A1', 'D1', 'A2']}).$1, 100);
      expect(GridCareer.grade(t, {'order': ['D2', 'D1', 'A1', 'A2']}).$1, 50);
      expect(GridCareer.grade(t, {'order': ['D2']}).$1, 0);
    });

    test('pay follows the level the server keeps', () {
      expect(GridCareer.payFor(1, 100), 12000);
      expect(GridCareer.payFor(1, 0), 6000);
      expect(GridCareer.payFor(5, 100), 34000);
      expect(GridCareer.payFor(9, 500), 34000, reason: 'out-of-range values are clamped');
    });

    test('no sun at night', () {
      expect(GridCareer.sunNow(DateTime.utc(2026, 10, 20, 22)), 0);
      expect(GridCareer.sunNow(DateTime.utc(2026, 10, 20, 11, 30)), 600);
    });
  });
}
