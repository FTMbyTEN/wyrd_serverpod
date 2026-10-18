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

/// A home someone bought on a plot in one of the island's estates (Ajah, Lekki, Ikoyi, Banana Island).
/// [plot] is <estate>:<n> from IslandMeEndpoint.estates; its [style] (bungalow, duplex, loft, mansion,
/// villa...) comes from there too. Everyone also keeps their free starter BQ on HQ Row (their profile).
abstract class IslandHome
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandHome._({
    this.id,
    required this.authUserId,
    required this.plot,
    required this.style,
    required this.price,
    required this.boughtAt,
  });

  factory IslandHome({
    int? id,
    required _isc.UuidValue authUserId,
    required String plot,
    required String style,
    required int price,
    required DateTime boughtAt,
  }) = _IslandHomeImpl;

  factory IslandHome.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandHome(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      plot: jsonSerialization['plot'] as String,
      style: jsonSerialization['style'] as String,
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

  String plot;

  String style;

  int price;

  DateTime boughtAt;

  /// Returns a shallow copy of this [IslandHome]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandHome copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? plot,
    String? style,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandHome',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'plot': plot,
      'style': style,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandHome',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'plot': plot,
      'style': style,
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

class _IslandHomeImpl extends IslandHome {
  _IslandHomeImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String plot,
    required String style,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         plot: plot,
         style: style,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandHome]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandHome copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? plot,
    String? style,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandHome(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      plot: plot ?? this.plot,
      style: style ?? this.style,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}
