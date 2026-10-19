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

/// The cash a completed funded job earned: one per acceptance (the unique entitlement). pending until the hold ends,
/// then available; held while under review.
abstract class RewardEarning
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardEarning._({
    this.id,
    required this.acceptanceId,
    required this.authUserId,
    required this.cashKobo,
    required this.status,
    required this.availableAt,
    required this.createdAt,
  });

  factory RewardEarning({
    int? id,
    required int acceptanceId,
    required _is.UuidValue authUserId,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) = _RewardEarningImpl;

  factory RewardEarning.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardEarning(
      id: jsonSerialization['id'] as int?,
      acceptanceId: jsonSerialization['acceptanceId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
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

  static final t = RewardEarningTable();

  static const db = RewardEarningRepository._();

  @override
  int? id;

  int acceptanceId;

  _is.UuidValue authUserId;

  int cashKobo;

  /// pending | available | held
  String status;

  DateTime availableAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardEarning]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardEarning copyWith({
    int? id,
    int? acceptanceId,
    _is.UuidValue? authUserId,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardEarning',
      if (id != null) 'id': id,
      'acceptanceId': acceptanceId,
      'authUserId': authUserId.toJson(),
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardEarning',
      if (id != null) 'id': id,
      'acceptanceId': acceptanceId,
      'authUserId': authUserId.toJson(),
      'cashKobo': cashKobo,
      'status': status,
      'availableAt': availableAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardEarningInclude include() {
    return RewardEarningInclude._();
  }

  static RewardEarningIncludeList includeList({
    _is.WhereExpressionBuilder<RewardEarningTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    RewardEarningInclude? include,
  }) {
    return RewardEarningIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardEarningImpl extends RewardEarning {
  _RewardEarningImpl({
    int? id,
    required int acceptanceId,
    required _is.UuidValue authUserId,
    required int cashKobo,
    required String status,
    required DateTime availableAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         acceptanceId: acceptanceId,
         authUserId: authUserId,
         cashKobo: cashKobo,
         status: status,
         availableAt: availableAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardEarning]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardEarning copyWith({
    Object? id = _Undefined,
    int? acceptanceId,
    _is.UuidValue? authUserId,
    int? cashKobo,
    String? status,
    DateTime? availableAt,
    DateTime? createdAt,
  }) {
    return RewardEarning(
      id: id is int? ? id : this.id,
      acceptanceId: acceptanceId ?? this.acceptanceId,
      authUserId: authUserId ?? this.authUserId,
      cashKobo: cashKobo ?? this.cashKobo,
      status: status ?? this.status,
      availableAt: availableAt ?? this.availableAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardEarningUpdateTable extends _is.UpdateTable<RewardEarningTable> {
  RewardEarningUpdateTable(super.table);

  _is.ColumnValue<int, int> acceptanceId(int value) => _is.ColumnValue(
    table.acceptanceId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
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

class RewardEarningTable extends _is.Table<int?> {
  RewardEarningTable({super.tableRelation})
    : super(tableName: 'reward_earning') {
    updateTable = RewardEarningUpdateTable(this);
    acceptanceId = _is.ColumnInt(
      'acceptanceId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
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

  late final RewardEarningUpdateTable updateTable;

  late final _is.ColumnInt acceptanceId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt cashKobo;

  /// pending | available | held
  late final _is.ColumnString status;

  late final _is.ColumnDateTime availableAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    acceptanceId,
    authUserId,
    cashKobo,
    status,
    availableAt,
    createdAt,
  ];
}

class RewardEarningInclude extends _is.IncludeObject {
  RewardEarningInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardEarning.t;
}

class RewardEarningIncludeList extends _is.IncludeList {
  RewardEarningIncludeList._({
    _is.WhereExpressionBuilder<RewardEarningTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardEarning.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardEarning.t;
}

class RewardEarningRepository {
  const RewardEarningRepository._();

  /// Returns a list of [RewardEarning]s matching the given query parameters.
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
  Future<List<RewardEarning>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEarningTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardEarning>(
      where: where?.call(RewardEarning.t),
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardEarning] matching the given query parameters.
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
  Future<RewardEarning?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEarningTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardEarning>(
      where: where?.call(RewardEarning.t),
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardEarning] by its [id] or null if no such row exists.
  Future<RewardEarning?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardEarning>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardEarning]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardEarning]s will have their `id` fields set.
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
  Future<List<RewardEarning>> insert(
    _is.DatabaseSession session,
    List<RewardEarning> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardEarning>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardEarning] and returns the inserted row.
  ///
  /// The returned [RewardEarning] will have its `id` field set.
  Future<RewardEarning> insertRow(
    _is.DatabaseSession session,
    RewardEarning row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardEarning>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardEarning]s in the list and returns the resulting rows.
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
  /// The returned [RewardEarning]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEarning>> upsert(
    _is.DatabaseSession session,
    List<RewardEarning> rows, {
    required _is.ColumnSelections<RewardEarningTable> conflictColumns,
    _is.ColumnSelections<RewardEarningTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardEarningTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardEarning>(
      rows,
      conflictColumns: conflictColumns(RewardEarning.t),
      updateColumns: updateColumns?.call(RewardEarning.t),
      updateWhere: updateWhere?.call(RewardEarning.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardEarning] and returns the resulting row.
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
  /// The returned [RewardEarning] will have its `id` field set.
  Future<RewardEarning?> upsertRow(
    _is.DatabaseSession session,
    RewardEarning row, {
    required _is.ColumnSelections<RewardEarningTable> conflictColumns,
    _is.ColumnSelections<RewardEarningTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardEarningTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardEarning>(
      row,
      conflictColumns: conflictColumns(RewardEarning.t),
      updateColumns: updateColumns?.call(RewardEarning.t),
      updateWhere: updateWhere?.call(RewardEarning.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardEarning]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEarning>> update(
    _is.DatabaseSession session,
    List<RewardEarning> rows, {
    _is.ColumnSelections<RewardEarningTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardEarning>(
      rows,
      columns: columns?.call(RewardEarning.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardEarning]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardEarning> updateRow(
    _is.DatabaseSession session,
    RewardEarning row, {
    _is.ColumnSelections<RewardEarningTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardEarning>(
      row,
      columns: columns?.call(RewardEarning.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardEarning] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardEarning?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardEarningUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardEarning>(
      id,
      columnValues: columnValues(RewardEarning.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardEarning]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEarning>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardEarningUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardEarningTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardEarning>(
      columnValues: columnValues(RewardEarning.t.updateTable),
      where: where(RewardEarning.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardEarning]s in the list and returns the deleted rows.
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
  Future<List<RewardEarning>> delete(
    _is.DatabaseSession session,
    List<RewardEarning> rows, {
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardEarning>(
      rows,
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardEarning].
  Future<RewardEarning> deleteRow(
    _is.DatabaseSession session,
    RewardEarning row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardEarning>(
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
  Future<List<RewardEarning>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardEarningTable> where,
    _is.OrderByBuilder<RewardEarningTable>? orderBy,
    _is.OrderByListBuilder<RewardEarningTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardEarning>(
      where: where(RewardEarning.t),
      orderBy: orderBy?.call(RewardEarning.t),
      orderByList: orderByList?.call(RewardEarning.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEarningTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardEarning>(
      where: where?.call(RewardEarning.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardEarning] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardEarningTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardEarning>(
      where: where(RewardEarning.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
