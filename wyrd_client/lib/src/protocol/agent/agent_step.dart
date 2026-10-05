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

/// One step of an agent task's work: what it thought, which tool it used and what came back.
abstract class AgentStep
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentStep._({
    this.id,
    required this.taskId,
    required this.run,
    required this.at,
    required this.kind,
    this.tool,
    required this.detail,
    this.output,
  });

  factory AgentStep({
    int? id,
    required int taskId,
    required int run,
    required DateTime at,
    required String kind,
    String? tool,
    required String detail,
    String? output,
  }) = _AgentStepImpl;

  factory AgentStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentStep(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      run: jsonSerialization['run'] as int,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      kind: jsonSerialization['kind'] as String,
      tool: jsonSerialization['tool'] as String?,
      detail: jsonSerialization['detail'] as String,
      output: jsonSerialization['output'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int taskId;

  int run;

  DateTime at;

  String kind;

  String? tool;

  String detail;

  String? output;

  /// Returns a shallow copy of this [AgentStep]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentStep copyWith({
    int? id,
    int? taskId,
    int? run,
    DateTime? at,
    String? kind,
    String? tool,
    String? detail,
    String? output,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentStep',
      if (id != null) 'id': id,
      'taskId': taskId,
      'run': run,
      'at': at.toJson(),
      'kind': kind,
      if (tool != null) 'tool': tool,
      'detail': detail,
      if (output != null) 'output': output,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentStep',
      if (id != null) 'id': id,
      'taskId': taskId,
      'run': run,
      'at': at.toJson(),
      'kind': kind,
      if (tool != null) 'tool': tool,
      'detail': detail,
      if (output != null) 'output': output,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentStepImpl extends AgentStep {
  _AgentStepImpl({
    int? id,
    required int taskId,
    required int run,
    required DateTime at,
    required String kind,
    String? tool,
    required String detail,
    String? output,
  }) : super._(
         id: id,
         taskId: taskId,
         run: run,
         at: at,
         kind: kind,
         tool: tool,
         detail: detail,
         output: output,
       );

  /// Returns a shallow copy of this [AgentStep]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentStep copyWith({
    Object? id = _Undefined,
    int? taskId,
    int? run,
    DateTime? at,
    String? kind,
    Object? tool = _Undefined,
    String? detail,
    Object? output = _Undefined,
  }) {
    return AgentStep(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      run: run ?? this.run,
      at: at ?? this.at,
      kind: kind ?? this.kind,
      tool: tool is String? ? tool : this.tool,
      detail: detail ?? this.detail,
      output: output is String? ? output : this.output,
    );
  }
}
