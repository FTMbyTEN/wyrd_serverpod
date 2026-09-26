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

abstract class TopicInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TopicInfo._({
    required this.topic,
    required this.seenCount,
    this.definitionPartOfSpeech,
    this.definition,
    this.selfQuestion,
    this.selfAnswer,
    this.synthesis,
    this.netFactTitle,
    this.netFactExtract,
    required this.chatMentions,
  });

  factory TopicInfo({
    required String topic,
    required int seenCount,
    String? definitionPartOfSpeech,
    String? definition,
    String? selfQuestion,
    String? selfAnswer,
    String? synthesis,
    String? netFactTitle,
    String? netFactExtract,
    required int chatMentions,
  }) = _TopicInfoImpl;

  factory TopicInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopicInfo(
      topic: jsonSerialization['topic'] as String,
      seenCount: jsonSerialization['seenCount'] as int,
      definitionPartOfSpeech:
          jsonSerialization['definitionPartOfSpeech'] as String?,
      definition: jsonSerialization['definition'] as String?,
      selfQuestion: jsonSerialization['selfQuestion'] as String?,
      selfAnswer: jsonSerialization['selfAnswer'] as String?,
      synthesis: jsonSerialization['synthesis'] as String?,
      netFactTitle: jsonSerialization['netFactTitle'] as String?,
      netFactExtract: jsonSerialization['netFactExtract'] as String?,
      chatMentions: jsonSerialization['chatMentions'] as int,
    );
  }

  String topic;

  int seenCount;

  String? definitionPartOfSpeech;

  String? definition;

  String? selfQuestion;

  String? selfAnswer;

  String? synthesis;

  String? netFactTitle;

  String? netFactExtract;

  int chatMentions;

  /// Returns a shallow copy of this [TopicInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TopicInfo copyWith({
    String? topic,
    int? seenCount,
    String? definitionPartOfSpeech,
    String? definition,
    String? selfQuestion,
    String? selfAnswer,
    String? synthesis,
    String? netFactTitle,
    String? netFactExtract,
    int? chatMentions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopicInfo',
      'topic': topic,
      'seenCount': seenCount,
      if (definitionPartOfSpeech != null)
        'definitionPartOfSpeech': definitionPartOfSpeech,
      if (definition != null) 'definition': definition,
      if (selfQuestion != null) 'selfQuestion': selfQuestion,
      if (selfAnswer != null) 'selfAnswer': selfAnswer,
      if (synthesis != null) 'synthesis': synthesis,
      if (netFactTitle != null) 'netFactTitle': netFactTitle,
      if (netFactExtract != null) 'netFactExtract': netFactExtract,
      'chatMentions': chatMentions,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopicInfo',
      'topic': topic,
      'seenCount': seenCount,
      if (definitionPartOfSpeech != null)
        'definitionPartOfSpeech': definitionPartOfSpeech,
      if (definition != null) 'definition': definition,
      if (selfQuestion != null) 'selfQuestion': selfQuestion,
      if (selfAnswer != null) 'selfAnswer': selfAnswer,
      if (synthesis != null) 'synthesis': synthesis,
      if (netFactTitle != null) 'netFactTitle': netFactTitle,
      if (netFactExtract != null) 'netFactExtract': netFactExtract,
      'chatMentions': chatMentions,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TopicInfoImpl extends TopicInfo {
  _TopicInfoImpl({
    required String topic,
    required int seenCount,
    String? definitionPartOfSpeech,
    String? definition,
    String? selfQuestion,
    String? selfAnswer,
    String? synthesis,
    String? netFactTitle,
    String? netFactExtract,
    required int chatMentions,
  }) : super._(
         topic: topic,
         seenCount: seenCount,
         definitionPartOfSpeech: definitionPartOfSpeech,
         definition: definition,
         selfQuestion: selfQuestion,
         selfAnswer: selfAnswer,
         synthesis: synthesis,
         netFactTitle: netFactTitle,
         netFactExtract: netFactExtract,
         chatMentions: chatMentions,
       );

  /// Returns a shallow copy of this [TopicInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TopicInfo copyWith({
    String? topic,
    int? seenCount,
    Object? definitionPartOfSpeech = _Undefined,
    Object? definition = _Undefined,
    Object? selfQuestion = _Undefined,
    Object? selfAnswer = _Undefined,
    Object? synthesis = _Undefined,
    Object? netFactTitle = _Undefined,
    Object? netFactExtract = _Undefined,
    int? chatMentions,
  }) {
    return TopicInfo(
      topic: topic ?? this.topic,
      seenCount: seenCount ?? this.seenCount,
      definitionPartOfSpeech: definitionPartOfSpeech is String?
          ? definitionPartOfSpeech
          : this.definitionPartOfSpeech,
      definition: definition is String? ? definition : this.definition,
      selfQuestion: selfQuestion is String? ? selfQuestion : this.selfQuestion,
      selfAnswer: selfAnswer is String? ? selfAnswer : this.selfAnswer,
      synthesis: synthesis is String? ? synthesis : this.synthesis,
      netFactTitle: netFactTitle is String? ? netFactTitle : this.netFactTitle,
      netFactExtract: netFactExtract is String?
          ? netFactExtract
          : this.netFactExtract,
      chatMentions: chatMentions ?? this.chatMentions,
    );
  }
}
