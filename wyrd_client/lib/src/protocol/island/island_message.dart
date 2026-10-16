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

/// One message in an encrypted group: ciphertext only.
abstract class IslandMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandMessage._({
    this.id,
    required this.groupId,
    required this.senderId,
    required this.ct,
    required this.createdAt,
  });

  factory IslandMessage({
    int? id,
    required int groupId,
    required _isc.UuidValue senderId,
    required String ct,
    required DateTime createdAt,
  }) = _IslandMessageImpl;

  factory IslandMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandMessage(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      senderId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderId'],
      ),
      ct: jsonSerialization['ct'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int groupId;

  _isc.UuidValue senderId;

  /// base64 iv.ciphertext (AES-GCM, the group key)
  String ct;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandMessage copyWith({
    int? id,
    int? groupId,
    _isc.UuidValue? senderId,
    String? ct,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandMessage',
      if (id != null) 'id': id,
      'groupId': groupId,
      'senderId': senderId.toJson(),
      'ct': ct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandMessage',
      if (id != null) 'id': id,
      'groupId': groupId,
      'senderId': senderId.toJson(),
      'ct': ct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandMessageImpl extends IslandMessage {
  _IslandMessageImpl({
    int? id,
    required int groupId,
    required _isc.UuidValue senderId,
    required String ct,
    required DateTime createdAt,
  }) : super._(
         id: id,
         groupId: groupId,
         senderId: senderId,
         ct: ct,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandMessage copyWith({
    Object? id = _Undefined,
    int? groupId,
    _isc.UuidValue? senderId,
    String? ct,
    DateTime? createdAt,
  }) {
    return IslandMessage(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      senderId: senderId ?? this.senderId,
      ct: ct ?? this.ct,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
