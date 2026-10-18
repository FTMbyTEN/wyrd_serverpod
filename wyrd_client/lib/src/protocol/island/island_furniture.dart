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

/// A piece of furniture someone bought at the Eko Home Store. One row per piece; [item] is a store id
/// (k:<model>) from IslandMeEndpoint.furnitureCatalog. Where it stands is in the room's layout.
abstract class IslandFurniture
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandFurniture._({
    this.id,
    required this.authUserId,
    required this.item,
    required this.price,
    required this.boughtAt,
  });

  factory IslandFurniture({
    int? id,
    required _isc.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) = _IslandFurnitureImpl;

  factory IslandFurniture.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandFurniture(
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

  /// Returns a shallow copy of this [IslandFurniture]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandFurniture copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandFurniture',
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
      '__className__': 'IslandFurniture',
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

class _IslandFurnitureImpl extends IslandFurniture {
  _IslandFurnitureImpl({
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

  /// Returns a shallow copy of this [IslandFurniture]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandFurniture copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandFurniture(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      item: item ?? this.item,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}
