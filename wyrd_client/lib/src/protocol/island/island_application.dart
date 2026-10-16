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

/// Someone applied for a job: the employer sees their handle, the skills they listed and this note --
/// nothing else about them.
abstract class IslandApplication
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandApplication._({
    this.id,
    required this.jobId,
    required this.authUserId,
    required this.note,
    required this.createdAt,
  });

  factory IslandApplication({
    int? id,
    required int jobId,
    required _isc.UuidValue authUserId,
    required String note,
    required DateTime createdAt,
  }) = _IslandApplicationImpl;

  factory IslandApplication.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandApplication(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      note: jsonSerialization['note'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  _isc.UuidValue authUserId;

  String note;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandApplication]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandApplication copyWith({
    int? id,
    int? jobId,
    _isc.UuidValue? authUserId,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandApplication',
      if (id != null) 'id': id,
      'jobId': jobId,
      'authUserId': authUserId.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandApplication',
      if (id != null) 'id': id,
      'jobId': jobId,
      'authUserId': authUserId.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandApplicationImpl extends IslandApplication {
  _IslandApplicationImpl({
    int? id,
    required int jobId,
    required _isc.UuidValue authUserId,
    required String note,
    required DateTime createdAt,
  }) : super._(
         id: id,
         jobId: jobId,
         authUserId: authUserId,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandApplication]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandApplication copyWith({
    Object? id = _Undefined,
    int? jobId,
    _isc.UuidValue? authUserId,
    String? note,
    DateTime? createdAt,
  }) {
    return IslandApplication(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      authUserId: authUserId ?? this.authUserId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
