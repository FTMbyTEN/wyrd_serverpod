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

/// A goal WYRD works at on its own: researched step by step in the background, once or on a
/// schedule, pausing for the owner's approval before anything with consequences.
abstract class AgentTask
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AgentTask._({
    this.id,
    required this.authUserId,
    required this.goal,
    this.everyHours,
    required this.status,
    this.result,
    this.previousResult,
    this.notes,
    this.transcript,
    this.pendingAction,
    required this.stepsUsed,
    required this.maxSteps,
    required this.runs,
    required this.unread,
    required this.nextRunAt,
    this.lastRunAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgentTask({
    int? id,
    required _is.UuidValue authUserId,
    required String goal,
    int? everyHours,
    required String status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    required int stepsUsed,
    required int maxSteps,
    required int runs,
    required bool unread,
    required DateTime nextRunAt,
    DateTime? lastRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AgentTaskImpl;

  factory AgentTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentTask(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      goal: jsonSerialization['goal'] as String,
      everyHours: jsonSerialization['everyHours'] as int?,
      status: jsonSerialization['status'] as String,
      result: jsonSerialization['result'] as String?,
      previousResult: jsonSerialization['previousResult'] as String?,
      notes: jsonSerialization['notes'] as String?,
      transcript: jsonSerialization['transcript'] as String?,
      pendingAction: jsonSerialization['pendingAction'] as String?,
      stepsUsed: jsonSerialization['stepsUsed'] as int,
      maxSteps: jsonSerialization['maxSteps'] as int,
      runs: jsonSerialization['runs'] as int,
      unread: _is.BoolJsonExtension.fromJson(jsonSerialization['unread']),
      nextRunAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['nextRunAt'],
      ),
      lastRunAt: jsonSerialization['lastRunAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastRunAt']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AgentTaskTable();

  static const db = AgentTaskRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String goal;

  int? everyHours;

  String status;

  String? result;

  String? previousResult;

  String? notes;

  String? transcript;

  String? pendingAction;

  int stepsUsed;

  int maxSteps;

  int runs;

  bool unread;

  DateTime nextRunAt;

  DateTime? lastRunAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AgentTask]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AgentTask copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? goal,
    int? everyHours,
    String? status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    int? stepsUsed,
    int? maxSteps,
    int? runs,
    bool? unread,
    DateTime? nextRunAt,
    DateTime? lastRunAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentTask',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'goal': goal,
      if (everyHours != null) 'everyHours': everyHours,
      'status': status,
      if (result != null) 'result': result,
      if (previousResult != null) 'previousResult': previousResult,
      if (notes != null) 'notes': notes,
      if (transcript != null) 'transcript': transcript,
      if (pendingAction != null) 'pendingAction': pendingAction,
      'stepsUsed': stepsUsed,
      'maxSteps': maxSteps,
      'runs': runs,
      'unread': unread,
      'nextRunAt': nextRunAt.toJson(),
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentTask',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'goal': goal,
      if (everyHours != null) 'everyHours': everyHours,
      'status': status,
      if (result != null) 'result': result,
      if (previousResult != null) 'previousResult': previousResult,
      if (notes != null) 'notes': notes,
      if (transcript != null) 'transcript': transcript,
      if (pendingAction != null) 'pendingAction': pendingAction,
      'stepsUsed': stepsUsed,
      'maxSteps': maxSteps,
      'runs': runs,
      'unread': unread,
      'nextRunAt': nextRunAt.toJson(),
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AgentTaskInclude include() {
    return AgentTaskInclude._();
  }

  static AgentTaskIncludeList includeList({
    _is.WhereExpressionBuilder<AgentTaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    AgentTaskInclude? include,
  }) {
    return AgentTaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentTaskImpl extends AgentTask {
  _AgentTaskImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String goal,
    int? everyHours,
    required String status,
    String? result,
    String? previousResult,
    String? notes,
    String? transcript,
    String? pendingAction,
    required int stepsUsed,
    required int maxSteps,
    required int runs,
    required bool unread,
    required DateTime nextRunAt,
    DateTime? lastRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         goal: goal,
         everyHours: everyHours,
         status: status,
         result: result,
         previousResult: previousResult,
         notes: notes,
         transcript: transcript,
         pendingAction: pendingAction,
         stepsUsed: stepsUsed,
         maxSteps: maxSteps,
         runs: runs,
         unread: unread,
         nextRunAt: nextRunAt,
         lastRunAt: lastRunAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AgentTask]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AgentTask copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? goal,
    Object? everyHours = _Undefined,
    String? status,
    Object? result = _Undefined,
    Object? previousResult = _Undefined,
    Object? notes = _Undefined,
    Object? transcript = _Undefined,
    Object? pendingAction = _Undefined,
    int? stepsUsed,
    int? maxSteps,
    int? runs,
    bool? unread,
    DateTime? nextRunAt,
    Object? lastRunAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AgentTask(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      goal: goal ?? this.goal,
      everyHours: everyHours is int? ? everyHours : this.everyHours,
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      previousResult: previousResult is String?
          ? previousResult
          : this.previousResult,
      notes: notes is String? ? notes : this.notes,
      transcript: transcript is String? ? transcript : this.transcript,
      pendingAction: pendingAction is String?
          ? pendingAction
          : this.pendingAction,
      stepsUsed: stepsUsed ?? this.stepsUsed,
      maxSteps: maxSteps ?? this.maxSteps,
      runs: runs ?? this.runs,
      unread: unread ?? this.unread,
      nextRunAt: nextRunAt ?? this.nextRunAt,
      lastRunAt: lastRunAt is DateTime? ? lastRunAt : this.lastRunAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AgentTaskUpdateTable extends _is.UpdateTable<AgentTaskTable> {
  AgentTaskUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> goal(String value) => _is.ColumnValue(
    table.goal,
    value,
  );

  _is.ColumnValue<int, int> everyHours(int? value) => _is.ColumnValue(
    table.everyHours,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> result(String? value) => _is.ColumnValue(
    table.result,
    value,
  );

  _is.ColumnValue<String, String> previousResult(String? value) =>
      _is.ColumnValue(
        table.previousResult,
        value,
      );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<String, String> transcript(String? value) => _is.ColumnValue(
    table.transcript,
    value,
  );

  _is.ColumnValue<String, String> pendingAction(String? value) =>
      _is.ColumnValue(
        table.pendingAction,
        value,
      );

  _is.ColumnValue<int, int> stepsUsed(int value) => _is.ColumnValue(
    table.stepsUsed,
    value,
  );

  _is.ColumnValue<int, int> maxSteps(int value) => _is.ColumnValue(
    table.maxSteps,
    value,
  );

  _is.ColumnValue<int, int> runs(int value) => _is.ColumnValue(
    table.runs,
    value,
  );

  _is.ColumnValue<bool, bool> unread(bool value) => _is.ColumnValue(
    table.unread,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> nextRunAt(DateTime value) =>
      _is.ColumnValue(
        table.nextRunAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastRunAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastRunAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class AgentTaskTable extends _is.Table<int?> {
  AgentTaskTable({super.tableRelation}) : super(tableName: 'agent_task') {
    updateTable = AgentTaskUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    goal = _is.ColumnString(
      'goal',
      this,
    );
    everyHours = _is.ColumnInt(
      'everyHours',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    result = _is.ColumnString(
      'result',
      this,
    );
    previousResult = _is.ColumnString(
      'previousResult',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    transcript = _is.ColumnString(
      'transcript',
      this,
    );
    pendingAction = _is.ColumnString(
      'pendingAction',
      this,
    );
    stepsUsed = _is.ColumnInt(
      'stepsUsed',
      this,
    );
    maxSteps = _is.ColumnInt(
      'maxSteps',
      this,
    );
    runs = _is.ColumnInt(
      'runs',
      this,
    );
    unread = _is.ColumnBool(
      'unread',
      this,
    );
    nextRunAt = _is.ColumnDateTime(
      'nextRunAt',
      this,
    );
    lastRunAt = _is.ColumnDateTime(
      'lastRunAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final AgentTaskUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString goal;

  late final _is.ColumnInt everyHours;

  late final _is.ColumnString status;

  late final _is.ColumnString result;

  late final _is.ColumnString previousResult;

  late final _is.ColumnString notes;

  late final _is.ColumnString transcript;

  late final _is.ColumnString pendingAction;

  late final _is.ColumnInt stepsUsed;

  late final _is.ColumnInt maxSteps;

  late final _is.ColumnInt runs;

  late final _is.ColumnBool unread;

  late final _is.ColumnDateTime nextRunAt;

  late final _is.ColumnDateTime lastRunAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    goal,
    everyHours,
    status,
    result,
    previousResult,
    notes,
    transcript,
    pendingAction,
    stepsUsed,
    maxSteps,
    runs,
    unread,
    nextRunAt,
    lastRunAt,
    createdAt,
    updatedAt,
  ];
}

class AgentTaskInclude extends _is.IncludeObject {
  AgentTaskInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AgentTask.t;
}

class AgentTaskIncludeList extends _is.IncludeList {
  AgentTaskIncludeList._({
    _is.WhereExpressionBuilder<AgentTaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AgentTask.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AgentTask.t;
}

class AgentTaskRepository {
  const AgentTaskRepository._();

  /// Returns a list of [AgentTask]s matching the given query parameters.
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
  Future<List<AgentTask>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentTaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AgentTask>(
      where: where?.call(AgentTask.t),
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AgentTask] matching the given query parameters.
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
  Future<AgentTask?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentTaskTable>? where,
    int? offset,
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AgentTask>(
      where: where?.call(AgentTask.t),
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AgentTask] by its [id] or null if no such row exists.
  Future<AgentTask?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AgentTask>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AgentTask]s in the list and returns the inserted rows.
  ///
  /// The returned [AgentTask]s will have their `id` fields set.
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
  Future<List<AgentTask>> insert(
    _is.DatabaseSession session,
    List<AgentTask> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AgentTask>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AgentTask] and returns the inserted row.
  ///
  /// The returned [AgentTask] will have its `id` field set.
  Future<AgentTask> insertRow(
    _is.DatabaseSession session,
    AgentTask row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AgentTask>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AgentTask]s in the list and returns the resulting rows.
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
  /// The returned [AgentTask]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentTask>> upsert(
    _is.DatabaseSession session,
    List<AgentTask> rows, {
    required _is.ColumnSelections<AgentTaskTable> conflictColumns,
    _is.ColumnSelections<AgentTaskTable>? updateColumns,
    _is.WhereExpressionBuilder<AgentTaskTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AgentTask>(
      rows,
      conflictColumns: conflictColumns(AgentTask.t),
      updateColumns: updateColumns?.call(AgentTask.t),
      updateWhere: updateWhere?.call(AgentTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AgentTask] and returns the resulting row.
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
  /// The returned [AgentTask] will have its `id` field set.
  Future<AgentTask?> upsertRow(
    _is.DatabaseSession session,
    AgentTask row, {
    required _is.ColumnSelections<AgentTaskTable> conflictColumns,
    _is.ColumnSelections<AgentTaskTable>? updateColumns,
    _is.WhereExpressionBuilder<AgentTaskTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AgentTask>(
      row,
      conflictColumns: conflictColumns(AgentTask.t),
      updateColumns: updateColumns?.call(AgentTask.t),
      updateWhere: updateWhere?.call(AgentTask.t),
      transaction: transaction,
    );
  }

  /// Updates all [AgentTask]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentTask>> update(
    _is.DatabaseSession session,
    List<AgentTask> rows, {
    _is.ColumnSelections<AgentTaskTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AgentTask>(
      rows,
      columns: columns?.call(AgentTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AgentTask]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AgentTask> updateRow(
    _is.DatabaseSession session,
    AgentTask row, {
    _is.ColumnSelections<AgentTaskTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AgentTask>(
      row,
      columns: columns?.call(AgentTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AgentTask] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AgentTask?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AgentTaskUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AgentTask>(
      id,
      columnValues: columnValues(AgentTask.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AgentTask]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentTask>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AgentTaskUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AgentTaskTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AgentTask>(
      columnValues: columnValues(AgentTask.t.updateTable),
      where: where(AgentTask.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AgentTask]s in the list and returns the deleted rows.
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
  Future<List<AgentTask>> delete(
    _is.DatabaseSession session,
    List<AgentTask> rows, {
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AgentTask>(
      rows,
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AgentTask].
  Future<AgentTask> deleteRow(
    _is.DatabaseSession session,
    AgentTask row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AgentTask>(
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
  Future<List<AgentTask>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgentTaskTable> where,
    _is.OrderByBuilder<AgentTaskTable>? orderBy,
    _is.OrderByListBuilder<AgentTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AgentTask>(
      where: where(AgentTask.t),
      orderBy: orderBy?.call(AgentTask.t),
      orderByList: orderByList?.call(AgentTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentTaskTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AgentTask>(
      where: where?.call(AgentTask.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AgentTask] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgentTaskTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AgentTask>(
      where: where(AgentTask.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
