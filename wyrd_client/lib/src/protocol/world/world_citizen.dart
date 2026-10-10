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

/// What WYRD, as the Authority of the open world, knows of one player: their standing in the city,
/// the missions they've done, and its own short record of them -- kept between visits.
abstract class WorldCitizen
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WorldCitizen._({
    this.id,
    required this.authUserId,
    int? standing,
    int? missionsDone,
    this.record,
    this.mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    int? naira,
    this.homeSlug,
    this.homeMode,
    this.rentPaidUntil,
    this.paidToday,
    this.guideDone,
    this.story,
    int? debt,
    this.debtSince,
    this.rentGraceUntil,
    this.fineWarnedAt,
    required this.updatedAt,
  }) : standing = standing ?? 0,
       missionsDone = missionsDone ?? 0,
       trainingOptIn = trainingOptIn ?? false,
       trainingAsked = trainingAsked ?? false,
       naira = naira ?? 5000,
       debt = debt ?? 0;

  factory WorldCitizen({
    int? id,
    required _isc.UuidValue authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    int? naira,
    String? homeSlug,
    String? homeMode,
    DateTime? rentPaidUntil,
    String? paidToday,
    String? guideDone,
    String? story,
    int? debt,
    DateTime? debtSince,
    DateTime? rentGraceUntil,
    DateTime? fineWarnedAt,
    required DateTime updatedAt,
  }) = _WorldCitizenImpl;

  factory WorldCitizen.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorldCitizen(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      standing: jsonSerialization['standing'] as int?,
      missionsDone: jsonSerialization['missionsDone'] as int?,
      record: jsonSerialization['record'] as String?,
      mission: jsonSerialization['mission'] as String?,
      trainingOptIn: jsonSerialization['trainingOptIn'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['trainingOptIn']),
      trainingAsked: jsonSerialization['trainingAsked'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['trainingAsked']),
      naira: jsonSerialization['naira'] as int?,
      homeSlug: jsonSerialization['homeSlug'] as String?,
      homeMode: jsonSerialization['homeMode'] as String?,
      rentPaidUntil: jsonSerialization['rentPaidUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['rentPaidUntil'],
            ),
      paidToday: jsonSerialization['paidToday'] as String?,
      guideDone: jsonSerialization['guideDone'] as String?,
      story: jsonSerialization['story'] as String?,
      debt: jsonSerialization['debt'] as int?,
      debtSince: jsonSerialization['debtSince'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['debtSince']),
      rentGraceUntil: jsonSerialization['rentGraceUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['rentGraceUntil'],
            ),
      fineWarnedAt: jsonSerialization['fineWarnedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['fineWarnedAt'],
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

  _isc.UuidValue authUserId;

  /// -100 .. 100: how the Authority regards them
  int standing;

  int missionsDone;

  /// WYRD's own notes on this citizen (it writes these), at most ~1,200 characters
  String? record;

  /// the mission WYRD has given them and not yet seen done, as JSON
  String? mission;

  /// the player agreed to let WYRD learn from their play (asked once, changeable any time)
  bool trainingOptIn;

  /// whether they've been asked yet
  bool trainingAsked;

  /// the player's naira (starts at 5,000); only the server changes it
  int naira;

  /// their home in the city, if any: its slug, 'rent' or 'own', and (renting) paid up to when
  String? homeSlug;

  String? homeMode;

  DateTime? rentPaidUntil;

  /// street-board missions already paid today, as JSON {day, ids}
  String? paidToday;

  /// the first-time guide steps done (and paid), as a JSON list
  String? guideDone;

  /// the story: reputation (district, faction, social), the branching missions' progress, and what
  /// the city remembers of you -- JSON, written only by StoryService
  String? story;

  /// naira owed on a payment plan (fines over the floor, fares on credit): at most 10,000, no interest; a fifth of
  /// each payout goes to it. Changed only by Bank, like naira
  int debt;

  /// since when something has been owed (debt under 2,000 owed for 30 days is forgiven)
  DateTime? debtSince;

  /// rent fell due and couldn't be paid: the home is kept until this date (two weeks from the first visit it was due)
  DateTime? rentGraceUntil;

  /// the last police stop let off with a warning (one warning a day)
  DateTime? fineWarnedAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WorldCitizen copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    int? naira,
    String? homeSlug,
    String? homeMode,
    DateTime? rentPaidUntil,
    String? paidToday,
    String? guideDone,
    String? story,
    int? debt,
    DateTime? debtSince,
    DateTime? rentGraceUntil,
    DateTime? fineWarnedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorldCitizen',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'standing': standing,
      'missionsDone': missionsDone,
      if (record != null) 'record': record,
      if (mission != null) 'mission': mission,
      'trainingOptIn': trainingOptIn,
      'trainingAsked': trainingAsked,
      'naira': naira,
      if (homeSlug != null) 'homeSlug': homeSlug,
      if (homeMode != null) 'homeMode': homeMode,
      if (rentPaidUntil != null) 'rentPaidUntil': rentPaidUntil?.toJson(),
      if (paidToday != null) 'paidToday': paidToday,
      if (guideDone != null) 'guideDone': guideDone,
      if (story != null) 'story': story,
      'debt': debt,
      if (debtSince != null) 'debtSince': debtSince?.toJson(),
      if (rentGraceUntil != null) 'rentGraceUntil': rentGraceUntil?.toJson(),
      if (fineWarnedAt != null) 'fineWarnedAt': fineWarnedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorldCitizen',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'standing': standing,
      'missionsDone': missionsDone,
      if (record != null) 'record': record,
      if (mission != null) 'mission': mission,
      'trainingOptIn': trainingOptIn,
      'trainingAsked': trainingAsked,
      'naira': naira,
      if (homeSlug != null) 'homeSlug': homeSlug,
      if (homeMode != null) 'homeMode': homeMode,
      if (rentPaidUntil != null) 'rentPaidUntil': rentPaidUntil?.toJson(),
      if (paidToday != null) 'paidToday': paidToday,
      if (guideDone != null) 'guideDone': guideDone,
      if (story != null) 'story': story,
      'debt': debt,
      if (debtSince != null) 'debtSince': debtSince?.toJson(),
      if (rentGraceUntil != null) 'rentGraceUntil': rentGraceUntil?.toJson(),
      if (fineWarnedAt != null) 'fineWarnedAt': fineWarnedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorldCitizenImpl extends WorldCitizen {
  _WorldCitizenImpl({
    int? id,
    required _isc.UuidValue authUserId,
    int? standing,
    int? missionsDone,
    String? record,
    String? mission,
    bool? trainingOptIn,
    bool? trainingAsked,
    int? naira,
    String? homeSlug,
    String? homeMode,
    DateTime? rentPaidUntil,
    String? paidToday,
    String? guideDone,
    String? story,
    int? debt,
    DateTime? debtSince,
    DateTime? rentGraceUntil,
    DateTime? fineWarnedAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         standing: standing,
         missionsDone: missionsDone,
         record: record,
         mission: mission,
         trainingOptIn: trainingOptIn,
         trainingAsked: trainingAsked,
         naira: naira,
         homeSlug: homeSlug,
         homeMode: homeMode,
         rentPaidUntil: rentPaidUntil,
         paidToday: paidToday,
         guideDone: guideDone,
         story: story,
         debt: debt,
         debtSince: debtSince,
         rentGraceUntil: rentGraceUntil,
         fineWarnedAt: fineWarnedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WorldCitizen copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    int? standing,
    int? missionsDone,
    Object? record = _Undefined,
    Object? mission = _Undefined,
    bool? trainingOptIn,
    bool? trainingAsked,
    int? naira,
    Object? homeSlug = _Undefined,
    Object? homeMode = _Undefined,
    Object? rentPaidUntil = _Undefined,
    Object? paidToday = _Undefined,
    Object? guideDone = _Undefined,
    Object? story = _Undefined,
    int? debt,
    Object? debtSince = _Undefined,
    Object? rentGraceUntil = _Undefined,
    Object? fineWarnedAt = _Undefined,
    DateTime? updatedAt,
  }) {
    return WorldCitizen(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      standing: standing ?? this.standing,
      missionsDone: missionsDone ?? this.missionsDone,
      record: record is String? ? record : this.record,
      mission: mission is String? ? mission : this.mission,
      trainingOptIn: trainingOptIn ?? this.trainingOptIn,
      trainingAsked: trainingAsked ?? this.trainingAsked,
      naira: naira ?? this.naira,
      homeSlug: homeSlug is String? ? homeSlug : this.homeSlug,
      homeMode: homeMode is String? ? homeMode : this.homeMode,
      rentPaidUntil: rentPaidUntil is DateTime?
          ? rentPaidUntil
          : this.rentPaidUntil,
      paidToday: paidToday is String? ? paidToday : this.paidToday,
      guideDone: guideDone is String? ? guideDone : this.guideDone,
      story: story is String? ? story : this.story,
      debt: debt ?? this.debt,
      debtSince: debtSince is DateTime? ? debtSince : this.debtSince,
      rentGraceUntil: rentGraceUntil is DateTime?
          ? rentGraceUntil
          : this.rentGraceUntil,
      fineWarnedAt: fineWarnedAt is DateTime?
          ? fineWarnedAt
          : this.fineWarnedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
