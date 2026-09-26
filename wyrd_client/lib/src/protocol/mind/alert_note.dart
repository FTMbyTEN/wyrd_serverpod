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

abstract class AlertNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AlertNote._({
    required this.tag,
    required this.ago,
    required this.body,
  });

  factory AlertNote({
    required String tag,
    required String ago,
    required String body,
  }) = _AlertNoteImpl;

  factory AlertNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return AlertNote(
      tag: jsonSerialization['tag'] as String,
      ago: jsonSerialization['ago'] as String,
      body: jsonSerialization['body'] as String,
    );
  }

  String tag;

  String ago;

  String body;

  /// Returns a shallow copy of this [AlertNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AlertNote copyWith({
    String? tag,
    String? ago,
    String? body,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AlertNote',
      'tag': tag,
      'ago': ago,
      'body': body,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AlertNote',
      'tag': tag,
      'ago': ago,
      'body': body,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AlertNoteImpl extends AlertNote {
  _AlertNoteImpl({
    required String tag,
    required String ago,
    required String body,
  }) : super._(
         tag: tag,
         ago: ago,
         body: body,
       );

  /// Returns a shallow copy of this [AlertNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AlertNote copyWith({
    String? tag,
    String? ago,
    String? body,
  }) {
    return AlertNote(
      tag: tag ?? this.tag,
      ago: ago ?? this.ago,
      body: body ?? this.body,
    );
  }
}
