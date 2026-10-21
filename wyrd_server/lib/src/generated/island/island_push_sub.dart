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

/// A phone's web-push address (from the browser's push service), so the game can tell a player something happened
/// while the game is closed. Only the address is kept: pushes carry no content.
abstract class IslandPushSub
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandPushSub._({
    this.id,
    required this.authUserId,
    required this.endpoint,
    required this.createdAt,
  });

  factory IslandPushSub({
    int? id,
    required _is.UuidValue authUserId,
    required String endpoint,
    required DateTime createdAt,
  }) = _IslandPushSubImpl;

  factory IslandPushSub.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandPushSub(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      endpoint: jsonSerialization['endpoint'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandPushSubTable();

  static const db = IslandPushSubRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String endpoint;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandPushSub]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandPushSub copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? endpoint,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandPushSub',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'endpoint': endpoint,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandPushSub',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'endpoint': endpoint,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandPushSubInclude include() {
    return IslandPushSubInclude._();
  }

  static IslandPushSubIncludeList includeList({
    _is.WhereExpressionBuilder<IslandPushSubTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    IslandPushSubInclude? include,
  }) {
    return IslandPushSubIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandPushSubImpl extends IslandPushSub {
  _IslandPushSubImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String endpoint,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         endpoint: endpoint,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandPushSub]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandPushSub copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? endpoint,
    DateTime? createdAt,
  }) {
    return IslandPushSub(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      endpoint: endpoint ?? this.endpoint,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandPushSubUpdateTable extends _is.UpdateTable<IslandPushSubTable> {
  IslandPushSubUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> endpoint(String value) => _is.ColumnValue(
    table.endpoint,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandPushSubTable extends _is.Table<int?> {
  IslandPushSubTable({super.tableRelation})
    : super(tableName: 'island_push_sub') {
    updateTable = IslandPushSubUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    endpoint = _is.ColumnString(
      'endpoint',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandPushSubUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString endpoint;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    endpoint,
    createdAt,
  ];
}

class IslandPushSubInclude extends _is.IncludeObject {
  IslandPushSubInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandPushSub.t;
}

class IslandPushSubIncludeList extends _is.IncludeList {
  IslandPushSubIncludeList._({
    _is.WhereExpressionBuilder<IslandPushSubTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandPushSub.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandPushSub.t;
}

class IslandPushSubRepository {
  const IslandPushSubRepository._();

  /// Returns a list of [IslandPushSub]s matching the given query parameters.
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
  Future<List<IslandPushSub>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPushSubTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandPushSub>(
      where: where?.call(IslandPushSub.t),
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandPushSub] matching the given query parameters.
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
  Future<IslandPushSub?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPushSubTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandPushSub>(
      where: where?.call(IslandPushSub.t),
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandPushSub] by its [id] or null if no such row exists.
  Future<IslandPushSub?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandPushSub>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandPushSub]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandPushSub]s will have their `id` fields set.
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
  Future<List<IslandPushSub>> insert(
    _is.DatabaseSession session,
    List<IslandPushSub> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandPushSub>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandPushSub] and returns the inserted row.
  ///
  /// The returned [IslandPushSub] will have its `id` field set.
  Future<IslandPushSub> insertRow(
    _is.DatabaseSession session,
    IslandPushSub row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandPushSub>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandPushSub]s in the list and returns the resulting rows.
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
  /// The returned [IslandPushSub]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPushSub>> upsert(
    _is.DatabaseSession session,
    List<IslandPushSub> rows, {
    required _is.ColumnSelections<IslandPushSubTable> conflictColumns,
    _is.ColumnSelections<IslandPushSubTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandPushSubTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandPushSub>(
      rows,
      conflictColumns: conflictColumns(IslandPushSub.t),
      updateColumns: updateColumns?.call(IslandPushSub.t),
      updateWhere: updateWhere?.call(IslandPushSub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandPushSub] and returns the resulting row.
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
  /// The returned [IslandPushSub] will have its `id` field set.
  Future<IslandPushSub?> upsertRow(
    _is.DatabaseSession session,
    IslandPushSub row, {
    required _is.ColumnSelections<IslandPushSubTable> conflictColumns,
    _is.ColumnSelections<IslandPushSubTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandPushSubTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandPushSub>(
      row,
      conflictColumns: conflictColumns(IslandPushSub.t),
      updateColumns: updateColumns?.call(IslandPushSub.t),
      updateWhere: updateWhere?.call(IslandPushSub.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandPushSub]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPushSub>> update(
    _is.DatabaseSession session,
    List<IslandPushSub> rows, {
    _is.ColumnSelections<IslandPushSubTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandPushSub>(
      rows,
      columns: columns?.call(IslandPushSub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandPushSub]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandPushSub> updateRow(
    _is.DatabaseSession session,
    IslandPushSub row, {
    _is.ColumnSelections<IslandPushSubTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandPushSub>(
      row,
      columns: columns?.call(IslandPushSub.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandPushSub] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandPushSub?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandPushSubUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandPushSub>(
      id,
      columnValues: columnValues(IslandPushSub.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandPushSub]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPushSub>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandPushSubUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandPushSubTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandPushSub>(
      columnValues: columnValues(IslandPushSub.t.updateTable),
      where: where(IslandPushSub.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandPushSub]s in the list and returns the deleted rows.
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
  Future<List<IslandPushSub>> delete(
    _is.DatabaseSession session,
    List<IslandPushSub> rows, {
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandPushSub>(
      rows,
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandPushSub].
  Future<IslandPushSub> deleteRow(
    _is.DatabaseSession session,
    IslandPushSub row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandPushSub>(
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
  Future<List<IslandPushSub>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandPushSubTable> where,
    _is.OrderByBuilder<IslandPushSubTable>? orderBy,
    _is.OrderByListBuilder<IslandPushSubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandPushSub>(
      where: where(IslandPushSub.t),
      orderBy: orderBy?.call(IslandPushSub.t),
      orderByList: orderByList?.call(IslandPushSub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPushSubTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandPushSub>(
      where: where?.call(IslandPushSub.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandPushSub] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandPushSubTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandPushSub>(
      where: where(IslandPushSub.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
