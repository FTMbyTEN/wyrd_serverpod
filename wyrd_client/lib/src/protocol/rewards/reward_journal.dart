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

/// One business transaction in the rewards ledger: its entries (RewardEntry) always sum to zero, in one unit. Never
/// edited or deleted (a database trigger refuses it); a mistake is put right by a new, linked journal.
abstract class RewardJournal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardJournal._({
    this.id,
    required this.ref,
    required this.idemKey,
    required this.unit,
    required this.kind,
    required this.memo,
    this.linkRef,
    required this.actor,
    required this.createdAt,
  });

  factory RewardJournal({
    int? id,
    required String ref,
    required String idemKey,
    required String unit,
    required String kind,
    required String memo,
    String? linkRef,
    required String actor,
    required DateTime createdAt,
  }) = _RewardJournalImpl;

  factory RewardJournal.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardJournal(
      id: jsonSerialization['id'] as int?,
      ref: jsonSerialization['ref'] as String,
      idemKey: jsonSerialization['idemKey'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: jsonSerialization['kind'] as String,
      memo: jsonSerialization['memo'] as String,
      linkRef: jsonSerialization['linkRef'] as String?,
      actor: jsonSerialization['actor'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// unique human reference, e.g. FJ-ACC-123
  String ref;

  /// the caller's idempotency key: the same key never posts twice
  String idemKey;

  /// GN | NGN
  String unit;

  /// fund | issue | reserve | release | earn | mature | withdraw | payout_paid | payout_fee | payout_failed | payout_returned | game_reward | levy | adjust
  String kind;

  String memo;

  /// the business record this belongs to (e.g. acc:12, wd:FJW-...)
  String? linkRef;

  /// who posted it: system, or a user / admin id
  String actor;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardJournal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardJournal copyWith({
    int? id,
    String? ref,
    String? idemKey,
    String? unit,
    String? kind,
    String? memo,
    String? linkRef,
    String? actor,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardJournal',
      if (id != null) 'id': id,
      'ref': ref,
      'idemKey': idemKey,
      'unit': unit,
      'kind': kind,
      'memo': memo,
      if (linkRef != null) 'linkRef': linkRef,
      'actor': actor,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardJournal',
      if (id != null) 'id': id,
      'ref': ref,
      'idemKey': idemKey,
      'unit': unit,
      'kind': kind,
      'memo': memo,
      if (linkRef != null) 'linkRef': linkRef,
      'actor': actor,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardJournalImpl extends RewardJournal {
  _RewardJournalImpl({
    int? id,
    required String ref,
    required String idemKey,
    required String unit,
    required String kind,
    required String memo,
    String? linkRef,
    required String actor,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ref: ref,
         idemKey: idemKey,
         unit: unit,
         kind: kind,
         memo: memo,
         linkRef: linkRef,
         actor: actor,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardJournal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardJournal copyWith({
    Object? id = _Undefined,
    String? ref,
    String? idemKey,
    String? unit,
    String? kind,
    String? memo,
    Object? linkRef = _Undefined,
    String? actor,
    DateTime? createdAt,
  }) {
    return RewardJournal(
      id: id is int? ? id : this.id,
      ref: ref ?? this.ref,
      idemKey: idemKey ?? this.idemKey,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      memo: memo ?? this.memo,
      linkRef: linkRef is String? ? linkRef : this.linkRef,
      actor: actor ?? this.actor,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
