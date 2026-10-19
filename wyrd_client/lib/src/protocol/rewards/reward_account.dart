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

/// One account in the rewards ledger. [unit] is GN (Game Naira, whole naira) or NGN (real naira, in kobo); a journal
/// only ever moves one unit. [balance] is a cache of the account's entries, updated in the same transaction as them
/// and checked by the reconciliation report. System accounts have a fixed [code] (e.g. ngn:fund:uncommitted,
/// gn:treasury); a player's real earnings live in ngn:earn:pending:{user}, ngn:earn:available:{user} and
/// ngn:payout:inflight:{user}.
abstract class RewardAccount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardAccount._({
    this.id,
    required this.code,
    required this.unit,
    required this.kind,
    this.ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required this.updatedAt,
  }) : balance = balance ?? 0,
       mayGoNegative = mayGoNegative ?? false;

  factory RewardAccount({
    int? id,
    required String code,
    required String unit,
    required String kind,
    _isc.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required DateTime updatedAt,
  }) = _RewardAccountImpl;

  factory RewardAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardAccount(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: jsonSerialization['kind'] as String,
      ownerUserId: jsonSerialization['ownerUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['ownerUserId'],
            ),
      balance: jsonSerialization['balance'] as int?,
      mayGoNegative: jsonSerialization['mayGoNegative'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['mayGoNegative']),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  /// GN | NGN
  String unit;

  /// fund | reserve | earnings | payout | treasury | source | sink
  String kind;

  _isc.UuidValue? ownerUserId;

  /// in the unit's minor units (GN: naira, NGN: kobo)
  int balance;

  /// only source accounts (external money in, authorised issuance) may go below zero
  bool mayGoNegative;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RewardAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardAccount copyWith({
    int? id,
    String? code,
    String? unit,
    String? kind,
    _isc.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardAccount',
      if (id != null) 'id': id,
      'code': code,
      'unit': unit,
      'kind': kind,
      if (ownerUserId != null) 'ownerUserId': ownerUserId?.toJson(),
      'balance': balance,
      'mayGoNegative': mayGoNegative,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardAccount',
      if (id != null) 'id': id,
      'code': code,
      'unit': unit,
      'kind': kind,
      if (ownerUserId != null) 'ownerUserId': ownerUserId?.toJson(),
      'balance': balance,
      'mayGoNegative': mayGoNegative,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardAccountImpl extends RewardAccount {
  _RewardAccountImpl({
    int? id,
    required String code,
    required String unit,
    required String kind,
    _isc.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         code: code,
         unit: unit,
         kind: kind,
         ownerUserId: ownerUserId,
         balance: balance,
         mayGoNegative: mayGoNegative,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardAccount copyWith({
    Object? id = _Undefined,
    String? code,
    String? unit,
    String? kind,
    Object? ownerUserId = _Undefined,
    int? balance,
    bool? mayGoNegative,
    DateTime? updatedAt,
  }) {
    return RewardAccount(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      ownerUserId: ownerUserId is _isc.UuidValue?
          ? ownerUserId
          : this.ownerUserId,
      balance: balance ?? this.balance,
      mayGoNegative: mayGoNegative ?? this.mayGoNegative,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
