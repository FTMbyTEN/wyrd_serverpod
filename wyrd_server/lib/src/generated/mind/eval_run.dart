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

abstract class EvalRun
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EvalRun._({
    this.id,
    required this.startedAt,
    required this.model,
    required this.passed,
    required this.total,
    required this.costMicroUsd,
    required this.ms,
    required this.results,
  });

  factory EvalRun({
    int? id,
    required DateTime startedAt,
    required String model,
    required int passed,
    required int total,
    required int costMicroUsd,
    required int ms,
    required String results,
  }) = _EvalRunImpl;

  factory EvalRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvalRun(
      id: jsonSerialization['id'] as int?,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      model: jsonSerialization['model'] as String,
      passed: jsonSerialization['passed'] as int,
      total: jsonSerialization['total'] as int,
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
      ms: jsonSerialization['ms'] as int,
      results: jsonSerialization['results'] as String,
    );
  }

  static final t = EvalRunTable();

  static const db = EvalRunRepository._();

  @override
  int? id;

  DateTime startedAt;

  String model;

  int passed;

  int total;

  int costMicroUsd;

  int ms;

  String results;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EvalRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EvalRun copyWith({
    int? id,
    DateTime? startedAt,
    String? model,
    int? passed,
    int? total,
    int? costMicroUsd,
    int? ms,
    String? results,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvalRun',
      if (id != null) 'id': id,
      'startedAt': startedAt.toJson(),
      'model': model,
      'passed': passed,
      'total': total,
      'costMicroUsd': costMicroUsd,
      'ms': ms,
      'results': results,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvalRun',
      if (id != null) 'id': id,
      'startedAt': startedAt.toJson(),
      'model': model,
      'passed': passed,
      'total': total,
      'costMicroUsd': costMicroUsd,
      'ms': ms,
      'results': results,
    };
  }

  static EvalRunInclude include() {
    return EvalRunInclude._();
  }

  static EvalRunIncludeList includeList({
    _is.WhereExpressionBuilder<EvalRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    EvalRunInclude? include,
  }) {
    return EvalRunIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvalRunImpl extends EvalRun {
  _EvalRunImpl({
    int? id,
    required DateTime startedAt,
    required String model,
    required int passed,
    required int total,
    required int costMicroUsd,
    required int ms,
    required String results,
  }) : super._(
         id: id,
         startedAt: startedAt,
         model: model,
         passed: passed,
         total: total,
         costMicroUsd: costMicroUsd,
         ms: ms,
         results: results,
       );

  /// Returns a shallow copy of this [EvalRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EvalRun copyWith({
    Object? id = _Undefined,
    DateTime? startedAt,
    String? model,
    int? passed,
    int? total,
    int? costMicroUsd,
    int? ms,
    String? results,
  }) {
    return EvalRun(
      id: id is int? ? id : this.id,
      startedAt: startedAt ?? this.startedAt,
      model: model ?? this.model,
      passed: passed ?? this.passed,
      total: total ?? this.total,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
      ms: ms ?? this.ms,
      results: results ?? this.results,
    );
  }
}

class EvalRunUpdateTable extends _is.UpdateTable<EvalRunTable> {
  EvalRunUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<String, String> model(String value) => _is.ColumnValue(
    table.model,
    value,
  );

  _is.ColumnValue<int, int> passed(int value) => _is.ColumnValue(
    table.passed,
    value,
  );

  _is.ColumnValue<int, int> total(int value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<int, int> costMicroUsd(int value) => _is.ColumnValue(
    table.costMicroUsd,
    value,
  );

  _is.ColumnValue<int, int> ms(int value) => _is.ColumnValue(
    table.ms,
    value,
  );

  _is.ColumnValue<String, String> results(String value) => _is.ColumnValue(
    table.results,
    value,
  );
}

class EvalRunTable extends _is.Table<int?> {
  EvalRunTable({super.tableRelation}) : super(tableName: 'eval_run') {
    updateTable = EvalRunUpdateTable(this);
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    model = _is.ColumnString(
      'model',
      this,
    );
    passed = _is.ColumnInt(
      'passed',
      this,
    );
    total = _is.ColumnInt(
      'total',
      this,
    );
    costMicroUsd = _is.ColumnInt(
      'costMicroUsd',
      this,
    );
    ms = _is.ColumnInt(
      'ms',
      this,
    );
    results = _is.ColumnString(
      'results',
      this,
    );
  }

  late final EvalRunUpdateTable updateTable;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnString model;

  late final _is.ColumnInt passed;

