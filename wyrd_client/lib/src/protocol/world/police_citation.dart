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

/// One offence on a player's record (Fair Streets): its code, where, the evidence and how sure the city is, what came of
/// it, and any appeal. A fine is "pending" until a stop, a posting or a call settles it; then paid (and/or on the plan),
/// a caution, or waived.
abstract class PoliceCitation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PoliceCitation._({
    this.id,
    required this.authUserId,
    required this.code,
    required this.place,
    required this.evidence,
    required this.confidence,
    required this.outcome,
    int? amount,
    required this.status,
    int? paid,
    int? owed,
    this.entryId,
    this.settledBy,
    this.appealReason,
    this.appealResult,
    required this.createdAt,
    this.settledAt,
  }) : amount = amount ?? 0,
       paid = paid ?? 0,
       owed = owed ?? 0;

  factory PoliceCitation({
    int? id,
    required _isc.UuidValue authUserId,
    required String code,
    required String place,
    required String evidence,
    required double confidence,
    required String outcome,
    int? amount,
    required String status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    required DateTime createdAt,
    DateTime? settledAt,
  }) = _PoliceCitationImpl;

  factory PoliceCitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoliceCitation(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      code: jsonSerialization['code'] as String,
      place: jsonSerialization['place'] as String,
      evidence: jsonSerialization['evidence'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      outcome: jsonSerialization['outcome'] as String,
      amount: jsonSerialization['amount'] as int?,
      status: jsonSerialization['status'] as String,
      paid: jsonSerialization['paid'] as int?,
      owed: jsonSerialization['owed'] as int?,
      entryId: jsonSerialization['entryId'] as int?,
      settledBy: jsonSerialization['settledBy'] as String?,
      appealReason: jsonSerialization['appealReason'] as String?,
      appealResult: jsonSerialization['appealResult'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      settledAt: jsonSerialization['settledAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['settledAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// RL-1 | SP-1 | SP-2 | CD-1 | PT-1 | FS-1
  String code;

  String place;

  /// JSON list of {source, id, confidence, detail}
  String evidence;

  double confidence;

  /// note | warning | fine
  String outcome;

  /// the fine as issued (0 for notes and warnings)
  int amount;

  /// note | warning | pending | paid | caution | waived | overturned
  String status;

  /// what was paid now and put on the plan when it was settled, and the ledger entry
  int paid;

  int owed;

  int? entryId;

  /// how it was settled: stop | complied | posted | desk | counsel | favour | cooled
  String? settledBy;

  String? appealReason;

  /// overturned | reduced | upheld | queued
  String? appealResult;

  DateTime createdAt;

  DateTime? settledAt;

  /// Returns a shallow copy of this [PoliceCitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PoliceCitation copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? code,
    String? place,
    String? evidence,
    double? confidence,
    String? outcome,
    int? amount,
    String? status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    DateTime? createdAt,
    DateTime? settledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoliceCitation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'place': place,
      'evidence': evidence,
      'confidence': confidence,
      'outcome': outcome,
      'amount': amount,
      'status': status,
      'paid': paid,
      'owed': owed,
      if (entryId != null) 'entryId': entryId,
      if (settledBy != null) 'settledBy': settledBy,
      if (appealReason != null) 'appealReason': appealReason,
      if (appealResult != null) 'appealResult': appealResult,
      'createdAt': createdAt.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PoliceCitation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'place': place,
      'evidence': evidence,
      'confidence': confidence,
      'outcome': outcome,
      'amount': amount,
      'status': status,
      'paid': paid,
      'owed': owed,
      if (entryId != null) 'entryId': entryId,
      if (settledBy != null) 'settledBy': settledBy,
      if (appealReason != null) 'appealReason': appealReason,
      if (appealResult != null) 'appealResult': appealResult,
      'createdAt': createdAt.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoliceCitationImpl extends PoliceCitation {
  _PoliceCitationImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String code,
    required String place,
    required String evidence,
    required double confidence,
    required String outcome,
    int? amount,
    required String status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    required DateTime createdAt,
    DateTime? settledAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         code: code,
         place: place,
         evidence: evidence,
         confidence: confidence,
         outcome: outcome,
         amount: amount,
         status: status,
         paid: paid,
         owed: owed,
         entryId: entryId,
         settledBy: settledBy,
         appealReason: appealReason,
         appealResult: appealResult,
         createdAt: createdAt,
         settledAt: settledAt,
       );

  /// Returns a shallow copy of this [PoliceCitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PoliceCitation copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? code,
    String? place,
    String? evidence,
    double? confidence,
    String? outcome,
    int? amount,
    String? status,
    int? paid,
    int? owed,
    Object? entryId = _Undefined,
    Object? settledBy = _Undefined,
    Object? appealReason = _Undefined,
    Object? appealResult = _Undefined,
    DateTime? createdAt,
    Object? settledAt = _Undefined,
  }) {
    return PoliceCitation(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      code: code ?? this.code,
      place: place ?? this.place,
      evidence: evidence ?? this.evidence,
      confidence: confidence ?? this.confidence,
      outcome: outcome ?? this.outcome,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paid: paid ?? this.paid,
      owed: owed ?? this.owed,
      entryId: entryId is int? ? entryId : this.entryId,
      settledBy: settledBy is String? ? settledBy : this.settledBy,
      appealReason: appealReason is String? ? appealReason : this.appealReason,
      appealResult: appealResult is String? ? appealResult : this.appealResult,
      createdAt: createdAt ?? this.createdAt,
      settledAt: settledAt is DateTime? ? settledAt : this.settledAt,
    );
  }
}
