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

abstract class TrustScore
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TrustScore._({
    this.id,
    required this.kind,
    required this.key,
    required this.good,
    required this.bad,
    required this.score,
    required this.updatedAt,
  });

  factory TrustScore({
    int? id,
    required String kind,
    required String key,
    required double good,
    required double bad,
    required double score,
    required DateTime updatedAt,
  }) = _TrustScoreImpl;

  factory TrustScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrustScore(
      id: jsonSerialization['id'] as int?,
      kind: jsonSerialization['kind'] as String,
      key: jsonSerialization['key'] as String,
      good: (jsonSerialization['good'] as num).toDouble(),
      bad: (jsonSerialization['bad'] as num).toDouble(),
      score: (jsonSerialization['score'] as num).toDouble(),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String kind;

  String key;

  double good;

  double bad;

  double score;

  DateTime updatedAt;

  /// Returns a shallow copy of this [TrustScore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TrustScore copyWith({
    int? id,
    String? kind,
    String? key,
    double? good,
    double? bad,
    double? score,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrustScore',
      if (id != null) 'id': id,
      'kind': kind,
      'key': key,
      'good': good,
      'bad': bad,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrustScore',
      if (id != null) 'id': id,
      'kind': kind,
      'key': key,
      'good': good,
      'bad': bad,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrustScoreImpl extends TrustScore {
  _TrustScoreImpl({
    int? id,
    required String kind,
    required String key,
    required double good,
    required double bad,
    required double score,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         kind: kind,
         key: key,
         good: good,
         bad: bad,
         score: score,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TrustScore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TrustScore copyWith({
    Object? id = _Undefined,
    String? kind,
    String? key,
    double? good,
    double? bad,
    double? score,
    DateTime? updatedAt,
  }) {
    return TrustScore(
      id: id is int? ? id : this.id,
      kind: kind ?? this.kind,
      key: key ?? this.key,
      good: good ?? this.good,
      bad: bad ?? this.bad,
      score: score ?? this.score,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