  late final _is.ColumnInt total;

  late final _is.ColumnInt costMicroUsd;

  late final _is.ColumnInt ms;

  late final _is.ColumnString results;

  @override
  List<_is.Column> get columns => [
    id,
    startedAt,
    model,
    passed,
    total,
    costMicroUsd,
    ms,
    results,
  ];
}

class EvalRunInclude extends _is.IncludeObject {
  EvalRunInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EvalRun.t;
}

class EvalRunIncludeList extends _is.IncludeList {
  EvalRunIncludeList._({
    _is.WhereExpressionBuilder<EvalRunTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EvalRun.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EvalRun.t;
}

class EvalRunRepository {
  const EvalRunRepository._();

  /// Returns a list of [EvalRun]s matching the given query parameters.
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
  Future<List<EvalRun>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvalRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EvalRun>(
      where: where?.call(EvalRun.t),
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EvalRun] matching the given query parameters.
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
  Future<EvalRun?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvalRunTable>? where,
    int? offset,
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EvalRun>(
      where: where?.call(EvalRun.t),
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EvalRun] by its [id] or null if no such row exists.
  Future<EvalRun?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EvalRun>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EvalRun]s in the list and returns the inserted rows.
  ///
  /// The returned [EvalRun]s will have their `id` fields set.
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
  Future<List<EvalRun>> insert(
    _is.DatabaseSession session,
    List<EvalRun> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EvalRun>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EvalRun] and returns the inserted row.
  ///
  /// The returned [EvalRun] will have its `id` field set.
  Future<EvalRun> insertRow(
    _is.DatabaseSession session,
    EvalRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EvalRun>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EvalRun]s in the list and returns the resulting rows.
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
  /// The returned [EvalRun]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvalRun>> upsert(
    _is.DatabaseSession session,
    List<EvalRun> rows, {
    required _is.ColumnSelections<EvalRunTable> conflictColumns,
    _is.ColumnSelections<EvalRunTable>? updateColumns,
    _is.WhereExpressionBuilder<EvalRunTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EvalRun>(
      rows,
      conflictColumns: conflictColumns(EvalRun.t),
      updateColumns: updateColumns?.call(EvalRun.t),
      updateWhere: updateWhere?.call(EvalRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EvalRun] and returns the resulting row.
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
  /// The returned [EvalRun] will have its `id` field set.
  Future<EvalRun?> upsertRow(
    _is.DatabaseSession session,
    EvalRun row, {
    required _is.ColumnSelections<EvalRunTable> conflictColumns,
    _is.ColumnSelections<EvalRunTable>? updateColumns,
    _is.WhereExpressionBuilder<EvalRunTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EvalRun>(
      row,
      conflictColumns: conflictColumns(EvalRun.t),
      updateColumns: updateColumns?.call(EvalRun.t),
      updateWhere: updateWhere?.call(EvalRun.t),
      transaction: transaction,
    );
  }

  /// Updates all [EvalRun]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvalRun>> update(
    _is.DatabaseSession session,
    List<EvalRun> rows, {
    _is.ColumnSelections<EvalRunTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EvalRun>(
      rows,
      columns: columns?.call(EvalRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EvalRun]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EvalRun> updateRow(
    _is.DatabaseSession session,
    EvalRun row, {
    _is.ColumnSelections<EvalRunTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EvalRun>(
      row,
      columns: columns?.call(EvalRun.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EvalRun] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EvalRun?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EvalRunUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EvalRun>(
      id,
      columnValues: columnValues(EvalRun.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EvalRun]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvalRun>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EvalRunUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EvalRunTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EvalRun>(
      columnValues: columnValues(EvalRun.t.updateTable),
      where: where(EvalRun.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EvalRun]s in the list and returns the deleted rows.
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
  Future<List<EvalRun>> delete(
    _is.DatabaseSession session,
    List<EvalRun> rows, {
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EvalRun>(
      rows,
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EvalRun].
  Future<EvalRun> deleteRow(
    _is.DatabaseSession session,
    EvalRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EvalRun>(
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
  Future<List<EvalRun>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvalRunTable> where,
    _is.OrderByBuilder<EvalRunTable>? orderBy,
    _is.OrderByListBuilder<EvalRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EvalRun>(
      where: where(EvalRun.t),
      orderBy: orderBy?.call(EvalRun.t),
      orderByList: orderByList?.call(EvalRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvalRunTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EvalRun>(
      where: where?.call(EvalRun.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EvalRun] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvalRunTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EvalRun>(
      where: where(EvalRun.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
