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
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;

abstract class CurriculumProgress
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CurriculumProgress._({
    this.id,
    required this.index,
    required this.completedTitles,
  });

  factory CurriculumProgress({
    int? id,
    required int index,
    required List<String> completedTitles,
  }) = _CurriculumProgressImpl;

  factory CurriculumProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumProgress(
      id: jsonSerialization['id'] as int?,
      index: jsonSerialization['index'] as int,
      completedTitles: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['completedTitles'],
      ),
    );
  }

  static final t = CurriculumProgressTable();

  static const db = CurriculumProgressRepository._();

  @override
  int? id;

  int index;

  List<String> completedTitles;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CurriculumProgress copyWith({
    int? id,
    int? index,
    List<String>? completedTitles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumProgress',
      if (id != null) 'id': id,
      'index': index,
      'completedTitles': completedTitles.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurriculumProgress',
      if (id != null) 'id': id,
      'index': index,
      'completedTitles': completedTitles.toJson(),
    };
  }

  static CurriculumProgressInclude include() {
    return CurriculumProgressInclude._();
  }

  static CurriculumProgressIncludeList includeList({
    _is.WhereExpressionBuilder<CurriculumProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    CurriculumProgressInclude? include,
  }) {
    return CurriculumProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumProgressImpl extends CurriculumProgress {
  _CurriculumProgressImpl({
    int? id,
    required int index,
    required List<String> completedTitles,
  }) : super._(
         id: id,
         index: index,
         completedTitles: completedTitles,
       );

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CurriculumProgress copyWith({
    Object? id = _Undefined,
    int? index,
    List<String>? completedTitles,
  }) {
    return CurriculumProgress(
      id: id is int? ? id : this.id,
      index: index ?? this.index,
      completedTitles:
          completedTitles ?? this.completedTitles.map((e0) => e0).toList(),
    );
  }
}

class CurriculumProgressUpdateTable
    extends _is.UpdateTable<CurriculumProgressTable> {
  CurriculumProgressUpdateTable(super.table);

  _is.ColumnValue<int, int> index(int value) => _is.ColumnValue(
    table.index,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> completedTitles(
    List<String> value,
  ) => _is.ColumnValue(
    table.completedTitles,
    value,
  );
}

class CurriculumProgressTable extends _is.Table<int?> {
  CurriculumProgressTable({super.tableRelation})
    : super(tableName: 'curriculum_progress') {
    updateTable = CurriculumProgressUpdateTable(this);
    index = _is.ColumnInt(
      'index',
      this,
    );
    completedTitles = _is.ColumnSerializable<List<String>>(
      'completedTitles',
      this,
    );
  }

  late final CurriculumProgressUpdateTable updateTable;

  late final _is.ColumnInt index;

  late final _is.ColumnSerializable<List<String>> completedTitles;

  @override
  List<_is.Column> get columns => [
    id,
    index,
    completedTitles,
  ];
}

class CurriculumProgressInclude extends _is.IncludeObject {
  CurriculumProgressInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CurriculumProgress.t;
}

class CurriculumProgressIncludeList extends _is.IncludeList {
  CurriculumProgressIncludeList._({
    _is.WhereExpressionBuilder<CurriculumProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CurriculumProgress.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CurriculumProgress.t;
}

class CurriculumProgressRepository {
  const CurriculumProgressRepository._();

  /// Returns a list of [CurriculumProgress]s matching the given query parameters.
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
  Future<List<CurriculumProgress>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CurriculumProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CurriculumProgress>(
      where: where?.call(CurriculumProgress.t),
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CurriculumProgress] matching the given query parameters.
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
  Future<CurriculumProgress?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CurriculumProgressTable>? where,
    int? offset,
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CurriculumProgress>(
      where: where?.call(CurriculumProgress.t),
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CurriculumProgress] by its [id] or null if no such row exists.
  Future<CurriculumProgress?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CurriculumProgress>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CurriculumProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [CurriculumProgress]s will have their `id` fields set.
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
  Future<List<CurriculumProgress>> insert(
    _is.DatabaseSession session,
    List<CurriculumProgress> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CurriculumProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CurriculumProgress] and returns the inserted row.
  ///
  /// The returned [CurriculumProgress] will have its `id` field set.
  Future<CurriculumProgress> insertRow(
    _is.DatabaseSession session,
    CurriculumProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CurriculumProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CurriculumProgress]s in the list and returns the resulting rows.
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
  /// The returned [CurriculumProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CurriculumProgress>> upsert(
    _is.DatabaseSession session,
    List<CurriculumProgress> rows, {
    required _is.ColumnSelections<CurriculumProgressTable> conflictColumns,
    _is.ColumnSelections<CurriculumProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<CurriculumProgressTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CurriculumProgress>(
      rows,
      conflictColumns: conflictColumns(CurriculumProgress.t),
      updateColumns: updateColumns?.call(CurriculumProgress.t),
      updateWhere: updateWhere?.call(CurriculumProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CurriculumProgress] and returns the resulting row.
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
  /// The returned [CurriculumProgress] will have its `id` field set.
  Future<CurriculumProgress?> upsertRow(
    _is.DatabaseSession session,
    CurriculumProgress row, {
    required _is.ColumnSelections<CurriculumProgressTable> conflictColumns,
    _is.ColumnSelections<CurriculumProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<CurriculumProgressTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CurriculumProgress>(
      row,
      conflictColumns: conflictColumns(CurriculumProgress.t),
      updateColumns: updateColumns?.call(CurriculumProgress.t),
      updateWhere: updateWhere?.call(CurriculumProgress.t),
      transaction: transaction,
    );
  }

  /// Updates all [CurriculumProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CurriculumProgress>> update(
    _is.DatabaseSession session,
    List<CurriculumProgress> rows, {
    _is.ColumnSelections<CurriculumProgressTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CurriculumProgress>(
      rows,
      columns: columns?.call(CurriculumProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CurriculumProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CurriculumProgress> updateRow(
    _is.DatabaseSession session,
    CurriculumProgress row, {
    _is.ColumnSelections<CurriculumProgressTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CurriculumProgress>(
      row,
      columns: columns?.call(CurriculumProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CurriculumProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CurriculumProgress?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CurriculumProgressUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CurriculumProgress>(
      id,
      columnValues: columnValues(CurriculumProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CurriculumProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CurriculumProgress>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CurriculumProgressUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CurriculumProgressTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CurriculumProgress>(
      columnValues: columnValues(CurriculumProgress.t.updateTable),
      where: where(CurriculumProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CurriculumProgress]s in the list and returns the deleted rows.
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
  Future<List<CurriculumProgress>> delete(
    _is.DatabaseSession session,
    List<CurriculumProgress> rows, {
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CurriculumProgress>(
      rows,
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CurriculumProgress].
  Future<CurriculumProgress> deleteRow(
    _is.DatabaseSession session,
    CurriculumProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CurriculumProgress>(
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
  Future<List<CurriculumProgress>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CurriculumProgressTable> where,
    _is.OrderByBuilder<CurriculumProgressTable>? orderBy,
    _is.OrderByListBuilder<CurriculumProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CurriculumProgress>(
      where: where(CurriculumProgress.t),
      orderBy: orderBy?.call(CurriculumProgress.t),
      orderByList: orderByList?.call(CurriculumProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CurriculumProgressTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CurriculumProgress>(
      where: where?.call(CurriculumProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CurriculumProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CurriculumProgressTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CurriculumProgress>(
      where: where(CurriculumProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
