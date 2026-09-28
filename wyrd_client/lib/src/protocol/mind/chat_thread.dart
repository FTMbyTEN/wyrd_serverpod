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

abstract class ChatThread
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatThread._({
    this.id,
    required this.authUserId,
    required this.subject,
    this.lastReadUrl,
    this.lastReadTitle,
    this.lastReadItemId,
    this.lastPassage,
    this.nextOffset,
    required this.updatedAt,
  });

  factory ChatThread({
    int? id,
    required _isc.UuidValue authUserId,
    required List<String> subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    required DateTime updatedAt,
  }) = _ChatThreadImpl;

  factory ChatThread.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatThread(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      subject: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['subject'],
      ),
      lastReadUrl: jsonSerialization['lastReadUrl'] as String?,
      lastReadTitle: jsonSerialization['lastReadTitle'] as String?,
      lastReadItemId: jsonSerialization['lastReadItemId'] as int?,
      lastPassage: jsonSerialization['lastPassage'] as String?,
      nextOffset: jsonSerialization['nextOffset'] as int?,
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

  List<String> subject;

  String? lastReadUrl;

  String? lastReadTitle;

  int? lastReadItemId;

  String? lastPassage;

  int? nextOffset;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ChatThread]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatThread copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    List<String>? subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatThread',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'subject': subject.toJson(),
      if (lastReadUrl != null) 'lastReadUrl': lastReadUrl,
      if (lastReadTitle != null) 'lastReadTitle': lastReadTitle,
      if (lastReadItemId != null) 'lastReadItemId': lastReadItemId,
      if (lastPassage != null) 'lastPassage': lastPassage,
      if (nextOffset != null) 'nextOffset': nextOffset,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatThread',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'subject': subject.toJson(),
      if (lastReadUrl != null) 'lastReadUrl': lastReadUrl,
      if (lastReadTitle != null) 'lastReadTitle': lastReadTitle,
      if (lastReadItemId != null) 'lastReadItemId': lastReadItemId,
      if (lastPassage != null) 'lastPassage': lastPassage,
      if (nextOffset != null) 'nextOffset': nextOffset,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatThreadImpl extends ChatThread {
  _ChatThreadImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required List<String> subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         subject: subject,
         lastReadUrl: lastReadUrl,
         lastReadTitle: lastReadTitle,
         lastReadItemId: lastReadItemId,
         lastPassage: lastPassage,
         nextOffset: nextOffset,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChatThread]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatThread copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    List<String>? subject,
    Object? lastReadUrl = _Undefined,
    Object? lastReadTitle = _Undefined,
    Object? lastReadItemId = _Undefined,
    Object? lastPassage = _Undefined,
    Object? nextOffset = _Undefined,
    DateTime? updatedAt,
  }) {
    return ChatThread(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      subject: subject ?? this.subject.map((e0) => e0).toList(),
      lastReadUrl: lastReadUrl is String? ? lastReadUrl : this.lastReadUrl,
      lastReadTitle: lastReadTitle is String?
          ? lastReadTitle
          : this.lastReadTitle,
      lastReadItemId: lastReadItemId is int?
          ? lastReadItemId
          : this.lastReadItemId,
      lastPassage: lastPassage is String? ? lastPassage : this.lastPassage,
      nextOffset: nextOffset is int? ? nextOffset : this.nextOffset,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
