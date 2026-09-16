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
import '../mind/digest_info.dart' as _iegfx6l9;

abstract class Mind
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Mind._({
    required this.mood,
    this.focusTopic,
    this.activeGoal,
    required this.curiosity,
    required this.confidence,
    required this.digest,
    this.lastEvent,
    this.explorationCount,
    required this.updatedAt,
  });

  factory Mind({
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    int? explorationCount,
    required DateTime updatedAt,
  }) = _MindImpl;

  factory Mind.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mind(
      mood: jsonSerialization['mood'] as String,
      focusTopic: jsonSerialization['focusTopic'] as String?,
      activeGoal: jsonSerialization['activeGoal'] as String?,
      curiosity: (jsonSerialization['curiosity'] as num).toDouble(),
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      digest: _i2pladzn.Protocol().deserialize<_iegfx6l9.DigestInfo>(
        jsonSerialization['digest'],
      ),
      lastEvent: jsonSerialization['lastEvent'] as String?,
      explorationCount: jsonSerialization['explorationCount'] as int?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  String mood;

  String? focusTopic;

  String? activeGoal;

  double curiosity;

  double confidence;

  _iegfx6l9.DigestInfo digest;

  String? lastEvent;

  int? explorationCount;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Mind copyWith({
    String? mood,
    String? focusTopic,
    String? activeGoal,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    String? lastEvent,
    int? explorationCount,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mind',
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJson(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      if (explorationCount != null) 'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mind',
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJsonForProtocol(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      if (explorationCount != null) 'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MindImpl extends Mind {
  _MindImpl({
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    int? explorationCount,
    required DateTime updatedAt,
  }) : super._(
         mood: mood,
         focusTopic: focusTopic,
         activeGoal: activeGoal,
         curiosity: curiosity,
         confidence: confidence,
         digest: digest,
         lastEvent: lastEvent,
         explorationCount: explorationCount,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Mind copyWith({
    String? mood,
    Object? focusTopic = _Undefined,
    Object? activeGoal = _Undefined,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    Object? lastEvent = _Undefined,
    Object? explorationCount = _Undefined,
    DateTime? updatedAt,
  }) {
    return Mind(
      mood: mood ?? this.mood,
      focusTopic: focusTopic is String? ? focusTopic : this.focusTopic,
      activeGoal: activeGoal is String? ? activeGoal : this.activeGoal,
      curiosity: curiosity ?? this.curiosity,
      confidence: confidence ?? this.confidence,
      digest: digest ?? this.digest.copyWith(),
      lastEvent: lastEvent is String? ? lastEvent : this.lastEvent,
      explorationCount: explorationCount is int?
          ? explorationCount
          : this.explorationCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
