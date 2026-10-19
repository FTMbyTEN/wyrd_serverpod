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

/// A versioned reward policy. Once a job offer uses a version it is never changed; a new policy is a new version.
/// The cash share is in basis points of the reward basis (1 basis unit = 1 naira), the cash rounded down to the whole naira.
abstract class RewardPolicy
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RewardPolicy._({
    this.id,
    required this.version,
    required this.cashShareBp,
    required this.feeAllowanceKobo,
    required this.holdHours,
    required this.createdBy,
    required this.createdAt,
  });

  factory RewardPolicy({
    int? id,
    required int version,
    required int cashShareBp,
    required int feeAllowanceKobo,
    required int holdHours,
    required String createdBy,
    required DateTime createdAt,
  }) = _RewardPolicyImpl;

  factory RewardPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardPolicy(
      id: jsonSerialization['id'] as int?,
      version: jsonSerialization['version'] as int,
      cashShareBp: jsonSerialization['cashShareBp'] as int,
      feeAllowanceKobo: jsonSerialization['feeAllowanceKobo'] as int,
      holdHours: jsonSerialization['holdHours'] as int,
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

  int version;

  /// 167 = 1.67%
  int cashShareBp;

  /// payout-cost allowance reserved with each cash reward, in kobo
  int feeAllowanceKobo;

  /// how long a cash reward stays pending (the verification hold) before it can be withdrawn
  int holdHours;

  String createdBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [RewardPolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RewardPolicy copyWith({
    int? id,
    int? version,
    int? cashShareBp,
    int? feeAllowanceKobo,
    int? holdHours,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardPolicy',
      if (id != null) 'id': id,
      'version': version,
      'cashShareBp': cashShareBp,
      'feeAllowanceKobo': feeAllowanceKobo,
      'holdHours': holdHours,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardPolicy',
      if (id != null) 'id': id,
      'version': version,
      'cashShareBp': cashShareBp,
      'feeAllowanceKobo': feeAllowanceKobo,
      'holdHours': holdHours,
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

class _RewardPolicyImpl extends RewardPolicy {
  _RewardPolicyImpl({
    int? id,
    required int version,
    required int cashShareBp,
    required int feeAllowanceKobo,
    required int holdHours,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         version: version,
         cashShareBp: cashShareBp,
         feeAllowanceKobo: feeAllowanceKobo,
         holdHours: holdHours,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardPolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RewardPolicy copyWith({
    Object? id = _Undefined,
    int? version,
    int? cashShareBp,
    int? feeAllowanceKobo,
    int? holdHours,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return RewardPolicy(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      cashShareBp: cashShareBp ?? this.cashShareBp,
      feeAllowanceKobo: feeAllowanceKobo ?? this.feeAllowanceKobo,
      holdHours: holdHours ?? this.holdHours,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
