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

/// A car someone bought at a Lagos Island dealer. [active] is the one they drive (and park outside where they are).
abstract class IslandCar
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandCar._({
    this.id,
    required this.authUserId,
    required this.model,
    required this.color,
    required this.price,
    required this.dealer,
    bool? active,
    required this.boughtAt,
  }) : active = active ?? false;

  factory IslandCar({
    int? id,
    required _isc.UuidValue authUserId,
    required String model,
    required String color,
    required int price,
    required String dealer,
    bool? active,
    required DateTime boughtAt,
  }) = _IslandCarImpl;

  factory IslandCar.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandCar(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      model: jsonSerialization['model'] as String,
      color: jsonSerialization['color'] as String,
      price: jsonSerialization['price'] as int,
      dealer: jsonSerialization['dealer'] as String,
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
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

  /// a model id from the dealer catalogue
  String model;

  String color;

  int price;

  String dealer;

  bool active;

  DateTime boughtAt;

  /// Returns a shallow copy of this [IslandCar]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandCar copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? model,
    String? color,
    int? price,
    String? dealer,
    bool? active,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandCar',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'color': color,
      'price': price,
      'dealer': dealer,
      'active': active,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandCar',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'color': color,
      'price': price,
      'dealer': dealer,
      'active': active,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandCarImpl extends IslandCar {
  _IslandCarImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String model,
    required String color,
    required int price,
    required String dealer,
    bool? active,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         model: model,
         color: color,
         price: price,
         dealer: dealer,
         active: active,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandCar]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandCar copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? model,
    String? color,
    int? price,
    String? dealer,
    bool? active,
    DateTime? boughtAt,
  }) {
    return IslandCar(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      model: model ?? this.model,
      color: color ?? this.color,
      price: price ?? this.price,
      dealer: dealer ?? this.dealer,
      active: active ?? this.active,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}
