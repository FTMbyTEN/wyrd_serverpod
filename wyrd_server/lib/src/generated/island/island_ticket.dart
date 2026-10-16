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

/// A ticket to an arena show.
abstract class IslandTicket
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandTicket._({
    this.id,
    required this.showId,
    required this.authUserId,
    required this.createdAt,
  });

  factory IslandTicket({
    int? id,
    required int showId,
    required _is.UuidValue authUserId,
    required DateTime createdAt,
  }) = _IslandTicketImpl;

  factory IslandTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTicket(
      id: jsonSerialization['id'] as int?,
      showId: jsonSerialization['showId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandTicketTable();

  static const db = IslandTicketRepository._();

  @override
  int? id;

  int showId;

  _is.UuidValue authUserId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandTicket]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandTicket copyWith({
    int? id,
    int? showId,
    _is.UuidValue? authUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTicket',
      if (id != null) 'id': id,
      'showId': showId,
      'authUserId': authUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTicket',
      if (id != null) 'id': id,
      'showId': showId,
      'authUserId': authUserId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandTicketInclude include() {
    return IslandTicketInclude._();
  }

  static IslandTicketIncludeList includeList({
    _is.WhereExpressionBuilder<IslandTicketTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    IslandTicketInclude? include,
  }) {
    return IslandTicketIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTicketImpl extends IslandTicket {
  _IslandTicketImpl({
    int? id,
    required int showId,
    required _is.UuidValue authUserId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         showId: showId,
         authUserId: authUserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandTicket]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandTicket copyWith({
    Object? id = _Undefined,
    int? showId,
    _is.UuidValue? authUserId,
    DateTime? createdAt,
  }) {
    return IslandTicket(
      id: id is int? ? id : this.id,
      showId: showId ?? this.showId,
      authUserId: authUserId ?? this.authUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandTicketUpdateTable extends _is.UpdateTable<IslandTicketTable> {
  IslandTicketUpdateTable(super.table);

  _is.ColumnValue<int, int> showId(int value) => _is.ColumnValue(
    table.showId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandTicketTable extends _is.Table<int?> {
  IslandTicketTable({super.tableRelation}) : super(tableName: 'island_ticket') {
    updateTable = IslandTicketUpdateTable(this);
    showId = _is.ColumnInt(
      'showId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandTicketUpdateTable updateTable;

  late final _is.ColumnInt showId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    showId,
    authUserId,
    createdAt,
  ];
}

class IslandTicketInclude extends _is.IncludeObject {
  IslandTicketInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandTicket.t;
}

class IslandTicketIncludeList extends _is.IncludeList {
  IslandTicketIncludeList._({
    _is.WhereExpressionBuilder<IslandTicketTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandTicket.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandTicket.t;
}

class IslandTicketRepository {
  const IslandTicketRepository._();

  /// Returns a list of [IslandTicket]s matching the given query parameters.
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
  Future<List<IslandTicket>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTicketTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandTicket>(
      where: where?.call(IslandTicket.t),
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandTicket] matching the given query parameters.
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
  Future<IslandTicket?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTicketTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandTicket>(
      where: where?.call(IslandTicket.t),
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandTicket] by its [id] or null if no such row exists.
  Future<IslandTicket?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandTicket>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandTicket]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandTicket]s will have their `id` fields set.
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
  Future<List<IslandTicket>> insert(
    _is.DatabaseSession session,
    List<IslandTicket> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandTicket>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandTicket] and returns the inserted row.
  ///
  /// The returned [IslandTicket] will have its `id` field set.
  Future<IslandTicket> insertRow(
    _is.DatabaseSession session,
    IslandTicket row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandTicket>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandTicket]s in the list and returns the resulting rows.
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
  /// The returned [IslandTicket]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTicket>> upsert(
    _is.DatabaseSession session,
    List<IslandTicket> rows, {
    required _is.ColumnSelections<IslandTicketTable> conflictColumns,
    _is.ColumnSelections<IslandTicketTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTicketTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandTicket>(
      rows,
      conflictColumns: conflictColumns(IslandTicket.t),
      updateColumns: updateColumns?.call(IslandTicket.t),
      updateWhere: updateWhere?.call(IslandTicket.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandTicket] and returns the resulting row.
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
  /// The returned [IslandTicket] will have its `id` field set.
  Future<IslandTicket?> upsertRow(
    _is.DatabaseSession session,
    IslandTicket row, {
    required _is.ColumnSelections<IslandTicketTable> conflictColumns,
    _is.ColumnSelections<IslandTicketTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTicketTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandTicket>(
      row,
      conflictColumns: conflictColumns(IslandTicket.t),
      updateColumns: updateColumns?.call(IslandTicket.t),
      updateWhere: updateWhere?.call(IslandTicket.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTicket]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTicket>> update(
    _is.DatabaseSession session,
    List<IslandTicket> rows, {
    _is.ColumnSelections<IslandTicketTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandTicket>(
      rows,
      columns: columns?.call(IslandTicket.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandTicket]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandTicket> updateRow(
    _is.DatabaseSession session,
    IslandTicket row, {
    _is.ColumnSelections<IslandTicketTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandTicket>(
      row,
      columns: columns?.call(IslandTicket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandTicket] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandTicket?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandTicketUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandTicket>(
      id,
      columnValues: columnValues(IslandTicket.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTicket]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTicket>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandTicketUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandTicketTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandTicket>(
      columnValues: columnValues(IslandTicket.t.updateTable),
      where: where(IslandTicket.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandTicket]s in the list and returns the deleted rows.
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
  Future<List<IslandTicket>> delete(
    _is.DatabaseSession session,
    List<IslandTicket> rows, {
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandTicket>(
      rows,
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandTicket].
  Future<IslandTicket> deleteRow(
    _is.DatabaseSession session,
    IslandTicket row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandTicket>(
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
  Future<List<IslandTicket>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTicketTable> where,
    _is.OrderByBuilder<IslandTicketTable>? orderBy,
    _is.OrderByListBuilder<IslandTicketTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandTicket>(
      where: where(IslandTicket.t),
      orderBy: orderBy?.call(IslandTicket.t),
      orderByList: orderByList?.call(IslandTicket.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTicketTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandTicket>(
      where: where?.call(IslandTicket.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandTicket] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTicketTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandTicket>(
      where: where(IslandTicket.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
