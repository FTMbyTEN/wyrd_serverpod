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

/// A phone's web-push address (from the browser's push service), so the game can tell a player something happened
/// while the game is closed. Only the address is kept: pushes carry no content.
abstract class IslandPushSub
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandPushSub._({
    this.id,
    required this.authUserId,
    required this.endpoint,
    required this.createdAt,
  });

  factory IslandPushSub({
    int? id,
    required _isc.UuidValue authUserId,
    required String endpoint,
    required DateTime createdAt,
  }) = _IslandPushSubImpl;

  factory IslandPushSub.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandPushSub(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      endpoint: jsonSerialization['endpoint'] as String,
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

  String endpoint;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandPushSub]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandPushSub copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? endpoint,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandPushSub',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'endpoint': endpoint,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandPushSub',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'endpoint': endpoint,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandPushSubImpl extends IslandPushSub {
  _IslandPushSubImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String endpoint,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         endpoint: endpoint,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandPushSub]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandPushSub copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? endpoint,
    DateTime? createdAt,
  }) {
    return IslandPushSub(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      endpoint: endpoint ?? this.endpoint,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
