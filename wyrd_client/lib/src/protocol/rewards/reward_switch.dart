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

/// Operational switches, changed by admins (audited): funded_jobs_paused (no new acceptances), payouts_paused (no new
/// payout submissions). Pausing never deletes or reduces a liability.
abstract class RewardSwitch
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardSwitch._({
    this.id,
    required this.key,
    required this.enabled,
    this.updatedBy,
    required this.updatedAt,
  });

  factory RewardSwitch({
    int? id,
    required String key,
    required bool enabled,
    _isc.UuidValue? updatedBy,
    required DateTime updatedAt,
  }) = _RewardSwitchImpl;

  factory RewardSwitch.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardSwitch(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      enabled: _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      updatedBy: jsonSerialization['updatedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['updatedBy'],
            ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String key;

  bool enabled;

  _isc.UuidValue? updatedBy;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RewardSwitch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardSwitch copyWith({
    int? id,
    String? key,
    bool? enabled,
    _isc.UuidValue? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardSwitch',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardSwitch',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardSwitchImpl extends RewardSwitch {
  _RewardSwitchImpl({
    int? id,
    required String key,
    required bool enabled,
    _isc.UuidValue? updatedBy,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         key: key,
         enabled: enabled,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardSwitch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardSwitch copyWith({
    Object? id = _Undefined,
    String? key,
    bool? enabled,
    Object? updatedBy = _Undefined,
    DateTime? updatedAt,
  }) {
    return RewardSwitch(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      updatedBy: updatedBy is _isc.UuidValue? ? updatedBy : this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
