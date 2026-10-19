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

/// A player's accepted job, with the reward snapshot agreed at acceptance and (funded) the reservation's journal.
abstract class JobAcceptance
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JobAcceptance._({
    this.id,
    required this.offerId,
    required this.authUserId,
    required this.idemKey,
    required this.status,
    required this.taskSpec,
    required this.gameReward,
    required this.cashKobo,
    required this.feeKobo,
    required this.holdHours,
    required this.acceptedAt,
    required this.deadline,
    this.reserveRef,
    this.completedAt,
    this.note,
  });

  factory JobAcceptance({
    int? id,
    required int offerId,
    required _isc.UuidValue authUserId,
    required String idemKey,
    required String status,
    required String taskSpec,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    required int holdHours,
    required DateTime acceptedAt,
    required DateTime deadline,
    String? reserveRef,
    DateTime? completedAt,
    String? note,
  }) = _JobAcceptanceImpl;

  factory JobAcceptance.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobAcceptance(
      id: jsonSerialization['id'] as int?,
      offerId: jsonSerialization['offerId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      idemKey: jsonSerialization['idemKey'] as String,
      status: jsonSerialization['status'] as String,
      taskSpec: jsonSerialization['taskSpec'] as String,
      gameReward: jsonSerialization['gameReward'] as int,
      cashKobo: jsonSerialization['cashKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      holdHours: jsonSerialization['holdHours'] as int,
      acceptedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['acceptedAt'],
      ),
      deadline: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      reserveRef: jsonSerialization['reserveRef'] as String?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      note: jsonSerialization['note'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offerId;

  _isc.UuidValue authUserId;

  String idemKey;

  /// accepted | completed | review | expired | cancelled | rejected
  String status;

  /// the server's task parameters, JSON (e.g. the delivery distance and time limit)
  String taskSpec;

  int gameReward;

  int cashKobo;

  int feeKobo;

  int holdHours;

  DateTime acceptedAt;

  DateTime deadline;

  String? reserveRef;

  DateTime? completedAt;

  /// why it went to review, or was rejected or cancelled
  String? note;

  /// Returns a shallow copy of this [JobAcceptance]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JobAcceptance copyWith({
    int? id,
    int? offerId,
    _isc.UuidValue? authUserId,
    String? idemKey,
    String? status,
    String? taskSpec,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    int? holdHours,
    DateTime? acceptedAt,
    DateTime? deadline,
    String? reserveRef,
    DateTime? completedAt,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAcceptance',
      if (id != null) 'id': id,
      'offerId': offerId,
      'authUserId': authUserId.toJson(),
      'idemKey': idemKey,
      'status': status,
      'taskSpec': taskSpec,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      'holdHours': holdHours,
      'acceptedAt': acceptedAt.toJson(),
      'deadline': deadline.toJson(),
      if (reserveRef != null) 'reserveRef': reserveRef,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAcceptance',
      if (id != null) 'id': id,
      'offerId': offerId,
      'authUserId': authUserId.toJson(),
      'idemKey': idemKey,
      'status': status,
      'taskSpec': taskSpec,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      'holdHours': holdHours,
      'acceptedAt': acceptedAt.toJson(),
      'deadline': deadline.toJson(),
      if (reserveRef != null) 'reserveRef': reserveRef,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAcceptanceImpl extends JobAcceptance {
  _JobAcceptanceImpl({
    int? id,
    required int offerId,
    required _isc.UuidValue authUserId,
    required String idemKey,
    required String status,
    required String taskSpec,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    required int holdHours,
    required DateTime acceptedAt,
    required DateTime deadline,
    String? reserveRef,
    DateTime? completedAt,
    String? note,
  }) : super._(
         id: id,
         offerId: offerId,
         authUserId: authUserId,
         idemKey: idemKey,
         status: status,
         taskSpec: taskSpec,
         gameReward: gameReward,
         cashKobo: cashKobo,
         feeKobo: feeKobo,
         holdHours: holdHours,
         acceptedAt: acceptedAt,
         deadline: deadline,
         reserveRef: reserveRef,
         completedAt: completedAt,
         note: note,
       );

  /// Returns a shallow copy of this [JobAcceptance]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JobAcceptance copyWith({
    Object? id = _Undefined,
    int? offerId,
    _isc.UuidValue? authUserId,
    String? idemKey,
    String? status,
    String? taskSpec,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    int? holdHours,
    DateTime? acceptedAt,
    DateTime? deadline,
    Object? reserveRef = _Undefined,
    Object? completedAt = _Undefined,
    Object? note = _Undefined,
  }) {
    return JobAcceptance(
      id: id is int? ? id : this.id,
      offerId: offerId ?? this.offerId,
      authUserId: authUserId ?? this.authUserId,
      idemKey: idemKey ?? this.idemKey,
      status: status ?? this.status,
      taskSpec: taskSpec ?? this.taskSpec,
      gameReward: gameReward ?? this.gameReward,
      cashKobo: cashKobo ?? this.cashKobo,
      feeKobo: feeKobo ?? this.feeKobo,
      holdHours: holdHours ?? this.holdHours,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      deadline: deadline ?? this.deadline,
      reserveRef: reserveRef is String? ? reserveRef : this.reserveRef,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      note: note is String? ? note : this.note,
    );
  }
}
