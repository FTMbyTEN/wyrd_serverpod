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
import 'package:wyrd_client/src/protocol/protocol.dart' as _i2pladzn;

abstract class Belief
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Belief._({
    this.id,
    required this.a,
    required this.b,
    required this.claim,
    required this.evidenceIds,
    required this.sources,
    required this.against,
    required this.confidence,
    required this.status,
    required this.origin,
    required this.tests,
    required this.createdAt,
    required this.updatedAt,
    required this.testedAt,
  });

  factory Belief({
    int? id,
    required String a,
    required String b,
    required String claim,
    required List<int> evidenceIds,
    required int sources,
    required int against,
    required double confidence,
    required String status,
    required String origin,
    required int tests,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime testedAt,
  }) = _BeliefImpl;

  factory Belief.fromJson(Map<String, dynamic> jsonSerialization) {
    return Belief(
      id: jsonSerialization['id'] as int?,
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      claim: jsonSerialization['claim'] as String,
      evidenceIds: _i2pladzn.Protocol().deserialize<List<int>>(
        jsonSerialization['evidenceIds'],
      ),
      sources: jsonSerialization['sources'] as int,
      against: jsonSerialization['against'] as int,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      origin: jsonSerialization['origin'] as String,
      tests: jsonSerialization['tests'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      testedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['testedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String a;

  String b;

  String claim;

  List<int> evidenceIds;

  int sources;

  int against;

  double confidence;

  String status;

  String origin;

  int tests;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime testedAt;

  /// Returns a shallow copy of this [Belief]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Belief copyWith({
    int? id,
    String? a,
    String? b,
    String? claim,
    List<int>? evidenceIds,
    int? sources,
    int? against,
    double? confidence,
    String? status,
    String? origin,
    int? tests,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? testedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Belief',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'claim': claim,
      'evidenceIds': evidenceIds.toJson(),
      'sources': sources,
      'against': against,
      'confidence': confidence,
      'status': status,
      'origin': origin,
      'tests': tests,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'testedAt': testedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Belief',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'claim': claim,
      'evidenceIds': evidenceIds.toJson(),
      'sources': sources,
      'against': against,
      'confidence': confidence,
      'status': status,
      'origin': origin,
      'tests': tests,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'testedAt': testedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BeliefImpl extends Belief {
  _BeliefImpl({
    int? id,
    required String a,
    required String b,
    required String claim,
    required List<int> evidenceIds,
    required int sources,
    required int against,
    required double confidence,
    required String status,
    required String origin,
    required int tests,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime testedAt,
  }) : super._(
         id: id,
         a: a,
         b: b,
         claim: claim,
         evidenceIds: evidenceIds,
         sources: sources,
         against: against,
         confidence: confidence,
         status: status,
         origin: origin,
         tests: tests,
         createdAt: createdAt,
         updatedAt: updatedAt,
         testedAt: testedAt,
       );

  /// Returns a shallow copy of this [Belief]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Belief copyWith({
    Object? id = _Undefined,
    String? a,
    String? b,
    String? claim,
    List<int>? evidenceIds,
    int? sources,
    int? against,
    double? confidence,
    String? status,
    String? origin,
    int? tests,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? testedAt,
  }) {
    return Belief(
      id: id is int? ? id : this.id,
      a: a ?? this.a,
      b: b ?? this.b,
      claim: claim ?? this.claim,
      evidenceIds: evidenceIds ?? this.evidenceIds.map((e0) => e0).toList(),
      sources: sources ?? this.sources,
      against: against ?? this.against,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      origin: origin ?? this.origin,
      tests: tests ?? this.tests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      testedAt: testedAt ?? this.testedAt,
    );
  }
}
