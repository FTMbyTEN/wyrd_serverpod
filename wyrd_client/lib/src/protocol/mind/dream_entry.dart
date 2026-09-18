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
import 'package:wyrd_client/src/protocol/protocol.dart' as _i2pladzn;

abstract class DreamEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DreamEntry._({
    this.id,
    required this.timestamp,
    required this.content,
    required this.sourceBlockIds,
  });

  factory DreamEntry({
    int? id,
    required DateTime timestamp,
    required String content,
    required List<int> sourceBlockIds,
  }) = _DreamEntryImpl;

  factory DreamEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return DreamEntry(
      id: jsonSerialization['id'] as int?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      content: jsonSerialization['content'] as String,
      sourceBlockIds: _i2pladzn.Protocol().deserialize<List<int>>(
        jsonSerialization['sourceBlockIds'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime timestamp;

  String content;

  List<int> sourceBlockIds;

  /// Returns a shallow copy of this [DreamEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DreamEntry copyWith({
    int? id,
    DateTime? timestamp,
    String? content,
    List<int>? sourceBlockIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DreamEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'content': content,
      'sourceBlockIds': sourceBlockIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DreamEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'content': content,
      'sourceBlockIds': sourceBlockIds.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DreamEntryImpl extends DreamEntry {
  _DreamEntryImpl({
    int? id,
    required DateTime timestamp,
    required String content,
    required List<int> sourceBlockIds,
  }) : super._(
         id: id,
         timestamp: timestamp,
         content: content,
         sourceBlockIds: sourceBlockIds,
       );

  /// Returns a shallow copy of this [DreamEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DreamEntry copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? content,
    List<int>? sourceBlockIds,
  }) {
    return DreamEntry(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
      sourceBlockIds:
          sourceBlockIds ?? this.sourceBlockIds.map((e0) => e0).toList(),
    );
  }
}
