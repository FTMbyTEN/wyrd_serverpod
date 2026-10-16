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

/// A member of an encrypted group, with their own wrapped copy of the group key.
abstract class IslandMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandMember._({
    this.id,
    required this.groupId,
    required this.authUserId,
    required this.wrappedKey,
    required this.wrapperPub,
    required this.addedAt,
  });

  factory IslandMember({
    int? id,
    required int groupId,
    required _isc.UuidValue authUserId,
    required String wrappedKey,
    required String wrapperPub,
    required DateTime addedAt,
  }) = _IslandMemberImpl;

  factory IslandMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandMember(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      wrappedKey: jsonSerialization['wrappedKey'] as String,
      wrapperPub: jsonSerialization['wrapperPub'] as String,
      addedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['addedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int groupId;

  _isc.UuidValue authUserId;

  /// the group key (AES-GCM) encrypted for this member: base64 iv.ciphertext, with the key agreed
  /// between [wrapperPub] and the member's own key pair
  String wrappedKey;

  /// the public key (JWK) of whoever wrapped it
  String wrapperPub;

  DateTime addedAt;

  /// Returns a shallow copy of this [IslandMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandMember copyWith({
    int? id,
    int? groupId,
    _isc.UuidValue? authUserId,
    String? wrappedKey,
    String? wrapperPub,
    DateTime? addedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandMember',
      if (id != null) 'id': id,
      'groupId': groupId,
      'authUserId': authUserId.toJson(),
      'wrappedKey': wrappedKey,
      'wrapperPub': wrapperPub,
      'addedAt': addedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandMember',
      if (id != null) 'id': id,
      'groupId': groupId,
      'authUserId': authUserId.toJson(),
      'wrappedKey': wrappedKey,
      'wrapperPub': wrapperPub,
      'addedAt': addedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandMemberImpl extends IslandMember {
  _IslandMemberImpl({
    int? id,
    required int groupId,
    required _isc.UuidValue authUserId,
    required String wrappedKey,
    required String wrapperPub,
    required DateTime addedAt,
  }) : super._(
         id: id,
         groupId: groupId,
         authUserId: authUserId,
         wrappedKey: wrappedKey,
         wrapperPub: wrapperPub,
         addedAt: addedAt,
       );

  /// Returns a shallow copy of this [IslandMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandMember copyWith({
    Object? id = _Undefined,
    int? groupId,
    _isc.UuidValue? authUserId,
    String? wrappedKey,
    String? wrapperPub,
    DateTime? addedAt,
  }) {
    return IslandMember(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      authUserId: authUserId ?? this.authUserId,
      wrappedKey: wrappedKey ?? this.wrappedKey,
      wrapperPub: wrapperPub ?? this.wrapperPub,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
