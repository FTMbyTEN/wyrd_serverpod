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
import '../mind/brain_firing.dart' as _ij919xat;
import '../mind/brain_neuron.dart' as _iebrsfth;
import '../mind/brain_synapse.dart' as _ircnot3v;

/// WYRD's real brain, for drawing: its strongest concepts (neurons), the synapses between them,
/// and the paths its last few thoughts took.
abstract class BrainMap
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BrainMap._({
    required this.neurons,
    required this.synapses,
    required this.firings,
  });

  factory BrainMap({
    required List<_iebrsfth.BrainNeuron> neurons,
    required List<_ircnot3v.BrainSynapse> synapses,
    required List<_ij919xat.BrainFiring> firings,
  }) = _BrainMapImpl;

  factory BrainMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return BrainMap(
      neurons: _i2pladzn.Protocol().deserialize<List<_iebrsfth.BrainNeuron>>(
        jsonSerialization['neurons'],
      ),
      synapses: _i2pladzn.Protocol().deserialize<List<_ircnot3v.BrainSynapse>>(
        jsonSerialization['synapses'],
      ),
      firings: _i2pladzn.Protocol().deserialize<List<_ij919xat.BrainFiring>>(
        jsonSerialization['firings'],
      ),
    );
  }

  List<_iebrsfth.BrainNeuron> neurons;

  List<_ircnot3v.BrainSynapse> synapses;

  List<_ij919xat.BrainFiring> firings;

  /// Returns a shallow copy of this [BrainMap]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BrainMap copyWith({
    List<_iebrsfth.BrainNeuron>? neurons,
    List<_ircnot3v.BrainSynapse>? synapses,
    List<_ij919xat.BrainFiring>? firings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BrainMap',
      'neurons': neurons.toJson(valueToJson: (v) => v.toJson()),
      'synapses': synapses.toJson(valueToJson: (v) => v.toJson()),
      'firings': firings.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BrainMap',
      'neurons': neurons.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'synapses': synapses.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'firings': firings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BrainMapImpl extends BrainMap {
  _BrainMapImpl({
    required List<_iebrsfth.BrainNeuron> neurons,
    required List<_ircnot3v.BrainSynapse> synapses,
    required List<_ij919xat.BrainFiring> firings,
  }) : super._(
         neurons: neurons,
         synapses: synapses,
         firings: firings,
       );

  /// Returns a shallow copy of this [BrainMap]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BrainMap copyWith({
    List<_iebrsfth.BrainNeuron>? neurons,
    List<_ircnot3v.BrainSynapse>? synapses,
    List<_ij919xat.BrainFiring>? firings,
  }) {
    return BrainMap(
      neurons: neurons ?? this.neurons.map((e0) => e0.copyWith()).toList(),
      synapses: synapses ?? this.synapses.map((e0) => e0.copyWith()).toList(),
      firings: firings ?? this.firings.map((e0) => e0.copyWith()).toList(),
    );
  }
}
