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

abstract class FeedIngest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedIngest._({
    required this.title,
    required this.feedSource,
    this.url,
    required this.timestamp,
    this.curriculumSubject,
    this.curriculumLevel,
  });

  factory FeedIngest({
    required String title,
    required String feedSource,
    String? url,
    required DateTime timestamp,
    String? curriculumSubject,
    String? curriculumLevel,
  }) = _FeedIngestImpl;

  factory FeedIngest.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedIngest(
      title: jsonSerialization['title'] as String,
      feedSource: jsonSerialization['feedSource'] as String,
      url: jsonSerialization['url'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      curriculumSubject: jsonSerialization['curriculumSubject'] as String?,
      curriculumLevel: jsonSerialization['curriculumLevel'] as String?,
    );
  }

  String title;

  String feedSource;

  String? url;

  DateTime timestamp;

  String? curriculumSubject;

  String? curriculumLevel;

  /// Returns a shallow copy of this [FeedIngest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedIngest copyWith({
    String? title,
    String? feedSource,
    String? url,
    DateTime? timestamp,
    String? curriculumSubject,
    String? curriculumLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedIngest',
      'title': title,
      'feedSource': feedSource,
      if (url != null) 'url': url,
      'timestamp': timestamp.toJson(),
      if (curriculumSubject != null) 'curriculumSubject': curriculumSubject,
      if (curriculumLevel != null) 'curriculumLevel': curriculumLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedIngest',
      'title': title,
      'feedSource': feedSource,
      if (url != null) 'url': url,
      'timestamp': timestamp.toJson(),
      if (curriculumSubject != null) 'curriculumSubject': curriculumSubject,
      if (curriculumLevel != null) 'curriculumLevel': curriculumLevel,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedIngestImpl extends FeedIngest {
  _FeedIngestImpl({
    required String title,
    required String feedSource,
    String? url,
    required DateTime timestamp,
    String? curriculumSubject,
    String? curriculumLevel,
  }) : super._(
         title: title,
         feedSource: feedSource,
         url: url,
         timestamp: timestamp,
         curriculumSubject: curriculumSubject,
         curriculumLevel: curriculumLevel,
       );

  /// Returns a shallow copy of this [FeedIngest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedIngest copyWith({
    String? title,
    String? feedSource,
    Object? url = _Undefined,
    DateTime? timestamp,
    Object? curriculumSubject = _Undefined,
    Object? curriculumLevel = _Undefined,
  }) {
    return FeedIngest(
      title: title ?? this.title,
      feedSource: feedSource ?? this.feedSource,
      url: url is String? ? url : this.url,
      timestamp: timestamp ?? this.timestamp,
      curriculumSubject: curriculumSubject is String?
          ? curriculumSubject
          : this.curriculumSubject,
      curriculumLevel: curriculumLevel is String?
          ? curriculumLevel
          : this.curriculumLevel,
    );
  }
}
