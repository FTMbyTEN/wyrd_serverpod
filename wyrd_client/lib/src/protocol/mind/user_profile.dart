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
import 'package:wyrd_client/src/protocol/protocol.dart' as _i2pladzn;
import '../mind/user_fact.dart' as _il0k3um2;

abstract class UserProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserProfile._({
    this.id,
    required this.authUserId,
    this.username,
    required this.facts,
    required this.visitCount,
    required this.firstSeen,
    required this.lastSeen,
  });

  factory UserProfile({
    int? id,
    required _isc.UuidValue authUserId,
    String? username,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      username: jsonSerialization['username'] as String?,
      facts: _i2pladzn.Protocol().deserialize<List<_il0k3um2.UserFact>>(
        jsonSerialization['facts'],
      ),
      visitCount: jsonSerialization['visitCount'] as int,
      firstSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeen'],
      ),
      lastSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeen'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String? username;

  List<_il0k3um2.UserFact> facts;

  int visitCount;

  DateTime firstSeen;

  DateTime lastSeen;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? username,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (username != null) 'username': username,
      'facts': facts.toJson(valueToJson: (v) => v.toJson()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (username != null) 'username': username,
      'facts': facts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    String? username,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
  }) : super._(
         id: id,
         authUserId: authUserId,
         username: username,
         facts: facts,
         visitCount: visitCount,
         firstSeen: firstSeen,
         lastSeen: lastSeen,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? username = _Undefined,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      username: username is String? ? username : this.username,
      facts: facts ?? this.facts.map((e0) => e0.copyWith()).toList(),
      visitCount: visitCount ?? this.visitCount,
      firstSeen: firstSeen ?? this.firstSeen,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
