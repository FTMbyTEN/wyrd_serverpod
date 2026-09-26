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

abstract class SystemStatus
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SystemStatus._({
    required this.turboActive,
    required this.turboFactor,
    required this.reasoningCycleMs,
    required this.selfQuestionCycleMs,
    required this.feedCycleMs,
    required this.lexiconCycleMs,
    required this.llmActive,
    this.llmModel,
    required this.qaDatasetEntries,
    required this.dialogueDatasetEntries,
  });

  factory SystemStatus({
    required bool turboActive,
    required int turboFactor,
    required int reasoningCycleMs,
    required int selfQuestionCycleMs,
    required int feedCycleMs,
    required int lexiconCycleMs,
    required bool llmActive,
    String? llmModel,
    required int qaDatasetEntries,
    required int dialogueDatasetEntries,
  }) = _SystemStatusImpl;

  factory SystemStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemStatus(
      turboActive: _is.BoolJsonExtension.fromJson(
        jsonSerialization['turboActive'],
      ),
      turboFactor: jsonSerialization['turboFactor'] as int,
      reasoningCycleMs: jsonSerialization['reasoningCycleMs'] as int,
      selfQuestionCycleMs: jsonSerialization['selfQuestionCycleMs'] as int,
      feedCycleMs: jsonSerialization['feedCycleMs'] as int,
      lexiconCycleMs: jsonSerialization['lexiconCycleMs'] as int,
      llmActive: _is.BoolJsonExtension.fromJson(jsonSerialization['llmActive']),
      llmModel: jsonSerialization['llmModel'] as String?,
      qaDatasetEntries: jsonSerialization['qaDatasetEntries'] as int,
      dialogueDatasetEntries:
          jsonSerialization['dialogueDatasetEntries'] as int,
    );
  }

  bool turboActive;

  int turboFactor;

  int reasoningCycleMs;

  int selfQuestionCycleMs;

  int feedCycleMs;

  int lexiconCycleMs;

  bool llmActive;

  String? llmModel;

  int qaDatasetEntries;

  int dialogueDatasetEntries;

  /// Returns a shallow copy of this [SystemStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SystemStatus copyWith({
    bool? turboActive,
    int? turboFactor,
    int? reasoningCycleMs,
    int? selfQuestionCycleMs,
    int? feedCycleMs,
    int? lexiconCycleMs,
    bool? llmActive,
    String? llmModel,
    int? qaDatasetEntries,
    int? dialogueDatasetEntries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemStatus',
      'turboActive': turboActive,
      'turboFactor': turboFactor,
      'reasoningCycleMs': reasoningCycleMs,
      'selfQuestionCycleMs': selfQuestionCycleMs,
      'feedCycleMs': feedCycleMs,
      'lexiconCycleMs': lexiconCycleMs,
      'llmActive': llmActive,
      if (llmModel != null) 'llmModel': llmModel,
      'qaDatasetEntries': qaDatasetEntries,
      'dialogueDatasetEntries': dialogueDatasetEntries,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemStatus',
      'turboActive': turboActive,
      'turboFactor': turboFactor,
      'reasoningCycleMs': reasoningCycleMs,
      'selfQuestionCycleMs': selfQuestionCycleMs,
      'feedCycleMs': feedCycleMs,
      'lexiconCycleMs': lexiconCycleMs,
      'llmActive': llmActive,
      if (llmModel != null) 'llmModel': llmModel,
      'qaDatasetEntries': qaDatasetEntries,
      'dialogueDatasetEntries': dialogueDatasetEntries,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemStatusImpl extends SystemStatus {
  _SystemStatusImpl({
    required bool turboActive,
    required int turboFactor,
    required int reasoningCycleMs,
    required int selfQuestionCycleMs,
    required int feedCycleMs,
    required int lexiconCycleMs,
    required bool llmActive,
    String? llmModel,
    required int qaDatasetEntries,
    required int dialogueDatasetEntries,
  }) : super._(
         turboActive: turboActive,
         turboFactor: turboFactor,
         reasoningCycleMs: reasoningCycleMs,
         selfQuestionCycleMs: selfQuestionCycleMs,
         feedCycleMs: feedCycleMs,
         lexiconCycleMs: lexiconCycleMs,
         llmActive: llmActive,
         llmModel: llmModel,
         qaDatasetEntries: qaDatasetEntries,
         dialogueDatasetEntries: dialogueDatasetEntries,
       );

  /// Returns a shallow copy of this [SystemStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SystemStatus copyWith({
    bool? turboActive,
    int? turboFactor,
    int? reasoningCycleMs,
    int? selfQuestionCycleMs,
    int? feedCycleMs,
    int? lexiconCycleMs,
    bool? llmActive,
    Object? llmModel = _Undefined,
    int? qaDatasetEntries,
    int? dialogueDatasetEntries,
  }) {
    return SystemStatus(
      turboActive: turboActive ?? this.turboActive,
      turboFactor: turboFactor ?? this.turboFactor,
      reasoningCycleMs: reasoningCycleMs ?? this.reasoningCycleMs,
      selfQuestionCycleMs: selfQuestionCycleMs ?? this.selfQuestionCycleMs,
      feedCycleMs: feedCycleMs ?? this.feedCycleMs,
      lexiconCycleMs: lexiconCycleMs ?? this.lexiconCycleMs,
      llmActive: llmActive ?? this.llmActive,
      llmModel: llmModel is String? ? llmModel : this.llmModel,
      qaDatasetEntries: qaDatasetEntries ?? this.qaDatasetEntries,
      dialogueDatasetEntries:
          dialogueDatasetEntries ?? this.dialogueDatasetEntries,
    );
  }
}
