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

/// A paid trip (a flight or a yacht charter): booked when it was paid for, started when the player was actually on it.
/// Only a trip that was booked and never started can be refunded.
abstract class IslandTrip
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandTrip._({
    this.id,
    required this.authUserId,
    required this.entryKey,
    required this.bookedAt,
    this.startedAt,
  });

  factory IslandTrip({
    int? id,
    required _is.UuidValue authUserId,
    required String entryKey,
    required DateTime bookedAt,
    DateTime? startedAt,
  }) = _IslandTripImpl;

  factory IslandTrip.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTrip(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      entryKey: jsonSerialization['entryKey'] as String,
      bookedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['bookedAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
    );
  }

  static final t = IslandTripTable();

  static const db = IslandTripRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// the ledger entry that paid for it (its key)
  String entryKey;

  DateTime bookedAt;

  DateTime? startedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandTrip]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandTrip copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? entryKey,
    DateTime? bookedAt,
    DateTime? startedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTrip',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryKey': entryKey,
      'bookedAt': bookedAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTrip',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryKey': entryKey,
      'bookedAt': bookedAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  static IslandTripInclude include() {
    return IslandTripInclude._();
  }

  static IslandTripIncludeList includeList({
    _is.WhereExpressionBuilder<IslandTripTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    IslandTripInclude? include,
  }) {
    return IslandTripIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTripImpl extends IslandTrip {
  _IslandTripImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String entryKey,
    required DateTime bookedAt,
    DateTime? startedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         entryKey: entryKey,
         bookedAt: bookedAt,
         startedAt: startedAt,
       );

  /// Returns a shallow copy of this [IslandTrip]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandTrip copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? entryKey,
    DateTime? bookedAt,
    Object? startedAt = _Undefined,
  }) {
    return IslandTrip(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      entryKey: entryKey ?? this.entryKey,
      bookedAt: bookedAt ?? this.bookedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
    );
  }
}

class IslandTripUpdateTable extends _is.UpdateTable<IslandTripTable> {
  IslandTripUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> entryKey(String value) => _is.ColumnValue(
    table.entryKey,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> bookedAt(DateTime value) =>
      _is.ColumnValue(
        table.bookedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );
}

class IslandTripTable extends _is.Table<int?> {
  IslandTripTable({super.tableRelation}) : super(tableName: 'island_trip') {
    updateTable = IslandTripUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    entryKey = _is.ColumnString(
      'entryKey',
      this,
    );
    bookedAt = _is.ColumnDateTime(
      'bookedAt',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
  }

  late final IslandTripUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// the ledger entry that paid for it (its key)
  late final _is.ColumnString entryKey;

  late final _is.ColumnDateTime bookedAt;

  late final _is.ColumnDateTime startedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    entryKey,
    bookedAt,
    startedAt,
  ];
}

class IslandTripInclude extends _is.IncludeObject {
  IslandTripInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandTrip.t;
}

class IslandTripIncludeList extends _is.IncludeList {
  IslandTripIncludeList._({
    _is.WhereExpressionBuilder<IslandTripTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandTrip.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandTrip.t;
}

class IslandTripRepository {
  const IslandTripRepository._();

  /// Returns a list of [IslandTrip]s matching the given query parameters.
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
  Future<List<IslandTrip>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTripTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandTrip>(
      where: where?.call(IslandTrip.t),
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandTrip] matching the given query parameters.
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
  Future<IslandTrip?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTripTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandTrip>(
      where: where?.call(IslandTrip.t),
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandTrip] by its [id] or null if no such row exists.
  Future<IslandTrip?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandTrip>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandTrip]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandTrip]s will have their `id` fields set.
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
  Future<List<IslandTrip>> insert(
    _is.DatabaseSession session,
    List<IslandTrip> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandTrip>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandTrip] and returns the inserted row.
  ///
  /// The returned [IslandTrip] will have its `id` field set.
  Future<IslandTrip> insertRow(
    _is.DatabaseSession session,
    IslandTrip row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandTrip>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandTrip]s in the list and returns the resulting rows.
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
  /// The returned [IslandTrip]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTrip>> upsert(
    _is.DatabaseSession session,
    List<IslandTrip> rows, {
    required _is.ColumnSelections<IslandTripTable> conflictColumns,
    _is.ColumnSelections<IslandTripTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTripTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandTrip>(
      rows,
      conflictColumns: conflictColumns(IslandTrip.t),
      updateColumns: updateColumns?.call(IslandTrip.t),
      updateWhere: updateWhere?.call(IslandTrip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandTrip] and returns the resulting row.
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
  /// The returned [IslandTrip] will have its `id` field set.
  Future<IslandTrip?> upsertRow(
    _is.DatabaseSession session,
    IslandTrip row, {
    required _is.ColumnSelections<IslandTripTable> conflictColumns,
    _is.ColumnSelections<IslandTripTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTripTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandTrip>(
      row,
      conflictColumns: conflictColumns(IslandTrip.t),
      updateColumns: updateColumns?.call(IslandTrip.t),
      updateWhere: updateWhere?.call(IslandTrip.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTrip]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTrip>> update(
    _is.DatabaseSession session,
    List<IslandTrip> rows, {
    _is.ColumnSelections<IslandTripTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandTrip>(
      rows,
      columns: columns?.call(IslandTrip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandTrip]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandTrip> updateRow(
    _is.DatabaseSession session,
    IslandTrip row, {
    _is.ColumnSelections<IslandTripTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandTrip>(
      row,
      columns: columns?.call(IslandTrip.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandTrip] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandTrip?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandTripUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandTrip>(
      id,
      columnValues: columnValues(IslandTrip.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTrip]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTrip>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandTripUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandTripTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandTrip>(
      columnValues: columnValues(IslandTrip.t.updateTable),
      where: where(IslandTrip.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandTrip]s in the list and returns the deleted rows.
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
  Future<List<IslandTrip>> delete(
    _is.DatabaseSession session,
    List<IslandTrip> rows, {
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandTrip>(
      rows,
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandTrip].
  Future<IslandTrip> deleteRow(
    _is.DatabaseSession session,
    IslandTrip row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandTrip>(
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
  Future<List<IslandTrip>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTripTable> where,
    _is.OrderByBuilder<IslandTripTable>? orderBy,
    _is.OrderByListBuilder<IslandTripTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandTrip>(
      where: where(IslandTrip.t),
      orderBy: orderBy?.call(IslandTrip.t),
      orderByList: orderByList?.call(IslandTrip.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTripTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandTrip>(
      where: where?.call(IslandTrip.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandTrip] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTripTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandTrip>(
      where: where(IslandTrip.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
