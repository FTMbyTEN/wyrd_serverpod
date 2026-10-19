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

/// A withdrawal of available real earnings. [amountKobo] leaves the available earnings (the gross debit); [feeKobo]
/// is the provider fee; [feePayer] says who bears it (player: they receive amount - fee; house: paid from the fee
/// allowance). An unknown outcome stays in flight until reconciled -- never retried under a new ref.
abstract class RewardWithdrawal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardWithdrawal._({
    this.id,
    required this.authUserId,
    required this.amountKobo,
    required this.feeKobo,
    required this.feePayer,
    required this.ref,
    required this.idemKey,
    required this.status,
    required this.provider,
    this.providerRef,
    required this.beneficiary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RewardWithdrawal({
    int? id,
    required _isc.UuidValue authUserId,
    required int amountKobo,
    required int feeKobo,
    required String feePayer,
    required String ref,
    required String idemKey,
    required String status,
    required String provider,
    String? providerRef,
    required String beneficiary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RewardWithdrawalImpl;

  factory RewardWithdrawal.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardWithdrawal(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      amountKobo: jsonSerialization['amountKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      feePayer: jsonSerialization['feePayer'] as String,
      ref: jsonSerialization['ref'] as String,
      idemKey: jsonSerialization['idemKey'] as String,
      status: jsonSerialization['status'] as String,
      provider: jsonSerialization['provider'] as String,
      providerRef: jsonSerialization['providerRef'] as String?,
      beneficiary: jsonSerialization['beneficiary'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  int amountKobo;

  int feeKobo;

  String feePayer;

  String ref;

  String idemKey;

  /// requested | submitted | pending | paid | failed | returned | unknown
  String status;

  String provider;

  String? providerRef;

  String beneficiary;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RewardWithdrawal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardWithdrawal copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? amountKobo,
    int? feeKobo,
    String? feePayer,
    String? ref,
    String? idemKey,
    String? status,
    String? provider,
    String? providerRef,
    String? beneficiary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardWithdrawal',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'amountKobo': amountKobo,
      'feeKobo': feeKobo,
      'feePayer': feePayer,
      'ref': ref,
      'idemKey': idemKey,
      'status': status,
      'provider': provider,
      if (providerRef != null) 'providerRef': providerRef,
      'beneficiary': beneficiary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardWithdrawal',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'amountKobo': amountKobo,
      'feeKobo': feeKobo,
      'feePayer': feePayer,
      'ref': ref,
      'idemKey': idemKey,
      'status': status,
      'provider': provider,
      if (providerRef != null) 'providerRef': providerRef,
      'beneficiary': beneficiary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardWithdrawalImpl extends RewardWithdrawal {
  _RewardWithdrawalImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required int amountKobo,
    required int feeKobo,
    required String feePayer,
    required String ref,
    required String idemKey,
    required String status,
    required String provider,
    String? providerRef,
    required String beneficiary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         amountKobo: amountKobo,
         feeKobo: feeKobo,
         feePayer: feePayer,
         ref: ref,
         idemKey: idemKey,
         status: status,
         provider: provider,
         providerRef: providerRef,
         beneficiary: beneficiary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardWithdrawal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardWithdrawal copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    int? amountKobo,
    int? feeKobo,
    String? feePayer,
    String? ref,
    String? idemKey,
    String? status,
    String? provider,
    Object? providerRef = _Undefined,
    String? beneficiary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RewardWithdrawal(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      amountKobo: amountKobo ?? this.amountKobo,
      feeKobo: feeKobo ?? this.feeKobo,
      feePayer: feePayer ?? this.feePayer,
      ref: ref ?? this.ref,
      idemKey: idemKey ?? this.idemKey,
      status: status ?? this.status,
      provider: provider ?? this.provider,
      providerRef: providerRef is String? ? providerRef : this.providerRef,
      beneficiary: beneficiary ?? this.beneficiary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
