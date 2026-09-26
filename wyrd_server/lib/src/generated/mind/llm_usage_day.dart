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

abstract class LlmUsageDay
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LlmUsageDay._({
    this.id,
    required this.day,
    required this.costMicroUsd,
    required this.calls,
  });

  factory LlmUsageDay({
    int? id,
    required String day,
    required int costMicroUsd,
    required int calls,
  }) = _LlmUsageDayImpl;

  factory LlmUsageDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return LlmUsageDay(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
      calls: jsonSerialization['calls'] as int,
    );
  }

  static final t = LlmUsageDayTable();

  static const db = LlmUsageDayRepository._();

  @override
  int? id;

  String day;

  int costMicroUsd;

  int calls;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LlmUsageDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LlmUsageDay copyWith({
    int? id,
    String? day,
    int? costMicroUsd,
    int? calls,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LlmUsageDay',
      if (id != null) 'id': id,
      'day': day,
      'costMicroUsd': costMicroUsd,
      'calls': calls,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LlmUsageDay',
      if (id != null) 'id': id,
      'day': day,
      'costMicroUsd': costMicroUsd,
      'calls': calls,
    };
  }

  static LlmUsageDayInclude include() {
    return LlmUsageDayInclude._();
  }

  static LlmUsageDayIncludeList includeList({
    _is.WhereExpressionBuilder<LlmUsageDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    LlmUsageDayInclude? include,
  }) {
    return LlmUsageDayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LlmUsageDayImpl extends LlmUsageDay {
  _LlmUsageDayImpl({
    int? id,
    required String day,
    required int costMicroUsd,
    required int calls,
  }) : super._(
         id: id,
         day: day,
         costMicroUsd: costMicroUsd,
         calls: calls,
       );

  /// Returns a shallow copy of this [LlmUsageDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LlmUsageDay copyWith({
    Object? id = _Undefined,
    String? day,
    int? costMicroUsd,
    int? calls,
  }) {
    return LlmUsageDay(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
      calls: calls ?? this.calls,
    );
  }
}

class LlmUsageDayUpdateTable extends _is.UpdateTable<LlmUsageDayTable> {
  LlmUsageDayUpdateTable(super.table);

  _is.ColumnValue<String, String> day(String value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<int, int> costMicroUsd(int value) => _is.ColumnValue(
    table.costMicroUsd,
    value,
  );

  _is.ColumnValue<int, int> calls(int value) => _is.ColumnValue(
    table.calls,
    value,
  );
}

class LlmUsageDayTable extends _is.Table<int?> {
  LlmUsageDayTable({super.tableRelation}) : super(tableName: 'llm_usage_day') {
    updateTable = LlmUsageDayUpdateTable(this);
    day = _is.ColumnString(
      'day',
      this,
    );
    costMicroUsd = _is.ColumnInt(
      'costMicroUsd',
      this,
    );
    calls = _is.ColumnInt(
      'calls',
      this,
    );
  }

  late final LlmUsageDayUpdateTable updateTable;

  late final _is.ColumnString day;

  late final _is.ColumnInt costMicroUsd;

  late final _is.ColumnInt calls;

