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

/// One design proposal for the open world, from WYRD (or the owner) in the design studio. Approved
/// proposals of a live kind (mission, npc_lines, tuning, event) change the game at once; ideas and
/// rules are a backlog to build.
abstract class CityDesignNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CityDesignNote._({
    this.id,
    required this.author,
    required this.kind,
    required this.title,
    required this.body,
    this.payload,
    required this.status,
    required this.createdAt,
    this.decidedAt,
  });

  factory CityDesignNote({
    int? id,
    required String author,
    required String kind,
    required String title,
    required String body,
    String? payload,
    required String status,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _CityDesignNoteImpl;

  factory CityDesignNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityDesignNote(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as String,
      kind: jsonSerialization['kind'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      payload: jsonSerialization['payload'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 'wyrd' or 'owner'
  String author;

  /// idea | rule | mission | npc_lines | tuning | event
  String kind;

  String title;

  String body;

  /// for live kinds: the checked settings, as JSON
  String? payload;

  /// proposed | approved | rejected
  String status;

  DateTime createdAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [CityDesignNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CityDesignNote copyWith({
    int? id,
    String? author,
    String? kind,
    String? title,
    String? body,
    String? payload,
    String? status,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityDesignNote',
      if (id != null) 'id': id,
      'author': author,
      'kind': kind,
      'title': title,
      'body': body,
      if (payload != null) 'payload': payload,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CityDesignNote',
      if (id != null) 'id': id,
      'author': author,
      'kind': kind,
      'title': title,
      'body': body,
      if (payload != null) 'payload': payload,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityDesignNoteImpl extends CityDesignNote {
  _CityDesignNoteImpl({
    int? id,
    required String author,
    required String kind,
    required String title,
    required String body,
    String? payload,
    required String status,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         author: author,
         kind: kind,
         title: title,
         body: body,
         payload: payload,
         status: status,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [CityDesignNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CityDesignNote copyWith({
    Object? id = _Undefined,
    String? author,
    String? kind,
    String? title,
    String? body,
    Object? payload = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return CityDesignNote(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload is String? ? payload : this.payload,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
