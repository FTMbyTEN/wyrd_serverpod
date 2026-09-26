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

abstract class CountryWeather
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CountryWeather._({
    required this.tempC,
    required this.code,
  });

  factory CountryWeather({
    required double tempC,
    required int code,
  }) = _CountryWeatherImpl;

  factory CountryWeather.fromJson(Map<String, dynamic> jsonSerialization) {
    return CountryWeather(
      tempC: (jsonSerialization['tempC'] as num).toDouble(),
      code: jsonSerialization['code'] as int,
    );
  }

  double tempC;

  int code;

  /// Returns a shallow copy of this [CountryWeather]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CountryWeather copyWith({
    double? tempC,
    int? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CountryWeather',
      'tempC': tempC,
      'code': code,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CountryWeather',
      'tempC': tempC,
      'code': code,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CountryWeatherImpl extends CountryWeather {
  _CountryWeatherImpl({
    required double tempC,
    required int code,
  }) : super._(
         tempC: tempC,
         code: code,
       );

  /// Returns a shallow copy of this [CountryWeather]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CountryWeather copyWith({
    double? tempC,
    int? code,
  }) {
    return CountryWeather(
      tempC: tempC ?? this.tempC,
      code: code ?? this.code,
    );
  }
}
