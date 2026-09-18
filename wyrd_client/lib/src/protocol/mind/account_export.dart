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
import '../mind/conversation_turn.dart' as _igyss20b;
import '../mind/user_fact.dart' as _il0k3um2;

abstract class AccountExport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AccountExport._({
    this.email,
    required this.facts,
    required this.visitCount,
    required this.firstSeen,
    required this.lastSeen,
    required this.conversation,
  });

  factory AccountExport({
    String? email,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
    required List<_igyss20b.ConversationTurn> conversation,
  }) = _AccountExportImpl;

  factory AccountExport.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountExport(
      email: jsonSerialization['email'] as String?,
      facts: _i2pladzn.Protocol().deserialize<List<_il0k3um2.UserFact>>(
        jsonSerialization['facts'],
      ),
      visitCount: jsonSerialization['visitCount'] as int,
      firstSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeen'],
      ),
      lastSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeen'],
      ),
      conversation: _i2pladzn.Protocol()
          .deserialize<List<_igyss20b.ConversationTurn>>(
            jsonSerialization['conversation'],
          ),
    );
  }

  String? email;

  List<_il0k3um2.UserFact> facts;

  int visitCount;

  DateTime firstSeen;

  DateTime lastSeen;

  List<_igyss20b.ConversationTurn> conversation;

  /// Returns a shallow copy of this [AccountExport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AccountExport copyWith({
    String? email,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
    List<_igyss20b.ConversationTurn>? conversation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountExport',
      if (email != null) 'email': email,
      'facts': facts.toJson(valueToJson: (v) => v.toJson()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
      'conversation': conversation.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountExport',
      if (email != null) 'email': email,
      'facts': facts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
      'conversation': conversation.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountExportImpl extends AccountExport {
  _AccountExportImpl({
    String? email,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
    required List<_igyss20b.ConversationTurn> conversation,
  }) : super._(
         email: email,
         facts: facts,
         visitCount: visitCount,
         firstSeen: firstSeen,
         lastSeen: lastSeen,
         conversation: conversation,
       );

  /// Returns a shallow copy of this [AccountExport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AccountExport copyWith({
    Object? email = _Undefined,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
    List<_igyss20b.ConversationTurn>? conversation,
  }) {
    return AccountExport(
      email: email is String? ? email : this.email,
      facts: facts ?? this.facts.map((e0) => e0.copyWith()).toList(),
      visitCount: visitCount ?? this.visitCount,
      firstSeen: firstSeen ?? this.firstSeen,
      lastSeen: lastSeen ?? this.lastSeen,
      conversation:
          conversation ?? this.conversation.map((e0) => e0.copyWith()).toList(),
    );
  }
}
