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
import '../mind/mind.dart' as _is7qzfkp;

abstract class ChatReply
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChatReply._({
    required this.reply,
    required this.mind,
  });

  factory ChatReply({
    required String reply,
    required _is7qzfkp.Mind mind,
  }) = _ChatReplyImpl;

  factory ChatReply.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatReply(
      reply: jsonSerialization['reply'] as String,
      mind: _i9sln91s.Protocol().deserialize<_is7qzfkp.Mind>(
        jsonSerialization['mind'],
      ),
    );
  }

  String reply;

  _is7qzfkp.Mind mind;

  /// Returns a shallow copy of this [ChatReply]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChatReply copyWith({
    String? reply,
    _is7qzfkp.Mind? mind,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatReply',
      'reply': reply,
      'mind': mind.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatReply',
      'reply': reply,
      'mind': mind.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ChatReplyImpl extends ChatReply {
  _ChatReplyImpl({
    required String reply,
    required _is7qzfkp.Mind mind,
  }) : super._(
         reply: reply,
         mind: mind,
       );

  /// Returns a shallow copy of this [ChatReply]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChatReply copyWith({
    String? reply,
    _is7qzfkp.Mind? mind,
  }) {
    return ChatReply(
      reply: reply ?? this.reply,
      mind: mind ?? this.mind.copyWith(),
    );
  }
}
