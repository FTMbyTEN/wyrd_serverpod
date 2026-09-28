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

abstract class QuizQuestion
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizQuestion._({
    required this.kind,
    required this.prompt,
    required this.options,
    required this.answer,
    required this.explanation,
    required this.keyword,
  });

  factory QuizQuestion({
    required String kind,
    required String prompt,
    required List<String> options,
    required int answer,
    required String explanation,
    required String keyword,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      kind: jsonSerialization['kind'] as String,
      prompt: jsonSerialization['prompt'] as String,
      options: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
      answer: jsonSerialization['answer'] as int,
      explanation: jsonSerialization['explanation'] as String,
      keyword: jsonSerialization['keyword'] as String,
    );
  }

  String kind;

  String prompt;

  List<String> options;

  int answer;

  String explanation;

  String keyword;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizQuestion copyWith({
    String? kind,
    String? prompt,
    List<String>? options,
    int? answer,
    String? explanation,
    String? keyword,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      'kind': kind,
      'prompt': prompt,
      'options': options.toJson(),
      'answer': answer,
      'explanation': explanation,
      'keyword': keyword,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestion',
      'kind': kind,
      'prompt': prompt,
      'options': options.toJson(),
      'answer': answer,
      'explanation': explanation,
      'keyword': keyword,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    required String kind,
    required String prompt,
    required List<String> options,
    required int answer,
    required String explanation,
    required String keyword,
  }) : super._(
         kind: kind,
         prompt: prompt,
         options: options,
         answer: answer,
         explanation: explanation,
         keyword: keyword,
       );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizQuestion copyWith({
    String? kind,
    String? prompt,
    List<String>? options,
    int? answer,
    String? explanation,
    String? keyword,
  }) {
    return QuizQuestion(
      kind: kind ?? this.kind,
      prompt: prompt ?? this.prompt,
      options: options ?? this.options.map((e0) => e0).toList(),
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
      keyword: keyword ?? this.keyword,
    );
  }
}
