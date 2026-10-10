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

/// A partner's API key (Konnectly first). Only a SHA-256 hash of the key is kept: a lost key can't be recovered,
/// only replaced. [env] is test (staging) or live (production); two keys can be active at once for rotation.
abstract class PartnerKey
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerKey._({
    this.id,
    required this.keyHash,
    required this.prefix,
    required this.partner,
    required this.env,
    required this.label,
    bool? active,
    required this.createdAt,
    this.revokedAt,
    this.lastUsedAt,
  }) : active = active ?? true;

  factory PartnerKey({
    int? id,
    required String keyHash,
    required String prefix,
    required String partner,
    required String env,
    required String label,
    bool? active,
    required DateTime createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  }) = _PartnerKeyImpl;

  factory PartnerKey.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerKey(
      id: jsonSerialization['id'] as int?,
      keyHash: jsonSerialization['keyHash'] as String,
      prefix: jsonSerialization['prefix'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      label: jsonSerialization['label'] as String,
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      lastUsedAt: jsonSerialization['lastUsedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastUsedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String keyHash;

  /// the first characters of the key, to recognise it in lists (e.g. kn_test_a1b2)
  String prefix;

  String partner;

  String env;

  String label;

  bool active;

  DateTime createdAt;

  DateTime? revokedAt;

  DateTime? lastUsedAt;

  /// Returns a shallow copy of this [PartnerKey]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerKey copyWith({
    int? id,
    String? keyHash,
    String? prefix,
    String? partner,
    String? env,
    String? label,
    bool? active,
    DateTime? createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerKey',
      if (id != null) 'id': id,
      'keyHash': keyHash,
      'prefix': prefix,
      'partner': partner,
      'env': env,
      'label': label,
      'active': active,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerKey',
      if (id != null) 'id': id,
      'keyHash': keyHash,
      'prefix': prefix,
      'partner': partner,
      'env': env,
      'label': label,
      'active': active,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerKeyImpl extends PartnerKey {
  _PartnerKeyImpl({
    int? id,
    required String keyHash,
    required String prefix,
    required String partner,
    required String env,
    required String label,
    bool? active,
    required DateTime createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  }) : super._(
         id: id,
         keyHash: keyHash,
         prefix: prefix,
         partner: partner,
         env: env,
         label: label,
         active: active,
         createdAt: createdAt,
         revokedAt: revokedAt,
         lastUsedAt: lastUsedAt,
       );

  /// Returns a shallow copy of this [PartnerKey]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerKey copyWith({
    Object? id = _Undefined,
    String? keyHash,
    String? prefix,
    String? partner,
    String? env,
    String? label,
    bool? active,
    DateTime? createdAt,
    Object? revokedAt = _Undefined,
    Object? lastUsedAt = _Undefined,
  }) {
    return PartnerKey(
      id: id is int? ? id : this.id,
      keyHash: keyHash ?? this.keyHash,
      prefix: prefix ?? this.prefix,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      label: label ?? this.label,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      lastUsedAt: lastUsedAt is DateTime? ? lastUsedAt : this.lastUsedAt,
    );
  }
}
