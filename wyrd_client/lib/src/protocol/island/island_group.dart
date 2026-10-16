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

/// An encrypted chat (two people or a group). The server holds only ciphertext: the group's name is
/// encrypted with the group key, and each member's copy of that key is wrapped for them in the browser.
abstract class IslandGroup
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandGroup._({
    this.id,
    required this.createdBy,
    required this.nameCt,
    required this.createdAt,
  });

  factory IslandGroup({
    int? id,
    required _isc.UuidValue createdBy,
    required String nameCt,
    required DateTime createdAt,
  }) = _IslandGroupImpl;

  factory IslandGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGroup(
      id: jsonSerialization['id'] as int?,
      createdBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdBy'],
      ),
      nameCt: jsonSerialization['nameCt'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue createdBy;

  /// the name, encrypted with the group key (base64 iv.ciphertext)
  String nameCt;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandGroup copyWith({
    int? id,
    _isc.UuidValue? createdBy,
    String? nameCt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGroup',
      if (id != null) 'id': id,
      'createdBy': createdBy.toJson(),
      'nameCt': nameCt,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGroup',
      if (id != null) 'id': id,
      'createdBy': createdBy.toJson(),
      'nameCt': nameCt,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGroupImpl extends IslandGroup {
  _IslandGroupImpl({
    int? id,
    required _isc.UuidValue createdBy,
    required String nameCt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         createdBy: createdBy,
         nameCt: nameCt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandGroup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandGroup copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? createdBy,
    String? nameCt,
    DateTime? createdAt,
  }) {
    return IslandGroup(
      id: id is int? ? id : this.id,
      createdBy: createdBy ?? this.createdBy,
      nameCt: nameCt ?? this.nameCt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
