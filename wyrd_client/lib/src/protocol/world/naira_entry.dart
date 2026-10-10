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

/// One movement of naira, kept for good: the player's side ([amount], + in / - out) and the city account on the other
/// side ([counter]), so every entry balances. Written only by Bank.post, in the same database transaction that changes
/// the player's balance; never edited (a mistake is put right by a reversing entry). [key] makes each action pay or
/// charge once, however often it's retried.
abstract class NairaEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NairaEntry._({
    this.id,
    required this.key,
    required this.authUserId,
    required this.amount,
    required this.balanceAfter,
    required this.kind,
    required this.counter,
    required this.memo,
    String? status,
    this.reverses,
    required this.createdAt,
  }) : status = status ?? 'posted';

  factory NairaEntry({
    int? id,
    required String key,
    required _isc.UuidValue authUserId,
    required int amount,
    required int balanceAfter,
    required String kind,
    required String counter,
    required String memo,
    String? status,
    int? reverses,
    required DateTime createdAt,
  }) = _NairaEntryImpl;

  factory NairaEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return NairaEntry(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      amount: jsonSerialization['amount'] as int,
      balanceAfter: jsonSerialization['balanceAfter'] as int,
      kind: jsonSerialization['kind'] as String,
      counter: jsonSerialization['counter'] as String,
      memo: jsonSerialization['memo'] as String,
      status: jsonSerialization['status'] as String?,
      reverses: jsonSerialization['reverses'] as int?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// what this movement is, once: e.g. job:{id}, rent:{home}:{week}, ride:{user}:{bucket}
  String key;

  _isc.UuidValue authUserId;

  /// + naira in, - naira out
  int amount;

  /// the player's balance just after it
  int balanceAfter;

  /// open | fare | ride | air | rent | home | fine | fee | job | mission | guide | story | place | refund | grant
  String kind;

  /// the other side: city:treasury, city:transport, city:landlord, city:courts, city:market, city:services
  String counter;

  /// what the player reads on the receipt
  String memo;

  /// posted | reversed
  String status;

  /// the entry this one reverses, if it's a reversal
  int? reverses;

  DateTime createdAt;

  /// Returns a shallow copy of this [NairaEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NairaEntry copyWith({
    int? id,
    String? key,
    _isc.UuidValue? authUserId,
    int? amount,
    int? balanceAfter,
    String? kind,
    String? counter,
    String? memo,
    String? status,
    int? reverses,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NairaEntry',
      if (id != null) 'id': id,
      'key': key,
      'authUserId': authUserId.toJson(),
      'amount': amount,
      'balanceAfter': balanceAfter,
      'kind': kind,
      'counter': counter,
      'memo': memo,
      'status': status,
      if (reverses != null) 'reverses': reverses,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NairaEntry',
      if (id != null) 'id': id,
      'key': key,
      'authUserId': authUserId.toJson(),
      'amount': amount,
      'balanceAfter': balanceAfter,
      'kind': kind,
      'counter': counter,
      'memo': memo,
      'status': status,
      if (reverses != null) 'reverses': reverses,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NairaEntryImpl extends NairaEntry {
  _NairaEntryImpl({
    int? id,
    required String key,
    required _isc.UuidValue authUserId,
    required int amount,
    required int balanceAfter,
    required String kind,
    required String counter,
    required String memo,
    String? status,
    int? reverses,
    required DateTime createdAt,
  }) : super._(
         id: id,
         key: key,
         authUserId: authUserId,
         amount: amount,
         balanceAfter: balanceAfter,
         kind: kind,
         counter: counter,
         memo: memo,
         status: status,
         reverses: reverses,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NairaEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NairaEntry copyWith({
    Object? id = _Undefined,
    String? key,
    _isc.UuidValue? authUserId,
    int? amount,
    int? balanceAfter,
    String? kind,
    String? counter,
    String? memo,
    String? status,
    Object? reverses = _Undefined,
    DateTime? createdAt,
  }) {
    return NairaEntry(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      authUserId: authUserId ?? this.authUserId,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      kind: kind ?? this.kind,
      counter: counter ?? this.counter,
      memo: memo ?? this.memo,
      status: status ?? this.status,
      reverses: reverses is int? ? reverses : this.reverses,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