  @override
  List<_is.Column> get columns => [
    id,
    day,
    costMicroUsd,
    calls,
  ];
}

class LlmUsageDayInclude extends _is.IncludeObject {
  LlmUsageDayInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LlmUsageDay.t;
}

class LlmUsageDayIncludeList extends _is.IncludeList {
  LlmUsageDayIncludeList._({
    _is.WhereExpressionBuilder<LlmUsageDayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LlmUsageDay.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LlmUsageDay.t;
}

class LlmUsageDayRepository {
  const LlmUsageDayRepository._();

  /// Returns a list of [LlmUsageDay]s matching the given query parameters.
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
  Future<List<LlmUsageDay>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LlmUsageDay>(
      where: where?.call(LlmUsageDay.t),
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LlmUsageDay] matching the given query parameters.
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
  Future<LlmUsageDay?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageDayTable>? where,
    int? offset,
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LlmUsageDay>(
      where: where?.call(LlmUsageDay.t),
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LlmUsageDay] by its [id] or null if no such row exists.
  Future<LlmUsageDay?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LlmUsageDay>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LlmUsageDay]s in the list and returns the inserted rows.
  ///
  /// The returned [LlmUsageDay]s will have their `id` fields set.
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
  Future<List<LlmUsageDay>> insert(
    _is.DatabaseSession session,
    List<LlmUsageDay> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LlmUsageDay>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LlmUsageDay] and returns the inserted row.
  ///
  /// The returned [LlmUsageDay] will have its `id` field set.
  Future<LlmUsageDay> insertRow(
    _is.DatabaseSession session,
    LlmUsageDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LlmUsageDay>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LlmUsageDay]s in the list and returns the resulting rows.
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
  /// The returned [LlmUsageDay]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageDay>> upsert(
    _is.DatabaseSession session,
    List<LlmUsageDay> rows, {
    required _is.ColumnSelections<LlmUsageDayTable> conflictColumns,
    _is.ColumnSelections<LlmUsageDayTable>? updateColumns,
    _is.WhereExpressionBuilder<LlmUsageDayTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LlmUsageDay>(
      rows,
      conflictColumns: conflictColumns(LlmUsageDay.t),
      updateColumns: updateColumns?.call(LlmUsageDay.t),
      updateWhere: updateWhere?.call(LlmUsageDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LlmUsageDay] and returns the resulting row.
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
  /// The returned [LlmUsageDay] will have its `id` field set.
  Future<LlmUsageDay?> upsertRow(
    _is.DatabaseSession session,
    LlmUsageDay row, {
    required _is.ColumnSelections<LlmUsageDayTable> conflictColumns,
    _is.ColumnSelections<LlmUsageDayTable>? updateColumns,
    _is.WhereExpressionBuilder<LlmUsageDayTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LlmUsageDay>(
      row,
      conflictColumns: conflictColumns(LlmUsageDay.t),
      updateColumns: updateColumns?.call(LlmUsageDay.t),
      updateWhere: updateWhere?.call(LlmUsageDay.t),
      transaction: transaction,
    );
  }

  /// Updates all [LlmUsageDay]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageDay>> update(
    _is.DatabaseSession session,
    List<LlmUsageDay> rows, {
    _is.ColumnSelections<LlmUsageDayTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LlmUsageDay>(
      rows,
      columns: columns?.call(LlmUsageDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LlmUsageDay]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LlmUsageDay> updateRow(
    _is.DatabaseSession session,
    LlmUsageDay row, {
    _is.ColumnSelections<LlmUsageDayTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LlmUsageDay>(
      row,
      columns: columns?.call(LlmUsageDay.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LlmUsageDay] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LlmUsageDay?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LlmUsageDayUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LlmUsageDay>(
      id,
      columnValues: columnValues(LlmUsageDay.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LlmUsageDay]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageDay>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LlmUsageDayUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LlmUsageDayTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LlmUsageDay>(
      columnValues: columnValues(LlmUsageDay.t.updateTable),
      where: where(LlmUsageDay.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LlmUsageDay]s in the list and returns the deleted rows.
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
  Future<List<LlmUsageDay>> delete(
    _is.DatabaseSession session,
    List<LlmUsageDay> rows, {
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LlmUsageDay>(
      rows,
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LlmUsageDay].
  Future<LlmUsageDay> deleteRow(
    _is.DatabaseSession session,
    LlmUsageDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LlmUsageDay>(
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
  Future<List<LlmUsageDay>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LlmUsageDayTable> where,
    _is.OrderByBuilder<LlmUsageDayTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LlmUsageDay>(
      where: where(LlmUsageDay.t),
      orderBy: orderBy?.call(LlmUsageDay.t),
      orderByList: orderByList?.call(LlmUsageDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageDayTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LlmUsageDay>(
      where: where?.call(LlmUsageDay.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LlmUsageDay] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LlmUsageDayTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LlmUsageDay>(
      where: where(LlmUsageDay.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
