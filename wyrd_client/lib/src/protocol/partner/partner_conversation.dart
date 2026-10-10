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

/// One partner conversation, belonging to one user reference and one partner environment. Deleted 30 days after its
/// last message (7 on staging).
abstract class PartnerConversation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerConversation._({
    this.id,
    required this.convId,
    required this.partner,
    required this.env,
    required this.userRef,
    required this.surface,
    required this.createdAt,
    required this.lastAt,
  });

  factory PartnerConversation({
    int? id,
    required String convId,
    required String partner,
    required String env,
    required String userRef,
    required String surface,
    required DateTime createdAt,
    required DateTime lastAt,
  }) = _PartnerConversationImpl;

  factory PartnerConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerConversation(
      id: jsonSerialization['id'] as int?,
      convId: jsonSerialization['convId'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      userRef: jsonSerialization['userRef'] as String,
      surface: jsonSerialization['surface'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['lastAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String convId;

  String partner;

  String env;

  String userRef;

  String surface;

  DateTime createdAt;

  DateTime lastAt;

  /// Returns a shallow copy of this [PartnerConversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerConversation copyWith({
    int? id,
    String? convId,
    String? partner,
    String? env,
    String? userRef,
    String? surface,
    DateTime? createdAt,
    DateTime? lastAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerConversation',
      if (id != null) 'id': id,
      'convId': convId,
      'partner': partner,
      'env': env,
      'userRef': userRef,
      'surface': surface,
      'createdAt': createdAt.toJson(),
      'lastAt': lastAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerConversation',
      if (id != null) 'id': id,
      'convId': convId,
      'partner': partner,
      'env': env,
      'userRef': userRef,
      'surface': surface,
      'createdAt': createdAt.toJson(),
      'lastAt': lastAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerConversationImpl extends PartnerConversation {
  _PartnerConversationImpl({
    int? id,
    required String convId,
    required String partner,
    required String env,
    required String userRef,
    required String surface,
    required DateTime createdAt,
    required DateTime lastAt,
  }) : super._(
         id: id,
         convId: convId,
         partner: partner,
         env: env,
         userRef: userRef,
         surface: surface,
         createdAt: createdAt,
         lastAt: lastAt,
       );

  /// Returns a shallow copy of this [PartnerConversation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerConversation copyWith({
    Object? id = _Undefined,
    String? convId,
    String? partner,
    String? env,
    String? userRef,
    String? surface,
    DateTime? createdAt,
    DateTime? lastAt,
  }) {
    return PartnerConversation(
      id: id is int? ? id : this.id,
      convId: convId ?? this.convId,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      userRef: userRef ?? this.userRef,
      surface: surface ?? this.surface,
      createdAt: createdAt ?? this.createdAt,
      lastAt: lastAt ?? this.lastAt,
    );
  }
}
