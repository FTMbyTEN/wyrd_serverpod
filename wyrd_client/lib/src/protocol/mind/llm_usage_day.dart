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

abstract class LlmUsageDay
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LlmUsageDay._({
    this.id,
    required this.day,
    required this.costMicroUsd,
    required this.calls,
  });

  factory LlmUsageDay({
    int? id,
    required String day,
    required int costMicroUsd,
    required int calls,
  }) = _LlmUsageDayImpl;

  factory LlmUsageDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return LlmUsageDay(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
      calls: jsonSerialization['calls'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String day;

  int costMicroUsd;

  int calls;

  /// Returns a shallow copy of this [LlmUsageDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LlmUsageDay copyWith({
    int? id,
    String? day,
    int? costMicroUsd,
    int? calls,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LlmUsageDay',
      if (id != null) 'id': id,
      'day': day,
      'costMicroUsd': costMicroUsd,
      'calls': calls,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LlmUsageDay',
      if (id != null) 'id': id,
      'day': day,
      'costMicroUsd': costMicroUsd,
      'calls': calls,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LlmUsageDayImpl extends LlmUsageDay {
  _LlmUsageDayImpl({
    int? id,
    required String day,
    required int costMicroUsd,
    required int calls,
  }) : super._(
         id: id,
         day: day,
         costMicroUsd: costMicroUsd,
         calls: calls,
       );

  /// Returns a shallow copy of this [LlmUsageDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LlmUsageDay copyWith({
    Object? id = _Undefined,
    String? day,
    int? costMicroUsd,
    int? calls,
  }) {
    return LlmUsageDay(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
      calls: calls ?? this.calls,
    );
  }
}
