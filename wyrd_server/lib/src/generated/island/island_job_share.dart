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

/// A finished island job's real-money share: 2% of the paycheck, drawn from the Real Rewards Fund into the player's
/// pending cash. One per paid shift ([source] is the shift's payroll key). pending until the hold ends, then
/// available; unfunded when the fund couldn't cover it (the player then got the whole paycheck in Game Naira).
abstract class IslandJobShare
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandJobShare._({
    this.id,
    required this.authUserId,
    required this.source,
    required this.workplace,
    required this.title,
    required this.paycheck,
    required this.cashKobo,
    required this.status,
    required this.availableAt,
    required this.createdAt,
  });

  factory IslandJobShare({
    int? id,
    required _is.UuidValue authUserId,
    required String source,
    required String workplace,
    required String title,
    required int paycheck,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) = _IslandJobShareImpl;

  factory IslandJobShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJobShare(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      source: jsonSerialization['source'] as String,
      workplace: jsonSerialization['workplace'] as String,
      title: jsonSerialization['title'] as String,
      paycheck: jsonSerialization['paycheck'] as int,
      cashKobo: jsonSerialization['cashKobo'] as int,
      status: jsonSerialization['status'] as String,
      availableAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandJobShareTable();

  static const db = IslandJobShareRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String source;

  /// grid | refinery | airport | club | market | okada
  String workplace;

  String title;

  /// the whole paycheck, in Game Naira
  int paycheck;

  int cashKobo;

  /// pending | available | unfunded
  String status;

  DateTime availableAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandJobShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandJobShare copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? source,
    String? workplace,
    String? title,
    int? paycheck,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJobShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'source': source,
      'workplace': workplace,
      'title': title,
      'paycheck': paycheck,
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJobShare',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'source': source,
      'workplace': workplace,
      'title': title,
      'paycheck': paycheck,
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandJobShareInclude include() {
    return IslandJobShareInclude._();
  }

  static IslandJobShareIncludeList includeList({
    _is.WhereExpressionBuilder<IslandJobShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    IslandJobShareInclude? include,
  }) {
    return IslandJobShareIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandJobShareImpl extends IslandJobShare {
  _IslandJobShareImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String source,
    required String workplace,
    required String title,
    required int paycheck,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         source: source,
         workplace: workplace,
         title: title,
         paycheck: paycheck,
         cashKobo: cashKobo,
         status: status,
         availableAt: availableAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandJobShare]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandJobShare copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? source,
    String? workplace,
    String? title,
    int? paycheck,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  }) {
    return IslandJobShare(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      source: source ?? this.source,
      workplace: workplace ?? this.workplace,
      title: title ?? this.title,
      paycheck: paycheck ?? this.paycheck,
      cashKobo: cashKobo ?? this.cashKobo,
      status: status ?? this.status,
      availableAt: availableAt ?? this.availableAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandJobShareUpdateTable extends _is.UpdateTable<IslandJobShareTable> {
  IslandJobShareUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> workplace(String value) => _is.ColumnValue(
    table.workplace,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<int, int> paycheck(int value) => _is.ColumnValue(
    table.paycheck,
    value,
  );

  _is.ColumnValue<int, int> cashKobo(int value) => _is.ColumnValue(
    table.cashKobo,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> availableAt(DateTime value) =>
      _is.ColumnValue(
        table.availableAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandJobShareTable extends _is.Table<int?> {
  IslandJobShareTable({super.tableRelation})
    : super(tableName: 'island_job_share') {
    updateTable = IslandJobShareUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    workplace = _is.ColumnString(
      'workplace',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    paycheck = _is.ColumnInt(
      'paycheck',
      this,
    );
    cashKobo = _is.ColumnInt(
      'cashKobo',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    availableAt = _is.ColumnDateTime(
      'availableAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandJobShareUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString source;

  /// grid | refinery | airport | club | market | okada
  late final _is.ColumnString workplace;

  late final _is.ColumnString title;

  /// the whole paycheck, in Game Naira
  late final _is.ColumnInt paycheck;

  late final _is.ColumnInt cashKobo;

  /// pending | available | unfunded
  late final _is.ColumnString status;

  late final _is.ColumnDateTime availableAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    source,
    workplace,
    title,
    paycheck,
    cashKobo,
    status,
    availableAt,
    createdAt,
  ];
}

class IslandJobShareInclude extends _is.IncludeObject {
  IslandJobShareInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandJobShare.t;
}

class IslandJobShareIncludeList extends _is.IncludeList {
  IslandJobShareIncludeList._({
    _is.WhereExpressionBuilder<IslandJobShareTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandJobShare.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandJobShare.t;
}

class IslandJobShareRepository {
  const IslandJobShareRepository._();

  /// Returns a list of [IslandJobShare]s matching the given query parameters.
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
  Future<List<IslandJobShare>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobShareTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandJobShare>(
      where: where?.call(IslandJobShare.t),
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandJobShare] matching the given query parameters.
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
  Future<IslandJobShare?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobShareTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandJobShare>(
      where: where?.call(IslandJobShare.t),
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandJobShare] by its [id] or null if no such row exists.
  Future<IslandJobShare?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandJobShare>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandJobShare]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandJobShare]s will have their `id` fields set.
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
  Future<List<IslandJobShare>> insert(
    _is.DatabaseSession session,
    List<IslandJobShare> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandJobShare>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandJobShare] and returns the inserted row.
  ///
  /// The returned [IslandJobShare] will have its `id` field set.
  Future<IslandJobShare> insertRow(
    _is.DatabaseSession session,
    IslandJobShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandJobShare>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandJobShare]s in the list and returns the resulting rows.
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
  /// The returned [IslandJobShare]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJobShare>> upsert(
    _is.DatabaseSession session,
    List<IslandJobShare> rows, {
    required _is.ColumnSelections<IslandJobShareTable> conflictColumns,
    _is.ColumnSelections<IslandJobShareTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJobShareTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandJobShare>(
      rows,
      conflictColumns: conflictColumns(IslandJobShare.t),
      updateColumns: updateColumns?.call(IslandJobShare.t),
      updateWhere: updateWhere?.call(IslandJobShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandJobShare] and returns the resulting row.
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
  /// The returned [IslandJobShare] will have its `id` field set.
  Future<IslandJobShare?> upsertRow(
    _is.DatabaseSession session,
    IslandJobShare row, {
    required _is.ColumnSelections<IslandJobShareTable> conflictColumns,
    _is.ColumnSelections<IslandJobShareTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJobShareTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandJobShare>(
      row,
      conflictColumns: conflictColumns(IslandJobShare.t),
      updateColumns: updateColumns?.call(IslandJobShare.t),
      updateWhere: updateWhere?.call(IslandJobShare.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJobShare]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJobShare>> update(
    _is.DatabaseSession session,
    List<IslandJobShare> rows, {
    _is.ColumnSelections<IslandJobShareTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandJobShare>(
      rows,
      columns: columns?.call(IslandJobShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandJobShare]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandJobShare> updateRow(
    _is.DatabaseSession session,
    IslandJobShare row, {
    _is.ColumnSelections<IslandJobShareTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandJobShare>(
      row,
      columns: columns?.call(IslandJobShare.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandJobShare] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandJobShare?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandJobShareUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandJobShare>(
      id,
      columnValues: columnValues(IslandJobShare.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJobShare]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJobShare>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandJobShareUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandJobShareTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandJobShare>(
      columnValues: columnValues(IslandJobShare.t.updateTable),
      where: where(IslandJobShare.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandJobShare]s in the list and returns the deleted rows.
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
  Future<List<IslandJobShare>> delete(
    _is.DatabaseSession session,
    List<IslandJobShare> rows, {
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandJobShare>(
      rows,
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandJobShare].
  Future<IslandJobShare> deleteRow(
    _is.DatabaseSession session,
    IslandJobShare row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandJobShare>(
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
  Future<List<IslandJobShare>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJobShareTable> where,
    _is.OrderByBuilder<IslandJobShareTable>? orderBy,
    _is.OrderByListBuilder<IslandJobShareTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandJobShare>(
      where: where(IslandJobShare.t),
      orderBy: orderBy?.call(IslandJobShare.t),
      orderByList: orderByList?.call(IslandJobShare.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobShareTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandJobShare>(
      where: where?.call(IslandJobShare.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandJobShare] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJobShareTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandJobShare>(
      where: where(IslandJobShare.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
