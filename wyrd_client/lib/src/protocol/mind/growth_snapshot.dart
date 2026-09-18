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

abstract class GrowthSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GrowthSnapshot._({
    this.id,
    required this.timestamp,
    required this.vocabCount,
    required this.blockCount,
    required this.digestPercent,
    required this.curiosity,
    required this.confidence,
  });

  factory GrowthSnapshot({
    int? id,
    required DateTime timestamp,
    required int vocabCount,
    required int blockCount,
    required double digestPercent,
    required double curiosity,
    required double confidence,
  }) = _GrowthSnapshotImpl;

  factory GrowthSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return GrowthSnapshot(
      id: jsonSerialization['id'] as int?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      vocabCount: jsonSerialization['vocabCount'] as int,
      blockCount: jsonSerialization['blockCount'] as int,
      digestPercent: (jsonSerialization['digestPercent'] as num).toDouble(),
      curiosity: (jsonSerialization['curiosity'] as num).toDouble(),
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime timestamp;

  int vocabCount;

  int blockCount;

  double digestPercent;

  double curiosity;

  double confidence;

  /// Returns a shallow copy of this [GrowthSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GrowthSnapshot copyWith({
    int? id,
    DateTime? timestamp,
    int? vocabCount,
    int? blockCount,
    double? digestPercent,
    double? curiosity,
    double? confidence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GrowthSnapshot',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'vocabCount': vocabCount,
      'blockCount': blockCount,
      'digestPercent': digestPercent,
      'curiosity': curiosity,
      'confidence': confidence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GrowthSnapshot',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'vocabCount': vocabCount,
      'blockCount': blockCount,
      'digestPercent': digestPercent,
      'curiosity': curiosity,
      'confidence': confidence,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GrowthSnapshotImpl extends GrowthSnapshot {
  _GrowthSnapshotImpl({
    int? id,
    required DateTime timestamp,
    required int vocabCount,
    required int blockCount,
    required double digestPercent,
    required double curiosity,
    required double confidence,
  }) : super._(
         id: id,
         timestamp: timestamp,
         vocabCount: vocabCount,
         blockCount: blockCount,
         digestPercent: digestPercent,
         curiosity: curiosity,
         confidence: confidence,
       );

  /// Returns a shallow copy of this [GrowthSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GrowthSnapshot copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    int? vocabCount,
    int? blockCount,
    double? digestPercent,
    double? curiosity,
    double? confidence,
  }) {
    return GrowthSnapshot(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      vocabCount: vocabCount ?? this.vocabCount,
      blockCount: blockCount ?? this.blockCount,
      digestPercent: digestPercent ?? this.digestPercent,
      curiosity: curiosity ?? this.curiosity,
      confidence: confidence ?? this.confidence,
    );
  }
}
