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

/// One moment of play, kept to teach WYRD (only with the player's consent, or the owner's own design
/// sessions): what was happening, what the player said or did, what WYRD answered and did, and how it
/// turned out. Scrubbed of personal details before it's stored.
abstract class GameExchange
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GameExchange._({
    this.id,
    required this.authUserId,
    required this.channel,
    required this.situation,
    required this.said,
    required this.reply,
    required this.actions,
    this.outcome,
    required this.createdAt,
  });

  factory GameExchange({
    int? id,
    required _isc.UuidValue authUserId,
    required String channel,
    required String situation,
    required String said,
    required String reply,
    required String actions,
    String? outcome,
    required DateTime createdAt,
  }) = _GameExchangeImpl;

  factory GameExchange.fromJson(Map<String, dynamic> jsonSerialization) {
    return GameExchange(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      channel: jsonSerialization['channel'] as String,
      situation: jsonSerialization['situation'] as String,
      said: jsonSerialization['said'] as String,
      reply: jsonSerialization['reply'] as String,
      actions: jsonSerialization['actions'] as String,
      outcome: jsonSerialization['outcome'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// speak | petition | drone | event | design
  String channel;

  /// the game's situation (JSON, scrubbed)
  String situation;

  String said;

  String reply;

  /// what WYRD did (JSON list of actions)
  String actions;

  /// how it turned out, filled in later: e.g. "mission_done", "standing:+4"
  String? outcome;

  DateTime createdAt;

  /// Returns a shallow copy of this [GameExchange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GameExchange copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? channel,
    String? situation,
    String? said,
    String? reply,
    String? actions,
    String? outcome,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GameExchange',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'channel': channel,
      'situation': situation,
      'said': said,
      'reply': reply,
      'actions': actions,
      if (outcome != null) 'outcome': outcome,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GameExchange',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'channel': channel,
      'situation': situation,
      'said': said,
      'reply': reply,
      'actions': actions,
      if (outcome != null) 'outcome': outcome,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GameExchangeImpl extends GameExchange {
  _GameExchangeImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String channel,
    required String situation,
    required String said,
    required String reply,
    required String actions,
    String? outcome,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         channel: channel,
         situation: situation,
         said: said,
         reply: reply,
         actions: actions,
         outcome: outcome,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [GameExchange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GameExchange copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? channel,
    String? situation,
    String? said,
    String? reply,
    String? actions,
    Object? outcome = _Undefined,
    DateTime? createdAt,
  }) {
    return GameExchange(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      channel: channel ?? this.channel,
      situation: situation ?? this.situation,
      said: said ?? this.said,
      reply: reply ?? this.reply,
      actions: actions ?? this.actions,
      outcome: outcome is String? ? outcome : this.outcome,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
