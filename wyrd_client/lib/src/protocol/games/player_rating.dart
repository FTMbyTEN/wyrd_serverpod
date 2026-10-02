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

/// A player's rating in one game (Elo, starting at 1000), and their record against WYRD.
abstract class PlayerRating
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlayerRating._({
    this.id,
    required this.authUserId,
    required this.game,
    required this.name,
    required this.rating,
    required this.played,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.updatedAt,
  });

  factory PlayerRating({
    int? id,
    required _isc.UuidValue authUserId,
    required String game,
    required String name,
    required double rating,
    required int played,
    required int wins,
    required int losses,
    required int draws,
    required DateTime updatedAt,
  }) = _PlayerRatingImpl;

  factory PlayerRating.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerRating(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      game: jsonSerialization['game'] as String,
      name: jsonSerialization['name'] as String,
      rating: (jsonSerialization['rating'] as num).toDouble(),
      played: jsonSerialization['played'] as int,
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
      draws: jsonSerialization['draws'] as int,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String game;

  String name;

  double rating;

  int played;

  int wins;

  int losses;

  int draws;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlayerRating copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? game,
    String? name,
    double? rating,
    int? played,
    int? wins,
    int? losses,
    int? draws,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerRating',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'name': name,
      'rating': rating,
      'played': played,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlayerRating',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'name': name,
      'rating': rating,
      'played': played,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerRatingImpl extends PlayerRating {
  _PlayerRatingImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String game,
    required String name,
    required double rating,
    required int played,
    required int wins,
    required int losses,
    required int draws,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         game: game,
         name: name,
         rating: rating,
         played: played,
         wins: wins,
         losses: losses,
         draws: draws,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlayerRating copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? game,
    String? name,
    double? rating,
    int? played,
    int? wins,
    int? losses,
    int? draws,
    DateTime? updatedAt,
  }) {
    return PlayerRating(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      game: game ?? this.game,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      played: played ?? this.played,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
