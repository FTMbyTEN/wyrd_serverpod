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

abstract class ReasoningNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReasoningNote._({
    this.id,
    required this.timestamp,
    required this.kind,
    required this.content,
  });

  factory ReasoningNote({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String content,
  }) = _ReasoningNoteImpl;

  factory ReasoningNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReasoningNote(
      id: jsonSerialization['id'] as int?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      kind: jsonSerialization['kind'] as String,
      content: jsonSerialization['content'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime timestamp;

  String kind;

  String content;

  /// Returns a shallow copy of this [ReasoningNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReasoningNote copyWith({
    int? id,
    DateTime? timestamp,
    String? kind,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReasoningNote',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'content': content,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReasoningNote',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'content': content,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReasoningNoteImpl extends ReasoningNote {
  _ReasoningNoteImpl({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String content,
  }) : super._(
         id: id,
         timestamp: timestamp,
         kind: kind,
         content: content,
       );

  /// Returns a shallow copy of this [ReasoningNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReasoningNote copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? kind,
    String? content,
  }) {
    return ReasoningNote(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      kind: kind ?? this.kind,
      content: content ?? this.content,
    );
  }
}
