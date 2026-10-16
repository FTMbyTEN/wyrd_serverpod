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

/// Someone applied for a job: the employer sees their handle, the skills they listed and this note --
/// nothing else about them.
abstract class IslandApplication
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandApplication._({
    this.id,
    required this.jobId,
    required this.authUserId,
    required this.note,
    required this.createdAt,
  });

  factory IslandApplication({
    int? id,
    required int jobId,
    required _is.UuidValue authUserId,
    required String note,
    required DateTime createdAt,
  }) = _IslandApplicationImpl;

  factory IslandApplication.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandApplication(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      note: jsonSerialization['note'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandApplicationTable();

  static const db = IslandApplicationRepository._();

  @override
  int? id;

  int jobId;

  _is.UuidValue authUserId;

  String note;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandApplication copyWith({
    int? id,
    int? jobId,
    _is.UuidValue? authUserId,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandApplication',
      if (id != null) 'id': id,
      'jobId': jobId,
      'authUserId': authUserId.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandApplication',
      if (id != null) 'id': id,
      'jobId': jobId,
      'authUserId': authUserId.toJson(),
      'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandApplicationInclude include() {
    return IslandApplicationInclude._();
  }

  static IslandApplicationIncludeList includeList({
    _is.WhereExpressionBuilder<IslandApplicationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    IslandApplicationInclude? include,
  }) {
    return IslandApplicationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandApplicationImpl extends IslandApplication {
  _IslandApplicationImpl({
    int? id,
    required int jobId,
    required _is.UuidValue authUserId,
    required String note,
    required DateTime createdAt,
  }) : super._(
         id: id,
         jobId: jobId,
         authUserId: authUserId,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandApplication copyWith({
    Object? id = _Undefined,
    int? jobId,
    _is.UuidValue? authUserId,
    String? note,
    DateTime? createdAt,
  }) {
    return IslandApplication(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      authUserId: authUserId ?? this.authUserId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandApplicationUpdateTable
    extends _is.UpdateTable<IslandApplicationTable> {
  IslandApplicationUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> note(String value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandApplicationTable extends _is.Table<int?> {
  IslandApplicationTable({super.tableRelation})
    : super(tableName: 'island_application') {
    updateTable = IslandApplicationUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandApplicationUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString note;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    authUserId,
    note,
    createdAt,
  ];
}

class IslandApplicationInclude extends _is.IncludeObject {
  IslandApplicationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandApplication.t;
}

class IslandApplicationIncludeList extends _is.IncludeList {
  IslandApplicationIncludeList._({
    _is.WhereExpressionBuilder<IslandApplicationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandApplication.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandApplication.t;
}

class IslandApplicationRepository {
  const IslandApplicationRepository._();

  /// Returns a list of [IslandApplication]s matching the given query parameters.
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
  Future<List<IslandApplication>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandApplicationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandApplication>(
      where: where?.call(IslandApplication.t),
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandApplication] matching the given query parameters.
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
  Future<IslandApplication?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandApplicationTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandApplication>(
      where: where?.call(IslandApplication.t),
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandApplication] by its [id] or null if no such row exists.
  Future<IslandApplication?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandApplication>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandApplication]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandApplication]s will have their `id` fields set.
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
  Future<List<IslandApplication>> insert(
    _is.DatabaseSession session,
    List<IslandApplication> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandApplication>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandApplication] and returns the inserted row.
  ///
  /// The returned [IslandApplication] will have its `id` field set.
  Future<IslandApplication> insertRow(
    _is.DatabaseSession session,
    IslandApplication row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandApplication>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandApplication]s in the list and returns the resulting rows.
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
  /// The returned [IslandApplication]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandApplication>> upsert(
    _is.DatabaseSession session,
    List<IslandApplication> rows, {
    required _is.ColumnSelections<IslandApplicationTable> conflictColumns,
    _is.ColumnSelections<IslandApplicationTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandApplicationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandApplication>(
      rows,
      conflictColumns: conflictColumns(IslandApplication.t),
      updateColumns: updateColumns?.call(IslandApplication.t),
      updateWhere: updateWhere?.call(IslandApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandApplication] and returns the resulting row.
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
  /// The returned [IslandApplication] will have its `id` field set.
  Future<IslandApplication?> upsertRow(
    _is.DatabaseSession session,
    IslandApplication row, {
    required _is.ColumnSelections<IslandApplicationTable> conflictColumns,
    _is.ColumnSelections<IslandApplicationTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandApplicationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandApplication>(
      row,
      conflictColumns: conflictColumns(IslandApplication.t),
      updateColumns: updateColumns?.call(IslandApplication.t),
      updateWhere: updateWhere?.call(IslandApplication.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandApplication]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandApplication>> update(
    _is.DatabaseSession session,
    List<IslandApplication> rows, {
    _is.ColumnSelections<IslandApplicationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandApplication>(
      rows,
      columns: columns?.call(IslandApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandApplication]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandApplication> updateRow(
    _is.DatabaseSession session,
    IslandApplication row, {
    _is.ColumnSelections<IslandApplicationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandApplication>(
      row,
      columns: columns?.call(IslandApplication.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandApplication] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandApplication?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandApplicationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandApplication>(
      id,
      columnValues: columnValues(IslandApplication.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandApplication]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandApplication>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandApplicationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<IslandApplicationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandApplication>(
      columnValues: columnValues(IslandApplication.t.updateTable),
      where: where(IslandApplication.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandApplication]s in the list and returns the deleted rows.
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
  Future<List<IslandApplication>> delete(
    _is.DatabaseSession session,
    List<IslandApplication> rows, {
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandApplication>(
      rows,
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandApplication].
  Future<IslandApplication> deleteRow(
    _is.DatabaseSession session,
    IslandApplication row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandApplication>(
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
  Future<List<IslandApplication>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandApplicationTable> where,
    _is.OrderByBuilder<IslandApplicationTable>? orderBy,
    _is.OrderByListBuilder<IslandApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandApplication>(
      where: where(IslandApplication.t),
      orderBy: orderBy?.call(IslandApplication.t),
      orderByList: orderByList?.call(IslandApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandApplicationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandApplication>(
      where: where?.call(IslandApplication.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandApplication] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandApplicationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandApplication>(
      where: where(IslandApplication.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
