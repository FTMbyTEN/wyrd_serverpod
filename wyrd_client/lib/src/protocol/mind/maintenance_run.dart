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

abstract class MaintenanceRun
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MaintenanceRun._({
    this.id,
    required this.name,
    required this.ranAt,
    this.note,
  });

  factory MaintenanceRun({
    int? id,
    required String name,
    required DateTime ranAt,
    String? note,
  }) = _MaintenanceRunImpl;

  factory MaintenanceRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaintenanceRun(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      ranAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['ranAt']),
      note: jsonSerialization['note'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  DateTime ranAt;

  String? note;

  /// Returns a shallow copy of this [MaintenanceRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MaintenanceRun copyWith({
    int? id,
    String? name,
    DateTime? ranAt,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaintenanceRun',
      if (id != null) 'id': id,
      'name': name,
      'ranAt': ranAt.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaintenanceRun',
      if (id != null) 'id': id,
      'name': name,
      'ranAt': ranAt.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaintenanceRunImpl extends MaintenanceRun {
  _MaintenanceRunImpl({
    int? id,
    required String name,
    required DateTime ranAt,
    String? note,
  }) : super._(
         id: id,
         name: name,
         ranAt: ranAt,
         note: note,
       );

  /// Returns a shallow copy of this [MaintenanceRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MaintenanceRun copyWith({
    Object? id = _Undefined,
    String? name,
    DateTime? ranAt,
    Object? note = _Undefined,
  }) {
    return MaintenanceRun(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      ranAt: ranAt ?? this.ranAt,
      note: note is String? ? note : this.note,
    );
  }
}
