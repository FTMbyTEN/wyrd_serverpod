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

/// A friend request between two Lagosians, and then the friendship: pending until the other one accepts or declines.
/// One row per pair and direction; accepting turns it into a friendship both of them see.
abstract class IslandFriend
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandFriend._({
    this.id,
    required this.fromUser,
    required this.toUser,
    required this.status,
    this.note,
    required this.createdAt,
    this.decidedAt,
  });

  factory IslandFriend({
    int? id,
    required _isc.UuidValue fromUser,
    required _isc.UuidValue toUser,
    required String status,
    String? note,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _IslandFriendImpl;

  factory IslandFriend.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandFriend(
      id: jsonSerialization['id'] as int?,
      fromUser: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['fromUser'],
      ),
      toUser: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['toUser']),
      status: jsonSerialization['status'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue fromUser;

  _isc.UuidValue toUser;

  /// pending | accepted | declined
  String status;

  /// a short hello with the request (optional)
  String? note;

  DateTime createdAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [IslandFriend]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandFriend copyWith({
    int? id,
    _isc.UuidValue? fromUser,
    _isc.UuidValue? toUser,
    String? status,
    String? note,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandFriend',
      if (id != null) 'id': id,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandFriend',
      if (id != null) 'id': id,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandFriendImpl extends IslandFriend {
  _IslandFriendImpl({
    int? id,
    required _isc.UuidValue fromUser,
    required _isc.UuidValue toUser,
    required String status,
    String? note,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         fromUser: fromUser,
         toUser: toUser,
         status: status,
         note: note,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [IslandFriend]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandFriend copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? fromUser,
    _isc.UuidValue? toUser,
    String? status,
    Object? note = _Undefined,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return IslandFriend(
      id: id is int? ? id : this.id,
      fromUser: fromUser ?? this.fromUser,
      toUser: toUser ?? this.toUser,
      status: status ?? this.status,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
