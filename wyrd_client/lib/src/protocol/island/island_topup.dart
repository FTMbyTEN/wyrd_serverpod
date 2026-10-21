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

/// Naira bought with real money through Flutterwave. Created pending when checkout starts; credited exactly once, after
/// the server itself has asked Flutterwave that the payment succeeded for the right amount.
abstract class IslandTopUp
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandTopUp._({
    this.id,
    required this.authUserId,
    required this.txRef,
    required this.pack,
    required this.amountNgn,
    required this.naira,
    required this.status,
    this.flwId,
    required this.createdAt,
    this.paidAt,
  });

  factory IslandTopUp({
    int? id,
    required _isc.UuidValue authUserId,
    required String txRef,
    required String pack,
    required int amountNgn,
    required int naira,
    required String status,
    String? flwId,
    required DateTime createdAt,
    DateTime? paidAt,
  }) = _IslandTopUpImpl;

  factory IslandTopUp.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTopUp(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      txRef: jsonSerialization['txRef'] as String,
      pack: jsonSerialization['pack'] as String,
      amountNgn: jsonSerialization['amountNgn'] as int,
      naira: jsonSerialization['naira'] as int,
      status: jsonSerialization['status'] as String,
      flwId: jsonSerialization['flwId'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// our reference for the payment (Flutterwave's tx_ref)
  String txRef;

  String pack;

  /// what the player pays, in real naira
  int amountNgn;

  /// what lands in their game wallet
  int naira;

  /// pending, paid or failed
  String status;

  /// Flutterwave's own id for the transaction, once it reports one
  String? flwId;

  DateTime createdAt;

  DateTime? paidAt;

  /// Returns a shallow copy of this [IslandTopUp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandTopUp copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? txRef,
    String? pack,
    int? amountNgn,
    int? naira,
    String? status,
    String? flwId,
    DateTime? createdAt,
    DateTime? paidAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTopUp',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'txRef': txRef,
      'pack': pack,
      'amountNgn': amountNgn,
      'naira': naira,
      'status': status,
      if (flwId != null) 'flwId': flwId,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTopUp',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'txRef': txRef,
      'pack': pack,
      'amountNgn': amountNgn,
      'naira': naira,
      'status': status,
      if (flwId != null) 'flwId': flwId,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTopUpImpl extends IslandTopUp {
  _IslandTopUpImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String txRef,
    required String pack,
    required int amountNgn,
    required int naira,
    required String status,
    String? flwId,
    required DateTime createdAt,
    DateTime? paidAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         txRef: txRef,
         pack: pack,
         amountNgn: amountNgn,
         naira: naira,
         status: status,
         flwId: flwId,
         createdAt: createdAt,
         paidAt: paidAt,
       );

  /// Returns a shallow copy of this [IslandTopUp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandTopUp copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? txRef,
    String? pack,
    int? amountNgn,
    int? naira,
    String? status,
    Object? flwId = _Undefined,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
  }) {
    return IslandTopUp(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      txRef: txRef ?? this.txRef,
      pack: pack ?? this.pack,
      amountNgn: amountNgn ?? this.amountNgn,
      naira: naira ?? this.naira,
      status: status ?? this.status,
      flwId: flwId is String? ? flwId : this.flwId,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
    );
  }
}
