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

/// A Grid shift or certification exam the server dealt: [spec] holds what was dealt, including the answers, which
/// the phone never sees. The result is graded here from what the player did, once.
abstract class IslandGridWork
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandGridWork._({
    this.id,
    required this.authUserId,
    required this.kind,
    required this.track,
    required this.level,
    required this.spec,
    required this.status,
    this.score,
    this.paid,
    required this.issuedAt,
    this.doneAt,
  });

  factory IslandGridWork({
    int? id,
    required _isc.UuidValue authUserId,
    required String kind,
    required String track,
    required int level,
    required String spec,
    required String status,
    int? score,
    int? paid,
    required DateTime issuedAt,
    DateTime? doneAt,
  }) = _IslandGridWorkImpl;

  factory IslandGridWork.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGridWork(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      kind: jsonSerialization['kind'] as String,
      track: jsonSerialization['track'] as String,
      level: jsonSerialization['level'] as int,
      spec: jsonSerialization['spec'] as String,
      status: jsonSerialization['status'] as String,
      score: jsonSerialization['score'] as int?,
      paid: jsonSerialization['paid'] as int?,
      issuedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// shift | exam
  String kind;

  String track;

  int level;

  String spec;

  /// open | done | void
  String status;

  int? score;

  int? paid;

  DateTime issuedAt;

  DateTime? doneAt;

  /// Returns a shallow copy of this [IslandGridWork]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandGridWork copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? kind,
    String? track,
    int? level,
    String? spec,
    String? status,
    int? score,
    int? paid,
    DateTime? issuedAt,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGridWork',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'track': track,
      'level': level,
      'spec': spec,
      'status': status,
      if (score != null) 'score': score,
      if (paid != null) 'paid': paid,
      'issuedAt': issuedAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGridWork',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'track': track,
      'level': level,
      'spec': spec,
      'status': status,
      if (score != null) 'score': score,
      if (paid != null) 'paid': paid,
      'issuedAt': issuedAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGridWorkImpl extends IslandGridWork {
  _IslandGridWorkImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String kind,
    required String track,
    required int level,
    required String spec,
    required String status,
    int? score,
    int? paid,
    required DateTime issuedAt,
    DateTime? doneAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         kind: kind,
         track: track,
         level: level,
         spec: spec,
         status: status,
         score: score,
         paid: paid,
         issuedAt: issuedAt,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [IslandGridWork]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandGridWork copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? kind,
    String? track,
    int? level,
    String? spec,
    String? status,
    Object? score = _Undefined,
    Object? paid = _Undefined,
    DateTime? issuedAt,
    Object? doneAt = _Undefined,
  }) {
    return IslandGridWork(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      kind: kind ?? this.kind,
      track: track ?? this.track,
      level: level ?? this.level,
      spec: spec ?? this.spec,
      status: status ?? this.status,
      score: score is int? ? score : this.score,
      paid: paid is int? ? paid : this.paid,
      issuedAt: issuedAt ?? this.issuedAt,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}
