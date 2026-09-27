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
import '../mind/concept_example.dart' as _iszhbpax;
import '../mind/concept_node.dart' as _ivkjyrm4;

abstract class ConceptDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConceptDetail._({
    required this.topic,
    required this.mentions,
    this.definition,
    this.partOfSpeech,
    required this.related,
    required this.examples,
  });

  factory ConceptDetail({
    required String topic,
    required int mentions,
    String? definition,
    String? partOfSpeech,
    required List<_ivkjyrm4.ConceptNode> related,
    required List<_iszhbpax.ConceptExample> examples,
  }) = _ConceptDetailImpl;

  factory ConceptDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConceptDetail(
      topic: jsonSerialization['topic'] as String,
      mentions: jsonSerialization['mentions'] as int,
      definition: jsonSerialization['definition'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
      related: _i2pladzn.Protocol().deserialize<List<_ivkjyrm4.ConceptNode>>(
        jsonSerialization['related'],
      ),
      examples: _i2pladzn.Protocol()
          .deserialize<List<_iszhbpax.ConceptExample>>(
            jsonSerialization['examples'],
          ),
    );
  }

  String topic;

  int mentions;

  String? definition;

  String? partOfSpeech;

  List<_ivkjyrm4.ConceptNode> related;

  List<_iszhbpax.ConceptExample> examples;

  /// Returns a shallow copy of this [ConceptDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConceptDetail copyWith({
    String? topic,
    int? mentions,
    String? definition,
    String? partOfSpeech,
    List<_ivkjyrm4.ConceptNode>? related,
    List<_iszhbpax.ConceptExample>? examples,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConceptDetail',
      'topic': topic,
      'mentions': mentions,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'related': related.toJson(valueToJson: (v) => v.toJson()),
      'examples': examples.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConceptDetail',
      'topic': topic,
      'mentions': mentions,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'related': related.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'examples': examples.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConceptDetailImpl extends ConceptDetail {
  _ConceptDetailImpl({
    required String topic,
    required int mentions,
    String? definition,
    String? partOfSpeech,
    required List<_ivkjyrm4.ConceptNode> related,
    required List<_iszhbpax.ConceptExample> examples,
  }) : super._(
         topic: topic,
         mentions: mentions,
         definition: definition,
         partOfSpeech: partOfSpeech,
         related: related,
         examples: examples,
       );

  /// Returns a shallow copy of this [ConceptDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConceptDetail copyWith({
    String? topic,
    int? mentions,
    Object? definition = _Undefined,
    Object? partOfSpeech = _Undefined,
    List<_ivkjyrm4.ConceptNode>? related,
    List<_iszhbpax.ConceptExample>? examples,
  }) {
    return ConceptDetail(
      topic: topic ?? this.topic,
      mentions: mentions ?? this.mentions,
      definition: definition is String? ? definition : this.definition,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
      related: related ?? this.related.map((e0) => e0.copyWith()).toList(),
      examples: examples ?? this.examples.map((e0) => e0.copyWith()).toList(),
    );
  }
}
