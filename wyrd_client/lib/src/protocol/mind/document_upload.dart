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

abstract class DocumentUpload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DocumentUpload._({
    required this.id,
    required this.name,
    required this.kind,
    required this.words,
    this.pages,
    required this.reply,
    this.turnId,
  });

  factory DocumentUpload({
    required int id,
    required String name,
    required String kind,
    required int words,
    int? pages,
    required String reply,
    int? turnId,
  }) = _DocumentUploadImpl;

  factory DocumentUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentUpload(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      kind: jsonSerialization['kind'] as String,
      words: jsonSerialization['words'] as int,
      pages: jsonSerialization['pages'] as int?,
      reply: jsonSerialization['reply'] as String,
      turnId: jsonSerialization['turnId'] as int?,
    );
  }

  int id;

  String name;

  String kind;

  int words;

  int? pages;

  String reply;

  int? turnId;

  /// Returns a shallow copy of this [DocumentUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DocumentUpload copyWith({
    int? id,
    String? name,
    String? kind,
    int? words,
    int? pages,
    String? reply,
    int? turnId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DocumentUpload',
      'id': id,
      'name': name,
      'kind': kind,
      'words': words,
      if (pages != null) 'pages': pages,
      'reply': reply,
      if (turnId != null) 'turnId': turnId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DocumentUpload',
      'id': id,
      'name': name,
      'kind': kind,
      'words': words,
      if (pages != null) 'pages': pages,
      'reply': reply,
      if (turnId != null) 'turnId': turnId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentUploadImpl extends DocumentUpload {
  _DocumentUploadImpl({
    required int id,
    required String name,
    required String kind,
    required int words,
    int? pages,
    required String reply,
    int? turnId,
  }) : super._(
         id: id,
         name: name,
         kind: kind,
         words: words,
         pages: pages,
         reply: reply,
         turnId: turnId,
       );

  /// Returns a shallow copy of this [DocumentUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DocumentUpload copyWith({
    int? id,
    String? name,
    String? kind,
    int? words,
    Object? pages = _Undefined,
    String? reply,
    Object? turnId = _Undefined,
  }) {
    return DocumentUpload(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      words: words ?? this.words,
      pages: pages is int? ? pages : this.pages,
      reply: reply ?? this.reply,
      turnId: turnId is int? ? turnId : this.turnId,
    );
  }
}
