import 'package:test/test.dart';
import 'package:wyrd_server/src/island/island_weather_route.dart';

void main() {
  final now = DateTime.utc(2026, 10, 20, 12, 30);
  int at(int h, [int m = 0]) => DateTime.utc(2026, 10, 20, h, m).millisecondsSinceEpoch ~/ 1000;
  // what the model said this afternoon: a steady drizzle under 92% cloud
  final model = {'time': '2026-10-20T13:30', 'temperature_2m': 29.1, 'precipitation': 0.1, 'weather_code': 51, 'cloud_cover': 92, 'visibility': 9180, 'is_day': 1};

  test('a recent airport report decides it: broken cloud and dry, not the model\'s drizzle', () {
    final w = IslandWeatherRoute.merge(model, null, {'obsTime': at(11), 'temp': 32, 'wspd': 8, 'wdir': 220, 'visib': '6+', 'clouds': [{'cover': 'BKN'}]}, now: now);
    expect(w['source'], 'observed');
    expect(w['precipitation_mm_h'], 0);
    expect(w['weather_code'], 2);
    expect(w['cloud_cover'], 75);
    expect(w['temperature_2m'], 32);
    expect(w['visibility'], 20000);
  });

  test('thunder at the airport is a storm on the island', () {
    final w = IslandWeatherRoute.merge(model, null, {'obsTime': at(12), 'wxString': '-TSRA', 'clouds': [{'cover': 'FEW'}, {'cover': 'SCT'}]}, now: now);
    expect(w['weather_code'], 95);
    expect(w['precipitation_mm_h'], 3);
  });

  test('heavy rain reported is heavy rain', () {
    final w = IslandWeatherRoute.merge(model, null, {'obsTime': at(12), 'wxString': '+RA', 'clouds': [{'cover': 'OVC'}]}, now: now);
    expect((w['weather_code'], w['precipitation_mm_h'], w['cloud_cover']), (65, 10.0, 100));
  });

  test('no recent report: the model, without its phantom drizzle, its 15-minute rain as mm an hour', () {
    expect(IslandWeatherRoute.merge(model, null, {'obsTime': at(9)}, now: now)['source'], 'model');
    expect(IslandWeatherRoute.merge(model, null, null, now: now)['precipitation_mm_h'], 0);
    final wet = IslandWeatherRoute.merge({...model, 'precipitation': 1.5, 'weather_code': 63}, null, null, now: now);
    expect(wet['precipitation_mm_h'], 6);
  });

  test('rain that started after a dry report counts once the model sees real rain', () {
    final w = IslandWeatherRoute.merge({...model, 'precipitation': 1.0, 'weather_code': 63}, null, {'obsTime': at(11, 30), 'clouds': [{'cover': 'BKN'}]}, now: now);
    expect(w['precipitation_mm_h'], 4);
    final soon = IslandWeatherRoute.merge({...model, 'precipitation': 1.0, 'weather_code': 63}, null, {'obsTime': at(12, 10), 'clouds': [{'cover': 'BKN'}]}, now: now);
    expect(soon['precipitation_mm_h'], 0, reason: 'a report 20 minutes ago said dry');
  });
}
