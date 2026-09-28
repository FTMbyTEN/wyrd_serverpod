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

abstract class ConversationTurn
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConversationTurn._({
    this.id,
    required this.authUserId,
    required this.userText,
    required this.botText,
    required this.timestamp,
    this.learnedAnswerId,
    this.rating,
    this.groundingIds,
  });

  factory ConversationTurn({
    int? id,
    required _isc.UuidValue authUserId,
    required String userText,
    required String botText,
    required DateTime timestamp,
    int? learnedAnswerId,
    int? rating,
    List<int>? groundingIds,
  }) = _ConversationTurnImpl;

  factory ConversationTurn.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConversationTurn(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      userText: jsonSerialization['userText'] as String,
      botText: jsonSerialization['botText'] as String,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      learnedAnswerId: jsonSerialization['learnedAnswerId'] as int?,
      rating: jsonSerialization['rating'] as int?,
      groundingIds: jsonSerialization['groundingIds'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<int>>(
              jsonSerialization['groundingIds'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String userText;

  String botText;

  DateTime timestamp;

  int? learnedAnswerId;

  int? rating;

  List<int>? groundingIds;

  /// Returns a shallow copy of this [ConversationTurn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConversationTurn copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? userText,
    String? botText,
    DateTime? timestamp,
    int? learnedAnswerId,
    int? rating,
    List<int>? groundingIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationTurn',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'userText': userText,
      'botText': botText,
      'timestamp': timestamp.toJson(),
      if (learnedAnswerId != null) 'learnedAnswerId': learnedAnswerId,
      if (rating != null) 'rating': rating,
      if (groundingIds != null) 'groundingIds': groundingIds?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationTurn',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'userText': userText,
      'botText': botText,
      'timestamp': timestamp.toJson(),
      if (learnedAnswerId != null) 'learnedAnswerId': learnedAnswerId,
      if (rating != null) 'rating': rating,
      if (groundingIds != null) 'groundingIds': groundingIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationTurnImpl extends ConversationTurn {
  _ConversationTurnImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String userText,
    required String botText,
    required DateTime timestamp,
    int? learnedAnswerId,
    int? rating,
    List<int>? groundingIds,
  }) : super._(
         id: id,
         authUserId: authUserId,
         userText: userText,
         botText: botText,
         timestamp: timestamp,
         learnedAnswerId: learnedAnswerId,
         rating: rating,
         groundingIds: groundingIds,
       );

  /// Returns a shallow copy of this [ConversationTurn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConversationTurn copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? userText,
    String? botText,
    DateTime? timestamp,
    Object? learnedAnswerId = _Undefined,
    Object? rating = _Undefined,
    Object? groundingIds = _Undefined,
  }) {
    return ConversationTurn(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      userText: userText ?? this.userText,
      botText: botText ?? this.botText,
      timestamp: timestamp ?? this.timestamp,
      learnedAnswerId: learnedAnswerId is int?
          ? learnedAnswerId
          : this.learnedAnswerId,
      rating: rating is int? ? rating : this.rating,
      groundingIds: groundingIds is List<int>?
          ? groundingIds
          : this.groundingIds?.map((e0) => e0).toList(),
    );
  }
}
