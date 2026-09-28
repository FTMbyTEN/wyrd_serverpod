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

abstract class WorkPartInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorkPartInfo._({
    required this.index,
    required this.title,
    required this.url,
  });

  factory WorkPartInfo({
    required int index,
    required String title,
    required String url,
  }) = _WorkPartInfoImpl;

  factory WorkPartInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkPartInfo(
      index: jsonSerialization['index'] as int,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String,
    );
  }

  int index;

  String title;

  String url;

  /// Returns a shallow copy of this [WorkPartInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorkPartInfo copyWith({
    int? index,
    String? title,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkPartInfo',
      'index': index,
      'title': title,
      'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkPartInfo',
      'index': index,
      'title': title,
      'url': url,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _WorkPartInfoImpl extends WorkPartInfo {
  _WorkPartInfoImpl({
    required int index,
    required String title,
    required String url,
  }) : super._(
         index: index,
         title: title,
         url: url,
       );

  /// Returns a shallow copy of this [WorkPartInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorkPartInfo copyWith({
    int? index,
    String? title,
    String? url,
  }) {
    return WorkPartInfo(
      index: index ?? this.index,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}
