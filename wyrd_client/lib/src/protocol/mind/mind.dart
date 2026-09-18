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
    this.id,
    required this.mood,
    this.focusTopic,
    this.activeGoal,
    required this.curiosity,
    required this.confidence,
    required this.digest,
    this.lastEvent,
    required this.explorationCount,
    required this.updatedAt,
    required this.seenTopics,
    required this.resolvedTopics,
    required this.selfAnswerTimestamps,
  });

  factory Mind({
    int? id,
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    required int explorationCount,
    required DateTime updatedAt,
    required List<String> seenTopics,
    required List<String> resolvedTopics,
    required List<int> selfAnswerTimestamps,
  }) = _MindImpl;

  factory Mind.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mind(
      id: jsonSerialization['id'] as int?,
      mood: jsonSerialization['mood'] as String,
      focusTopic: jsonSerialization['focusTopic'] as String?,
      activeGoal: jsonSerialization['activeGoal'] as String?,
      curiosity: (jsonSerialization['curiosity'] as num).toDouble(),
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      digest: _i2pladzn.Protocol().deserialize<_iegfx6l9.DigestInfo>(
        jsonSerialization['digest'],
      ),
      lastEvent: jsonSerialization['lastEvent'] as String?,
      explorationCount: jsonSerialization['explorationCount'] as int,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      seenTopics: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['seenTopics'],
      ),
      resolvedTopics: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['resolvedTopics'],
      ),
      selfAnswerTimestamps: _i2pladzn.Protocol().deserialize<List<int>>(
        jsonSerialization['selfAnswerTimestamps'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String mood;

  String? focusTopic;

  String? activeGoal;

  double curiosity;

  double confidence;

  _iegfx6l9.DigestInfo digest;

  String? lastEvent;

  int explorationCount;

  DateTime updatedAt;

  List<String> seenTopics;

  List<String> resolvedTopics;

  List<int> selfAnswerTimestamps;

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Mind copyWith({
    int? id,
    String? mood,
    String? focusTopic,
    String? activeGoal,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    String? lastEvent,
    int? explorationCount,
    DateTime? updatedAt,
    List<String>? seenTopics,
    List<String>? resolvedTopics,
    List<int>? selfAnswerTimestamps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mind',
      if (id != null) 'id': id,
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJson(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
      'seenTopics': seenTopics.toJson(),
      'resolvedTopics': resolvedTopics.toJson(),
      'selfAnswerTimestamps': selfAnswerTimestamps.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mind',
      if (id != null) 'id': id,
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJsonForProtocol(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
      'seenTopics': seenTopics.toJson(),
      'resolvedTopics': resolvedTopics.toJson(),
      'selfAnswerTimestamps': selfAnswerTimestamps.toJson(),
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
    int? id,
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    required int explorationCount,
    required DateTime updatedAt,
    required List<String> seenTopics,
    required List<String> resolvedTopics,
    required List<int> selfAnswerTimestamps,
  }) : super._(
         id: id,
         mood: mood,
         focusTopic: focusTopic,
         activeGoal: activeGoal,
         curiosity: curiosity,
         confidence: confidence,
         digest: digest,
         lastEvent: lastEvent,
         explorationCount: explorationCount,
         updatedAt: updatedAt,
         seenTopics: seenTopics,
         resolvedTopics: resolvedTopics,
         selfAnswerTimestamps: selfAnswerTimestamps,
       );

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Mind copyWith({
    Object? id = _Undefined,
    String? mood,
    Object? focusTopic = _Undefined,
    Object? activeGoal = _Undefined,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    Object? lastEvent = _Undefined,
    int? explorationCount,
    DateTime? updatedAt,
    List<String>? seenTopics,
    List<String>? resolvedTopics,
    List<int>? selfAnswerTimestamps,
  }) {
    return Mind(
      id: id is int? ? id : this.id,
      mood: mood ?? this.mood,
      focusTopic: focusTopic is String? ? focusTopic : this.focusTopic,
      activeGoal: activeGoal is String? ? activeGoal : this.activeGoal,
      curiosity: curiosity ?? this.curiosity,
      confidence: confidence ?? this.confidence,
      digest: digest ?? this.digest.copyWith(),
      lastEvent: lastEvent is String? ? lastEvent : this.lastEvent,
      explorationCount: explorationCount ?? this.explorationCount,
      updatedAt: updatedAt ?? this.updatedAt,
      seenTopics: seenTopics ?? this.seenTopics.map((e0) => e0).toList(),
      resolvedTopics:
          resolvedTopics ?? this.resolvedTopics.map((e0) => e0).toList(),
      selfAnswerTimestamps:
          selfAnswerTimestamps ??
          this.selfAnswerTimestamps.map((e0) => e0).toList(),
    );
  }
}
