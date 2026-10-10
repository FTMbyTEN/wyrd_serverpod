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

/// Something true of the whole city, set once by what a player did (e.g. unit-fixed:T-31 -- the faulty WYRD unit in
/// Mushin, fixed by whoever finished the Unit T-31 mission): its name, a value, and when.
abstract class CityFlag
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CityFlag._({
    this.id,
    required this.name,
    required this.value,
    required this.at,
  });

  factory CityFlag({
    int? id,
    required String name,
    required String value,
    required DateTime at,
  }) = _CityFlagImpl;

  factory CityFlag.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityFlag(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String value;

  DateTime at;

  /// Returns a shallow copy of this [CityFlag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CityFlag copyWith({
    int? id,
    String? name,
    String? value,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityFlag',
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CityFlag',
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityFlagImpl extends CityFlag {
  _CityFlagImpl({
    int? id,
    required String name,
    required String value,
    required DateTime at,
  }) : super._(
         id: id,
         name: name,
         value: value,
         at: at,
       );

  /// Returns a shallow copy of this [CityFlag]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CityFlag copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    DateTime? at,
  }) {
    return CityFlag(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      at: at ?? this.at,
    );
  }
}
