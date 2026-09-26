/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;
import '../mind/country_weather.dart' as _ivrgl1cp;

abstract class CountryDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CountryDetail._({
    required this.name,
    this.capital,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.currencies,
    this.flag,
    this.weather,
  });

  factory CountryDetail({
    required String name,
    String? capital,
    required String region,
    required String subregion,
    required List<String> languages,
    required List<String> currencies,
    String? flag,
    _ivrgl1cp.CountryWeather? weather,
  }) = _CountryDetailImpl;

  factory CountryDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return CountryDetail(
      name: jsonSerialization['name'] as String,
      capital: jsonSerialization['capital'] as String?,
      region: jsonSerialization['region'] as String,
      subregion: jsonSerialization['subregion'] as String,
      languages: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['languages'],
      ),
      currencies: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['currencies'],
      ),
      flag: jsonSerialization['flag'] as String?,
      weather: jsonSerialization['weather'] == null
          ? null
          : _i9sln91s.Protocol().deserialize<_ivrgl1cp.CountryWeather>(
              jsonSerialization['weather'],
            ),
    );
  }

  String name;

  String? capital;

  String region;

  String subregion;

  List<String> languages;

  List<String> currencies;

  String? flag;

  _ivrgl1cp.CountryWeather? weather;

  /// Returns a shallow copy of this [CountryDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CountryDetail copyWith({
    String? name,
    String? capital,
    String? region,
    String? subregion,
    List<String>? languages,
    List<String>? currencies,
    String? flag,
    _ivrgl1cp.CountryWeather? weather,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CountryDetail',
      'name': name,
      if (capital != null) 'capital': capital,
      'region': region,
      'subregion': subregion,
      'languages': languages.toJson(),
      'currencies': currencies.toJson(),
      if (flag != null) 'flag': flag,
      if (weather != null) 'weather': weather?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CountryDetail',
      'name': name,
      if (capital != null) 'capital': capital,
      'region': region,
      'subregion': subregion,
      'languages': languages.toJson(),
      'currencies': currencies.toJson(),
      if (flag != null) 'flag': flag,
      if (weather != null) 'weather': weather?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CountryDetailImpl extends CountryDetail {
  _CountryDetailImpl({
    required String name,
    String? capital,
    required String region,
    required String subregion,
    required List<String> languages,
    required List<String> currencies,
    String? flag,
    _ivrgl1cp.CountryWeather? weather,
  }) : super._(
         name: name,
         capital: capital,
         region: region,
         subregion: subregion,
         languages: languages,
         currencies: currencies,
         flag: flag,
         weather: weather,
       );

  /// Returns a shallow copy of this [CountryDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CountryDetail copyWith({
    String? name,
    Object? capital = _Undefined,
    String? region,
    String? subregion,
    List<String>? languages,
    List<String>? currencies,
    Object? flag = _Undefined,
    Object? weather = _Undefined,
  }) {
    return CountryDetail(
      name: name ?? this.name,
      capital: capital is String? ? capital : this.capital,
      region: region ?? this.region,
      subregion: subregion ?? this.subregion,
      languages: languages ?? this.languages.map((e0) => e0).toList(),
      currencies: currencies ?? this.currencies.map((e0) => e0).toList(),
      flag: flag is String? ? flag : this.flag,
      weather: weather is _ivrgl1cp.CountryWeather?
          ? weather
          : this.weather?.copyWith(),
    );
  }
}
