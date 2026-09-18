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

abstract class LexiconWordSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LexiconWordSummary._({
    required this.word,
    this.definition,
    this.partOfSpeech,
  });

  factory LexiconWordSummary({
    required String word,
    String? definition,
    String? partOfSpeech,
  }) = _LexiconWordSummaryImpl;

  factory LexiconWordSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return LexiconWordSummary(
      word: jsonSerialization['word'] as String,
      definition: jsonSerialization['definition'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
    );
  }

  String word;

  String? definition;

  String? partOfSpeech;

  /// Returns a shallow copy of this [LexiconWordSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LexiconWordSummary copyWith({
    String? word,
    String? definition,
    String? partOfSpeech,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LexiconWordSummary',
      'word': word,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LexiconWordSummary',
      'word': word,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LexiconWordSummaryImpl extends LexiconWordSummary {
  _LexiconWordSummaryImpl({
    required String word,
    String? definition,
    String? partOfSpeech,
  }) : super._(
         word: word,
         definition: definition,
         partOfSpeech: partOfSpeech,
       );

  /// Returns a shallow copy of this [LexiconWordSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LexiconWordSummary copyWith({
    String? word,
    Object? definition = _Undefined,
    Object? partOfSpeech = _Undefined,
  }) {
    return LexiconWordSummary(
      word: word ?? this.word,
      definition: definition is String? ? definition : this.definition,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
    );
  }
}
