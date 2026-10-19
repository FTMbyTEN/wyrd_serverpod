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

/// Every administrative action on the rewards system, kept for good.
abstract class RewardAudit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardAudit._({
    this.id,
    this.actor,
    required this.action,
    required this.details,
    required this.createdAt,
  });

  factory RewardAudit({
    int? id,
    _isc.UuidValue? actor,
    required String action,
    required String details,
    required DateTime createdAt,
  }) = _RewardAuditImpl;

  factory RewardAudit.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardAudit(
      id: jsonSerialization['id'] as int?,
      actor: jsonSerialization['actor'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['actor']),
      action: jsonSerialization['action'] as String,
      details: jsonSerialization['details'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue? actor;

  String action;

  String details;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardAudit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardAudit copyWith({
    int? id,
    _isc.UuidValue? actor,
    String? action,
    String? details,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardAudit',
      if (id != null) 'id': id,
      if (actor != null) 'actor': actor?.toJson(),
      'action': action,
      'details': details,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardAudit',
      if (id != null) 'id': id,
      if (actor != null) 'actor': actor?.toJson(),
      'action': action,
      'details': details,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardAuditImpl extends RewardAudit {
  _RewardAuditImpl({
    int? id,
    _isc.UuidValue? actor,
    required String action,
    required String details,
    required DateTime createdAt,
  }) : super._(
         id: id,
         actor: actor,
         action: action,
         details: details,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardAudit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardAudit copyWith({
    Object? id = _Undefined,
    Object? actor = _Undefined,
    String? action,
    String? details,
    DateTime? createdAt,
  }) {
    return RewardAudit(
      id: id is int? ? id : this.id,
      actor: actor is _isc.UuidValue? ? actor : this.actor,
      action: action ?? this.action,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
