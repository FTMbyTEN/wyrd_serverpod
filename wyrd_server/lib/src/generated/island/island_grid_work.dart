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

/// A Grid shift or certification exam the server dealt: [spec] holds what was dealt, including the answers, which
/// the phone never sees. The result is graded here from what the player did, once.
abstract class IslandGridWork
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandGridWork._({
    this.id,
    required this.authUserId,
    required this.kind,
    required this.track,
    required this.level,
    required this.spec,
    required this.status,
    this.score,
    this.paid,
    required this.issuedAt,
    this.doneAt,
  });

  factory IslandGridWork({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String track,
    required int level,
    required String spec,
    required String status,
    int? score,
    int? paid,
    required DateTime issuedAt,
    DateTime? doneAt,
  }) = _IslandGridWorkImpl;

  factory IslandGridWork.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGridWork(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      kind: jsonSerialization['kind'] as String,
      track: jsonSerialization['track'] as String,
      level: jsonSerialization['level'] as int,
      spec: jsonSerialization['spec'] as String,
      status: jsonSerialization['status'] as String,
      score: jsonSerialization['score'] as int?,
      paid: jsonSerialization['paid'] as int?,
      issuedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  static final t = IslandGridWorkTable();

  static const db = IslandGridWorkRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// shift | exam
  String kind;

  String track;

  int level;

  String spec;

  /// open | done | void
  String status;

  int? score;

  int? paid;

  DateTime issuedAt;

  DateTime? doneAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandGridWork]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandGridWork copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? kind,
    String? track,
    int? level,
    String? spec,
    String? status,
    int? score,
    int? paid,
    DateTime? issuedAt,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGridWork',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'track': track,
      'level': level,
      'spec': spec,
      'status': status,
      if (score != null) 'score': score,
      if (paid != null) 'paid': paid,
      'issuedAt': issuedAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGridWork',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'track': track,
      'level': level,
      'spec': spec,
      'status': status,
      if (score != null) 'score': score,
      if (paid != null) 'paid': paid,
      'issuedAt': issuedAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  static IslandGridWorkInclude include() {
    return IslandGridWorkInclude._();
  }

  static IslandGridWorkIncludeList includeList({
    _is.WhereExpressionBuilder<IslandGridWorkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    IslandGridWorkInclude? include,
  }) {
    return IslandGridWorkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGridWorkImpl extends IslandGridWork {
  _IslandGridWorkImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String track,
    required int level,
    required String spec,
    required String status,
    int? score,
    int? paid,
    required DateTime issuedAt,
    DateTime? doneAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         kind: kind,
         track: track,
         level: level,
         spec: spec,
         status: status,
         score: score,
         paid: paid,
         issuedAt: issuedAt,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [IslandGridWork]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandGridWork copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? kind,
    String? track,
    int? level,
    String? spec,
    String? status,
    Object? score = _Undefined,
    Object? paid = _Undefined,
    DateTime? issuedAt,
    Object? doneAt = _Undefined,
  }) {
    return IslandGridWork(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      kind: kind ?? this.kind,
      track: track ?? this.track,
      level: level ?? this.level,
      spec: spec ?? this.spec,
      status: status ?? this.status,
      score: score is int? ? score : this.score,
      paid: paid is int? ? paid : this.paid,
      issuedAt: issuedAt ?? this.issuedAt,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}

class IslandGridWorkUpdateTable extends _is.UpdateTable<IslandGridWorkTable> {
  IslandGridWorkUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> track(String value) => _is.ColumnValue(
    table.track,
    value,
  );

  _is.ColumnValue<int, int> level(int value) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<String, String> spec(String value) => _is.ColumnValue(
    table.spec,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> score(int? value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<int, int> paid(int? value) => _is.ColumnValue(
    table.paid,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _is.ColumnValue(
        table.issuedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> doneAt(DateTime? value) =>
      _is.ColumnValue(
        table.doneAt,
        value,
      );
}

class IslandGridWorkTable extends _is.Table<int?> {
  IslandGridWorkTable({super.tableRelation})
    : super(tableName: 'island_grid_work') {
    updateTable = IslandGridWorkUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    track = _is.ColumnString(
      'track',
      this,
    );
    level = _is.ColumnInt(
      'level',
      this,
    );
    spec = _is.ColumnString(
      'spec',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    score = _is.ColumnInt(
      'score',
      this,
    );
    paid = _is.ColumnInt(
      'paid',
      this,
    );
    issuedAt = _is.ColumnDateTime(
      'issuedAt',
      this,
    );
    doneAt = _is.ColumnDateTime(
      'doneAt',
      this,
    );
  }

  late final IslandGridWorkUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// shift | exam
  late final _is.ColumnString kind;

  late final _is.ColumnString track;

  late final _is.ColumnInt level;

  late final _is.ColumnString spec;

  /// open | done | void
  late final _is.ColumnString status;

  late final _is.ColumnInt score;

  late final _is.ColumnInt paid;

  late final _is.ColumnDateTime issuedAt;

  late final _is.ColumnDateTime doneAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    kind,
    track,
    level,
    spec,
    status,
    score,
    paid,
    issuedAt,
    doneAt,
  ];
}

class IslandGridWorkInclude extends _is.IncludeObject {
  IslandGridWorkInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandGridWork.t;
}

class IslandGridWorkIncludeList extends _is.IncludeList {
  IslandGridWorkIncludeList._({
    _is.WhereExpressionBuilder<IslandGridWorkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandGridWork.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandGridWork.t;
}

class IslandGridWorkRepository {
  const IslandGridWorkRepository._();

  /// Returns a list of [IslandGridWork]s matching the given query parameters.
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
  Future<List<IslandGridWork>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridWorkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandGridWork>(
      where: where?.call(IslandGridWork.t),
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandGridWork] matching the given query parameters.
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
  Future<IslandGridWork?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridWorkTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandGridWork>(
      where: where?.call(IslandGridWork.t),
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandGridWork] by its [id] or null if no such row exists.
  Future<IslandGridWork?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandGridWork>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandGridWork]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandGridWork]s will have their `id` fields set.
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
  Future<List<IslandGridWork>> insert(
    _is.DatabaseSession session,
    List<IslandGridWork> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandGridWork>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandGridWork] and returns the inserted row.
  ///
  /// The returned [IslandGridWork] will have its `id` field set.
  Future<IslandGridWork> insertRow(
    _is.DatabaseSession session,
    IslandGridWork row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandGridWork>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandGridWork]s in the list and returns the resulting rows.
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
  /// The returned [IslandGridWork]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridWork>> upsert(
    _is.DatabaseSession session,
    List<IslandGridWork> rows, {
    required _is.ColumnSelections<IslandGridWorkTable> conflictColumns,
    _is.ColumnSelections<IslandGridWorkTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGridWorkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandGridWork>(
      rows,
      conflictColumns: conflictColumns(IslandGridWork.t),
      updateColumns: updateColumns?.call(IslandGridWork.t),
      updateWhere: updateWhere?.call(IslandGridWork.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandGridWork] and returns the resulting row.
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
  /// The returned [IslandGridWork] will have its `id` field set.
  Future<IslandGridWork?> upsertRow(
    _is.DatabaseSession session,
    IslandGridWork row, {
    required _is.ColumnSelections<IslandGridWorkTable> conflictColumns,
    _is.ColumnSelections<IslandGridWorkTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGridWorkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandGridWork>(
      row,
      conflictColumns: conflictColumns(IslandGridWork.t),
      updateColumns: updateColumns?.call(IslandGridWork.t),
      updateWhere: updateWhere?.call(IslandGridWork.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGridWork]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridWork>> update(
    _is.DatabaseSession session,
    List<IslandGridWork> rows, {
    _is.ColumnSelections<IslandGridWorkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandGridWork>(
      rows,
      columns: columns?.call(IslandGridWork.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandGridWork]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandGridWork> updateRow(
    _is.DatabaseSession session,
    IslandGridWork row, {
    _is.ColumnSelections<IslandGridWorkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandGridWork>(
      row,
      columns: columns?.call(IslandGridWork.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandGridWork] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandGridWork?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandGridWorkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandGridWork>(
      id,
      columnValues: columnValues(IslandGridWork.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGridWork]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridWork>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandGridWorkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandGridWorkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandGridWork>(
      columnValues: columnValues(IslandGridWork.t.updateTable),
      where: where(IslandGridWork.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandGridWork]s in the list and returns the deleted rows.
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
  Future<List<IslandGridWork>> delete(
    _is.DatabaseSession session,
    List<IslandGridWork> rows, {
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandGridWork>(
      rows,
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandGridWork].
  Future<IslandGridWork> deleteRow(
    _is.DatabaseSession session,
    IslandGridWork row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandGridWork>(
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
  Future<List<IslandGridWork>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGridWorkTable> where,
    _is.OrderByBuilder<IslandGridWorkTable>? orderBy,
    _is.OrderByListBuilder<IslandGridWorkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandGridWork>(
      where: where(IslandGridWork.t),
      orderBy: orderBy?.call(IslandGridWork.t),
      orderByList: orderByList?.call(IslandGridWork.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridWorkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandGridWork>(
      where: where?.call(IslandGridWork.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandGridWork] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGridWorkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandGridWork>(
      where: where(IslandGridWork.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
