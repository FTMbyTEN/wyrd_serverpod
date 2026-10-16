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

/// The inside of a building: its furniture, as JSON [{k: kind, x, z, r: quarter turns, c: colour}].
/// [key] is hq:<slot> for an HQ (its owner arranges it) or place:<id> for a club, the casino, the
/// tower and the rest (WYRD's operator arranges those).
abstract class IslandRoom
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandRoom._({
    this.id,
    required this.key,
    required this.layout,
    required this.updatedAt,
  });

  factory IslandRoom({
    int? id,
    required String key,
    required String layout,
    required DateTime updatedAt,
  }) = _IslandRoomImpl;

  factory IslandRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandRoom(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      layout: jsonSerialization['layout'] as String,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String key;

  String layout;

  DateTime updatedAt;

  /// Returns a shallow copy of this [IslandRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandRoom copyWith({
    int? id,
    String? key,
    String? layout,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandRoom',
      if (id != null) 'id': id,
      'key': key,
      'layout': layout,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandRoom',
      if (id != null) 'id': id,
      'key': key,
      'layout': layout,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandRoomImpl extends IslandRoom {
  _IslandRoomImpl({
    int? id,
    required String key,
    required String layout,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         key: key,
         layout: layout,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IslandRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandRoom copyWith({
    Object? id = _Undefined,
    String? key,
    String? layout,
    DateTime? updatedAt,
  }) {
    return IslandRoom(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      layout: layout ?? this.layout,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
