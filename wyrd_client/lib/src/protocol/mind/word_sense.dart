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

abstract class WordSense
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WordSense._({
    this.id,
    required this.lemma,
    required this.pos,
    required this.rank,
    required this.tagCount,
    required this.definition,
    this.example,
    required this.synonyms,
    this.hypernym,
  });

  factory WordSense({
    int? id,
    required String lemma,
    required String pos,
    required int rank,
    required int tagCount,
    required String definition,
    String? example,
    required List<String> synonyms,
    String? hypernym,
  }) = _WordSenseImpl;

  factory WordSense.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordSense(
      id: jsonSerialization['id'] as int?,
      lemma: jsonSerialization['lemma'] as String,
      pos: jsonSerialization['pos'] as String,
      rank: jsonSerialization['rank'] as int,
      tagCount: jsonSerialization['tagCount'] as int,
      definition: jsonSerialization['definition'] as String,
      example: jsonSerialization['example'] as String?,
      synonyms: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['synonyms'],
      ),
      hypernym: jsonSerialization['hypernym'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String lemma;

  String pos;

  int rank;

  int tagCount;

  String definition;

  String? example;

  List<String> synonyms;

  String? hypernym;

  /// Returns a shallow copy of this [WordSense]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WordSense copyWith({
    int? id,
    String? lemma,
    String? pos,
    int? rank,
    int? tagCount,
    String? definition,
    String? example,
    List<String>? synonyms,
    String? hypernym,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordSense',
      if (id != null) 'id': id,
      'lemma': lemma,
      'pos': pos,
      'rank': rank,
      'tagCount': tagCount,
      'definition': definition,
      if (example != null) 'example': example,
      'synonyms': synonyms.toJson(),
      if (hypernym != null) 'hypernym': hypernym,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordSense',
      if (id != null) 'id': id,
      'lemma': lemma,
      'pos': pos,
      'rank': rank,
      'tagCount': tagCount,
      'definition': definition,
      if (example != null) 'example': example,
      'synonyms': synonyms.toJson(),
      if (hypernym != null) 'hypernym': hypernym,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WordSenseImpl extends WordSense {
  _WordSenseImpl({
    int? id,
    required String lemma,
    required String pos,
    required int rank,
    required int tagCount,
    required String definition,
    String? example,
    required List<String> synonyms,
    String? hypernym,
  }) : super._(
         id: id,
         lemma: lemma,
         pos: pos,
         rank: rank,
         tagCount: tagCount,
         definition: definition,
         example: example,
         synonyms: synonyms,
         hypernym: hypernym,
       );

  /// Returns a shallow copy of this [WordSense]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WordSense copyWith({
    Object? id = _Undefined,
    String? lemma,
    String? pos,
    int? rank,
    int? tagCount,
    String? definition,
    Object? example = _Undefined,
    List<String>? synonyms,
    Object? hypernym = _Undefined,
  }) {
    return WordSense(
      id: id is int? ? id : this.id,
      lemma: lemma ?? this.lemma,
      pos: pos ?? this.pos,
      rank: rank ?? this.rank,
      tagCount: tagCount ?? this.tagCount,
      definition: definition ?? this.definition,
      example: example is String? ? example : this.example,
      synonyms: synonyms ?? this.synonyms.map((e0) => e0).toList(),
      hypernym: hypernym is String? ? hypernym : this.hypernym,
    );
  }
}
