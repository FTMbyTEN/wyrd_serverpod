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

/// A player's own character in NAIJA 2099, made in the character creator before they first enter
/// the city: which body, its proportions, skin tone, outfit colour, neon trim and street name.
abstract class PlayerCharacter
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlayerCharacter._({
    this.id,
    required this.authUserId,
    required this.base,
    int? outfit,
    required this.name,
    required this.height,
    required this.build,
    required this.shoulders,
    required this.hips,
    required this.skin,
    required this.outfitHue,
    required this.neon,
    required this.createdAt,
    required this.updatedAt,
  }) : outfit = outfit ?? 0;

  factory PlayerCharacter({
    int? id,
    required _isc.UuidValue authUserId,
    required String base,
    int? outfit,
    required String name,
    required double height,
    required double build,
    required double shoulders,
    required double hips,
    required double skin,
    required double outfitHue,
    required int neon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlayerCharacterImpl;

  factory PlayerCharacter.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerCharacter(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      base: jsonSerialization['base'] as String,
      outfit: jsonSerialization['outfit'] as int?,
      name: jsonSerialization['name'] as String,
      height: (jsonSerialization['height'] as num).toDouble(),
      build: (jsonSerialization['build'] as num).toDouble(),
      shoulders: (jsonSerialization['shoulders'] as num).toDouble(),
      hips: (jsonSerialization['hips'] as num).toDouble(),
      skin: (jsonSerialization['skin'] as num).toDouble(),
      outfitHue: (jsonSerialization['outfitHue'] as num).toDouble(),
      neon: jsonSerialization['neon'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
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

  /// the base body: 'ten' (a man) or 'ama' (a woman)
  String base;

  /// the outfit from the wardrobe (0 = the body's own)
  int outfit;

  /// the name the city (and WYRD) knows them by
  String name;

  /// proportions, each -1 .. 1 (0 = the base's own)
  double height;

  double build;

  double shoulders;

  double hips;

  /// skin tone -1 (darker) .. 1 (lighter); outfit hue shift in degrees; neon trim colour (0xRRGGBB)
  double skin;

  double outfitHue;

  int neon;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PlayerCharacter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlayerCharacter copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? base,
    int? outfit,
    String? name,
    double? height,
    double? build,
    double? shoulders,
    double? hips,
    double? skin,
    double? outfitHue,
    int? neon,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerCharacter',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'base': base,
      'outfit': outfit,
      'name': name,
      'height': height,
      'build': build,
      'shoulders': shoulders,
      'hips': hips,
      'skin': skin,
      'outfitHue': outfitHue,
      'neon': neon,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlayerCharacter',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'base': base,
      'outfit': outfit,
      'name': name,
      'height': height,
      'build': build,
      'shoulders': shoulders,
      'hips': hips,
      'skin': skin,
      'outfitHue': outfitHue,
      'neon': neon,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerCharacterImpl extends PlayerCharacter {
  _PlayerCharacterImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String base,
    int? outfit,
    required String name,
    required double height,
    required double build,
    required double shoulders,
    required double hips,
    required double skin,
    required double outfitHue,
    required int neon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         base: base,
         outfit: outfit,
         name: name,
         height: height,
         build: build,
         shoulders: shoulders,
         hips: hips,
         skin: skin,
         outfitHue: outfitHue,
         neon: neon,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerCharacter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlayerCharacter copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? base,
    int? outfit,
    String? name,
    double? height,
    double? build,
    double? shoulders,
    double? hips,
    double? skin,
    double? outfitHue,
    int? neon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerCharacter(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      base: base ?? this.base,
      outfit: outfit ?? this.outfit,
      name: name ?? this.name,
      height: height ?? this.height,
      build: build ?? this.build,
      shoulders: shoulders ?? this.shoulders,
      hips: hips ?? this.hips,
      skin: skin ?? this.skin,
      outfitHue: outfitHue ?? this.outfitHue,
      neon: neon ?? this.neon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
