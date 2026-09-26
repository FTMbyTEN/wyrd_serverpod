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

abstract class DroneMission
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DroneMission._({
    this.id,
    required this.droneId,
    required this.kind,
    required this.instruction,
    required this.summary,
    required this.stepsJson,
    required this.status,
    this.reason,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DroneMission({
    int? id,
    required String droneId,
    required String kind,
    required String instruction,
    required String summary,
    required String stepsJson,
    required String status,
    String? reason,
    _isc.UuidValue? createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DroneMissionImpl;

  factory DroneMission.fromJson(Map<String, dynamic> jsonSerialization) {
    return DroneMission(
      id: jsonSerialization['id'] as int?,
      droneId: jsonSerialization['droneId'] as String,
      kind: jsonSerialization['kind'] as String,
      instruction: jsonSerialization['instruction'] as String,
      summary: jsonSerialization['summary'] as String,
      stepsJson: jsonSerialization['stepsJson'] as String,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['createdBy'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
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

  String kind;

  String instruction;

  String summary;

  String stepsJson;

  String status;

  String? reason;

  _isc.UuidValue? createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DroneMission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DroneMission copyWith({
    int? id,
    String? droneId,
    String? kind,
    String? instruction,
    String? summary,
    String? stepsJson,
    String? status,
    String? reason,
    _isc.UuidValue? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DroneMission',
      if (id != null) 'id': id,
      'droneId': droneId,
      'kind': kind,
      'instruction': instruction,
      'summary': summary,
      'stepsJson': stepsJson,
      'status': status,
      if (reason != null) 'reason': reason,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DroneMission',
      if (id != null) 'id': id,
      'droneId': droneId,
      'kind': kind,
      'instruction': instruction,
      'summary': summary,
      'stepsJson': stepsJson,
      'status': status,
      if (reason != null) 'reason': reason,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DroneMissionImpl extends DroneMission {
  _DroneMissionImpl({
    int? id,
    required String droneId,
    required String kind,
    required String instruction,
    required String summary,
    required String stepsJson,
    required String status,
    String? reason,
    _isc.UuidValue? createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         droneId: droneId,
         kind: kind,
         instruction: instruction,
         summary: summary,
         stepsJson: stepsJson,
         status: status,
         reason: reason,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DroneMission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DroneMission copyWith({
    Object? id = _Undefined,
    String? droneId,
    String? kind,
    String? instruction,
    String? summary,
    String? stepsJson,
    String? status,
    Object? reason = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DroneMission(
      id: id is int? ? id : this.id,
      droneId: droneId ?? this.droneId,
      kind: kind ?? this.kind,
      instruction: instruction ?? this.instruction,
      summary: summary ?? this.summary,
      stepsJson: stepsJson ?? this.stepsJson,
      status: status ?? this.status,
      reason: reason is String? ? reason : this.reason,
      createdBy: createdBy is _isc.UuidValue? ? createdBy : this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
