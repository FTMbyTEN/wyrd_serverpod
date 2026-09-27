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

abstract class Synapse
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Synapse._({
    this.id,
    required this.a,
    required this.b,
    required this.weight,
    required this.fires,
    required this.lastFired,
  });

  factory Synapse({
    int? id,
    required String a,
    required String b,
    required double weight,
    required int fires,
    required DateTime lastFired,
  }) = _SynapseImpl;

  factory Synapse.fromJson(Map<String, dynamic> jsonSerialization) {
    return Synapse(
      id: jsonSerialization['id'] as int?,
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      fires: jsonSerialization['fires'] as int,
      lastFired: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastFired'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String a;

  String b;

  double weight;

  int fires;

  DateTime lastFired;

  /// Returns a shallow copy of this [Synapse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Synapse copyWith({
    int? id,
    String? a,
    String? b,
    double? weight,
    int? fires,
    DateTime? lastFired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Synapse',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
      'lastFired': lastFired.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Synapse',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
      'lastFired': lastFired.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SynapseImpl extends Synapse {
  _SynapseImpl({
    int? id,
    required String a,
    required String b,
    required double weight,
    required int fires,
    required DateTime lastFired,
  }) : super._(
         id: id,
         a: a,
         b: b,
         weight: weight,
         fires: fires,
         lastFired: lastFired,
       );

  /// Returns a shallow copy of this [Synapse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Synapse copyWith({
    Object? id = _Undefined,
    String? a,
    String? b,
    double? weight,
    int? fires,
    DateTime? lastFired,
  }) {
    return Synapse(
      id: id is int? ? id : this.id,
      a: a ?? this.a,
      b: b ?? this.b,
      weight: weight ?? this.weight,
      fires: fires ?? this.fires,
      lastFired: lastFired ?? this.lastFired,
    );
  }
}
