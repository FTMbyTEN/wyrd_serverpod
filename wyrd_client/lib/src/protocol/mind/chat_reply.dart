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
import '../mind/chat_action.dart' as _i3mvbw8t;
import '../mind/mind.dart' as _is7qzfkp;

abstract class ChatReply
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatReply._({
    required this.reply,
    required this.mind,
    this.action,
  });

  factory ChatReply({
    required String reply,
    required _is7qzfkp.Mind mind,
    _i3mvbw8t.ChatAction? action,
  }) = _ChatReplyImpl;

  factory ChatReply.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatReply(
      reply: jsonSerialization['reply'] as String,
      mind: _i2pladzn.Protocol().deserialize<_is7qzfkp.Mind>(
        jsonSerialization['mind'],
      ),
      action: jsonSerialization['action'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<_i3mvbw8t.ChatAction>(
              jsonSerialization['action'],
            ),
    );
  }

  String reply;

  _is7qzfkp.Mind mind;

  _i3mvbw8t.ChatAction? action;

  /// Returns a shallow copy of this [ChatReply]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatReply copyWith({
    String? reply,
    _is7qzfkp.Mind? mind,
    _i3mvbw8t.ChatAction? action,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatReply',
      'reply': reply,
      'mind': mind.toJson(),
      if (action != null) 'action': action?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatReply',
      'reply': reply,
      'mind': mind.toJsonForProtocol(),
      if (action != null) 'action': action?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatReplyImpl extends ChatReply {
  _ChatReplyImpl({
    required String reply,
    required _is7qzfkp.Mind mind,
    _i3mvbw8t.ChatAction? action,
  }) : super._(
         reply: reply,
         mind: mind,
         action: action,
       );

  /// Returns a shallow copy of this [ChatReply]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatReply copyWith({
    String? reply,
    _is7qzfkp.Mind? mind,
    Object? action = _Undefined,
  }) {
    return ChatReply(
      reply: reply ?? this.reply,
      mind: mind ?? this.mind.copyWith(),
      action: action is _i3mvbw8t.ChatAction?
          ? action
          : this.action?.copyWith(),
    );
  }
}
