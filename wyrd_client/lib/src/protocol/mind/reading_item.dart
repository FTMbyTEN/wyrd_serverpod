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

abstract class ReadingItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReadingItem._({
    this.id,
    required this.authUserId,
    required this.url,
    required this.title,
    required this.kind,
    this.nextOffset,
    this.lastOffset,
    required this.total,
    this.source,
    this.author,
    this.partIndex,
    this.partCount,
    this.partTitle,
    this.partUrl,
    required this.startedAt,
    required this.updatedAt,
  });

  factory ReadingItem({
    int? id,
    required _isc.UuidValue authUserId,
    required String url,
    required String title,
    required String kind,
    int? nextOffset,
    int? lastOffset,
    required int total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    required DateTime startedAt,
    required DateTime updatedAt,
  }) = _ReadingItemImpl;

  factory ReadingItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingItem(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      url: jsonSerialization['url'] as String,
      title: jsonSerialization['title'] as String,
      kind: jsonSerialization['kind'] as String,
      nextOffset: jsonSerialization['nextOffset'] as int?,
      lastOffset: jsonSerialization['lastOffset'] as int?,
      total: jsonSerialization['total'] as int,
      source: jsonSerialization['source'] as String?,
      author: jsonSerialization['author'] as String?,
      partIndex: jsonSerialization['partIndex'] as int?,
      partCount: jsonSerialization['partCount'] as int?,
      partTitle: jsonSerialization['partTitle'] as String?,
      partUrl: jsonSerialization['partUrl'] as String?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
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

  String url;

  String title;

  String kind;

  int? nextOffset;

  int? lastOffset;

  int total;

  String? source;

  String? author;

  int? partIndex;

  int? partCount;

  String? partTitle;

  String? partUrl;

  DateTime startedAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ReadingItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReadingItem copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? url,
    String? title,
    String? kind,
    int? nextOffset,
    int? lastOffset,
    int? total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    DateTime? startedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingItem',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'url': url,
      'title': title,
      'kind': kind,
      if (nextOffset != null) 'nextOffset': nextOffset,
      if (lastOffset != null) 'lastOffset': lastOffset,
      'total': total,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (partIndex != null) 'partIndex': partIndex,
      if (partCount != null) 'partCount': partCount,
      if (partTitle != null) 'partTitle': partTitle,
      if (partUrl != null) 'partUrl': partUrl,
      'startedAt': startedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingItem',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'url': url,
      'title': title,
      'kind': kind,
      if (nextOffset != null) 'nextOffset': nextOffset,
      if (lastOffset != null) 'lastOffset': lastOffset,
      'total': total,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (partIndex != null) 'partIndex': partIndex,
      if (partCount != null) 'partCount': partCount,
      if (partTitle != null) 'partTitle': partTitle,
      if (partUrl != null) 'partUrl': partUrl,
      'startedAt': startedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReadingItemImpl extends ReadingItem {
  _ReadingItemImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String url,
    required String title,
    required String kind,
    int? nextOffset,
    int? lastOffset,
    required int total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    required DateTime startedAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         url: url,
         title: title,
         kind: kind,
         nextOffset: nextOffset,
         lastOffset: lastOffset,
         total: total,
         source: source,
         author: author,
         partIndex: partIndex,
         partCount: partCount,
         partTitle: partTitle,
         partUrl: partUrl,
         startedAt: startedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReadingItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReadingItem copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? url,
    String? title,
    String? kind,
    Object? nextOffset = _Undefined,
    Object? lastOffset = _Undefined,
    int? total,
    Object? source = _Undefined,
    Object? author = _Undefined,
    Object? partIndex = _Undefined,
    Object? partCount = _Undefined,
    Object? partTitle = _Undefined,
    Object? partUrl = _Undefined,
    DateTime? startedAt,
    DateTime? updatedAt,
  }) {
    return ReadingItem(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      url: url ?? this.url,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      nextOffset: nextOffset is int? ? nextOffset : this.nextOffset,
      lastOffset: lastOffset is int? ? lastOffset : this.lastOffset,
      total: total ?? this.total,
      source: source is String? ? source : this.source,
      author: author is String? ? author : this.author,
      partIndex: partIndex is int? ? partIndex : this.partIndex,
      partCount: partCount is int? ? partCount : this.partCount,
      partTitle: partTitle is String? ? partTitle : this.partTitle,
      partUrl: partUrl is String? ? partUrl : this.partUrl,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
