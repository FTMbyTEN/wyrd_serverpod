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

/// A funded-jobs campaign: offers belong to it; pausing it stops new acceptances only (earned rewards are untouched).
abstract class FundedCampaign
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FundedCampaign._({
    this.id,
    required this.name,
    required this.status,
    required this.createdBy,
    required this.createdAt,
  });

  factory FundedCampaign({
    int? id,
    required String name,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) = _FundedCampaignImpl;

  factory FundedCampaign.fromJson(Map<String, dynamic> jsonSerialization) {
    return FundedCampaign(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  /// active | paused | closed
  String status;

  String createdBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [FundedCampaign]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FundedCampaign copyWith({
    int? id,
    String? name,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FundedCampaign',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FundedCampaign',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FundedCampaignImpl extends FundedCampaign {
  _FundedCampaignImpl({
    int? id,
    required String name,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         status: status,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FundedCampaign]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FundedCampaign copyWith({
    Object? id = _Undefined,
    String? name,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return FundedCampaign(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
