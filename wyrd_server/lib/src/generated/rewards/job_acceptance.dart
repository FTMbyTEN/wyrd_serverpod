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

/// A player's accepted job, with the reward snapshot agreed at acceptance and (funded) the reservation's journal.
abstract class JobAcceptance
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue authUserId,
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
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      idemKey: jsonSerialization['idemKey'] as String,
      status: jsonSerialization['status'] as String,
      taskSpec: jsonSerialization['taskSpec'] as String,
      gameReward: jsonSerialization['gameReward'] as int,
      cashKobo: jsonSerialization['cashKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      holdHours: jsonSerialization['holdHours'] as int,
      acceptedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['acceptedAt'],
      ),
      deadline: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      reserveRef: jsonSerialization['reserveRef'] as String?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      note: jsonSerialization['note'] as String?,
    );
  }

  static final t = JobAcceptanceTable();

  static const db = JobAcceptanceRepository._();

  @override
  int? id;

  int offerId;

  _is.UuidValue authUserId;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobAcceptance]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JobAcceptance copyWith({
    int? id,
    int? offerId,
    _is.UuidValue? authUserId,
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

  static JobAcceptanceInclude include() {
    return JobAcceptanceInclude._();
  }

  static JobAcceptanceIncludeList includeList({
    _is.WhereExpressionBuilder<JobAcceptanceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    JobAcceptanceInclude? include,
  }) {
    return JobAcceptanceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAcceptanceImpl extends JobAcceptance {
  _JobAcceptanceImpl({
    int? id,
    required int offerId,
    required _is.UuidValue authUserId,
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
  @_is.useResult
  @override
  JobAcceptance copyWith({
    Object? id = _Undefined,
    int? offerId,
    _is.UuidValue? authUserId,
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

class JobAcceptanceUpdateTable extends _is.UpdateTable<JobAcceptanceTable> {
  JobAcceptanceUpdateTable(super.table);

  _is.ColumnValue<int, int> offerId(int value) => _is.ColumnValue(
    table.offerId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> idemKey(String value) => _is.ColumnValue(
    table.idemKey,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> taskSpec(String value) => _is.ColumnValue(
    table.taskSpec,
    value,
  );

  _is.ColumnValue<int, int> gameReward(int value) => _is.ColumnValue(
    table.gameReward,
    value,
  );

  _is.ColumnValue<int, int> cashKobo(int value) => _is.ColumnValue(
    table.cashKobo,
    value,
  );

  _is.ColumnValue<int, int> feeKobo(int value) => _is.ColumnValue(
    table.feeKobo,
    value,
  );

  _is.ColumnValue<int, int> holdHours(int value) => _is.ColumnValue(
    table.holdHours,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> acceptedAt(DateTime value) =>
      _is.ColumnValue(
        table.acceptedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> deadline(DateTime value) =>
      _is.ColumnValue(
        table.deadline,
        value,
      );

  _is.ColumnValue<String, String> reserveRef(String? value) => _is.ColumnValue(
    table.reserveRef,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );
}

class JobAcceptanceTable extends _is.Table<int?> {
  JobAcceptanceTable({super.tableRelation})
    : super(tableName: 'job_acceptance') {
    updateTable = JobAcceptanceUpdateTable(this);
    offerId = _is.ColumnInt(
      'offerId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    idemKey = _is.ColumnString(
      'idemKey',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    taskSpec = _is.ColumnString(
      'taskSpec',
      this,
    );
    gameReward = _is.ColumnInt(
      'gameReward',
      this,
    );
    cashKobo = _is.ColumnInt(
      'cashKobo',
      this,
    );
    feeKobo = _is.ColumnInt(
      'feeKobo',
      this,
    );
    holdHours = _is.ColumnInt(
      'holdHours',
      this,
    );
    acceptedAt = _is.ColumnDateTime(
      'acceptedAt',
      this,
    );
    deadline = _is.ColumnDateTime(
      'deadline',
      this,
    );
    reserveRef = _is.ColumnString(
      'reserveRef',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
  }

  late final JobAcceptanceUpdateTable updateTable;

  late final _is.ColumnInt offerId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString idemKey;

  /// accepted | completed | review | expired | cancelled | rejected
  late final _is.ColumnString status;

  /// the server's task parameters, JSON (e.g. the delivery distance and time limit)
  late final _is.ColumnString taskSpec;

  late final _is.ColumnInt gameReward;

  late final _is.ColumnInt cashKobo;

  late final _is.ColumnInt feeKobo;

  late final _is.ColumnInt holdHours;

  late final _is.ColumnDateTime acceptedAt;

  late final _is.ColumnDateTime deadline;

  late final _is.ColumnString reserveRef;

  late final _is.ColumnDateTime completedAt;

  /// why it went to review, or was rejected or cancelled
  late final _is.ColumnString note;

  @override
  List<_is.Column> get columns => [
    id,
    offerId,
    authUserId,
    idemKey,
    status,
    taskSpec,
    gameReward,
    cashKobo,
    feeKobo,
    holdHours,
    acceptedAt,
    deadline,
    reserveRef,
    completedAt,
    note,
  ];
}

class JobAcceptanceInclude extends _is.IncludeObject {
  JobAcceptanceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JobAcceptance.t;
}

class JobAcceptanceIncludeList extends _is.IncludeList {
  JobAcceptanceIncludeList._({
    _is.WhereExpressionBuilder<JobAcceptanceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobAcceptance.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JobAcceptance.t;
}

class JobAcceptanceRepository {
  const JobAcceptanceRepository._();

  /// Returns a list of [JobAcceptance]s matching the given query parameters.
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
  Future<List<JobAcceptance>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobAcceptanceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobAcceptance>(
      where: where?.call(JobAcceptance.t),
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobAcceptance] matching the given query parameters.
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
  Future<JobAcceptance?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobAcceptanceTable>? where,
    int? offset,
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobAcceptance>(
      where: where?.call(JobAcceptance.t),
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobAcceptance] by its [id] or null if no such row exists.
  Future<JobAcceptance?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobAcceptance>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobAcceptance]s in the list and returns the inserted rows.
  ///
  /// The returned [JobAcceptance]s will have their `id` fields set.
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
  Future<List<JobAcceptance>> insert(
    _is.DatabaseSession session,
    List<JobAcceptance> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JobAcceptance>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JobAcceptance] and returns the inserted row.
  ///
  /// The returned [JobAcceptance] will have its `id` field set.
  Future<JobAcceptance> insertRow(
    _is.DatabaseSession session,
    JobAcceptance row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobAcceptance>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JobAcceptance]s in the list and returns the resulting rows.
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
  /// The returned [JobAcceptance]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobAcceptance>> upsert(
    _is.DatabaseSession session,
    List<JobAcceptance> rows, {
    required _is.ColumnSelections<JobAcceptanceTable> conflictColumns,
    _is.ColumnSelections<JobAcceptanceTable>? updateColumns,
    _is.WhereExpressionBuilder<JobAcceptanceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JobAcceptance>(
      rows,
      conflictColumns: conflictColumns(JobAcceptance.t),
      updateColumns: updateColumns?.call(JobAcceptance.t),
      updateWhere: updateWhere?.call(JobAcceptance.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JobAcceptance] and returns the resulting row.
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
  /// The returned [JobAcceptance] will have its `id` field set.
  Future<JobAcceptance?> upsertRow(
    _is.DatabaseSession session,
    JobAcceptance row, {
    required _is.ColumnSelections<JobAcceptanceTable> conflictColumns,
    _is.ColumnSelections<JobAcceptanceTable>? updateColumns,
    _is.WhereExpressionBuilder<JobAcceptanceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JobAcceptance>(
      row,
      conflictColumns: conflictColumns(JobAcceptance.t),
      updateColumns: updateColumns?.call(JobAcceptance.t),
      updateWhere: updateWhere?.call(JobAcceptance.t),
      transaction: transaction,
    );
  }

  /// Updates all [JobAcceptance]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobAcceptance>> update(
    _is.DatabaseSession session,
    List<JobAcceptance> rows, {
    _is.ColumnSelections<JobAcceptanceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JobAcceptance>(
      rows,
      columns: columns?.call(JobAcceptance.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JobAcceptance]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobAcceptance> updateRow(
    _is.DatabaseSession session,
    JobAcceptance row, {
    _is.ColumnSelections<JobAcceptanceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobAcceptance>(
      row,
      columns: columns?.call(JobAcceptance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAcceptance] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobAcceptance?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JobAcceptanceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JobAcceptance>(
      id,
      columnValues: columnValues(JobAcceptance.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobAcceptance]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobAcceptance>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JobAcceptanceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JobAcceptanceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JobAcceptance>(
      columnValues: columnValues(JobAcceptance.t.updateTable),
      where: where(JobAcceptance.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JobAcceptance]s in the list and returns the deleted rows.
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
  Future<List<JobAcceptance>> delete(
    _is.DatabaseSession session,
    List<JobAcceptance> rows, {
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JobAcceptance>(
      rows,
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JobAcceptance].
  Future<JobAcceptance> deleteRow(
    _is.DatabaseSession session,
    JobAcceptance row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobAcceptance>(
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
  Future<List<JobAcceptance>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobAcceptanceTable> where,
    _is.OrderByBuilder<JobAcceptanceTable>? orderBy,
    _is.OrderByListBuilder<JobAcceptanceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JobAcceptance>(
      where: where(JobAcceptance.t),
      orderBy: orderBy?.call(JobAcceptance.t),
      orderByList: orderByList?.call(JobAcceptance.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobAcceptanceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JobAcceptance>(
      where: where?.call(JobAcceptance.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobAcceptance] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobAcceptanceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobAcceptance>(
      where: where(JobAcceptance.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
