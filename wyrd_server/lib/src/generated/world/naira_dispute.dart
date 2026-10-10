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

/// A player disputing a charge on their receipts. Small ones are refunded at once (the goodwill rule: up to 1,000
/// naira a week, no questions); the rest wait here for the owner's review.
abstract class NairaDispute
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  NairaDispute._({
    this.id,
    required this.authUserId,
    required this.entryId,
    required this.reason,
    required this.status,
    this.refundEntryId,
    required this.createdAt,
  });

  factory NairaDispute({
    int? id,
    required _is.UuidValue authUserId,
    required int entryId,
    required String reason,
    required String status,
    int? refundEntryId,
    required DateTime createdAt,
  }) = _NairaDisputeImpl;

  factory NairaDispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return NairaDispute(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      entryId: jsonSerialization['entryId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String,
      refundEntryId: jsonSerialization['refundEntryId'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = NairaDisputeTable();

  static const db = NairaDisputeRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// the disputed entry (NairaEntry id)
  int entryId;

  /// not_delivered | wrong_amount | other
  String reason;

  /// refunded | queued | declined
  String status;

  /// the refund's entry, if refunded
  int? refundEntryId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [NairaDispute]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NairaDispute copyWith({
    int? id,
    _is.UuidValue? authUserId,
    int? entryId,
    String? reason,
    String? status,
    int? refundEntryId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NairaDispute',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryId': entryId,
      'reason': reason,
      'status': status,
      if (refundEntryId != null) 'refundEntryId': refundEntryId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NairaDispute',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'entryId': entryId,
      'reason': reason,
      'status': status,
      if (refundEntryId != null) 'refundEntryId': refundEntryId,
      'createdAt': createdAt.toJson(),
    };
  }

  static NairaDisputeInclude include() {
    return NairaDisputeInclude._();
  }

  static NairaDisputeIncludeList includeList({
    _is.WhereExpressionBuilder<NairaDisputeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    NairaDisputeInclude? include,
  }) {
    return NairaDisputeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NairaDisputeImpl extends NairaDispute {
  _NairaDisputeImpl({
    int? id,
    required _is.UuidValue authUserId,
    required int entryId,
    required String reason,
    required String status,
    int? refundEntryId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         entryId: entryId,
         reason: reason,
         status: status,
         refundEntryId: refundEntryId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NairaDispute]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NairaDispute copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    int? entryId,
    String? reason,
    String? status,
    Object? refundEntryId = _Undefined,
    DateTime? createdAt,
  }) {
    return NairaDispute(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      entryId: entryId ?? this.entryId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      refundEntryId: refundEntryId is int? ? refundEntryId : this.refundEntryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NairaDisputeUpdateTable extends _is.UpdateTable<NairaDisputeTable> {
  NairaDisputeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> entryId(int value) => _is.ColumnValue(
    table.entryId,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> refundEntryId(int? value) => _is.ColumnValue(
    table.refundEntryId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class NairaDisputeTable extends _is.Table<int?> {
  NairaDisputeTable({super.tableRelation}) : super(tableName: 'naira_dispute') {
    updateTable = NairaDisputeUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    entryId = _is.ColumnInt(
      'entryId',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    refundEntryId = _is.ColumnInt(
      'refundEntryId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final NairaDisputeUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// the disputed entry (NairaEntry id)
  late final _is.ColumnInt entryId;

  /// not_delivered | wrong_amount | other
  late final _is.ColumnString reason;

  /// refunded | queued | declined
  late final _is.ColumnString status;

  /// the refund's entry, if refunded
  late final _is.ColumnInt refundEntryId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    entryId,
    reason,
    status,
    refundEntryId,
    createdAt,
  ];
}

class NairaDisputeInclude extends _is.IncludeObject {
  NairaDisputeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => NairaDispute.t;
}

class NairaDisputeIncludeList extends _is.IncludeList {
  NairaDisputeIncludeList._({
    _is.WhereExpressionBuilder<NairaDisputeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NairaDispute.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => NairaDispute.t;
}

class NairaDisputeRepository {
  const NairaDisputeRepository._();

  /// Returns a list of [NairaDispute]s matching the given query parameters.
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
  Future<List<NairaDispute>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaDisputeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NairaDispute>(
      where: where?.call(NairaDispute.t),
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NairaDispute] matching the given query parameters.
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
  Future<NairaDispute?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaDisputeTable>? where,
    int? offset,
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NairaDispute>(
      where: where?.call(NairaDispute.t),
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NairaDispute] by its [id] or null if no such row exists.
  Future<NairaDispute?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NairaDispute>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NairaDispute]s in the list and returns the inserted rows.
  ///
  /// The returned [NairaDispute]s will have their `id` fields set.
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
  Future<List<NairaDispute>> insert(
    _is.DatabaseSession session,
    List<NairaDispute> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<NairaDispute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [NairaDispute] and returns the inserted row.
  ///
  /// The returned [NairaDispute] will have its `id` field set.
  Future<NairaDispute> insertRow(
    _is.DatabaseSession session,
    NairaDispute row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<NairaDispute>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [NairaDispute]s in the list and returns the resulting rows.
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
  /// The returned [NairaDispute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaDispute>> upsert(
    _is.DatabaseSession session,
    List<NairaDispute> rows, {
    required _is.ColumnSelections<NairaDisputeTable> conflictColumns,
    _is.ColumnSelections<NairaDisputeTable>? updateColumns,
    _is.WhereExpressionBuilder<NairaDisputeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<NairaDispute>(
      rows,
      conflictColumns: conflictColumns(NairaDispute.t),
      updateColumns: updateColumns?.call(NairaDispute.t),
      updateWhere: updateWhere?.call(NairaDispute.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [NairaDispute] and returns the resulting row.
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
  /// The returned [NairaDispute] will have its `id` field set.
  Future<NairaDispute?> upsertRow(
    _is.DatabaseSession session,
    NairaDispute row, {
    required _is.ColumnSelections<NairaDisputeTable> conflictColumns,
    _is.ColumnSelections<NairaDisputeTable>? updateColumns,
    _is.WhereExpressionBuilder<NairaDisputeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<NairaDispute>(
      row,
      conflictColumns: conflictColumns(NairaDispute.t),
      updateColumns: updateColumns?.call(NairaDispute.t),
      updateWhere: updateWhere?.call(NairaDispute.t),
      transaction: transaction,
    );
  }

  /// Updates all [NairaDispute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaDispute>> update(
    _is.DatabaseSession session,
    List<NairaDispute> rows, {
    _is.ColumnSelections<NairaDisputeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<NairaDispute>(
      rows,
      columns: columns?.call(NairaDispute.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [NairaDispute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NairaDispute> updateRow(
    _is.DatabaseSession session,
    NairaDispute row, {
    _is.ColumnSelections<NairaDisputeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<NairaDispute>(
      row,
      columns: columns?.call(NairaDispute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NairaDispute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NairaDispute?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<NairaDisputeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<NairaDispute>(
      id,
      columnValues: columnValues(NairaDispute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NairaDispute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaDispute>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<NairaDisputeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<NairaDisputeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<NairaDispute>(
      columnValues: columnValues(NairaDispute.t.updateTable),
      where: where(NairaDispute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [NairaDispute]s in the list and returns the deleted rows.
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
  Future<List<NairaDispute>> delete(
    _is.DatabaseSession session,
    List<NairaDispute> rows, {
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<NairaDispute>(
      rows,
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [NairaDispute].
  Future<NairaDispute> deleteRow(
    _is.DatabaseSession session,
    NairaDispute row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NairaDispute>(
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
  Future<List<NairaDispute>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NairaDisputeTable> where,
    _is.OrderByBuilder<NairaDisputeTable>? orderBy,
    _is.OrderByListBuilder<NairaDisputeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<NairaDispute>(
      where: where(NairaDispute.t),
      orderBy: orderBy?.call(NairaDispute.t),
      orderByList: orderByList?.call(NairaDispute.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaDisputeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<NairaDispute>(
      where: where?.call(NairaDispute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NairaDispute] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NairaDisputeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NairaDispute>(
      where: where(NairaDispute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
