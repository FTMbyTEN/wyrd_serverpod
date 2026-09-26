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

abstract class WorldCountry
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WorldCountry._({
    required this.name,
    required this.cca2,
    required this.cca3,
    required this.region,
    required this.lat,
    required this.lng,
  });

  factory WorldCountry({
    required String name,
    required String cca2,
    required String cca3,
    required String region,
    required double lat,
    required double lng,
  }) = _WorldCountryImpl;

  factory WorldCountry.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorldCountry(
      name: jsonSerialization['name'] as String,
      cca2: jsonSerialization['cca2'] as String,
      cca3: jsonSerialization['cca3'] as String,
      region: jsonSerialization['region'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
    );
  }

  String name;

  String cca2;

  String cca3;

  String region;

  double lat;

  double lng;

  /// Returns a shallow copy of this [WorldCountry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorldCountry copyWith({
    String? name,
    String? cca2,
    String? cca3,
    String? region,
    double? lat,
    double? lng,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorldCountry',
      'name': name,
      'cca2': cca2,
      'cca3': cca3,
      'region': region,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorldCountry',
      'name': name,
      'cca2': cca2,
      'cca3': cca3,
      'region': region,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _WorldCountryImpl extends WorldCountry {
  _WorldCountryImpl({
    required String name,
    required String cca2,
    required String cca3,
    required String region,
    required double lat,
    required double lng,
  }) : super._(
         name: name,
         cca2: cca2,
         cca3: cca3,
         region: region,
         lat: lat,
         lng: lng,
       );

  /// Returns a shallow copy of this [WorldCountry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorldCountry copyWith({
    String? name,
    String? cca2,
    String? cca3,
    String? region,
    double? lat,
    double? lng,
  }) {
    return WorldCountry(
      name: name ?? this.name,
      cca2: cca2 ?? this.cca2,
      cca3: cca3 ?? this.cca3,
      region: region ?? this.region,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
