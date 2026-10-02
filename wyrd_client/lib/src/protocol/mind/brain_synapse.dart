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

abstract class BrainSynapse
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BrainSynapse._({
    required this.a,
    required this.b,
    required this.weight,
    required this.fires,
  });

  factory BrainSynapse({
    required String a,
    required String b,
    required double weight,
    required int fires,
  }) = _BrainSynapseImpl;

  factory BrainSynapse.fromJson(Map<String, dynamic> jsonSerialization) {
    return BrainSynapse(
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      fires: jsonSerialization['fires'] as int,
    );
  }

  String a;

  String b;

  double weight;

  int fires;

  /// Returns a shallow copy of this [BrainSynapse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BrainSynapse copyWith({
    String? a,
    String? b,
    double? weight,
    int? fires,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BrainSynapse',
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BrainSynapse',
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BrainSynapseImpl extends BrainSynapse {
  _BrainSynapseImpl({
    required String a,
    required String b,
    required double weight,
    required int fires,
  }) : super._(
         a: a,
         b: b,
         weight: weight,
         fires: fires,
       );

  /// Returns a shallow copy of this [BrainSynapse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BrainSynapse copyWith({
    String? a,
    String? b,
    double? weight,
    int? fires,
  }) {
    return BrainSynapse(
      a: a ?? this.a,
      b: b ?? this.b,
      weight: weight ?? this.weight,
      fires: fires ?? this.fires,
    );
  }
}
