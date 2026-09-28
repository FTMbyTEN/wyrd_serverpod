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

abstract class LlmUsageUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LlmUsageUser._({
    this.id,
    required this.day,
    required this.authUserId,
    required this.costMicroUsd,
  });

  factory LlmUsageUser({
    int? id,
    required String day,
    required _is.UuidValue authUserId,
    required int costMicroUsd,
  }) = _LlmUsageUserImpl;

  factory LlmUsageUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return LlmUsageUser(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      costMicroUsd: jsonSerialization['costMicroUsd'] as int,
    );
  }

  static final t = LlmUsageUserTable();

  static const db = LlmUsageUserRepository._();

  @override
  int? id;

  String day;

  _is.UuidValue authUserId;

  int costMicroUsd;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LlmUsageUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LlmUsageUser copyWith({
    int? id,
    String? day,
    _is.UuidValue? authUserId,
    int? costMicroUsd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LlmUsageUser',
      if (id != null) 'id': id,
      'day': day,
      'authUserId': authUserId.toJson(),
      'costMicroUsd': costMicroUsd,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LlmUsageUser',
      if (id != null) 'id': id,
      'day': day,
      'authUserId': authUserId.toJson(),
      'costMicroUsd': costMicroUsd,
    };
  }

  static LlmUsageUserInclude include() {
    return LlmUsageUserInclude._();
  }

  static LlmUsageUserIncludeList includeList({
    _is.WhereExpressionBuilder<LlmUsageUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    LlmUsageUserInclude? include,
  }) {
    return LlmUsageUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LlmUsageUserImpl extends LlmUsageUser {
  _LlmUsageUserImpl({
    int? id,
    required String day,
    required _is.UuidValue authUserId,
    required int costMicroUsd,
  }) : super._(
         id: id,
         day: day,
         authUserId: authUserId,
         costMicroUsd: costMicroUsd,
       );

  /// Returns a shallow copy of this [LlmUsageUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LlmUsageUser copyWith({
    Object? id = _Undefined,
    String? day,
    _is.UuidValue? authUserId,
    int? costMicroUsd,
  }) {
    return LlmUsageUser(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      authUserId: authUserId ?? this.authUserId,
      costMicroUsd: costMicroUsd ?? this.costMicroUsd,
    );
  }
}

class LlmUsageUserUpdateTable extends _is.UpdateTable<LlmUsageUserTable> {
  LlmUsageUserUpdateTable(super.table);

