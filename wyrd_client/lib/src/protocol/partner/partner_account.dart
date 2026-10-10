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

/// What a partner has paid for in one environment: staging is an allowance (requests and an end date); production
/// has no allowance (null) and is billed on usage.
abstract class PartnerAccount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerAccount._({
    this.id,
    required this.partner,
    required this.env,
    this.allowance,
    int? used,
    this.validUntil,
    this.note,
    required this.createdAt,
  }) : used = used ?? 0;

  factory PartnerAccount({
    int? id,
    required String partner,
    required String env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    required DateTime createdAt,
  }) = _PartnerAccountImpl;

  factory PartnerAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerAccount(
      id: jsonSerialization['id'] as int?,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      allowance: jsonSerialization['allowance'] as int?,
      used: jsonSerialization['used'] as int?,
      validUntil: jsonSerialization['validUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['validUntil'],
            ),
      note: jsonSerialization['note'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String partner;

  String env;

  int? allowance;

  int used;

  DateTime? validUntil;

  /// how it was paid for (the owner's note), for the record
  String? note;

  DateTime createdAt;

  /// Returns a shallow copy of this [PartnerAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerAccount copyWith({
    int? id,
    String? partner,
    String? env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerAccount',
      if (id != null) 'id': id,
      'partner': partner,
      'env': env,
      if (allowance != null) 'allowance': allowance,
      'used': used,
      if (validUntil != null) 'validUntil': validUntil?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerAccount',
      if (id != null) 'id': id,
      'partner': partner,
      'env': env,
      if (allowance != null) 'allowance': allowance,
      'used': used,
      if (validUntil != null) 'validUntil': validUntil?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerAccountImpl extends PartnerAccount {
  _PartnerAccountImpl({
    int? id,
    required String partner,
    required String env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    required DateTime createdAt,
  }) : super._(
         id: id,
         partner: partner,
         env: env,
         allowance: allowance,
         used: used,
         validUntil: validUntil,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PartnerAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerAccount copyWith({
    Object? id = _Undefined,
    String? partner,
    String? env,
    Object? allowance = _Undefined,
    int? used,
    Object? validUntil = _Undefined,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return PartnerAccount(
      id: id is int? ? id : this.id,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      allowance: allowance is int? ? allowance : this.allowance,
      used: used ?? this.used,
      validUntil: validUntil is DateTime? ? validUntil : this.validUntil,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
