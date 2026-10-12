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

abstract class Chat
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Chat._({
    this.id,
    required this.authUserId,
    this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat({
    int? id,
    required _isc.UuidValue authUserId,
    String? title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatImpl;

  factory Chat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chat(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
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

  /// from the first message, once there is one
  String? title;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Chat copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (title != null) 'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (title != null) 'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required _isc.UuidValue authUserId,
    String? title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         title: title,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Chat copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? title = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      title: title is String? ? title : this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
