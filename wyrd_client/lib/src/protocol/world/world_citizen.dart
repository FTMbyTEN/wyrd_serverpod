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

/// What WYRD, as the Authority of the open world, knows of one player: their standing in the city,
/// the missions they've done, and its own short record of them -- kept between visits.
abstract class WorldCitizen
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorldCitizen._({
    this.id,
    required this.authUserId,
    int? standing,
    int? missionsDone,
    this.record,
    this.mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    required this.updatedAt,
  }) : standing = standing ?? 0,
       missionsDone = missionsDone ?? 0,
       trainingOptIn = trainingOptIn ?? false,
       trainingAsked = trainingAsked ?? false;

  factory WorldCitizen({
    int? id,
    required _isc.UuidValue authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    required DateTime updatedAt,
  }) = _WorldCitizenImpl;

  factory WorldCitizen.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorldCitizen(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      standing: jsonSerialization['standing'] as int?,
      missionsDone: jsonSerialization['missionsDone'] as int?,
      record: jsonSerialization['record'] as String?,
      mission: jsonSerialization['mission'] as String?,
      trainingOptIn: jsonSerialization['trainingOptIn'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['trainingOptIn']),
      trainingAsked: jsonSerialization['trainingAsked'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['trainingAsked']),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// -100 .. 100: how the Authority regards them
  int standing;

  int missionsDone;

  /// WYRD's own notes on this citizen (it writes these), at most ~1,200 characters
  String? record;

  /// the mission WYRD has given them and not yet seen done, as JSON
  String? mission;

  /// the player agreed to let WYRD learn from their play (asked once, changeable any time)
  bool trainingOptIn;

  /// whether they've been asked yet
  bool trainingAsked;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorldCitizen copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorldCitizen',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'standing': standing,
      'missionsDone': missionsDone,
      if (record != null) 'record': record,
      if (mission != null) 'mission': mission,
      'trainingOptIn': trainingOptIn,
      'trainingAsked': trainingAsked,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorldCitizen',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'standing': standing,
      'missionsDone': missionsDone,
      if (record != null) 'record': record,
      if (mission != null) 'mission': mission,
      'trainingOptIn': trainingOptIn,
      'trainingAsked': trainingAsked,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorldCitizenImpl extends WorldCitizen {
  _WorldCitizenImpl({
    int? id,
    required _isc.UuidValue authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         standing: standing,
         missionsDone: missionsDone,
         record: record,
         mission: mission,
         trainingOptIn: trainingOptIn,
         trainingAsked: trainingAsked,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorldCitizen copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    int? standing,
    int? missionsDone,
    Object? record = _Undefined,
    Object? mission = _Undefined,
    bool? trainingOptIn,
    bool? trainingAsked,
    DateTime? updatedAt,
  }) {
    return WorldCitizen(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      standing: standing ?? this.standing,
      missionsDone: missionsDone ?? this.missionsDone,
      record: record is String? ? record : this.record,
      mission: mission is String? ? mission : this.mission,
      trainingOptIn: trainingOptIn ?? this.trainingOptIn,
      trainingAsked: trainingAsked ?? this.trainingAsked,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
