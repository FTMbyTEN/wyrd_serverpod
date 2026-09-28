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

abstract class QuizStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizStats._({
    required this.rounds,
    required this.correct,
    required this.total,
  });

  factory QuizStats({
    required int rounds,
    required int correct,
    required int total,
  }) = _QuizStatsImpl;

  factory QuizStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizStats(
      rounds: jsonSerialization['rounds'] as int,
      correct: jsonSerialization['correct'] as int,
      total: jsonSerialization['total'] as int,
    );
  }

  int rounds;

  int correct;

  int total;

  /// Returns a shallow copy of this [QuizStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizStats copyWith({
    int? rounds,
    int? correct,
    int? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizStats',
      'rounds': rounds,
      'correct': correct,
      'total': total,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizStats',
      'rounds': rounds,
      'correct': correct,
      'total': total,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _QuizStatsImpl extends QuizStats {
  _QuizStatsImpl({
    required int rounds,
    required int correct,
    required int total,
  }) : super._(
         rounds: rounds,
         correct: correct,
         total: total,
       );

  /// Returns a shallow copy of this [QuizStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizStats copyWith({
    int? rounds,
    int? correct,
    int? total,
  }) {
    return QuizStats(
      rounds: rounds ?? this.rounds,
      correct: correct ?? this.correct,
      total: total ?? this.total,
    );
  }
}
