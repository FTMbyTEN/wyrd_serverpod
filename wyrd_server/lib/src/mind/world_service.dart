import 'dart:convert';

import '../generated/protocol.dart';
import 'world_countries_data.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

/// Ports server.js's world-map data (/api/world/countries, /api/world/country/:code). Country
/// facts are bundled static data; weather is the one live piece, fetched from Open-Meteo per
/// country centroid and cached briefly so repeat clicks don't refetch every time.
class WorldService {
  static const _weatherTtl = Duration(minutes: 15);
  static final _weatherCache =
      <String, ({DateTime at, CountryWeather weather})>{};
  static final _byCca3 = {for (final c in worldCountries) c.cca3: c};

  static List<WorldCountry> countries() => [
    for (final c in worldCountries)
      WorldCountry(
        name: c.name,
        cca2: c.cca2,
        cca3: c.cca3,
        region: c.region,
        lat: c.lat,
        lng: c.lng,
      ),
  ];

  /// Null for an unknown code.
  static Future<CountryDetail?> country(Session session, String code) async {
    final info = _byCca3[code.toUpperCase()];
    if (info == null) return null;
    return CountryDetail(
      name: info.name,
      capital: info.capital,
      region: info.region,
      subregion: info.subregion,
      languages: info.languages,
      currencies: info.currencies,
      flag: info.flag,
      weather: await _weather(session, info),
    );
  }

  static Future<CountryWeather?> _weather(
    Session session,
    WorldCountryData info,
  ) async {
    final cached = _weatherCache[info.cca3];
    if (cached != null && DateTime.now().difference(cached.at) < _weatherTtl) {
      return cached.weather;
    }
    try {
      final res = await http
          .get(
            Uri.parse(
              'https://api.open-meteo.com/v1/forecast'
              '?latitude=${info.lat}&longitude=${info.lng}&current=temperature_2m,weather_code',
            ),
          )
          .timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final current =
            (jsonDecode(res.body) as Map<String, dynamic>)['current']
                as Map<String, dynamic>?;
        if (current != null) {
          final weather = CountryWeather(
            tempC: (current['temperature_2m'] as num).toDouble(),
            code: (current['weather_code'] as num).toInt(),
          );
          _weatherCache[info.cca3] = (at: DateTime.now(), weather: weather);
          return weather;
        }
      }
    } catch (e) {
      session.log(
        '[world] weather fetch failed for ${info.cca3}: $e',
        level: LogLevel.warning,
      );
    }
    return cached?.weather; // stale beats nothing
  }
}
