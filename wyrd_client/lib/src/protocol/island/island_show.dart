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

/// A show at the arena: an artist performs live for the people holding tickets. WYRD's operator checks
/// each before tickets go on sale (status on_sale).
abstract class IslandShow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandShow._({
    this.id,
    required this.hostUserId,
    required this.artist,
    required this.title,
    required this.startsAt,
    int? minutes,
    required this.price,
    int? capacity,
    String? status,
    required this.createdAt,
  }) : minutes = minutes ?? 60,
       capacity = capacity ?? 500,
       status = status ?? 'pending';

  factory IslandShow({
    int? id,
    required _isc.UuidValue hostUserId,
    required String artist,
    required String title,
    required DateTime startsAt,
    int? minutes,
    required int price,
    int? capacity,
    String? status,
    required DateTime createdAt,
  }) = _IslandShowImpl;

  factory IslandShow.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandShow(
      id: jsonSerialization['id'] as int?,
      hostUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['hostUserId'],
      ),
      artist: jsonSerialization['artist'] as String,
      title: jsonSerialization['title'] as String,
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      minutes: jsonSerialization['minutes'] as int?,
      price: jsonSerialization['price'] as int,
      capacity: jsonSerialization['capacity'] as int?,
      status: jsonSerialization['status'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue hostUserId;

  String artist;

  String title;

  DateTime startsAt;

  /// how long it runs
  int minutes;

  /// ticket price in naira (play money), 0 for free
  int price;

  int capacity;

  /// pending | on_sale | rejected | cancelled
  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandShow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandShow copyWith({
    int? id,
    _isc.UuidValue? hostUserId,
    String? artist,
    String? title,
    DateTime? startsAt,
    int? minutes,
    int? price,
    int? capacity,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandShow',
      if (id != null) 'id': id,
      'hostUserId': hostUserId.toJson(),
      'artist': artist,
      'title': title,
      'startsAt': startsAt.toJson(),
      'minutes': minutes,
      'price': price,
      'capacity': capacity,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandShow',
      if (id != null) 'id': id,
      'hostUserId': hostUserId.toJson(),
      'artist': artist,
      'title': title,
      'startsAt': startsAt.toJson(),
      'minutes': minutes,
      'price': price,
      'capacity': capacity,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandShowImpl extends IslandShow {
  _IslandShowImpl({
    int? id,
    required _isc.UuidValue hostUserId,
    required String artist,
    required String title,
    required DateTime startsAt,
    int? minutes,
    required int price,
    int? capacity,
    String? status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         hostUserId: hostUserId,
         artist: artist,
         title: title,
         startsAt: startsAt,
         minutes: minutes,
         price: price,
         capacity: capacity,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandShow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandShow copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? hostUserId,
    String? artist,
    String? title,
    DateTime? startsAt,
    int? minutes,
    int? price,
    int? capacity,
    String? status,
    DateTime? createdAt,
  }) {
    return IslandShow(
      id: id is int? ? id : this.id,
      hostUserId: hostUserId ?? this.hostUserId,
      artist: artist ?? this.artist,
      title: title ?? this.title,
      startsAt: startsAt ?? this.startsAt,
      minutes: minutes ?? this.minutes,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
