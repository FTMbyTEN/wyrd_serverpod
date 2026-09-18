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

abstract class SelfConfigChange
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SelfConfigChange._({
    required this.timestamp,
    required this.key,
    required this.oldValueJson,
    required this.newValueJson,
    required this.reason,
  });

  factory SelfConfigChange({
    required DateTime timestamp,
    required String key,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
  }) = _SelfConfigChangeImpl;

  factory SelfConfigChange.fromJson(Map<String, dynamic> jsonSerialization) {
    return SelfConfigChange(
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      key: jsonSerialization['key'] as String,
      oldValueJson: jsonSerialization['oldValueJson'] as String,
      newValueJson: jsonSerialization['newValueJson'] as String,
      reason: jsonSerialization['reason'] as String,
    );
  }

  DateTime timestamp;

  String key;

  String oldValueJson;

  String newValueJson;

  String reason;

  /// Returns a shallow copy of this [SelfConfigChange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SelfConfigChange copyWith({
    DateTime? timestamp,
    String? key,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SelfConfigChange',
      'timestamp': timestamp.toJson(),
      'key': key,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SelfConfigChange',
      'timestamp': timestamp.toJson(),
      'key': key,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SelfConfigChangeImpl extends SelfConfigChange {
  _SelfConfigChangeImpl({
    required DateTime timestamp,
    required String key,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
  }) : super._(
         timestamp: timestamp,
         key: key,
         oldValueJson: oldValueJson,
         newValueJson: newValueJson,
         reason: reason,
       );

  /// Returns a shallow copy of this [SelfConfigChange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SelfConfigChange copyWith({
    DateTime? timestamp,
    String? key,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
  }) {
    return SelfConfigChange(
      timestamp: timestamp ?? this.timestamp,
      key: key ?? this.key,
      oldValueJson: oldValueJson ?? this.oldValueJson,
      newValueJson: newValueJson ?? this.newValueJson,
      reason: reason ?? this.reason,
    );
  }
}
