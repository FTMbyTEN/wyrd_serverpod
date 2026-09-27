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

abstract class ConceptExample
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConceptExample._({
    required this.source,
    required this.title,
    this.snippet,
    this.url,
    required this.timestamp,
  });

  factory ConceptExample({
    required String source,
    required String title,
    String? snippet,
    String? url,
    required DateTime timestamp,
  }) = _ConceptExampleImpl;

  factory ConceptExample.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConceptExample(
      source: jsonSerialization['source'] as String,
      title: jsonSerialization['title'] as String,
      snippet: jsonSerialization['snippet'] as String?,
      url: jsonSerialization['url'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  String source;

  String title;

  String? snippet;

  String? url;

  DateTime timestamp;

  /// Returns a shallow copy of this [ConceptExample]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConceptExample copyWith({
    String? source,
    String? title,
    String? snippet,
    String? url,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConceptExample',
      'source': source,
      'title': title,
      if (snippet != null) 'snippet': snippet,
      if (url != null) 'url': url,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConceptExample',
      'source': source,
      'title': title,
      if (snippet != null) 'snippet': snippet,
      if (url != null) 'url': url,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConceptExampleImpl extends ConceptExample {
  _ConceptExampleImpl({
    required String source,
    required String title,
    String? snippet,
    String? url,
    required DateTime timestamp,
  }) : super._(
         source: source,
         title: title,
         snippet: snippet,
         url: url,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [ConceptExample]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConceptExample copyWith({
    String? source,
    String? title,
    Object? snippet = _Undefined,
    Object? url = _Undefined,
    DateTime? timestamp,
  }) {
    return ConceptExample(
      source: source ?? this.source,
      title: title ?? this.title,
      snippet: snippet is String? ? snippet : this.snippet,
      url: url is String? ? url : this.url,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
