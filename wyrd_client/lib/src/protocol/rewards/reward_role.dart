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

/// Who may do what with the rewards treasury: viewer (read the reports), operator (offers, reviews, proposals, pauses),
/// approver (approve another admin's proposal). Granted by the owner (the drone operator).
abstract class RewardRole
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardRole._({
    this.id,
    required this.authUserId,
    required this.role,
    required this.grantedBy,
    required this.createdAt,
  });

  factory RewardRole({
    int? id,
    required _isc.UuidValue authUserId,
    required String role,
    required _isc.UuidValue grantedBy,
    required DateTime createdAt,
  }) = _RewardRoleImpl;

  factory RewardRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardRole(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String,
      grantedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['grantedBy'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String role;

  _isc.UuidValue grantedBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardRole]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardRole copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? role,
    _isc.UuidValue? grantedBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      'grantedBy': grantedBy.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      'grantedBy': grantedBy.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardRoleImpl extends RewardRole {
  _RewardRoleImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String role,
    required _isc.UuidValue grantedBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         role: role,
         grantedBy: grantedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardRole]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardRole copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? role,
    _isc.UuidValue? grantedBy,
    DateTime? createdAt,
  }) {
    return RewardRole(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      grantedBy: grantedBy ?? this.grantedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
