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

abstract class MemoryBlock
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemoryBlock._({
    this.id,
    this.legacyId,
    required this.timestamp,
    required this.source,
    this.feedSource,
    this.title,
    this.extract,
    this.url,
    this.userText,
    this.botText,
    this.triggeredBy,
    required this.topics,
    this.curriculum,
  });

  factory MemoryBlock({
    int? id,
    String? legacyId,
    required DateTime timestamp,
    required String source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    required List<String> topics,
    String? curriculum,
  }) = _MemoryBlockImpl;

  factory MemoryBlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemoryBlock(
      id: jsonSerialization['id'] as int?,
      legacyId: jsonSerialization['legacyId'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      source: jsonSerialization['source'] as String,
      feedSource: jsonSerialization['feedSource'] as String?,
      title: jsonSerialization['title'] as String?,
      extract: jsonSerialization['extract'] as String?,
      url: jsonSerialization['url'] as String?,
      userText: jsonSerialization['userText'] as String?,
      botText: jsonSerialization['botText'] as String?,
      triggeredBy: jsonSerialization['triggeredBy'] as String?,
      topics: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      curriculum: jsonSerialization['curriculum'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? legacyId;

  DateTime timestamp;

  String source;

  String? feedSource;

  String? title;

  String? extract;

  String? url;

  String? userText;

  String? botText;

  String? triggeredBy;

  List<String> topics;

  String? curriculum;

  /// Returns a shallow copy of this [MemoryBlock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemoryBlock copyWith({
    int? id,
    String? legacyId,
    DateTime? timestamp,
    String? source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    List<String>? topics,
    String? curriculum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemoryBlock',
      if (id != null) 'id': id,
      if (legacyId != null) 'legacyId': legacyId,
      'timestamp': timestamp.toJson(),
      'source': source,
      if (feedSource != null) 'feedSource': feedSource,
      if (title != null) 'title': title,
      if (extract != null) 'extract': extract,
      if (url != null) 'url': url,
      if (userText != null) 'userText': userText,
      if (botText != null) 'botText': botText,
      if (triggeredBy != null) 'triggeredBy': triggeredBy,
      'topics': topics.toJson(),
      if (curriculum != null) 'curriculum': curriculum,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemoryBlock',
      if (id != null) 'id': id,
      if (legacyId != null) 'legacyId': legacyId,
      'timestamp': timestamp.toJson(),
      'source': source,
      if (feedSource != null) 'feedSource': feedSource,
      if (title != null) 'title': title,
      if (extract != null) 'extract': extract,
      if (url != null) 'url': url,
      if (userText != null) 'userText': userText,
      if (botText != null) 'botText': botText,
      if (triggeredBy != null) 'triggeredBy': triggeredBy,
      'topics': topics.toJson(),
      if (curriculum != null) 'curriculum': curriculum,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryBlockImpl extends MemoryBlock {
  _MemoryBlockImpl({
    int? id,
    String? legacyId,
    required DateTime timestamp,
    required String source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    required List<String> topics,
    String? curriculum,
  }) : super._(
         id: id,
         legacyId: legacyId,
         timestamp: timestamp,
         source: source,
         feedSource: feedSource,
         title: title,
         extract: extract,
         url: url,
         userText: userText,
         botText: botText,
         triggeredBy: triggeredBy,
         topics: topics,
         curriculum: curriculum,
       );

  /// Returns a shallow copy of this [MemoryBlock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemoryBlock copyWith({
    Object? id = _Undefined,
    Object? legacyId = _Undefined,
    DateTime? timestamp,
    String? source,
    Object? feedSource = _Undefined,
    Object? title = _Undefined,
    Object? extract = _Undefined,
    Object? url = _Undefined,
    Object? userText = _Undefined,
    Object? botText = _Undefined,
    Object? triggeredBy = _Undefined,
    List<String>? topics,
    Object? curriculum = _Undefined,
  }) {
    return MemoryBlock(
      id: id is int? ? id : this.id,
      legacyId: legacyId is String? ? legacyId : this.legacyId,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      feedSource: feedSource is String? ? feedSource : this.feedSource,
      title: title is String? ? title : this.title,
      extract: extract is String? ? extract : this.extract,
      url: url is String? ? url : this.url,
      userText: userText is String? ? userText : this.userText,
      botText: botText is String? ? botText : this.botText,
      triggeredBy: triggeredBy is String? ? triggeredBy : this.triggeredBy,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      curriculum: curriculum is String? ? curriculum : this.curriculum,
    );
  }
}
