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

/// A finished island job's real-money share: 2% of the paycheck, drawn from the Real Rewards Fund into the player's
/// pending cash. One per paid shift ([source] is the shift's payroll key). pending until the hold ends, then
/// available; unfunded when the fund couldn't cover it (the player then got the whole paycheck in Game Naira).
abstract class IslandJobShare
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandJobShare._({
    this.id,
    required this.authUserId,
    required this.source,
    required this.workplace,
    required this.title,
    required this.paycheck,
    required this.cashKobo,
    required this.status,
    required this.availableAt,
    required this.createdAt,
  });

  factory IslandJobShare({
    int? id,
    required _isc.UuidValue authUserId,
    required String source,
    required String workplace,
    required String title,
    required int paycheck,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) = _IslandJobShareImpl;

  factory IslandJobShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJobShare(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      source: jsonSerialization['source'] as String,
      workplace: jsonSerialization['workplace'] as String,
      title: jsonSerialization['title'] as String,
      paycheck: jsonSerialization['paycheck'] as int,
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

  _isc.UuidValue authUserId;

  String source;

  /// grid | refinery | airport | club | market | okada
  String workplace;

  String title;

  /// the whole paycheck, in Game Naira
  int paycheck;

  int cashKobo;

  /// pending | available | unfunded
  String status;

  DateTime availableAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandJobShare]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandJobShare copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? source,
    String? workplace,
    String? title,
    int? paycheck,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJobShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'source': source,
      'workplace': workplace,
      'title': title,
      'paycheck': paycheck,
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJobShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'source': source,
      'workplace': workplace,
      'title': title,
      'paycheck': paycheck,
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

class _IslandJobShareImpl extends IslandJobShare {
  _IslandJobShareImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String source,
    required String workplace,
    required String title,
    required int paycheck,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         source: source,
         workplace: workplace,
         title: title,
         paycheck: paycheck,
         cashKobo: cashKobo,
         status: status,
         availableAt: availableAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandJobShare]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandJobShare copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? source,
    String? workplace,
    String? title,
    int? paycheck,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  }) {
    return IslandJobShare(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      source: source ?? this.source,
      workplace: workplace ?? this.workplace,
      title: title ?? this.title,
      paycheck: paycheck ?? this.paycheck,
      cashKobo: cashKobo ?? this.cashKobo,
      status: status ?? this.status,
      availableAt: availableAt ?? this.availableAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
