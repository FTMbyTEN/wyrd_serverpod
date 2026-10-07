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
import 'package:serverpod/serverpod.dart' as _is;

/// What WYRD, as the Authority of the open world, knows of one player: their standing in the city,
/// the missions they've done, and its own short record of them -- kept between visits.
abstract class WorldCitizen
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required this.updatedAt,
  }) : standing = standing ?? 0,
       missionsDone = missionsDone ?? 0,
       trainingOptIn = trainingOptIn ?? false,
       trainingAsked = trainingAsked ?? false,
       naira = naira ?? 5000;

  factory WorldCitizen({
    int? id,
    required _is.UuidValue authUserId,
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
    required DateTime updatedAt,
  }) = _WorldCitizenImpl;

  factory WorldCitizen.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorldCitizen(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      standing: jsonSerialization['standing'] as int?,
      missionsDone: jsonSerialization['missionsDone'] as int?,
      record: jsonSerialization['record'] as String?,
      mission: jsonSerialization['mission'] as String?,
      trainingOptIn: jsonSerialization['trainingOptIn'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['trainingOptIn']),
      trainingAsked: jsonSerialization['trainingAsked'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['trainingAsked']),
      naira: jsonSerialization['naira'] as int?,
      homeSlug: jsonSerialization['homeSlug'] as String?,
      homeMode: jsonSerialization['homeMode'] as String?,
      rentPaidUntil: jsonSerialization['rentPaidUntil'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['rentPaidUntil'],
            ),
      paidToday: jsonSerialization['paidToday'] as String?,
      guideDone: jsonSerialization['guideDone'] as String?,
      story: jsonSerialization['story'] as String?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WorldCitizenTable();

  static const db = WorldCitizenRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

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

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorldCitizen copyWith({
    int? id,
    _is.UuidValue? authUserId,
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
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WorldCitizenInclude include() {
    return WorldCitizenInclude._();
  }

  static WorldCitizenIncludeList includeList({
    _is.WhereExpressionBuilder<WorldCitizenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    WorldCitizenInclude? include,
  }) {
    return WorldCitizenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorldCitizenImpl extends WorldCitizen {
  _WorldCitizenImpl({
    int? id,
    required _is.UuidValue authUserId,
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
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorldCitizen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorldCitizen copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorldCitizenUpdateTable extends _is.UpdateTable<WorldCitizenTable> {
  WorldCitizenUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> standing(int value) => _is.ColumnValue(
    table.standing,
    value,
  );

  _is.ColumnValue<int, int> missionsDone(int value) => _is.ColumnValue(
    table.missionsDone,
    value,
  );

  _is.ColumnValue<String, String> record(String? value) => _is.ColumnValue(
    table.record,
    value,
  );

  _is.ColumnValue<String, String> mission(String? value) => _is.ColumnValue(
    table.mission,
    value,
  );

  _is.ColumnValue<bool, bool> trainingOptIn(bool value) => _is.ColumnValue(
    table.trainingOptIn,
    value,
  );

  _is.ColumnValue<bool, bool> trainingAsked(bool value) => _is.ColumnValue(
    table.trainingAsked,
    value,
  );

  _is.ColumnValue<int, int> naira(int value) => _is.ColumnValue(
    table.naira,
    value,
  );

  _is.ColumnValue<String, String> homeSlug(String? value) => _is.ColumnValue(
    table.homeSlug,
    value,
  );

  _is.ColumnValue<String, String> homeMode(String? value) => _is.ColumnValue(
    table.homeMode,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> rentPaidUntil(DateTime? value) =>
      _is.ColumnValue(
        table.rentPaidUntil,
        value,
      );

  _is.ColumnValue<String, String> paidToday(String? value) => _is.ColumnValue(
    table.paidToday,
    value,
  );

  _is.ColumnValue<String, String> guideDone(String? value) => _is.ColumnValue(
    table.guideDone,
    value,
  );

  _is.ColumnValue<String, String> story(String? value) => _is.ColumnValue(
    table.story,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class WorldCitizenTable extends _is.Table<int?> {
  WorldCitizenTable({super.tableRelation}) : super(tableName: 'world_citizen') {
    updateTable = WorldCitizenUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    standing = _is.ColumnInt(
      'standing',
      this,
      hasDefault: true,
    );
    missionsDone = _is.ColumnInt(
      'missionsDone',
      this,
      hasDefault: true,
    );
    record = _is.ColumnString(
      'record',
      this,
    );
    mission = _is.ColumnString(
      'mission',
      this,
    );
    trainingOptIn = _is.ColumnBool(
      'trainingOptIn',
      this,
      hasDefault: true,
    );
    trainingAsked = _is.ColumnBool(
      'trainingAsked',
      this,
      hasDefault: true,
    );
    naira = _is.ColumnInt(
      'naira',
      this,
      hasDefault: true,
    );
    homeSlug = _is.ColumnString(
      'homeSlug',
      this,
    );
    homeMode = _is.ColumnString(
      'homeMode',
      this,
    );
    rentPaidUntil = _is.ColumnDateTime(
      'rentPaidUntil',
      this,
    );
    paidToday = _is.ColumnString(
      'paidToday',
      this,
    );
    guideDone = _is.ColumnString(
      'guideDone',
      this,
    );
    story = _is.ColumnString(
      'story',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final WorldCitizenUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// -100 .. 100: how the Authority regards them
  late final _is.ColumnInt standing;

  late final _is.ColumnInt missionsDone;

  /// WYRD's own notes on this citizen (it writes these), at most ~1,200 characters
  late final _is.ColumnString record;

  /// the mission WYRD has given them and not yet seen done, as JSON
  late final _is.ColumnString mission;

  /// the player agreed to let WYRD learn from their play (asked once, changeable any time)
  late final _is.ColumnBool trainingOptIn;

  /// whether they've been asked yet
  late final _is.ColumnBool trainingAsked;

  /// the player's naira (starts at 5,000); only the server changes it
  late final _is.ColumnInt naira;

  /// their home in the city, if any: its slug, 'rent' or 'own', and (renting) paid up to when
  late final _is.ColumnString homeSlug;

  late final _is.ColumnString homeMode;

  late final _is.ColumnDateTime rentPaidUntil;

  /// street-board missions already paid today, as JSON {day, ids}
  late final _is.ColumnString paidToday;

  /// the first-time guide steps done (and paid), as a JSON list
  late final _is.ColumnString guideDone;

  /// the story: reputation (district, faction, social), the branching missions' progress, and what
  /// the city remembers of you -- JSON, written only by StoryService
  late final _is.ColumnString story;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    standing,
    missionsDone,
    record,
    mission,
    trainingOptIn,
    trainingAsked,
    naira,
    homeSlug,
    homeMode,
    rentPaidUntil,
    paidToday,
    guideDone,
    story,
    updatedAt,
  ];
}

class WorldCitizenInclude extends _is.IncludeObject {
  WorldCitizenInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WorldCitizen.t;
}

class WorldCitizenIncludeList extends _is.IncludeList {
  WorldCitizenIncludeList._({
    _is.WhereExpressionBuilder<WorldCitizenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorldCitizen.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WorldCitizen.t;
}

class WorldCitizenRepository {
  const WorldCitizenRepository._();

  /// Returns a list of [WorldCitizen]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<WorldCitizen>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorldCitizenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorldCitizen>(
      where: where?.call(WorldCitizen.t),
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorldCitizen] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<WorldCitizen?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorldCitizenTable>? where,
    int? offset,
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorldCitizen>(
      where: where?.call(WorldCitizen.t),
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorldCitizen] by its [id] or null if no such row exists.
  Future<WorldCitizen?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorldCitizen>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorldCitizen]s in the list and returns the inserted rows.
  ///
  /// The returned [WorldCitizen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> insert(
    _is.DatabaseSession session,
    List<WorldCitizen> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WorldCitizen>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WorldCitizen] and returns the inserted row.
  ///
  /// The returned [WorldCitizen] will have its `id` field set.
  Future<WorldCitizen> insertRow(
    _is.DatabaseSession session,
    WorldCitizen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorldCitizen>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WorldCitizen]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [WorldCitizen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> upsert(
    _is.DatabaseSession session,
    List<WorldCitizen> rows, {
    required _is.ColumnSelections<WorldCitizenTable> conflictColumns,
    _is.ColumnSelections<WorldCitizenTable>? updateColumns,
    _is.WhereExpressionBuilder<WorldCitizenTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WorldCitizen>(
      rows,
      conflictColumns: conflictColumns(WorldCitizen.t),
      updateColumns: updateColumns?.call(WorldCitizen.t),
      updateWhere: updateWhere?.call(WorldCitizen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WorldCitizen] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [WorldCitizen] will have its `id` field set.
  Future<WorldCitizen?> upsertRow(
    _is.DatabaseSession session,
    WorldCitizen row, {
    required _is.ColumnSelections<WorldCitizenTable> conflictColumns,
    _is.ColumnSelections<WorldCitizenTable>? updateColumns,
    _is.WhereExpressionBuilder<WorldCitizenTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WorldCitizen>(
      row,
      conflictColumns: conflictColumns(WorldCitizen.t),
      updateColumns: updateColumns?.call(WorldCitizen.t),
      updateWhere: updateWhere?.call(WorldCitizen.t),
      transaction: transaction,
    );
  }

  /// Updates all [WorldCitizen]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> update(
    _is.DatabaseSession session,
    List<WorldCitizen> rows, {
    _is.ColumnSelections<WorldCitizenTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WorldCitizen>(
      rows,
      columns: columns?.call(WorldCitizen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WorldCitizen]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorldCitizen> updateRow(
    _is.DatabaseSession session,
    WorldCitizen row, {
    _is.ColumnSelections<WorldCitizenTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorldCitizen>(
      row,
      columns: columns?.call(WorldCitizen.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorldCitizen] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorldCitizen?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WorldCitizenUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WorldCitizen>(
      id,
      columnValues: columnValues(WorldCitizen.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorldCitizen]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WorldCitizenUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WorldCitizenTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WorldCitizen>(
      columnValues: columnValues(WorldCitizen.t.updateTable),
      where: where(WorldCitizen.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WorldCitizen]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> delete(
    _is.DatabaseSession session,
    List<WorldCitizen> rows, {
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WorldCitizen>(
      rows,
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WorldCitizen].
  Future<WorldCitizen> deleteRow(
    _is.DatabaseSession session,
    WorldCitizen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorldCitizen>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WorldCitizen>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorldCitizenTable> where,
    _is.OrderByBuilder<WorldCitizenTable>? orderBy,
    _is.OrderByListBuilder<WorldCitizenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WorldCitizen>(
      where: where(WorldCitizen.t),
      orderBy: orderBy?.call(WorldCitizen.t),
      orderByList: orderByList?.call(WorldCitizen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WorldCitizenTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WorldCitizen>(
      where: where?.call(WorldCitizen.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorldCitizen] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WorldCitizenTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorldCitizen>(
      where: where(WorldCitizen.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
