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

/// A player's National Grid career on one track (control, lineman, solar, plant): the server's own record of their
/// experience and level (1 Trainee .. 5 Chief). Pay is by this level, never by what the phone says.
abstract class IslandGridCareer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandGridCareer._({
    this.id,
    required this.authUserId,
    required this.track,
    required this.xp,
    required this.level,
    this.examAfter,
  });

  factory IslandGridCareer({
    int? id,
    required _isc.UuidValue authUserId,
    required String track,
    required int xp,
    required int level,
    DateTime? examAfter,
  }) = _IslandGridCareerImpl;

  factory IslandGridCareer.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGridCareer(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      track: jsonSerialization['track'] as String,
      xp: jsonSerialization['xp'] as int,
      level: jsonSerialization['level'] as int,
      examAfter: jsonSerialization['examAfter'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['examAfter']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String track;

  int xp;

  int level;

  /// a failed certification can be retaken after this
  DateTime? examAfter;

  /// Returns a shallow copy of this [IslandGridCareer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandGridCareer copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? track,
    int? xp,
    int? level,
    DateTime? examAfter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGridCareer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'track': track,
      'xp': xp,
      'level': level,
      if (examAfter != null) 'examAfter': examAfter?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGridCareer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'track': track,
      'xp': xp,
      'level': level,
      if (examAfter != null) 'examAfter': examAfter?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGridCareerImpl extends IslandGridCareer {
  _IslandGridCareerImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String track,
    required int xp,
    required int level,
    DateTime? examAfter,
  }) : super._(
         id: id,
         authUserId: authUserId,
         track: track,
         xp: xp,
         level: level,
         examAfter: examAfter,
       );

  /// Returns a shallow copy of this [IslandGridCareer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandGridCareer copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? track,
    int? xp,
    int? level,
    Object? examAfter = _Undefined,
  }) {
    return IslandGridCareer(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      track: track ?? this.track,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      examAfter: examAfter is DateTime? ? examAfter : this.examAfter,
    );
  }
}
