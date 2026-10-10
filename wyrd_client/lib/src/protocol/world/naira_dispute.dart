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

/// A player disputing a charge on their receipts. Small ones are refunded at once (the goodwill rule: up to 1,000
/// naira a week, no questions); the rest wait here for the owner's review.
abstract class NairaDispute
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NairaDispute._({
    this.id,
    required this.authUserId,
    required this.entryId,
    required this.reason,
    required this.status,
    this.refundEntryId,
    required this.createdAt,
  });

  factory NairaDispute({
    int? id,
    required _isc.UuidValue authUserId,
    required int entryId,
    required String reason,
    required String status,
    int? refundEntryId,
    required DateTime createdAt,
  }) = _NairaDisputeImpl;

  factory NairaDispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return NairaDispute(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      entryId: jsonSerialization['entryId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String,
      refundEntryId: jsonSerialization['refundEntryId'] as int?,
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

  /// the disputed entry (NairaEntry id)
  int entryId;

  /// not_delivered | wrong_amount | other
  String reason;

  /// refunded | queued | declined
  String status;

  /// the refund's entry, if refunded
  int? refundEntryId;

  DateTime createdAt;

  /// Returns a shallow copy of this [NairaDispute]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NairaDispute copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? entryId,
    String? reason,
    String? status,
    int? refundEntryId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NairaDispute',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryId': entryId,
      'reason': reason,
      'status': status,
      if (refundEntryId != null) 'refundEntryId': refundEntryId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NairaDispute',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryId': entryId,
      'reason': reason,
      'status': status,
      if (refundEntryId != null) 'refundEntryId': refundEntryId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NairaDisputeImpl extends NairaDispute {
  _NairaDisputeImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required int entryId,
    required String reason,
    required String status,
    int? refundEntryId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         entryId: entryId,
         reason: reason,
         status: status,
         refundEntryId: refundEntryId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NairaDispute]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NairaDispute copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    int? entryId,
    String? reason,
    String? status,
    Object? refundEntryId = _Undefined,
    DateTime? createdAt,
  }) {
    return NairaDispute(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      entryId: entryId ?? this.entryId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      refundEntryId: refundEntryId is int? ? refundEntryId : this.refundEntryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
