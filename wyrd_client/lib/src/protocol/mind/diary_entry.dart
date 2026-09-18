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

abstract class DiaryEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiaryEntry._({
    this.id,
    required this.date,
    required this.timestamp,
    required this.content,
  });

  factory DiaryEntry({
    int? id,
    required String date,
    required DateTime timestamp,
    required String content,
  }) = _DiaryEntryImpl;

  factory DiaryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiaryEntry(
      id: jsonSerialization['id'] as int?,
      date: jsonSerialization['date'] as String,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      content: jsonSerialization['content'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String date;

  DateTime timestamp;

  String content;

  /// Returns a shallow copy of this [DiaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiaryEntry copyWith({
    int? id,
    String? date,
    DateTime? timestamp,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiaryEntry',
      if (id != null) 'id': id,
      'date': date,
      'timestamp': timestamp.toJson(),
      'content': content,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiaryEntry',
      if (id != null) 'id': id,
      'date': date,
      'timestamp': timestamp.toJson(),
      'content': content,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiaryEntryImpl extends DiaryEntry {
  _DiaryEntryImpl({
    int? id,
    required String date,
    required DateTime timestamp,
    required String content,
  }) : super._(
         id: id,
         date: date,
         timestamp: timestamp,
         content: content,
       );

  /// Returns a shallow copy of this [DiaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiaryEntry copyWith({
    Object? id = _Undefined,
    String? date,
    DateTime? timestamp,
    String? content,
  }) {
    return DiaryEntry(
      id: id is int? ? id : this.id,
      date: date ?? this.date,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
    );
  }
}
