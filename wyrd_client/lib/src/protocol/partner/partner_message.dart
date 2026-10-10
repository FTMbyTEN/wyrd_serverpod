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

/// One message in a partner conversation: the customer's (user) or WYRD's (assistant).
abstract class PartnerMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerMessage._({
    this.id,
    required this.convId,
    required this.msgId,
    required this.role,
    required this.text,
    required this.createdAt,
  });

  factory PartnerMessage({
    int? id,
    required String convId,
    required String msgId,
    required String role,
    required String text,
    required DateTime createdAt,
  }) = _PartnerMessageImpl;

  factory PartnerMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerMessage(
      id: jsonSerialization['id'] as int?,
      convId: jsonSerialization['convId'] as String,
      msgId: jsonSerialization['msgId'] as String,
      role: jsonSerialization['role'] as String,
      text: jsonSerialization['text'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String convId;

  String msgId;

  String role;

  String text;

  DateTime createdAt;

  /// Returns a shallow copy of this [PartnerMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerMessage copyWith({
    int? id,
    String? convId,
    String? msgId,
    String? role,
    String? text,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerMessage',
      if (id != null) 'id': id,
      'convId': convId,
      'msgId': msgId,
      'role': role,
      'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerMessage',
      if (id != null) 'id': id,
      'convId': convId,
      'msgId': msgId,
      'role': role,
      'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerMessageImpl extends PartnerMessage {
  _PartnerMessageImpl({
    int? id,
    required String convId,
    required String msgId,
    required String role,
    required String text,
    required DateTime createdAt,
  }) : super._(
         id: id,
         convId: convId,
         msgId: msgId,
         role: role,
         text: text,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PartnerMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerMessage copyWith({
    Object? id = _Undefined,
    String? convId,
    String? msgId,
    String? role,
    String? text,
    DateTime? createdAt,
  }) {
    return PartnerMessage(
      id: id is int? ? id : this.id,
      convId: convId ?? this.convId,
      msgId: msgId ?? this.msgId,
      role: role ?? this.role,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
