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

abstract class BrainNeuron
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BrainNeuron._({
    required this.id,
    required this.weight,
    required this.degree,
  });

  factory BrainNeuron({
    required String id,
    required double weight,
    required int degree,
  }) = _BrainNeuronImpl;

  factory BrainNeuron.fromJson(Map<String, dynamic> jsonSerialization) {
    return BrainNeuron(
      id: jsonSerialization['id'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      degree: jsonSerialization['degree'] as int,
    );
  }

  String id;

  double weight;

  int degree;

  /// Returns a shallow copy of this [BrainNeuron]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BrainNeuron copyWith({
    String? id,
    double? weight,
    int? degree,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BrainNeuron',
      'id': id,
      'weight': weight,
      'degree': degree,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BrainNeuron',
      'id': id,
      'weight': weight,
      'degree': degree,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BrainNeuronImpl extends BrainNeuron {
  _BrainNeuronImpl({
    required String id,
    required double weight,
    required int degree,
  }) : super._(
         id: id,
         weight: weight,
         degree: degree,
       );

  /// Returns a shallow copy of this [BrainNeuron]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BrainNeuron copyWith({
    String? id,
    double? weight,
    int? degree,
  }) {
    return BrainNeuron(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      degree: degree ?? this.degree,
    );
  }
}
