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

abstract class UserDocument
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserDocument._({
    this.id,
    required this.authUserId,
    required this.name,
    required this.kind,
    required this.text,
    required this.chars,
    required this.words,
    this.pages,
    required this.createdAt,
  });

  factory UserDocument({
    int? id,
    required _isc.UuidValue authUserId,
    required String name,
    required String kind,
    required String text,
    required int chars,
    required int words,
    int? pages,
    required DateTime createdAt,
  }) = _UserDocumentImpl;

  factory UserDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserDocument(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      name: jsonSerialization['name'] as String,
      kind: jsonSerialization['kind'] as String,
      text: jsonSerialization['text'] as String,
      chars: jsonSerialization['chars'] as int,
      words: jsonSerialization['words'] as int,
      pages: jsonSerialization['pages'] as int?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String name;

  String kind;

  String text;

  int chars;

  int words;

  int? pages;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserDocument]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserDocument copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? name,
    String? kind,
    String? text,
    int? chars,
    int? words,
    int? pages,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserDocument',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'name': name,
      'kind': kind,
      'text': text,
      'chars': chars,
      'words': words,
      if (pages != null) 'pages': pages,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserDocument',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'name': name,
      'kind': kind,
      'text': text,
      'chars': chars,
      'words': words,
      if (pages != null) 'pages': pages,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDocumentImpl extends UserDocument {
  _UserDocumentImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String name,
    required String kind,
    required String text,
    required int chars,
    required int words,
    int? pages,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         name: name,
         kind: kind,
         text: text,
         chars: chars,
         words: words,
         pages: pages,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserDocument]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserDocument copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? name,
    String? kind,
    String? text,
    int? chars,
    int? words,
    Object? pages = _Undefined,
    DateTime? createdAt,
  }) {
    return UserDocument(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      text: text ?? this.text,
      chars: chars ?? this.chars,
      words: words ?? this.words,
      pages: pages is int? ? pages : this.pages,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
