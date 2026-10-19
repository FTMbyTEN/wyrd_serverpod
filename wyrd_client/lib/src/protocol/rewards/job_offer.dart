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

/// A job a player can accept. Its rewards are fixed when the offer is made (the reward snapshot) and copied onto every
/// acceptance; a later policy never changes them.
abstract class JobOffer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JobOffer._({
    this.id,
    required this.type,
    this.campaignId,
    required this.title,
    required this.task,
    required this.basis,
    required this.gameReward,
    required this.cashKobo,
    required this.feeKobo,
    this.policyVersion,
    this.places,
    required this.closesAt,
    required this.completeMinutes,
    required this.status,
    required this.createdBy,
    required this.createdAt,
  });

  factory JobOffer({
    int? id,
    required String type,
    int? campaignId,
    required String title,
    required String task,
    required int basis,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    int? policyVersion,
    int? places,
    required DateTime closesAt,
    required int completeMinutes,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) = _JobOfferImpl;

  factory JobOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobOffer(
      id: jsonSerialization['id'] as int?,
      type: jsonSerialization['type'] as String,
      campaignId: jsonSerialization['campaignId'] as int?,
      title: jsonSerialization['title'] as String,
      task: jsonSerialization['task'] as String,
      basis: jsonSerialization['basis'] as int,
      gameReward: jsonSerialization['gameReward'] as int,
      cashKobo: jsonSerialization['cashKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      policyVersion: jsonSerialization['policyVersion'] as int?,
      places: jsonSerialization['places'] as int?,
      closesAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['closesAt'],
      ),
      completeMinutes: jsonSerialization['completeMinutes'] as int,
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

  /// ORDINARY_GAME_JOB | FUNDED_SPLIT_JOB
  String type;

  int? campaignId;

  String title;

  /// what the task is (delivery), checked by the server on completion
  String task;

  /// the reward basis (naira) the split was worked out from
  int basis;

  /// Game Naira paid on completion
  int gameReward;

  /// real cash reward, kobo (0 for ordinary jobs)
  int cashKobo;

  /// payout-cost allowance reserved with it, kobo
  int feeKobo;

  int? policyVersion;

  /// how many players may accept it (null: no limit beyond funding)
  int? places;

  DateTime closesAt;

  /// minutes an accepted job has to be completed
  int completeMinutes;

  /// open | closed
  String status;

  String createdBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [JobOffer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JobOffer copyWith({
    int? id,
    String? type,
    int? campaignId,
    String? title,
    String? task,
    int? basis,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    int? policyVersion,
    int? places,
    DateTime? closesAt,
    int? completeMinutes,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobOffer',
      if (id != null) 'id': id,
      'type': type,
      if (campaignId != null) 'campaignId': campaignId,
      'title': title,
      'task': task,
      'basis': basis,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      if (policyVersion != null) 'policyVersion': policyVersion,
      if (places != null) 'places': places,
      'closesAt': closesAt.toJson(),
      'completeMinutes': completeMinutes,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobOffer',
      if (id != null) 'id': id,
      'type': type,
      if (campaignId != null) 'campaignId': campaignId,
      'title': title,
      'task': task,
      'basis': basis,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      if (policyVersion != null) 'policyVersion': policyVersion,
      if (places != null) 'places': places,
      'closesAt': closesAt.toJson(),
      'completeMinutes': completeMinutes,
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

class _JobOfferImpl extends JobOffer {
  _JobOfferImpl({
    int? id,
    required String type,
    int? campaignId,
    required String title,
    required String task,
    required int basis,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    int? policyVersion,
    int? places,
    required DateTime closesAt,
    required int completeMinutes,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         type: type,
         campaignId: campaignId,
         title: title,
         task: task,
         basis: basis,
         gameReward: gameReward,
         cashKobo: cashKobo,
         feeKobo: feeKobo,
         policyVersion: policyVersion,
         places: places,
         closesAt: closesAt,
         completeMinutes: completeMinutes,
         status: status,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JobOffer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JobOffer copyWith({
    Object? id = _Undefined,
    String? type,
    Object? campaignId = _Undefined,
    String? title,
    String? task,
    int? basis,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    Object? policyVersion = _Undefined,
    Object? places = _Undefined,
    DateTime? closesAt,
    int? completeMinutes,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return JobOffer(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      campaignId: campaignId is int? ? campaignId : this.campaignId,
      title: title ?? this.title,
      task: task ?? this.task,
      basis: basis ?? this.basis,
      gameReward: gameReward ?? this.gameReward,
      cashKobo: cashKobo ?? this.cashKobo,
      feeKobo: feeKobo ?? this.feeKobo,
      policyVersion: policyVersion is int? ? policyVersion : this.policyVersion,
      places: places is int? ? places : this.places,
      closesAt: closesAt ?? this.closesAt,
      completeMinutes: completeMinutes ?? this.completeMinutes,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
