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

/// Someone asked to enter another person's HQ; the owner says yes or no. Who asked is shown to the
/// owner only; the owner's name is shown to the asker only once they're let in.
abstract class IslandAccess
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandAccess._({
    this.id,
    required this.ownerId,
    required this.requesterId,
    String? status,
    required this.createdAt,
  }) : status = status ?? 'pending';

  factory IslandAccess({
    int? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue requesterId,
    String? status,
    required DateTime createdAt,
  }) = _IslandAccessImpl;

  factory IslandAccess.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandAccess(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      requesterId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['requesterId'],
      ),
      status: jsonSerialization['status'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandAccessTable();

  static const db = IslandAccessRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  _is.UuidValue requesterId;

  /// pending | granted | denied
  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandAccess copyWith({
    int? id,
    _is.UuidValue? ownerId,
    _is.UuidValue? requesterId,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandAccess',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'requesterId': requesterId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandAccess',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'requesterId': requesterId.toJson(),
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandAccessInclude include() {
    return IslandAccessInclude._();
  }

  static IslandAccessIncludeList includeList({
    _is.WhereExpressionBuilder<IslandAccessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    IslandAccessInclude? include,
  }) {
    return IslandAccessIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandAccessImpl extends IslandAccess {
  _IslandAccessImpl({
    int? id,
    required _is.UuidValue ownerId,
    required _is.UuidValue requesterId,
    String? status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         requesterId: requesterId,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandAccess copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    _is.UuidValue? requesterId,
    String? status,
    DateTime? createdAt,
  }) {
    return IslandAccess(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      requesterId: requesterId ?? this.requesterId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandAccessUpdateTable extends _is.UpdateTable<IslandAccessTable> {
  IslandAccessUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> requesterId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.requesterId,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandAccessTable extends _is.Table<int?> {
  IslandAccessTable({super.tableRelation}) : super(tableName: 'island_access') {
    updateTable = IslandAccessUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    requesterId = _is.ColumnUuid(
      'requesterId',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandAccessUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnUuid requesterId;

  /// pending | granted | denied
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    requesterId,
    status,
    createdAt,
  ];
}

class IslandAccessInclude extends _is.IncludeObject {
  IslandAccessInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandAccess.t;
}

class IslandAccessIncludeList extends _is.IncludeList {
  IslandAccessIncludeList._({
    _is.WhereExpressionBuilder<IslandAccessTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandAccess.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandAccess.t;
}

class IslandAccessRepository {
  const IslandAccessRepository._();

  /// Returns a list of [IslandAccess]s matching the given query parameters.
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
  Future<List<IslandAccess>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandAccessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandAccess>(
      where: where?.call(IslandAccess.t),
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandAccess] matching the given query parameters.
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
  Future<IslandAccess?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandAccessTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandAccess>(
      where: where?.call(IslandAccess.t),
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandAccess] by its [id] or null if no such row exists.
  Future<IslandAccess?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandAccess>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandAccess]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandAccess]s will have their `id` fields set.
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
  Future<List<IslandAccess>> insert(
    _is.DatabaseSession session,
    List<IslandAccess> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandAccess>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandAccess] and returns the inserted row.
  ///
  /// The returned [IslandAccess] will have its `id` field set.
  Future<IslandAccess> insertRow(
    _is.DatabaseSession session,
    IslandAccess row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandAccess>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandAccess]s in the list and returns the resulting rows.
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
  /// The returned [IslandAccess]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandAccess>> upsert(
    _is.DatabaseSession session,
    List<IslandAccess> rows, {
    required _is.ColumnSelections<IslandAccessTable> conflictColumns,
    _is.ColumnSelections<IslandAccessTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandAccessTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandAccess>(
      rows,
      conflictColumns: conflictColumns(IslandAccess.t),
      updateColumns: updateColumns?.call(IslandAccess.t),
      updateWhere: updateWhere?.call(IslandAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandAccess] and returns the resulting row.
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
  /// The returned [IslandAccess] will have its `id` field set.
  Future<IslandAccess?> upsertRow(
    _is.DatabaseSession session,
    IslandAccess row, {
    required _is.ColumnSelections<IslandAccessTable> conflictColumns,
    _is.ColumnSelections<IslandAccessTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandAccessTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandAccess>(
      row,
      conflictColumns: conflictColumns(IslandAccess.t),
      updateColumns: updateColumns?.call(IslandAccess.t),
      updateWhere: updateWhere?.call(IslandAccess.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandAccess]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandAccess>> update(
    _is.DatabaseSession session,
    List<IslandAccess> rows, {
    _is.ColumnSelections<IslandAccessTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandAccess>(
      rows,
      columns: columns?.call(IslandAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandAccess]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandAccess> updateRow(
    _is.DatabaseSession session,
    IslandAccess row, {
    _is.ColumnSelections<IslandAccessTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandAccess>(
      row,
      columns: columns?.call(IslandAccess.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandAccess] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandAccess?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandAccessUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandAccess>(
      id,
      columnValues: columnValues(IslandAccess.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandAccess]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandAccess>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandAccessUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandAccessTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandAccess>(
      columnValues: columnValues(IslandAccess.t.updateTable),
      where: where(IslandAccess.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandAccess]s in the list and returns the deleted rows.
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
  Future<List<IslandAccess>> delete(
    _is.DatabaseSession session,
    List<IslandAccess> rows, {
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandAccess>(
      rows,
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandAccess].
  Future<IslandAccess> deleteRow(
    _is.DatabaseSession session,
    IslandAccess row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandAccess>(
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
  Future<List<IslandAccess>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandAccessTable> where,
    _is.OrderByBuilder<IslandAccessTable>? orderBy,
    _is.OrderByListBuilder<IslandAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandAccess>(
      where: where(IslandAccess.t),
      orderBy: orderBy?.call(IslandAccess.t),
      orderByList: orderByList?.call(IslandAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandAccessTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandAccess>(
      where: where?.call(IslandAccess.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandAccess] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandAccessTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandAccess>(
      where: where(IslandAccess.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
