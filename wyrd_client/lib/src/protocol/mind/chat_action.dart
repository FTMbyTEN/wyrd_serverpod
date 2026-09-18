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

abstract class ChatAction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatAction._({
    required this.type,
    this.country,
  });

  factory ChatAction({
    required String type,
    String? country,
  }) = _ChatActionImpl;

  factory ChatAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatAction(
      type: jsonSerialization['type'] as String,
      country: jsonSerialization['country'] as String?,
    );
  }

  String type;

  String? country;

  /// Returns a shallow copy of this [ChatAction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatAction copyWith({
    String? type,
    String? country,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatAction',
      'type': type,
      if (country != null) 'country': country,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatAction',
      'type': type,
      if (country != null) 'country': country,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatActionImpl extends ChatAction {
  _ChatActionImpl({
    required String type,
    String? country,
  }) : super._(
         type: type,
         country: country,
       );

  /// Returns a shallow copy of this [ChatAction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatAction copyWith({
    String? type,
    Object? country = _Undefined,
  }) {
    return ChatAction(
      type: type ?? this.type,
      country: country is String? ? country : this.country,
    );
  }
}
