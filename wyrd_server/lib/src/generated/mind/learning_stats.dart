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
import 'package:serverpod/serverpod.dart' as _is;

abstract class LearningStats
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LearningStats._({
    required this.answers,
    required this.shared,
    required this.reuses,
    required this.improved,
  });

  factory LearningStats({
    required int answers,
    required int shared,
    required int reuses,
    required int improved,
  }) = _LearningStatsImpl;

  factory LearningStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return LearningStats(
      answers: jsonSerialization['answers'] as int,
      shared: jsonSerialization['shared'] as int,
      reuses: jsonSerialization['reuses'] as int,
      improved: jsonSerialization['improved'] as int,
    );
  }

  int answers;

  int shared;

  int reuses;

  int improved;

  /// Returns a shallow copy of this [LearningStats]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LearningStats copyWith({
    int? answers,
    int? shared,
    int? reuses,
    int? improved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearningStats',
      'answers': answers,
      'shared': shared,
      'reuses': reuses,
      'improved': improved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LearningStats',
      'answers': answers,
      'shared': shared,
      'reuses': reuses,
      'improved': improved,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LearningStatsImpl extends LearningStats {
  _LearningStatsImpl({
    required int answers,
    required int shared,
    required int reuses,
    required int improved,
  }) : super._(
         answers: answers,
         shared: shared,
         reuses: reuses,
         improved: improved,
       );

  /// Returns a shallow copy of this [LearningStats]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LearningStats copyWith({
    int? answers,
    int? shared,
    int? reuses,
    int? improved,
  }) {
    return LearningStats(
      answers: answers ?? this.answers,
      shared: shared ?? this.shared,
      reuses: reuses ?? this.reuses,
      improved: improved ?? this.improved,
    );
  }
}
