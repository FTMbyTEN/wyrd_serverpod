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

abstract class ConceptEdge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConceptEdge._({
    required this.a,
    required this.b,
    required this.weight,
  });

  factory ConceptEdge({
    required String a,
    required String b,
    required int weight,
  }) = _ConceptEdgeImpl;

  factory ConceptEdge.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConceptEdge(
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      weight: jsonSerialization['weight'] as int,
    );
  }

  String a;

  String b;

  int weight;

  /// Returns a shallow copy of this [ConceptEdge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConceptEdge copyWith({
    String? a,
    String? b,
    int? weight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConceptEdge',
      'a': a,
      'b': b,
      'weight': weight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConceptEdge',
      'a': a,
      'b': b,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ConceptEdgeImpl extends ConceptEdge {
  _ConceptEdgeImpl({
    required String a,
    required String b,
    required int weight,
  }) : super._(
         a: a,
         b: b,
         weight: weight,
       );

  /// Returns a shallow copy of this [ConceptEdge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConceptEdge copyWith({
    String? a,
    String? b,
    int? weight,
  }) {
    return ConceptEdge(
      a: a ?? this.a,
      b: b ?? this.b,
      weight: weight ?? this.weight,
    );
  }
}
