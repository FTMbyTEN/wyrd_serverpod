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

/// A ticket to an arena show.
abstract class IslandTicket
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandTicket._({
    this.id,
    required this.showId,
    required this.authUserId,
    required this.createdAt,
  });

  factory IslandTicket({
    int? id,
    required int showId,
    required _isc.UuidValue authUserId,
    required DateTime createdAt,
  }) = _IslandTicketImpl;

  factory IslandTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTicket(
      id: jsonSerialization['id'] as int?,
      showId: jsonSerialization['showId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int showId;

  _isc.UuidValue authUserId;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandTicket]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandTicket copyWith({
    int? id,
    int? showId,
    _isc.UuidValue? authUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTicket',
      if (id != null) 'id': id,
      'showId': showId,
      'authUserId': authUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTicket',
      if (id != null) 'id': id,
      'showId': showId,
      'authUserId': authUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTicketImpl extends IslandTicket {
  _IslandTicketImpl({
    int? id,
    required int showId,
    required _isc.UuidValue authUserId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         showId: showId,
         authUserId: authUserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandTicket]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandTicket copyWith({
    Object? id = _Undefined,
    int? showId,
    _isc.UuidValue? authUserId,
    DateTime? createdAt,
  }) {
    return IslandTicket(
      id: id is int? ? id : this.id,
      showId: showId ?? this.showId,
      authUserId: authUserId ?? this.authUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
