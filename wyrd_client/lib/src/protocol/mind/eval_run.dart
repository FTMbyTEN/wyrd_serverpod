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

abstract class EvalRun
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EvalRun._({
    this.id,
    required this.startedAt,
    required this.model,
    required this.passed,
    required this.total,
    required this.costMicroUsd,
    required this.ms,
    required this.results,
  });

  factory EvalRun({
    int? id,
    required DateTime startedAt,
    required String model,
    required int passed,
    required int total,
    required int costMicroUsd,
    required int ms,
    required String results,
  }) = _EvalRunImpl;

  factory EvalRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvalRun(
      id: jsonSerialization['id'] as int?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      model: jsonSerialization['model'] as String,
      passed: jsonSerialization['passed'] as int,
      total: jsonSerialization['total'] as int,
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
      ms: jsonSerialization['ms'] as int,
      results: jsonSerialization['results'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime startedAt;

  String model;

  int passed;

  int total;

  int costMicroUsd;

  int ms;

  String results;

  /// Returns a shallow copy of this [EvalRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EvalRun copyWith({
    int? id,
    DateTime? startedAt,
    String? model,
    int? passed,
    int? total,
    int? costMicroUsd,
    int? ms,
    String? results,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvalRun',
      if (id != null) 'id': id,
      'startedAt': startedAt.toJson(),
      'model': model,
      'passed': passed,
      'total': total,
      'costMicroUsd': costMicroUsd,
      'ms': ms,
      'results': results,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvalRun',
      if (id != null) 'id': id,
      'startedAt': startedAt.toJson(),
      'model': model,
      'passed': passed,
      'total': total,
      'costMicroUsd': costMicroUsd,
      'ms': ms,
      'results': results,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvalRunImpl extends EvalRun {
  _EvalRunImpl({
    int? id,
    required DateTime startedAt,
    required String model,
    required int passed,
    required int total,
    required int costMicroUsd,
    required int ms,
    required String results,
  }) : super._(
         id: id,
         startedAt: startedAt,
         model: model,
         passed: passed,
         total: total,
         costMicroUsd: costMicroUsd,
         ms: ms,
         results: results,
       );

  /// Returns a shallow copy of this [EvalRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EvalRun copyWith({
    Object? id = _Undefined,
    DateTime? startedAt,
    String? model,
    int? passed,
    int? total,
    int? costMicroUsd,
    int? ms,
    String? results,
  }) {
    return EvalRun(
      id: id is int? ? id : this.id,
      startedAt: startedAt ?? this.startedAt,
      model: model ?? this.model,
      passed: passed ?? this.passed,
      total: total ?? this.total,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
      ms: ms ?? this.ms,
      results: results ?? this.results,
    );
  }
}
