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

/// One line of a RewardJournal: [amount] in the journal's unit (+ into the account, - out of it). Append-only.
abstract class RewardEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardEntry._({
    this.id,
    required this.journalId,
    required this.accountId,
    required this.amount,
    required this.createdAt,
  });

  factory RewardEntry({
    int? id,
    required int journalId,
    required int accountId,
    required int amount,
    required DateTime createdAt,
  }) = _RewardEntryImpl;

  factory RewardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardEntry(
      id: jsonSerialization['id'] as int?,
      journalId: jsonSerialization['journalId'] as int,
      accountId: jsonSerialization['accountId'] as int,
      amount: jsonSerialization['amount'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int journalId;

  int accountId;

  int amount;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardEntry copyWith({
    int? id,
    int? journalId,
    int? accountId,
    int? amount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardEntry',
      if (id != null) 'id': id,
      'journalId': journalId,
      'accountId': accountId,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardEntry',
      if (id != null) 'id': id,
      'journalId': journalId,
      'accountId': accountId,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardEntryImpl extends RewardEntry {
  _RewardEntryImpl({
    int? id,
    required int journalId,
    required int accountId,
    required int amount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         journalId: journalId,
         accountId: accountId,
         amount: amount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardEntry copyWith({
    Object? id = _Undefined,
    int? journalId,
    int? accountId,
    int? amount,
    DateTime? createdAt,
  }) {
    return RewardEntry(
      id: id is int? ? id : this.id,
      journalId: journalId ?? this.journalId,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
