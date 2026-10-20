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

/// A private jet someone owns at Lagos Island Airport (one each): its kind, its registration (5N-XXX, Nigeria's
/// prefix), its livery (an index into the game's colours), and whether the owner's name is shown on its hangar.
abstract class IslandJet
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandJet._({
    this.id,
    required this.authUserId,
    required this.model,
    required this.tail,
    required this.livery,
    bool? showName,
    required this.price,
    required this.boughtAt,
  }) : showName = showName ?? false;

  factory IslandJet({
    int? id,
    required _isc.UuidValue authUserId,
    required String model,
    required String tail,
    required int livery,
    bool? showName,
    required int price,
    required DateTime boughtAt,
  }) = _IslandJetImpl;

  factory IslandJet.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJet(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      model: jsonSerialization['model'] as String,
      tail: jsonSerialization['tail'] as String,
      livery: jsonSerialization['livery'] as int,
      showName: jsonSerialization['showName'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['showName']),
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

  /// light | midsize | heavy (IslandMeEndpoint.jetCatalog)
  String model;

  String tail;

  int livery;

  /// the owner's island name on the hangar door (off unless they turn it on)
  bool showName;

  int price;

  DateTime boughtAt;

  /// Returns a shallow copy of this [IslandJet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandJet copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? model,
    String? tail,
    int? livery,
    bool? showName,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'tail': tail,
      'livery': livery,
      'showName': showName,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'tail': tail,
      'livery': livery,
      'showName': showName,
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

class _IslandJetImpl extends IslandJet {
  _IslandJetImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String model,
    required String tail,
    required int livery,
    bool? showName,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         model: model,
         tail: tail,
         livery: livery,
         showName: showName,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandJet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandJet copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? model,
    String? tail,
    int? livery,
    bool? showName,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandJet(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      model: model ?? this.model,
      tail: tail ?? this.tail,
      livery: livery ?? this.livery,
      showName: showName ?? this.showName,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}