  _is.ColumnValue<String, String> day(String value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> costMicroUsd(int value) => _is.ColumnValue(
    table.costMicroUsd,
    value,
  );
}

class LlmUsageUserTable extends _is.Table<int?> {
  LlmUsageUserTable({super.tableRelation})
    : super(tableName: 'llm_usage_user') {
    updateTable = LlmUsageUserUpdateTable(this);
    day = _is.ColumnString(
      'day',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    costMicroUsd = _is.ColumnInt(
      'costMicroUsd',
      this,
    );
  }

  late final LlmUsageUserUpdateTable updateTable;

  late final _is.ColumnString day;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt costMicroUsd;

  @override
  List<_is.Column> get columns => [
    id,
    day,
    authUserId,
    costMicroUsd,
  ];
}

class LlmUsageUserInclude extends _is.IncludeObject {
  LlmUsageUserInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LlmUsageUser.t;
}

class LlmUsageUserIncludeList extends _is.IncludeList {
  LlmUsageUserIncludeList._({
    _is.WhereExpressionBuilder<LlmUsageUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LlmUsageUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LlmUsageUser.t;
}

class LlmUsageUserRepository {
  const LlmUsageUserRepository._();

  /// Returns a list of [LlmUsageUser]s matching the given query parameters.
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
  Future<List<LlmUsageUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LlmUsageUser>(
      where: where?.call(LlmUsageUser.t),
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LlmUsageUser] matching the given query parameters.
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
  Future<LlmUsageUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageUserTable>? where,
    int? offset,
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LlmUsageUser>(
      where: where?.call(LlmUsageUser.t),
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LlmUsageUser] by its [id] or null if no such row exists.
  Future<LlmUsageUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LlmUsageUser>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LlmUsageUser]s in the list and returns the inserted rows.
  ///
  /// The returned [LlmUsageUser]s will have their `id` fields set.
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
  Future<List<LlmUsageUser>> insert(
    _is.DatabaseSession session,
    List<LlmUsageUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LlmUsageUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LlmUsageUser] and returns the inserted row.
  ///
  /// The returned [LlmUsageUser] will have its `id` field set.
  Future<LlmUsageUser> insertRow(
    _is.DatabaseSession session,
    LlmUsageUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LlmUsageUser>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LlmUsageUser]s in the list and returns the resulting rows.
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
  /// The returned [LlmUsageUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageUser>> upsert(
    _is.DatabaseSession session,
    List<LlmUsageUser> rows, {
    required _is.ColumnSelections<LlmUsageUserTable> conflictColumns,
    _is.ColumnSelections<LlmUsageUserTable>? updateColumns,
    _is.WhereExpressionBuilder<LlmUsageUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LlmUsageUser>(
      rows,
      conflictColumns: conflictColumns(LlmUsageUser.t),
      updateColumns: updateColumns?.call(LlmUsageUser.t),
      updateWhere: updateWhere?.call(LlmUsageUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LlmUsageUser] and returns the resulting row.
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
  /// The returned [LlmUsageUser] will have its `id` field set.
  Future<LlmUsageUser?> upsertRow(
    _is.DatabaseSession session,
    LlmUsageUser row, {
    required _is.ColumnSelections<LlmUsageUserTable> conflictColumns,
    _is.ColumnSelections<LlmUsageUserTable>? updateColumns,
    _is.WhereExpressionBuilder<LlmUsageUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LlmUsageUser>(
      row,
      conflictColumns: conflictColumns(LlmUsageUser.t),
      updateColumns: updateColumns?.call(LlmUsageUser.t),
      updateWhere: updateWhere?.call(LlmUsageUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [LlmUsageUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageUser>> update(
    _is.DatabaseSession session,
    List<LlmUsageUser> rows, {
    _is.ColumnSelections<LlmUsageUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LlmUsageUser>(
      rows,
      columns: columns?.call(LlmUsageUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LlmUsageUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LlmUsageUser> updateRow(
    _is.DatabaseSession session,
    LlmUsageUser row, {
    _is.ColumnSelections<LlmUsageUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LlmUsageUser>(
      row,
      columns: columns?.call(LlmUsageUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LlmUsageUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LlmUsageUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LlmUsageUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LlmUsageUser>(
      id,
      columnValues: columnValues(LlmUsageUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LlmUsageUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LlmUsageUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LlmUsageUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LlmUsageUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LlmUsageUser>(
      columnValues: columnValues(LlmUsageUser.t.updateTable),
      where: where(LlmUsageUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LlmUsageUser]s in the list and returns the deleted rows.
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
  Future<List<LlmUsageUser>> delete(
    _is.DatabaseSession session,
    List<LlmUsageUser> rows, {
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LlmUsageUser>(
      rows,
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LlmUsageUser].
  Future<LlmUsageUser> deleteRow(
    _is.DatabaseSession session,
    LlmUsageUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LlmUsageUser>(
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
  Future<List<LlmUsageUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LlmUsageUserTable> where,
    _is.OrderByBuilder<LlmUsageUserTable>? orderBy,
    _is.OrderByListBuilder<LlmUsageUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LlmUsageUser>(
      where: where(LlmUsageUser.t),
      orderBy: orderBy?.call(LlmUsageUser.t),
      orderByList: orderByList?.call(LlmUsageUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LlmUsageUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LlmUsageUser>(
      where: where?.call(LlmUsageUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LlmUsageUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LlmUsageUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LlmUsageUser>(
      where: where(LlmUsageUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
