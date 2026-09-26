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

abstract class GateShape
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GateShape._({
    required this.type,
    required this.a,
    required this.b,
    required this.freqX,
    required this.freqY,
    required this.freqZ,
    required this.turns,
    required this.radiusScale,
    required this.heightScale,
    required this.twist,
    required this.label,
  });

  factory GateShape({
    required String type,
    required double a,
    required double b,
    required int freqX,
    required int freqY,
    required int freqZ,
    required double turns,
    required double radiusScale,
    required double heightScale,
    required double twist,
    required String label,
  }) = _GateShapeImpl;

  factory GateShape.fromJson(Map<String, dynamic> jsonSerialization) {
    return GateShape(
      type: jsonSerialization['type'] as String,
      a: (jsonSerialization['a'] as num).toDouble(),
      b: (jsonSerialization['b'] as num).toDouble(),
      freqX: jsonSerialization['freqX'] as int,
      freqY: jsonSerialization['freqY'] as int,
      freqZ: jsonSerialization['freqZ'] as int,
      turns: (jsonSerialization['turns'] as num).toDouble(),
      radiusScale: (jsonSerialization['radiusScale'] as num).toDouble(),
      heightScale: (jsonSerialization['heightScale'] as num).toDouble(),
      twist: (jsonSerialization['twist'] as num).toDouble(),
      label: jsonSerialization['label'] as String,
    );
  }

  String type;

  double a;

  double b;

  int freqX;

  int freqY;

  int freqZ;

  double turns;

  double radiusScale;

  double heightScale;

  double twist;

  String label;

  /// Returns a shallow copy of this [GateShape]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GateShape copyWith({
    String? type,
    double? a,
    double? b,
    int? freqX,
    int? freqY,
    int? freqZ,
    double? turns,
    double? radiusScale,
    double? heightScale,
    double? twist,
    String? label,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GateShape',
      'type': type,
      'a': a,
      'b': b,
      'freqX': freqX,
      'freqY': freqY,
      'freqZ': freqZ,
      'turns': turns,
      'radiusScale': radiusScale,
      'heightScale': heightScale,
      'twist': twist,
      'label': label,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GateShape',
      'type': type,
      'a': a,
      'b': b,
      'freqX': freqX,
      'freqY': freqY,
      'freqZ': freqZ,
      'turns': turns,
      'radiusScale': radiusScale,
      'heightScale': heightScale,
      'twist': twist,
      'label': label,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _GateShapeImpl extends GateShape {
  _GateShapeImpl({
    required String type,
    required double a,
    required double b,
    required int freqX,
    required int freqY,
    required int freqZ,
    required double turns,
    required double radiusScale,
    required double heightScale,
    required double twist,
    required String label,
  }) : super._(
         type: type,
         a: a,
         b: b,
         freqX: freqX,
         freqY: freqY,
         freqZ: freqZ,
         turns: turns,
         radiusScale: radiusScale,
         heightScale: heightScale,
         twist: twist,
         label: label,
       );

  /// Returns a shallow copy of this [GateShape]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GateShape copyWith({
    String? type,
    double? a,
    double? b,
    int? freqX,
    int? freqY,
    int? freqZ,
    double? turns,
    double? radiusScale,
    double? heightScale,
    double? twist,
    String? label,
  }) {
    return GateShape(
      type: type ?? this.type,
      a: a ?? this.a,
      b: b ?? this.b,
      freqX: freqX ?? this.freqX,
      freqY: freqY ?? this.freqY,
      freqZ: freqZ ?? this.freqZ,
      turns: turns ?? this.turns,
      radiusScale: radiusScale ?? this.radiusScale,
      heightScale: heightScale ?? this.heightScale,
      twist: twist ?? this.twist,
      label: label ?? this.label,
    );
  }
}
