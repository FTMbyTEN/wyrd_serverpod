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

/// A WYRD user on LAGOS ISLAND: the name others see, the skills they choose to show employers, their
/// messaging public key (the private key never leaves their browser), and their personal HQ.
abstract class IslandProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandProfile._({
    this.id,
    required this.authUserId,
    required this.handle,
    String? skills,
    bool? openToWork,
    this.pubKey,
    this.hqName,
    String? hqColor,
    bool? hqLocked,
    bool? ghost,
    String? hqInvites,
    this.look,
    required this.createdAt,
  }) : skills = skills ?? '',
       openToWork = openToWork ?? false,
       hqColor = hqColor ?? '#A855F7',
       hqLocked = hqLocked ?? true,
       ghost = ghost ?? false,
       hqInvites = hqInvites ?? '[]';

  factory IslandProfile({
    int? id,
    required _isc.UuidValue authUserId,
    required String handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    bool? ghost,
    String? hqInvites,
    String? look,
    required DateTime createdAt,
  }) = _IslandProfileImpl;

  factory IslandProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      handle: jsonSerialization['handle'] as String,
      skills: jsonSerialization['skills'] as String?,
      openToWork: jsonSerialization['openToWork'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['openToWork']),
      pubKey: jsonSerialization['pubKey'] as String?,
      hqName: jsonSerialization['hqName'] as String?,
      hqColor: jsonSerialization['hqColor'] as String?,
      hqLocked: jsonSerialization['hqLocked'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['hqLocked']),
      ghost: jsonSerialization['ghost'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['ghost']),
      hqInvites: jsonSerialization['hqInvites'] as String?,
      look: jsonSerialization['look'] as String?,
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

  /// the name on the island, unique (letters, digits, _ . -)
  String handle;

  /// what they can do, comma separated, as they wrote it; used for job matching only when openToWork
  String skills;

  bool openToWork;

  /// their ECDH P-256 public key (JWK, JSON); messages to them are encrypted with it in the browser
  String? pubKey;

  /// their HQ: its name, colour, whether anyone may walk in, and who is invited (JSON list of handles)
  String? hqName;

  String hqColor;

  bool hqLocked;

  /// ghost mode: their name is hidden everywhere (map, chat, HQ Row, homes, search) and nobody may visit or knock;
  /// their homes still count as lived in and they still show on the map
  bool ghost;

  String hqInvites;

  /// how they look on the island: "g,skin,hair,style,bottom" (g: m or f), chosen when they joined
  String? look;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    bool? ghost,
    String? hqInvites,
    String? look,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'handle': handle,
      'skills': skills,
      'openToWork': openToWork,
      if (pubKey != null) 'pubKey': pubKey,
      if (hqName != null) 'hqName': hqName,
      'hqColor': hqColor,
      'hqLocked': hqLocked,
      'ghost': ghost,
      'hqInvites': hqInvites,
      if (look != null) 'look': look,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'handle': handle,
      'skills': skills,
      'openToWork': openToWork,
      if (pubKey != null) 'pubKey': pubKey,
      if (hqName != null) 'hqName': hqName,
      'hqColor': hqColor,
      'hqLocked': hqLocked,
      'ghost': ghost,
      'hqInvites': hqInvites,
      if (look != null) 'look': look,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandProfileImpl extends IslandProfile {
  _IslandProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    bool? ghost,
    String? hqInvites,
    String? look,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         handle: handle,
         skills: skills,
         openToWork: openToWork,
         pubKey: pubKey,
         hqName: hqName,
         hqColor: hqColor,
         hqLocked: hqLocked,
         ghost: ghost,
         hqInvites: hqInvites,
         look: look,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? handle,
    String? skills,
    bool? openToWork,
    Object? pubKey = _Undefined,
    Object? hqName = _Undefined,
    String? hqColor,
    bool? hqLocked,
    bool? ghost,
    String? hqInvites,
    Object? look = _Undefined,
    DateTime? createdAt,
  }) {
    return IslandProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      handle: handle ?? this.handle,
      skills: skills ?? this.skills,
      openToWork: openToWork ?? this.openToWork,
      pubKey: pubKey is String? ? pubKey : this.pubKey,
      hqName: hqName is String? ? hqName : this.hqName,
      hqColor: hqColor ?? this.hqColor,
      hqLocked: hqLocked ?? this.hqLocked,
      ghost: ghost ?? this.ghost,
      hqInvites: hqInvites ?? this.hqInvites,
      look: look is String? ? look : this.look,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
