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

abstract class MindTopic
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MindTopic._({
    this.id,
    required this.topic,
    required this.resolved,
  });

  factory MindTopic({
    int? id,
    required String topic,
    required bool resolved,
  }) = _MindTopicImpl;

  factory MindTopic.fromJson(Map<String, dynamic> jsonSerialization) {
    return MindTopic(
      id: jsonSerialization['id'] as int?,
      topic: jsonSerialization['topic'] as String,
      resolved: _isc.BoolJsonExtension.fromJson(jsonSerialization['resolved']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String topic;

  bool resolved;

  /// Returns a shallow copy of this [MindTopic]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MindTopic copyWith({
    int? id,
    String? topic,
    bool? resolved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MindTopic',
      if (id != null) 'id': id,
      'topic': topic,
      'resolved': resolved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MindTopic',
      if (id != null) 'id': id,
      'topic': topic,
      'resolved': resolved,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MindTopicImpl extends MindTopic {
  _MindTopicImpl({
    int? id,
    required String topic,
    required bool resolved,
  }) : super._(
         id: id,
         topic: topic,
         resolved: resolved,
       );

  /// Returns a shallow copy of this [MindTopic]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MindTopic copyWith({
    Object? id = _Undefined,
    String? topic,
    bool? resolved,
  }) {
    return MindTopic(
      id: id is int? ? id : this.id,
      topic: topic ?? this.topic,
      resolved: resolved ?? this.resolved,
    );
  }
}
