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

abstract class LlmUsageUser
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LlmUsageUser._({
    this.id,
    required this.day,
    required this.authUserId,
    required this.costMicroUsd,
  });

  factory LlmUsageUser({
    int? id,
    required String day,
    required _isc.UuidValue authUserId,
    required int costMicroUsd,
  }) = _LlmUsageUserImpl;

  factory LlmUsageUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return LlmUsageUser(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String day;

  _isc.UuidValue authUserId;

  int costMicroUsd;

  /// Returns a shallow copy of this [LlmUsageUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LlmUsageUser copyWith({
    int? id,
    String? day,
    _isc.UuidValue? authUserId,
    int? costMicroUsd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LlmUsageUser',
      if (id != null) 'id': id,
      'day': day,
      'authUserId': authUserId.toJson(),
      'costMicroUsd': costMicroUsd,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LlmUsageUser',
      if (id != null) 'id': id,
      'day': day,
      'authUserId': authUserId.toJson(),
      'costMicroUsd': costMicroUsd,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LlmUsageUserImpl extends LlmUsageUser {
  _LlmUsageUserImpl({
    int? id,
    required String day,
    required _isc.UuidValue authUserId,
    required int costMicroUsd,
  }) : super._(
         id: id,
         day: day,
         authUserId: authUserId,
         costMicroUsd: costMicroUsd,
       );

  /// Returns a shallow copy of this [LlmUsageUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LlmUsageUser copyWith({
    Object? id = _Undefined,
    String? day,
    _isc.UuidValue? authUserId,
    int? costMicroUsd,
  }) {
    return LlmUsageUser(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      authUserId: authUserId ?? this.authUserId,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
    );
  }
}
