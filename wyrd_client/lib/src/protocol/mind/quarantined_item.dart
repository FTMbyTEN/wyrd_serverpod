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

abstract class QuarantinedItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuarantinedItem._({
    this.id,
    required this.timestamp,
    required this.source,
    required this.title,
    this.url,
    this.extract,
    required this.score,
    required this.reasons,
  });

  factory QuarantinedItem({
    int? id,
    required DateTime timestamp,
    required String source,
    required String title,
    String? url,
    String? extract,
    required double score,
    required List<String> reasons,
  }) = _QuarantinedItemImpl;

  factory QuarantinedItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuarantinedItem(
      id: jsonSerialization['id'] as int?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      source: jsonSerialization['source'] as String,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String?,
      extract: jsonSerialization['extract'] as String?,
      score: (jsonSerialization['score'] as num).toDouble(),
      reasons: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['reasons'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime timestamp;

  String source;

  String title;

  String? url;

  String? extract;

  double score;

  List<String> reasons;

  /// Returns a shallow copy of this [QuarantinedItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuarantinedItem copyWith({
    int? id,
    DateTime? timestamp,
    String? source,
    String? title,
    String? url,
    String? extract,
    double? score,
    List<String>? reasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuarantinedItem',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'source': source,
      'title': title,
      if (url != null) 'url': url,
      if (extract != null) 'extract': extract,
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuarantinedItem',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'source': source,
      'title': title,
      if (url != null) 'url': url,
      if (extract != null) 'extract': extract,
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuarantinedItemImpl extends QuarantinedItem {
  _QuarantinedItemImpl({
    int? id,
    required DateTime timestamp,
    required String source,
    required String title,
    String? url,
    String? extract,
    required double score,
    required List<String> reasons,
  }) : super._(
         id: id,
         timestamp: timestamp,
         source: source,
         title: title,
         url: url,
         extract: extract,
         score: score,
         reasons: reasons,
       );

  /// Returns a shallow copy of this [QuarantinedItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuarantinedItem copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? source,
    String? title,
    Object? url = _Undefined,
    Object? extract = _Undefined,
    double? score,
    List<String>? reasons,
  }) {
    return QuarantinedItem(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      title: title ?? this.title,
      url: url is String? ? url : this.url,
      extract: extract is String? ? extract : this.extract,
      score: score ?? this.score,
      reasons: reasons ?? this.reasons.map((e0) => e0).toList(),
    );
  }
}
