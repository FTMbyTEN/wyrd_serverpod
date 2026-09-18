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
import '../mind/concept_edge.dart' as _ilcy6dlv;
import '../mind/concept_node.dart' as _ivkjyrm4;

abstract class ConceptGraph
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConceptGraph._({
    required this.nodes,
    required this.edges,
  });

  factory ConceptGraph({
    required List<_ivkjyrm4.ConceptNode> nodes,
    required List<_ilcy6dlv.ConceptEdge> edges,
  }) = _ConceptGraphImpl;

  factory ConceptGraph.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConceptGraph(
      nodes: _i2pladzn.Protocol().deserialize<List<_ivkjyrm4.ConceptNode>>(
        jsonSerialization['nodes'],
      ),
      edges: _i2pladzn.Protocol().deserialize<List<_ilcy6dlv.ConceptEdge>>(
        jsonSerialization['edges'],
      ),
    );
  }

  List<_ivkjyrm4.ConceptNode> nodes;

  List<_ilcy6dlv.ConceptEdge> edges;

  /// Returns a shallow copy of this [ConceptGraph]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConceptGraph copyWith({
    List<_ivkjyrm4.ConceptNode>? nodes,
    List<_ilcy6dlv.ConceptEdge>? edges,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConceptGraph',
      'nodes': nodes.toJson(valueToJson: (v) => v.toJson()),
      'edges': edges.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConceptGraph',
      'nodes': nodes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'edges': edges.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ConceptGraphImpl extends ConceptGraph {
  _ConceptGraphImpl({
    required List<_ivkjyrm4.ConceptNode> nodes,
    required List<_ilcy6dlv.ConceptEdge> edges,
  }) : super._(
         nodes: nodes,
         edges: edges,
       );

  /// Returns a shallow copy of this [ConceptGraph]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConceptGraph copyWith({
    List<_ivkjyrm4.ConceptNode>? nodes,
    List<_ilcy6dlv.ConceptEdge>? edges,
  }) {
    return ConceptGraph(
      nodes: nodes ?? this.nodes.map((e0) => e0.copyWith()).toList(),
      edges: edges ?? this.edges.map((e0) => e0.copyWith()).toList(),
    );
  }
}
