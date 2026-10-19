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

/// The cash a completed funded job earned: one per acceptance (the unique entitlement). pending until the hold ends,
/// then available; held while under review.
abstract class RewardEarning
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardEarning._({
    this.id,
    required this.acceptanceId,
    required this.authUserId,
    required this.cashKobo,
    required this.status,
    required this.availableAt,
    required this.createdAt,
  });

  factory RewardEarning({
    int? id,
    required int acceptanceId,
    required _isc.UuidValue authUserId,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) = _RewardEarningImpl;

  factory RewardEarning.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardEarning(
      id: jsonSerialization['id'] as int?,
      acceptanceId: jsonSerialization['acceptanceId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      cashKobo: jsonSerialization['cashKobo'] as int,
      status: jsonSerialization['status'] as String,
      availableAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int acceptanceId;

  _isc.UuidValue authUserId;

  int cashKobo;

  /// pending | available | held
  String status;

  DateTime availableAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardEarning]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardEarning copyWith({
    int? id,
    int? acceptanceId,
    _isc.UuidValue? authUserId,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardEarning',
      if (id != null) 'id': id,
      'acceptanceId': acceptanceId,
      'authUserId': authUserId.toJson(),
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardEarning',
      if (id != null) 'id': id,
      'acceptanceId': acceptanceId,
      'authUserId': authUserId.toJson(),
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardEarningImpl extends RewardEarning {
  _RewardEarningImpl({
    int? id,
    required int acceptanceId,
    required _isc.UuidValue authUserId,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         acceptanceId: acceptanceId,
         authUserId: authUserId,
         cashKobo: cashKobo,
         status: status,
         availableAt: availableAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardEarning]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardEarning copyWith({
    Object? id = _Undefined,
    int? acceptanceId,
    _isc.UuidValue? authUserId,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  }) {
    return RewardEarning(
      id: id is int? ? id : this.id,
      acceptanceId: acceptanceId ?? this.acceptanceId,
      authUserId: authUserId ?? this.authUserId,
      cashKobo: cashKobo ?? this.cashKobo,
      status: status ?? this.status,
      availableAt: availableAt ?? this.availableAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
