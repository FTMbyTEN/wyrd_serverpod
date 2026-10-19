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

/// An outfit someone bought at a Lagos Island boutique (Idumota, Falomo, Circle Mall) or on the Fashion app. One row per
/// outfit; [item] is an id from IslandMeEndpoint.outfitCatalog. What they're wearing is the last field of their look.
abstract class IslandOutfit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandOutfit._({
    this.id,
    required this.authUserId,
    required this.item,
    required this.price,
    required this.boughtAt,
  });

  factory IslandOutfit({
    int? id,
    required _isc.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) = _IslandOutfitImpl;

  factory IslandOutfit.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandOutfit(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      item: jsonSerialization['item'] as String,
      price: jsonSerialization['price'] as int,
      boughtAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['boughtAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String item;

  int price;

  DateTime boughtAt;

  /// Returns a shallow copy of this [IslandOutfit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandOutfit copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandOutfit',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'item': item,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandOutfit',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'item': item,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandOutfitImpl extends IslandOutfit {
  _IslandOutfitImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         item: item,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandOutfit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandOutfit copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandOutfit(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      item: item ?? this.item,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}
