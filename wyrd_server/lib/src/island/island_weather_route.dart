import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

/// Lagos Island's weather, one reading for every player: GET /lagos-island/weather.
///
/// The weather model (Open-Meteo) alone runs wrong over coastal Lagos: it often shows a steady drizzle under thick
/// cloud while the sky is dry. So the real observation from Lagos airport (DNMM, the official METAR, about hourly)
/// decides what it is doing whenever there is a recent one: rain or thunder, the cloud, fog or haze, the temperature
/// and the wind. The model fills the gaps between reports (and the humidity, the dust), with its 15-minute rainfall
/// turned into mm an hour. Fetched at most every 10 minutes, whoever asks.
class IslandWeatherRoute extends Route {
  IslandWeatherRoute() : super(methods: {Method.get});

  static Map<String, dynamic>? _last;
  static DateTime _at = DateTime.fromMillisecondsSinceEpoch(0);
  static Future<Map<String, dynamic>>? _pending;

  /// a report this recent decides the weather; older, the model does
  static const obsFresh = Duration(minutes: 150);

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    Map<String, dynamic> w;
    try {
      w = await current(session);
    } catch (e) {
      session.log('[weather] $e', level: LogLevel.warning);
      if (_last == null) return _json(503, {'error': 'no reading yet'});
      w = _last!;
    }
    return _json(200, w);
  }

  static Response _json(int status, Map<String, dynamic> m) => Response(status,
      body: Body.fromString(jsonEncode(m), mimeType: MimeType.json),
      headers: Headers.fromMap({
        'cache-control': ['public, max-age=300'],
        'access-control-allow-origin': ['*'], // the game also runs from a local copy while it's being built
      }));

  static Future<Map<String, dynamic>> current(Session s) {
    if (_last != null && DateTime.now().difference(_at) < const Duration(minutes: 10)) return Future.value(_last!);
    return _pending ??= _fetch().then((w) {
      _last = w;
      _at = DateTime.now();
      return w;
    }).whenComplete(() => _pending = null);
  }

  static Future<Object?> _get(String url) async {
    final c = HttpClient()..connectionTimeout = const Duration(seconds: 8);
    try {
      final rq = await c.getUrl(Uri.parse(url));
      rq.headers.set('user-agent', 'LagosIsland/1.0 (wryd00.serverpod.space)');
      final rs = await rq.close().timeout(const Duration(seconds: 10));
      if (rs.statusCode != 200) throw HttpException('$url: ${rs.statusCode}');
      return jsonDecode(await rs.transform(utf8.decoder).join());
    } finally {
      c.close(force: true);
    }
  }

  static Future<Map<String, dynamic>> _fetch() async {
    final results = await Future.wait([
      _get('https://api.open-meteo.com/v1/forecast?latitude=6.45&longitude=3.42&current=temperature_2m,apparent_temperature,relative_humidity_2m,precipitation,weather_code,cloud_cover,visibility,wind_speed_10m,wind_direction_10m,is_day&timezone=Africa%2FLagos').catchError((_) => null),
      _get('https://air-quality-api.open-meteo.com/v1/air-quality?latitude=6.45&longitude=3.42&current=dust,pm10&timezone=Africa%2FLagos').catchError((_) => null),
      _get('https://aviationweather.gov/api/data/metar?ids=DNMM&hours=3&format=json').catchError((_) => null),
    ]);
    final model = (results[0] as Map?)?['current'] as Map?, air = (results[1] as Map?)?['current'] as Map?;
    final obsList = results[2] is List ? results[2] as List : const [];
    if (model == null && obsList.isEmpty) throw StateError('no weather source answered');
    return merge(model?.cast<String, dynamic>(), air?.cast<String, dynamic>(), obsList.isEmpty ? null : (obsList.first as Map).cast<String, dynamic>());
  }

  /// The reading the game uses, in its own terms (rainMm is mm an hour; visibility in metres).
  static Map<String, dynamic> merge(Map<String, dynamic>? m, Map<String, dynamic>? air, Map<String, dynamic>? obs, {DateTime? now}) {
    final t = now ?? DateTime.now().toUtc();
    final obsAt = obs?['obsTime'] is num ? DateTime.fromMillisecondsSinceEpoch((obs!['obsTime'] as num).toInt() * 1000, isUtc: true) : null;
    final fresh = obsAt != null && t.difference(obsAt) <= obsFresh;
    // the model, as a fallback: 15-minute rain to mm an hour; a thin drizzle under cloud is the model's habit here, not rain
    var code = (m?['weather_code'] as num?)?.toInt() ?? 0;
    var rainMm = ((m?['precipitation'] as num?)?.toDouble() ?? 0) * 4;
    if (rainMm < 0.5 && code >= 51 && code <= 57) {
      rainMm = 0;
      code = 3;
    }
    var cloud = (m?['cloud_cover'] as num?)?.toDouble() ?? 30;
    var vis = (m?['visibility'] as num?)?.toDouble() ?? 20000;
    num? temp = m?['temperature_2m'] as num?, wind = m?['wind_speed_10m'] as num?, windDir = m?['wind_direction_10m'] as num?;
    String source = 'model';
    if (fresh) {
      source = 'observed';
      final wx = '${obs!['wxString'] ?? ''}';
      const covers = {'FEW': 20, 'SCT': 45, 'BKN': 75, 'OVC': 100, 'VV': 100};
      final layers = obs['clouds'] is List ? (obs['clouds'] as List).map((c) => covers['${(c as Map)['cover']}'] ?? 0).toList() : <int>[];
      cloud = layers.isEmpty ? (const {'CLR': 0, 'SKC': 0, 'CAVOK': 0, 'NSC': 5}['${obs['cover']}'] ?? 10).toDouble() : layers.reduce(max).toDouble();
      final v = '${obs['visib'] ?? ''}';
      vis = v.endsWith('+') ? 20000 : ((double.tryParse(v) ?? 6) * 1609).clamp(50, 20000).toDouble();
      temp = obs['temp'] as num? ?? temp;
      wind = obs['wspd'] is num ? (obs['wspd'] as num) * 1.852 : wind; // knots to km/h
      windDir = obs['wdir'] is num ? obs['wdir'] as num : windDir;
      final heavy = wx.contains('+'), light = wx.contains('-');
      if (wx.contains('TS')) {
        code = 95;
        rainMm = wx.contains('RA') ? (heavy ? 12 : light ? 3 : 7) : max(rainMm, 0);
      } else if (wx.contains('RA') || wx.contains('SH')) {
        code = heavy ? 65 : light ? 61 : 63;
        rainMm = heavy ? 10 : light ? 1 : 4;
      } else if (wx.contains('DZ')) {
        code = 53;
        rainMm = 0.4;
      } else {
        // dry when it was observed; rain that started since only counts if the model sees real rain (not its drizzle)
        final sinceObs = t.difference(obsAt);
        if (!(sinceObs > const Duration(minutes: 45) && rainMm >= 2)) {
          rainMm = 0;
          code = wx.contains('FG') ? 45 : cloud >= 85 ? 3 : cloud >= 45 ? 2 : cloud >= 15 ? 1 : 0;
        }
      }
    }
    final lagos = t.add(const Duration(hours: 1));
    return {
      'time': (m?['time'] as String?) ?? '${lagos.toIso8601String().substring(0, 16)}',
      'temperature_2m': temp,
      'apparent_temperature': m?['apparent_temperature'] ?? temp,
      'relative_humidity_2m': m?['relative_humidity_2m'],
      'precipitation_mm_h': double.parse(rainMm.toStringAsFixed(1)),
      'weather_code': code,
      'cloud_cover': cloud.round(),
      'visibility': vis.round(),
      'wind_speed_10m': wind,
      'wind_direction_10m': windDir,
      'is_day': m?['is_day'] ?? (lagos.hour >= 7 && lagos.hour < 19 ? 1 : 0),
      'dust': air?['dust'] ?? 0,
      'pm10': air?['pm10'] ?? 0,
      'source': source,
      if (obsAt != null) 'observedAt': obsAt.toIso8601String(),
      if (obs != null) 'metar': obs['rawOb'],
    };
  }
}
