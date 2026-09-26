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

abstract class DroneState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DroneState._({
    this.id,
    required this.droneId,
    required this.connected,
    required this.armed,
    this.mode,
    this.lat,
    this.lon,
    this.relativeAltM,
    this.headingDeg,
    this.groundSpeedMs,
    this.batteryPct,
    this.gpsFix,
    this.satellites,
    this.homeLat,
    this.homeLon,
    this.missionStatus,
    this.missionStep,
    this.missionError,
    required this.updatedAt,
  });

  factory DroneState({
    int? id,
    required String droneId,
    required bool connected,
    required bool armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    required DateTime updatedAt,
  }) = _DroneStateImpl;

  factory DroneState.fromJson(Map<String, dynamic> jsonSerialization) {
    return DroneState(
      id: jsonSerialization['id'] as int?,
      droneId: jsonSerialization['droneId'] as String,
      connected: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['connected'],
      ),
      armed: _isc.BoolJsonExtension.fromJson(jsonSerialization['armed']),
      mode: jsonSerialization['mode'] as String?,
      lat: (jsonSerialization['lat'] as num?)?.toDouble(),
      lon: (jsonSerialization['lon'] as num?)?.toDouble(),
      relativeAltM: (jsonSerialization['relativeAltM'] as num?)?.toDouble(),
      headingDeg: (jsonSerialization['headingDeg'] as num?)?.toDouble(),
      groundSpeedMs: (jsonSerialization['groundSpeedMs'] as num?)?.toDouble(),
      batteryPct: jsonSerialization['batteryPct'] as int?,
      gpsFix: jsonSerialization['gpsFix'] as int?,
      satellites: jsonSerialization['satellites'] as int?,
      homeLat: (jsonSerialization['homeLat'] as num?)?.toDouble(),
      homeLon: (jsonSerialization['homeLon'] as num?)?.toDouble(),
      missionStatus: jsonSerialization['missionStatus'] as String?,
      missionStep: jsonSerialization['missionStep'] as int?,
      missionError: jsonSerialization['missionError'] as String?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String droneId;

  bool connected;

  bool armed;

  String? mode;

  double? lat;

  double? lon;

  double? relativeAltM;

  double? headingDeg;

  double? groundSpeedMs;

  int? batteryPct;

  int? gpsFix;

  int? satellites;

  double? homeLat;

  double? homeLon;

  String? missionStatus;

  int? missionStep;

  String? missionError;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DroneState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DroneState copyWith({
    int? id,
    String? droneId,
    bool? connected,
    bool? armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DroneState',
      if (id != null) 'id': id,
      'droneId': droneId,
      'connected': connected,
      'armed': armed,
      if (mode != null) 'mode': mode,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (relativeAltM != null) 'relativeAltM': relativeAltM,
      if (headingDeg != null) 'headingDeg': headingDeg,
      if (groundSpeedMs != null) 'groundSpeedMs': groundSpeedMs,
      if (batteryPct != null) 'batteryPct': batteryPct,
      if (gpsFix != null) 'gpsFix': gpsFix,
      if (satellites != null) 'satellites': satellites,
      if (homeLat != null) 'homeLat': homeLat,
      if (homeLon != null) 'homeLon': homeLon,
      if (missionStatus != null) 'missionStatus': missionStatus,
      if (missionStep != null) 'missionStep': missionStep,
      if (missionError != null) 'missionError': missionError,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DroneState',
      if (id != null) 'id': id,
      'droneId': droneId,
      'connected': connected,
      'armed': armed,
      if (mode != null) 'mode': mode,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (relativeAltM != null) 'relativeAltM': relativeAltM,
      if (headingDeg != null) 'headingDeg': headingDeg,
      if (groundSpeedMs != null) 'groundSpeedMs': groundSpeedMs,
      if (batteryPct != null) 'batteryPct': batteryPct,
      if (gpsFix != null) 'gpsFix': gpsFix,
      if (satellites != null) 'satellites': satellites,
      if (homeLat != null) 'homeLat': homeLat,
      if (homeLon != null) 'homeLon': homeLon,
      if (missionStatus != null) 'missionStatus': missionStatus,
      if (missionStep != null) 'missionStep': missionStep,
      if (missionError != null) 'missionError': missionError,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DroneStateImpl extends DroneState {
  _DroneStateImpl({
    int? id,
    required String droneId,
    required bool connected,
    required bool armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         droneId: droneId,
         connected: connected,
         armed: armed,
         mode: mode,
         lat: lat,
         lon: lon,
         relativeAltM: relativeAltM,
         headingDeg: headingDeg,
         groundSpeedMs: groundSpeedMs,
         batteryPct: batteryPct,
         gpsFix: gpsFix,
         satellites: satellites,
         homeLat: homeLat,
         homeLon: homeLon,
         missionStatus: missionStatus,
         missionStep: missionStep,
         missionError: missionError,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DroneState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DroneState copyWith({
    Object? id = _Undefined,
    String? droneId,
    bool? connected,
    bool? armed,
    Object? mode = _Undefined,
    Object? lat = _Undefined,
    Object? lon = _Undefined,
    Object? relativeAltM = _Undefined,
    Object? headingDeg = _Undefined,
    Object? groundSpeedMs = _Undefined,
    Object? batteryPct = _Undefined,
    Object? gpsFix = _Undefined,
    Object? satellites = _Undefined,
    Object? homeLat = _Undefined,
    Object? homeLon = _Undefined,
    Object? missionStatus = _Undefined,
    Object? missionStep = _Undefined,
    Object? missionError = _Undefined,
    DateTime? updatedAt,
  }) {
    return DroneState(
      id: id is int? ? id : this.id,
      droneId: droneId ?? this.droneId,
      connected: connected ?? this.connected,
      armed: armed ?? this.armed,
      mode: mode is String? ? mode : this.mode,
      lat: lat is double? ? lat : this.lat,
      lon: lon is double? ? lon : this.lon,
      relativeAltM: relativeAltM is double? ? relativeAltM : this.relativeAltM,
      headingDeg: headingDeg is double? ? headingDeg : this.headingDeg,
      groundSpeedMs: groundSpeedMs is double?
          ? groundSpeedMs
          : this.groundSpeedMs,
      batteryPct: batteryPct is int? ? batteryPct : this.batteryPct,
      gpsFix: gpsFix is int? ? gpsFix : this.gpsFix,
      satellites: satellites is int? ? satellites : this.satellites,
      homeLat: homeLat is double? ? homeLat : this.homeLat,
      homeLon: homeLon is double? ? homeLon : this.homeLon,
      missionStatus: missionStatus is String?
          ? missionStatus
          : this.missionStatus,
      missionStep: missionStep is int? ? missionStep : this.missionStep,
      missionError: missionError is String? ? missionError : this.missionError,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
