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

/// Where a player stands with the police, held by the server (Fair Streets): their heat (stars are its whole part),
/// the wanted state machine's state and its timers, the Calm streets setting, and when they last made each call.
abstract class WantedState
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WantedState._({
    this.id,
    required this.authUserId,
    double? heat,
    String? state,
    required this.stateAt,
    this.pursuitAt,
    this.lastPursuitAt,
    this.lastStopAt,
    this.lostSince,
    this.complyingSince,
    this.nearSince,
    this.searchUntil,
    bool? calm,
    this.calls,
    required this.updatedAt,
  }) : heat = heat ?? 0.0,
       state = state ?? 'clear',
       calm = calm ?? false;

  factory WantedState({
    int? id,
    required _is.UuidValue authUserId,
    double? heat,
    String? state,
    required DateTime stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    required DateTime updatedAt,
  }) = _WantedStateImpl;

  factory WantedState.fromJson(Map<String, dynamic> jsonSerialization) {
    return WantedState(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      heat: (jsonSerialization['heat'] as num?)?.toDouble(),
      state: jsonSerialization['state'] as String?,
      stateAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['stateAt']),
      pursuitAt: jsonSerialization['pursuitAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['pursuitAt']),
      lastPursuitAt: jsonSerialization['lastPursuitAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastPursuitAt'],
            ),
      lastStopAt: jsonSerialization['lastStopAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastStopAt']),
      lostSince: jsonSerialization['lostSince'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lostSince']),
      complyingSince: jsonSerialization['complyingSince'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['complyingSince'],
            ),
      nearSince: jsonSerialization['nearSince'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['nearSince']),
      searchUntil: jsonSerialization['searchUntil'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['searchUntil'],
            ),
      calm: jsonSerialization['calm'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['calm']),
      calls: jsonSerialization['calls'] as String?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WantedStateTable();

  static const db = WantedStateRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  double heat;

  /// clear | watched | pursuit | complying | searching | cooling
  String state;

  DateTime stateAt;

  DateTime? pursuitAt;

  DateTime? lastPursuitAt;

  DateTime? lastStopAt;

  DateTime? lostSince;

  DateTime? complyingSince;

  DateTime? nearSince;

  DateTime? searchUntil;

  /// pursuits become posted citations
  bool calm;

  /// when each contact was last called, JSON {id: iso}
  String? calls;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WantedState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WantedState copyWith({
    int? id,
    _is.UuidValue? authUserId,
    double? heat,
    String? state,
    DateTime? stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WantedState',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'heat': heat,
      'state': state,
      'stateAt': stateAt.toJson(),
      if (pursuitAt != null) 'pursuitAt': pursuitAt?.toJson(),
      if (lastPursuitAt != null) 'lastPursuitAt': lastPursuitAt?.toJson(),
      if (lastStopAt != null) 'lastStopAt': lastStopAt?.toJson(),
      if (lostSince != null) 'lostSince': lostSince?.toJson(),
      if (complyingSince != null) 'complyingSince': complyingSince?.toJson(),
      if (nearSince != null) 'nearSince': nearSince?.toJson(),
      if (searchUntil != null) 'searchUntil': searchUntil?.toJson(),
      'calm': calm,
      if (calls != null) 'calls': calls,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WantedState',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'heat': heat,
      'state': state,
      'stateAt': stateAt.toJson(),
      if (pursuitAt != null) 'pursuitAt': pursuitAt?.toJson(),
      if (lastPursuitAt != null) 'lastPursuitAt': lastPursuitAt?.toJson(),
      if (lastStopAt != null) 'lastStopAt': lastStopAt?.toJson(),
      if (lostSince != null) 'lostSince': lostSince?.toJson(),
      if (complyingSince != null) 'complyingSince': complyingSince?.toJson(),
      if (nearSince != null) 'nearSince': nearSince?.toJson(),
      if (searchUntil != null) 'searchUntil': searchUntil?.toJson(),
      'calm': calm,
      if (calls != null) 'calls': calls,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WantedStateInclude include() {
    return WantedStateInclude._();
  }

  static WantedStateIncludeList includeList({
    _is.WhereExpressionBuilder<WantedStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    WantedStateInclude? include,
  }) {
    return WantedStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WantedStateImpl extends WantedState {
  _WantedStateImpl({
    int? id,
    required _is.UuidValue authUserId,
    double? heat,
    String? state,
    required DateTime stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         heat: heat,
         state: state,
         stateAt: stateAt,
         pursuitAt: pursuitAt,
         lastPursuitAt: lastPursuitAt,
         lastStopAt: lastStopAt,
         lostSince: lostSince,
         complyingSince: complyingSince,
         nearSince: nearSince,
         searchUntil: searchUntil,
         calm: calm,
         calls: calls,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WantedState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WantedState copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    double? heat,
    String? state,
    DateTime? stateAt,
    Object? pursuitAt = _Undefined,
    Object? lastPursuitAt = _Undefined,
    Object? lastStopAt = _Undefined,
    Object? lostSince = _Undefined,
    Object? complyingSince = _Undefined,
    Object? nearSince = _Undefined,
    Object? searchUntil = _Undefined,
    bool? calm,
    Object? calls = _Undefined,
    DateTime? updatedAt,
  }) {
    return WantedState(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      heat: heat ?? this.heat,
      state: state ?? this.state,
      stateAt: stateAt ?? this.stateAt,
      pursuitAt: pursuitAt is DateTime? ? pursuitAt : this.pursuitAt,
      lastPursuitAt: lastPursuitAt is DateTime?
          ? lastPursuitAt
          : this.lastPursuitAt,
      lastStopAt: lastStopAt is DateTime? ? lastStopAt : this.lastStopAt,
      lostSince: lostSince is DateTime? ? lostSince : this.lostSince,
      complyingSince: complyingSince is DateTime?
          ? complyingSince
          : this.complyingSince,
      nearSince: nearSince is DateTime? ? nearSince : this.nearSince,
      searchUntil: searchUntil is DateTime? ? searchUntil : this.searchUntil,
      calm: calm ?? this.calm,
      calls: calls is String? ? calls : this.calls,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WantedStateUpdateTable extends _is.UpdateTable<WantedStateTable> {
  WantedStateUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<double, double> heat(double value) => _is.ColumnValue(
    table.heat,
    value,
  );

  _is.ColumnValue<String, String> state(String value) => _is.ColumnValue(
    table.state,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> stateAt(DateTime value) =>
      _is.ColumnValue(
        table.stateAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> pursuitAt(DateTime? value) =>
      _is.ColumnValue(
        table.pursuitAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastPursuitAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastPursuitAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastStopAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastStopAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lostSince(DateTime? value) =>
      _is.ColumnValue(
        table.lostSince,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> complyingSince(DateTime? value) =>
      _is.ColumnValue(
        table.complyingSince,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> nearSince(DateTime? value) =>
      _is.ColumnValue(
        table.nearSince,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> searchUntil(DateTime? value) =>
      _is.ColumnValue(
        table.searchUntil,
        value,
      );

  _is.ColumnValue<bool, bool> calm(bool value) => _is.ColumnValue(
    table.calm,
    value,
  );

  _is.ColumnValue<String, String> calls(String? value) => _is.ColumnValue(
    table.calls,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class WantedStateTable extends _is.Table<int?> {
  WantedStateTable({super.tableRelation}) : super(tableName: 'wanted_state') {
    updateTable = WantedStateUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    heat = _is.ColumnDouble(
      'heat',
      this,
      hasDefault: true,
    );
    state = _is.ColumnString(
      'state',
      this,
      hasDefault: true,
    );
    stateAt = _is.ColumnDateTime(
      'stateAt',
      this,
    );
    pursuitAt = _is.ColumnDateTime(
      'pursuitAt',
      this,
    );
    lastPursuitAt = _is.ColumnDateTime(
      'lastPursuitAt',
      this,
    );
    lastStopAt = _is.ColumnDateTime(
      'lastStopAt',
      this,
    );
    lostSince = _is.ColumnDateTime(
      'lostSince',
      this,
    );
    complyingSince = _is.ColumnDateTime(
      'complyingSince',
      this,
    );
    nearSince = _is.ColumnDateTime(
      'nearSince',
      this,
    );
    searchUntil = _is.ColumnDateTime(
      'searchUntil',
      this,
    );
    calm = _is.ColumnBool(
      'calm',
      this,
      hasDefault: true,
    );
    calls = _is.ColumnString(
      'calls',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final WantedStateUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnDouble heat;

  /// clear | watched | pursuit | complying | searching | cooling
  late final _is.ColumnString state;

  late final _is.ColumnDateTime stateAt;

  late final _is.ColumnDateTime pursuitAt;

  late final _is.ColumnDateTime lastPursuitAt;

  late final _is.ColumnDateTime lastStopAt;

  late final _is.ColumnDateTime lostSince;

  late final _is.ColumnDateTime complyingSince;

  late final _is.ColumnDateTime nearSince;

  late final _is.ColumnDateTime searchUntil;

  /// pursuits become posted citations
  late final _is.ColumnBool calm;

  /// when each contact was last called, JSON {id: iso}
  late final _is.ColumnString calls;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    heat,
    state,
    stateAt,
    pursuitAt,
    lastPursuitAt,
    lastStopAt,
    lostSince,
    complyingSince,
    nearSince,
    searchUntil,
    calm,
    calls,
    updatedAt,
  ];
}

class WantedStateInclude extends _is.IncludeObject {
  WantedStateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WantedState.t;
}

class WantedStateIncludeList extends _is.IncludeList {
  WantedStateIncludeList._({
    _is.WhereExpressionBuilder<WantedStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WantedState.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WantedState.t;
}

class WantedStateRepository {
  const WantedStateRepository._();

  /// Returns a list of [WantedState]s matching the given query parameters.
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
  Future<List<WantedState>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WantedStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WantedState>(
      where: where?.call(WantedState.t),
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WantedState] matching the given query parameters.
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
  Future<WantedState?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WantedStateTable>? where,
    int? offset,
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WantedState>(
      where: where?.call(WantedState.t),
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WantedState] by its [id] or null if no such row exists.
  Future<WantedState?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WantedState>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WantedState]s in the list and returns the inserted rows.
  ///
  /// The returned [WantedState]s will have their `id` fields set.
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
  Future<List<WantedState>> insert(
    _is.DatabaseSession session,
    List<WantedState> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WantedState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WantedState] and returns the inserted row.
  ///
  /// The returned [WantedState] will have its `id` field set.
  Future<WantedState> insertRow(
    _is.DatabaseSession session,
    WantedState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WantedState>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WantedState]s in the list and returns the resulting rows.
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
  /// The returned [WantedState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WantedState>> upsert(
    _is.DatabaseSession session,
    List<WantedState> rows, {
    required _is.ColumnSelections<WantedStateTable> conflictColumns,
    _is.ColumnSelections<WantedStateTable>? updateColumns,
    _is.WhereExpressionBuilder<WantedStateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WantedState>(
      rows,
      conflictColumns: conflictColumns(WantedState.t),
      updateColumns: updateColumns?.call(WantedState.t),
      updateWhere: updateWhere?.call(WantedState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WantedState] and returns the resulting row.
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
  /// The returned [WantedState] will have its `id` field set.
  Future<WantedState?> upsertRow(
    _is.DatabaseSession session,
    WantedState row, {
    required _is.ColumnSelections<WantedStateTable> conflictColumns,
    _is.ColumnSelections<WantedStateTable>? updateColumns,
    _is.WhereExpressionBuilder<WantedStateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WantedState>(
      row,
      conflictColumns: conflictColumns(WantedState.t),
      updateColumns: updateColumns?.call(WantedState.t),
      updateWhere: updateWhere?.call(WantedState.t),
      transaction: transaction,
    );
  }

  /// Updates all [WantedState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WantedState>> update(
    _is.DatabaseSession session,
    List<WantedState> rows, {
    _is.ColumnSelections<WantedStateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WantedState>(
      rows,
      columns: columns?.call(WantedState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WantedState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WantedState> updateRow(
    _is.DatabaseSession session,
    WantedState row, {
    _is.ColumnSelections<WantedStateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WantedState>(
      row,
      columns: columns?.call(WantedState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WantedState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WantedState?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WantedStateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WantedState>(
      id,
      columnValues: columnValues(WantedState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WantedState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WantedState>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WantedStateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WantedStateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WantedState>(
      columnValues: columnValues(WantedState.t.updateTable),
      where: where(WantedState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WantedState]s in the list and returns the deleted rows.
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
  Future<List<WantedState>> delete(
    _is.DatabaseSession session,
    List<WantedState> rows, {
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WantedState>(
      rows,
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WantedState].
  Future<WantedState> deleteRow(
    _is.DatabaseSession session,
    WantedState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WantedState>(
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
  Future<List<WantedState>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WantedStateTable> where,
    _is.OrderByBuilder<WantedStateTable>? orderBy,
    _is.OrderByListBuilder<WantedStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WantedState>(
      where: where(WantedState.t),
      orderBy: orderBy?.call(WantedState.t),
      orderByList: orderByList?.call(WantedState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WantedStateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WantedState>(
      where: where?.call(WantedState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WantedState] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WantedStateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WantedState>(
      where: where(WantedState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
