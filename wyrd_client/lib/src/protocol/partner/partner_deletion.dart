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

/// A deletion a partner asked for (one conversation, or everything for a user reference), so it can be confirmed.
abstract class PartnerDeletion
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerDeletion._({
    this.id,
    required this.deletionId,
    required this.partner,
    required this.env,
    required this.what,
    required this.status,
    required this.createdAt,
    this.doneAt,
  });

  factory PartnerDeletion({
    int? id,
    required String deletionId,
    required String partner,
    required String env,
    required String what,
    required String status,
    required DateTime createdAt,
    DateTime? doneAt,
  }) = _PartnerDeletionImpl;

  factory PartnerDeletion.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerDeletion(
      id: jsonSerialization['id'] as int?,
      deletionId: jsonSerialization['deletionId'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      what: jsonSerialization['what'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String deletionId;

  String partner;

  String env;

  String what;

  String status;

  DateTime createdAt;

  DateTime? doneAt;

  /// Returns a shallow copy of this [PartnerDeletion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerDeletion copyWith({
    int? id,
    String? deletionId,
    String? partner,
    String? env,
    String? what,
    String? status,
    DateTime? createdAt,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerDeletion',
      if (id != null) 'id': id,
      'deletionId': deletionId,
      'partner': partner,
      'env': env,
      'what': what,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerDeletion',
      if (id != null) 'id': id,
      'deletionId': deletionId,
      'partner': partner,
      'env': env,
      'what': what,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerDeletionImpl extends PartnerDeletion {
  _PartnerDeletionImpl({
    int? id,
    required String deletionId,
    required String partner,
    required String env,
    required String what,
    required String status,
    required DateTime createdAt,
    DateTime? doneAt,
  }) : super._(
         id: id,
         deletionId: deletionId,
         partner: partner,
         env: env,
         what: what,
         status: status,
         createdAt: createdAt,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [PartnerDeletion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerDeletion copyWith({
    Object? id = _Undefined,
    String? deletionId,
    String? partner,
    String? env,
    String? what,
    String? status,
    DateTime? createdAt,
    Object? doneAt = _Undefined,
  }) {
    return PartnerDeletion(
      id: id is int? ? id : this.id,
      deletionId: deletionId ?? this.deletionId,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      what: what ?? this.what,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}
