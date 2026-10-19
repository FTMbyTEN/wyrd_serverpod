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

/// Money added to the Real Rewards Fund (NGN) or Game Naira issued to the City Treasury (GN): proposed by one admin
/// with its evidence (e.g. the bank statement line), approved by a different one. Only an approved record posts.
abstract class RewardFunding
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardFunding._({
    this.id,
    required this.unit,
    required this.amount,
    required this.evidence,
    required this.status,
    required this.proposedBy,
    this.approvedBy,
    this.journalRef,
    required this.createdAt,
    this.decidedAt,
  });

  factory RewardFunding({
    int? id,
    required String unit,
    required int amount,
    required String evidence,
    required String status,
    required _isc.UuidValue proposedBy,
    _isc.UuidValue? approvedBy,
    String? journalRef,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _RewardFundingImpl;

  factory RewardFunding.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardFunding(
      id: jsonSerialization['id'] as int?,
      unit: jsonSerialization['unit'] as String,
      amount: jsonSerialization['amount'] as int,
      evidence: jsonSerialization['evidence'] as String,
      status: jsonSerialization['status'] as String,
      proposedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['proposedBy'],
      ),
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedBy'],
            ),
      journalRef: jsonSerialization['journalRef'] as String?,
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

  /// GN | NGN
  String unit;

  int amount;

  String evidence;

  /// proposed | approved | rejected
  String status;

  _isc.UuidValue proposedBy;

  _isc.UuidValue? approvedBy;

  String? journalRef;

  DateTime createdAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [RewardFunding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardFunding copyWith({
    int? id,
    String? unit,
    int? amount,
    String? evidence,
    String? status,
    _isc.UuidValue? proposedBy,
    _isc.UuidValue? approvedBy,
    String? journalRef,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardFunding',
      if (id != null) 'id': id,
      'unit': unit,
      'amount': amount,
      'evidence': evidence,
      'status': status,
      'proposedBy': proposedBy.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (journalRef != null) 'journalRef': journalRef,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardFunding',
      if (id != null) 'id': id,
      'unit': unit,
      'amount': amount,
      'evidence': evidence,
      'status': status,
      'proposedBy': proposedBy.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (journalRef != null) 'journalRef': journalRef,
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

class _RewardFundingImpl extends RewardFunding {
  _RewardFundingImpl({
    int? id,
    required String unit,
    required int amount,
    required String evidence,
    required String status,
    required _isc.UuidValue proposedBy,
    _isc.UuidValue? approvedBy,
    String? journalRef,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         unit: unit,
         amount: amount,
         evidence: evidence,
         status: status,
         proposedBy: proposedBy,
         approvedBy: approvedBy,
         journalRef: journalRef,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [RewardFunding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardFunding copyWith({
    Object? id = _Undefined,
    String? unit,
    int? amount,
    String? evidence,
    String? status,
    _isc.UuidValue? proposedBy,
    Object? approvedBy = _Undefined,
    Object? journalRef = _Undefined,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return RewardFunding(
      id: id is int? ? id : this.id,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      evidence: evidence ?? this.evidence,
      status: status ?? this.status,
      proposedBy: proposedBy ?? this.proposedBy,
      approvedBy: approvedBy is _isc.UuidValue? ? approvedBy : this.approvedBy,
      journalRef: journalRef is String? ? journalRef : this.journalRef,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
