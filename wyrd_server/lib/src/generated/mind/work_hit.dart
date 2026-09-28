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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;

abstract class WorkHit
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WorkHit._({
    required this.id,
    required this.source,
    required this.title,
    this.author,
    required this.subjects,
    this.coverUrl,
    this.language,
    this.blurb,
  });

  factory WorkHit({
    required String id,
    required String source,
    required String title,
    String? author,
    required List<String> subjects,
    String? coverUrl,
    String? language,
    String? blurb,
  }) = _WorkHitImpl;

  factory WorkHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkHit(
      id: jsonSerialization['id'] as String,
      source: jsonSerialization['source'] as String,
      title: jsonSerialization['title'] as String,
      author: jsonSerialization['author'] as String?,
      subjects: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['subjects'],
      ),
      coverUrl: jsonSerialization['coverUrl'] as String?,
      language: jsonSerialization['language'] as String?,
      blurb: jsonSerialization['blurb'] as String?,
    );
  }

  String source;

  String id;

  String title;

  String? author;

  List<String> subjects;

  String? coverUrl;

  String? language;

  String? blurb;

  /// Returns a shallow copy of this [WorkHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkHit copyWith({
    String? id,
    String? source,
    String? title,
    String? author,
    List<String>? subjects,
    String? coverUrl,
    String? language,
    String? blurb,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkHit',
      'id': id,
      'source': source,
      'title': title,
      if (author != null) 'author': author,
      'subjects': subjects.toJson(),
      if (coverUrl != null) 'coverUrl': coverUrl,
      if (language != null) 'language': language,
      if (blurb != null) 'blurb': blurb,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkHit',
      'id': id,
      'source': source,
      'title': title,
      if (author != null) 'author': author,
      'subjects': subjects.toJson(),
      if (coverUrl != null) 'coverUrl': coverUrl,
      if (language != null) 'language': language,
      if (blurb != null) 'blurb': blurb,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkHitImpl extends WorkHit {
  _WorkHitImpl({
    required String id,
    required String source,
    required String title,
    String? author,
    required List<String> subjects,
    String? coverUrl,
    String? language,
    String? blurb,
  }) : super._(
         id: id,
         source: source,
         title: title,
         author: author,
         subjects: subjects,
         coverUrl: coverUrl,
         language: language,
         blurb: blurb,
       );

  /// Returns a shallow copy of this [WorkHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkHit copyWith({
    String? id,
    String? source,
    String? title,
    Object? author = _Undefined,
    List<String>? subjects,
    Object? coverUrl = _Undefined,
    Object? language = _Undefined,
    Object? blurb = _Undefined,
  }) {
    return WorkHit(
      id: id ?? this.id,
      source: source ?? this.source,
      title: title ?? this.title,
      author: author is String? ? author : this.author,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      language: language is String? ? language : this.language,
      blurb: blurb is String? ? blurb : this.blurb,
    );
  }
}
