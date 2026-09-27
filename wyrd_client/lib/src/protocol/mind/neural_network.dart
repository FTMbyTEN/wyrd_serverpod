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
import '../mind/concept_node.dart' as _ivkjyrm4;
import '../mind/synapse.dart' as _i4orlz2e;

abstract class NeuralNetwork
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NeuralNetwork._({
    required this.neurons,
    required this.synapses,
    required this.totalSynapses,
  });

  factory NeuralNetwork({
    required List<_ivkjyrm4.ConceptNode> neurons,
    required List<_i4orlz2e.Synapse> synapses,
    required int totalSynapses,
  }) = _NeuralNetworkImpl;

  factory NeuralNetwork.fromJson(Map<String, dynamic> jsonSerialization) {
    return NeuralNetwork(
      neurons: _i2pladzn.Protocol().deserialize<List<_ivkjyrm4.ConceptNode>>(
        jsonSerialization['neurons'],
      ),
      synapses: _i2pladzn.Protocol().deserialize<List<_i4orlz2e.Synapse>>(
        jsonSerialization['synapses'],
      ),
      totalSynapses: jsonSerialization['totalSynapses'] as int,
    );
  }

  List<_ivkjyrm4.ConceptNode> neurons;

  List<_i4orlz2e.Synapse> synapses;

  int totalSynapses;

  /// Returns a shallow copy of this [NeuralNetwork]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NeuralNetwork copyWith({
    List<_ivkjyrm4.ConceptNode>? neurons,
    List<_i4orlz2e.Synapse>? synapses,
    int? totalSynapses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NeuralNetwork',
      'neurons': neurons.toJson(valueToJson: (v) => v.toJson()),
      'synapses': synapses.toJson(valueToJson: (v) => v.toJson()),
      'totalSynapses': totalSynapses,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NeuralNetwork',
      'neurons': neurons.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'synapses': synapses.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalSynapses': totalSynapses,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _NeuralNetworkImpl extends NeuralNetwork {
  _NeuralNetworkImpl({
    required List<_ivkjyrm4.ConceptNode> neurons,
    required List<_i4orlz2e.Synapse> synapses,
    required int totalSynapses,
  }) : super._(
         neurons: neurons,
         synapses: synapses,
         totalSynapses: totalSynapses,
       );

  /// Returns a shallow copy of this [NeuralNetwork]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NeuralNetwork copyWith({
    List<_ivkjyrm4.ConceptNode>? neurons,
    List<_i4orlz2e.Synapse>? synapses,
    int? totalSynapses,
  }) {
    return NeuralNetwork(
      neurons: neurons ?? this.neurons.map((e0) => e0.copyWith()).toList(),
      synapses: synapses ?? this.synapses.map((e0) => e0.copyWith()).toList(),
      totalSynapses: totalSynapses ?? this.totalSynapses,
    );
  }
}
