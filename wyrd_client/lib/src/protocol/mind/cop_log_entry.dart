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

abstract class CopLogEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CopLogEntry._({
    this.id,
    required this.timestamp,
    required this.kind,
    required this.configKey,
    required this.oldValueJson,
    required this.newValueJson,
    required this.reason,
    required this.verdict,
  });

  factory CopLogEntry({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String configKey,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
    required String verdict,
  }) = _CopLogEntryImpl;

  factory CopLogEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return CopLogEntry(
      id: jsonSerialization['id'] as int?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      kind: jsonSerialization['kind'] as String,
      configKey: jsonSerialization['configKey'] as String,
      oldValueJson: jsonSerialization['oldValueJson'] as String,
      newValueJson: jsonSerialization['newValueJson'] as String,
      reason: jsonSerialization['reason'] as String,
      verdict: jsonSerialization['verdict'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime timestamp;

  String kind;

  String configKey;

  String oldValueJson;

  String newValueJson;

  String reason;

  String verdict;

  /// Returns a shallow copy of this [CopLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CopLogEntry copyWith({
    int? id,
    DateTime? timestamp,
    String? kind,
    String? configKey,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? verdict,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CopLogEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'configKey': configKey,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
      'verdict': verdict,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CopLogEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'configKey': configKey,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
      'verdict': verdict,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CopLogEntryImpl extends CopLogEntry {
  _CopLogEntryImpl({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String configKey,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
    required String verdict,
  }) : super._(
         id: id,
         timestamp: timestamp,
         kind: kind,
         configKey: configKey,
         oldValueJson: oldValueJson,
         newValueJson: newValueJson,
         reason: reason,
         verdict: verdict,
       );

  /// Returns a shallow copy of this [CopLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CopLogEntry copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? kind,
    String? configKey,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? verdict,
  }) {
    return CopLogEntry(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      kind: kind ?? this.kind,
      configKey: configKey ?? this.configKey,
      oldValueJson: oldValueJson ?? this.oldValueJson,
      newValueJson: newValueJson ?? this.newValueJson,
      reason: reason ?? this.reason,
      verdict: verdict ?? this.verdict,
    );
  }
}
