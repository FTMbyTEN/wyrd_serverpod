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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// What NAIJA 2099's city has seen, kept to teach WYRD -- anonymous and counted, never personal: how many times
/// something happened at one place in one hour (cars queued at a junction, crashes on a street, rides to a
/// district...). Only from players who agreed to let WYRD learn from their play. No player is stored with it.
abstract class CitySignal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CitySignal._({
    this.id,
    required this.hour,
    required this.kind,
    required this.place,
    required this.times,
    required this.total,
  });

  factory CitySignal({
    int? id,
    required DateTime hour,
    required String kind,
    required String place,
    required int times,
    required double total,
  }) = _CitySignalImpl;

  factory CitySignal.fromJson(Map<String, dynamic> jsonSerialization) {
    return CitySignal(
      id: jsonSerialization['id'] as int?,
      hour: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['hour']),
      kind: jsonSerialization['kind'] as String,
      place: jsonSerialization['place'] as String,
      times: jsonSerialization['times'] as int,
      total: (jsonSerialization['total'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// the hour it happened in (UTC, on the hour)
  DateTime hour;

  /// queue | ride | air | crash | redlight | speeding | caught | lost | call | switch
  String kind;

  /// a street, junction or district name from the game's map (at most 60 characters)
  String place;

  /// how many times
  int times;

  /// a quantity summed over them, where the kind has one (cars waiting, km ridden, km/h...)
  double total;

  /// Returns a shallow copy of this [CitySignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CitySignal copyWith({
    int? id,
    DateTime? hour,
    String? kind,
    String? place,
    int? times,
    double? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CitySignal',
      if (id != null) 'id': id,
      'hour': hour.toJson(),
      'kind': kind,
      'place': place,
      'times': times,
      'total': total,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CitySignal',
      if (id != null) 'id': id,
      'hour': hour.toJson(),
      'kind': kind,
      'place': place,
      'times': times,
      'total': total,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CitySignalImpl extends CitySignal {
  _CitySignalImpl({
    int? id,
    required DateTime hour,
    required String kind,
    required String place,
    required int times,
    required double total,
  }) : super._(
         id: id,
         hour: hour,
         kind: kind,
         place: place,
         times: times,
         total: total,
       );

  /// Returns a shallow copy of this [CitySignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CitySignal copyWith({
    Object? id = _Undefined,
    DateTime? hour,
    String? kind,
    String? place,
    int? times,
    double? total,
  }) {
    return CitySignal(
      id: id is int? ? id : this.id,
      hour: hour ?? this.hour,
      kind: kind ?? this.kind,
      place: place ?? this.place,
      times: times ?? this.times,
      total: total ?? this.total,
    );
  }
}
