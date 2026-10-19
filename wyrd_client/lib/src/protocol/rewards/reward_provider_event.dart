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

/// A payout provider's callback or status report, kept once per provider event id (duplicates are ignored).
abstract class RewardProviderEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardProviderEvent._({
    this.id,
    required this.provider,
    required this.eventId,
    required this.payoutRef,
    required this.status,
    required this.signatureOk,
    required this.outcome,
    required this.receivedAt,
  });

  factory RewardProviderEvent({
    int? id,
    required String provider,
    required String eventId,
    required String payoutRef,
    required String status,
    required bool signatureOk,
    required String outcome,
    required DateTime receivedAt,
  }) = _RewardProviderEventImpl;

  factory RewardProviderEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardProviderEvent(
      id: jsonSerialization['id'] as int?,
      provider: jsonSerialization['provider'] as String,
      eventId: jsonSerialization['eventId'] as String,
      payoutRef: jsonSerialization['payoutRef'] as String,
      status: jsonSerialization['status'] as String,
      signatureOk: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['signatureOk'],
      ),
      outcome: jsonSerialization['outcome'] as String,
      receivedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String provider;

  String eventId;

  String payoutRef;

  /// submitted | pending | paid | failed | returned
  String status;

  bool signatureOk;

  /// applied | ignored_duplicate | ignored_out_of_order | rejected_signature | unknown_payout
  String outcome;

  DateTime receivedAt;

  /// Returns a shallow copy of this [RewardProviderEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardProviderEvent copyWith({
    int? id,
    String? provider,
    String? eventId,
    String? payoutRef,
    String? status,
    bool? signatureOk,
    String? outcome,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardProviderEvent',
      if (id != null) 'id': id,
      'provider': provider,
      'eventId': eventId,
      'payoutRef': payoutRef,
      'status': status,
      'signatureOk': signatureOk,
      'outcome': outcome,
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardProviderEvent',
      if (id != null) 'id': id,
      'provider': provider,
      'eventId': eventId,
      'payoutRef': payoutRef,
      'status': status,
      'signatureOk': signatureOk,
      'outcome': outcome,
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardProviderEventImpl extends RewardProviderEvent {
  _RewardProviderEventImpl({
    int? id,
    required String provider,
    required String eventId,
    required String payoutRef,
    required String status,
    required bool signatureOk,
    required String outcome,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         provider: provider,
         eventId: eventId,
         payoutRef: payoutRef,
         status: status,
         signatureOk: signatureOk,
         outcome: outcome,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [RewardProviderEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardProviderEvent copyWith({
    Object? id = _Undefined,
    String? provider,
    String? eventId,
    String? payoutRef,
    String? status,
    bool? signatureOk,
    String? outcome,
    DateTime? receivedAt,
  }) {
    return RewardProviderEvent(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      eventId: eventId ?? this.eventId,
      payoutRef: payoutRef ?? this.payoutRef,
      status: status ?? this.status,
      signatureOk: signatureOk ?? this.signatureOk,
      outcome: outcome ?? this.outcome,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
