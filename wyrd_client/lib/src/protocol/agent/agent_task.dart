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

/// A goal WYRD works at on its own: researched step by step in the background, once or on a
/// schedule, pausing for the owner's approval before anything with consequences.
abstract class AgentTask
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentTask._({
    this.id,
    required this.authUserId,
    required this.goal,
    this.everyHours,
    required this.status,
    this.result,
    this.previousResult,
    this.notes,
    this.transcript,
    this.pendingAction,
    required this.stepsUsed,
    required this.maxSteps,
    required this.runs,
    required this.unread,
    required this.nextRunAt,
    this.lastRunAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgentTask({
    int? id,
    required _isc.UuidValue authUserId,
    required String goal,
    int? everyHours,
    required String status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    required int stepsUsed,
    required int maxSteps,
    required int runs,
    required bool unread,
    required DateTime nextRunAt,
    DateTime? lastRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AgentTaskImpl;

  factory AgentTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentTask(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      goal: jsonSerialization['goal'] as String,
      everyHours: jsonSerialization['everyHours'] as int?,
      status: jsonSerialization['status'] as String,
      result: jsonSerialization['result'] as String?,
      previousResult: jsonSerialization['previousResult'] as String?,
      notes: jsonSerialization['notes'] as String?,
      transcript: jsonSerialization['transcript'] as String?,
      pendingAction: jsonSerialization['pendingAction'] as String?,
      stepsUsed: jsonSerialization['stepsUsed'] as int,
      maxSteps: jsonSerialization['maxSteps'] as int,
      runs: jsonSerialization['runs'] as int,
      unread: _isc.BoolJsonExtension.fromJson(jsonSerialization['unread']),
      nextRunAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['nextRunAt'],
      ),
      lastRunAt: jsonSerialization['lastRunAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['lastRunAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String goal;

  int? everyHours;

  String status;

  String? result;

  String? previousResult;

  String? notes;

  String? transcript;

  String? pendingAction;

  int stepsUsed;

  int maxSteps;

  int runs;

  bool unread;

  DateTime nextRunAt;

  DateTime? lastRunAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AgentTask]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentTask copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? goal,
    int? everyHours,
    String? status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    int? stepsUsed,
    int? maxSteps,
    int? runs,
    bool? unread,
    DateTime? nextRunAt,
    DateTime? lastRunAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentTask',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'goal': goal,
      if (everyHours != null) 'everyHours': everyHours,
      'status': status,
      if (result != null) 'result': result,
      if (previousResult != null) 'previousResult': previousResult,
      if (notes != null) 'notes': notes,
      if (transcript != null) 'transcript': transcript,
      if (pendingAction != null) 'pendingAction': pendingAction,
      'stepsUsed': stepsUsed,
      'maxSteps': maxSteps,
      'runs': runs,
      'unread': unread,
      'nextRunAt': nextRunAt.toJson(),
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentTask',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'goal': goal,
      if (everyHours != null) 'everyHours': everyHours,
      'status': status,
      if (result != null) 'result': result,
      if (previousResult != null) 'previousResult': previousResult,
      if (notes != null) 'notes': notes,
      if (transcript != null) 'transcript': transcript,
      if (pendingAction != null) 'pendingAction': pendingAction,
      'stepsUsed': stepsUsed,
      'maxSteps': maxSteps,
      'runs': runs,
      'unread': unread,
      'nextRunAt': nextRunAt.toJson(),
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentTaskImpl extends AgentTask {
  _AgentTaskImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String goal,
    int? everyHours,
    required String status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    required int stepsUsed,
    required int maxSteps,
    required int runs,
    required bool unread,
    required DateTime nextRunAt,
    DateTime? lastRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         goal: goal,
         everyHours: everyHours,
         status: status,
         result: result,
         previousResult: previousResult,
         notes: notes,
         transcript: transcript,
         pendingAction: pendingAction,
         stepsUsed: stepsUsed,
         maxSteps: maxSteps,
         runs: runs,
         unread: unread,
         nextRunAt: nextRunAt,
         lastRunAt: lastRunAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AgentTask]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentTask copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? goal,
    Object? everyHours = _Undefined,
    String? status,
    Object? result = _Undefined,
    Object? previousResult = _Undefined,
    Object? notes = _Undefined,
    Object? transcript = _Undefined,
    Object? pendingAction = _Undefined,
    int? stepsUsed,
    int? maxSteps,
    int? runs,
    bool? unread,
    DateTime? nextRunAt,
    Object? lastRunAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AgentTask(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      goal: goal ?? this.goal,
      everyHours: everyHours is int? ? everyHours : this.everyHours,
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      previousResult: previousResult is String?
          ? previousResult
          : this.previousResult,
      notes: notes is String? ? notes : this.notes,
      transcript: transcript is String? ? transcript : this.transcript,
      pendingAction: pendingAction is String?
          ? pendingAction
          : this.pendingAction,
      stepsUsed: stepsUsed ?? this.stepsUsed,
      maxSteps: maxSteps ?? this.maxSteps,
      runs: runs ?? this.runs,
      unread: unread ?? this.unread,
      nextRunAt: nextRunAt ?? this.nextRunAt,
      lastRunAt: lastRunAt is DateTime? ? lastRunAt : this.lastRunAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
