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

/// A paid trip (a flight or a yacht charter): booked when it was paid for, started when the player was actually on it.
/// Only a trip that was booked and never started can be refunded.
abstract class IslandTrip
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandTrip._({
    this.id,
    required this.authUserId,
    required this.entryKey,
    required this.bookedAt,
    this.startedAt,
  });

  factory IslandTrip({
    int? id,
    required _isc.UuidValue authUserId,
    required String entryKey,
    required DateTime bookedAt,
    DateTime? startedAt,
  }) = _IslandTripImpl;

  factory IslandTrip.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTrip(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      entryKey: jsonSerialization['entryKey'] as String,
      bookedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['bookedAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// the ledger entry that paid for it (its key)
  String entryKey;

  DateTime bookedAt;

  DateTime? startedAt;

  /// Returns a shallow copy of this [IslandTrip]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandTrip copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? entryKey,
    DateTime? bookedAt,
    DateTime? startedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTrip',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryKey': entryKey,
      'bookedAt': bookedAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTrip',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryKey': entryKey,
      'bookedAt': bookedAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTripImpl extends IslandTrip {
  _IslandTripImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String entryKey,
    required DateTime bookedAt,
    DateTime? startedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         entryKey: entryKey,
         bookedAt: bookedAt,
         startedAt: startedAt,
       );

  /// Returns a shallow copy of this [IslandTrip]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandTrip copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? entryKey,
    DateTime? bookedAt,
    Object? startedAt = _Undefined,
  }) {
    return IslandTrip(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      entryKey: entryKey ?? this.entryKey,
      bookedAt: bookedAt ?? this.bookedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
    );
  }
}
