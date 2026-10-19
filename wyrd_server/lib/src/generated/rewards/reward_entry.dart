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

/// One line of a RewardJournal: [amount] in the journal's unit (+ into the account, - out of it). Append-only.
abstract class RewardEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardEntry._({
    this.id,
    required this.journalId,
    required this.accountId,
    required this.amount,
    required this.createdAt,
  });

  factory RewardEntry({
    int? id,
    required int journalId,
    required int accountId,
    required int amount,
    required DateTime createdAt,
  }) = _RewardEntryImpl;

  factory RewardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardEntry(
      id: jsonSerialization['id'] as int?,
      journalId: jsonSerialization['journalId'] as int,
      accountId: jsonSerialization['accountId'] as int,
      amount: jsonSerialization['amount'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RewardEntryTable();

  static const db = RewardEntryRepository._();

  @override
  int? id;

  int journalId;

  int accountId;

  int amount;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardEntry copyWith({
    int? id,
    int? journalId,
    int? accountId,
    int? amount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardEntry',
      if (id != null) 'id': id,
      'journalId': journalId,
      'accountId': accountId,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardEntry',
      if (id != null) 'id': id,
      'journalId': journalId,
      'accountId': accountId,
      'amount': amount,
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardEntryInclude include() {
    return RewardEntryInclude._();
  }

  static RewardEntryIncludeList includeList({
    _is.WhereExpressionBuilder<RewardEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    RewardEntryInclude? include,
  }) {
    return RewardEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardEntryImpl extends RewardEntry {
  _RewardEntryImpl({
    int? id,
    required int journalId,
    required int accountId,
    required int amount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         journalId: journalId,
         accountId: accountId,
         amount: amount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardEntry copyWith({
    Object? id = _Undefined,
    int? journalId,
    int? accountId,
    int? amount,
    DateTime? createdAt,
  }) {
    return RewardEntry(
      id: id is int? ? id : this.id,
      journalId: journalId ?? this.journalId,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardEntryUpdateTable extends _is.UpdateTable<RewardEntryTable> {
  RewardEntryUpdateTable(super.table);

  _is.ColumnValue<int, int> journalId(int value) => _is.ColumnValue(
    table.journalId,
    value,
  );

  _is.ColumnValue<int, int> accountId(int value) => _is.ColumnValue(
    table.accountId,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RewardEntryTable extends _is.Table<int?> {
  RewardEntryTable({super.tableRelation}) : super(tableName: 'reward_entry') {
    updateTable = RewardEntryUpdateTable(this);
    journalId = _is.ColumnInt(
      'journalId',
      this,
    );
    accountId = _is.ColumnInt(
      'accountId',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RewardEntryUpdateTable updateTable;

  late final _is.ColumnInt journalId;

  late final _is.ColumnInt accountId;

  late final _is.ColumnInt amount;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    journalId,
    accountId,
    amount,
    createdAt,
  ];
}

class RewardEntryInclude extends _is.IncludeObject {
  RewardEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardEntry.t;
}

class RewardEntryIncludeList extends _is.IncludeList {
  RewardEntryIncludeList._({
    _is.WhereExpressionBuilder<RewardEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardEntry.t;
}

class RewardEntryRepository {
  const RewardEntryRepository._();

  /// Returns a list of [RewardEntry]s matching the given query parameters.
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
  Future<List<RewardEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardEntry>(
      where: where?.call(RewardEntry.t),
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardEntry] matching the given query parameters.
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
  Future<RewardEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardEntry>(
      where: where?.call(RewardEntry.t),
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardEntry] by its [id] or null if no such row exists.
  Future<RewardEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardEntry]s will have their `id` fields set.
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
  Future<List<RewardEntry>> insert(
    _is.DatabaseSession session,
    List<RewardEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardEntry] and returns the inserted row.
  ///
  /// The returned [RewardEntry] will have its `id` field set.
  Future<RewardEntry> insertRow(
    _is.DatabaseSession session,
    RewardEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardEntry]s in the list and returns the resulting rows.
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
  /// The returned [RewardEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEntry>> upsert(
    _is.DatabaseSession session,
    List<RewardEntry> rows, {
    required _is.ColumnSelections<RewardEntryTable> conflictColumns,
    _is.ColumnSelections<RewardEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardEntry>(
      rows,
      conflictColumns: conflictColumns(RewardEntry.t),
      updateColumns: updateColumns?.call(RewardEntry.t),
      updateWhere: updateWhere?.call(RewardEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardEntry] and returns the resulting row.
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
  /// The returned [RewardEntry] will have its `id` field set.
  Future<RewardEntry?> upsertRow(
    _is.DatabaseSession session,
    RewardEntry row, {
    required _is.ColumnSelections<RewardEntryTable> conflictColumns,
    _is.ColumnSelections<RewardEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardEntry>(
      row,
      conflictColumns: conflictColumns(RewardEntry.t),
      updateColumns: updateColumns?.call(RewardEntry.t),
      updateWhere: updateWhere?.call(RewardEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEntry>> update(
    _is.DatabaseSession session,
    List<RewardEntry> rows, {
    _is.ColumnSelections<RewardEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardEntry>(
      rows,
      columns: columns?.call(RewardEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardEntry> updateRow(
    _is.DatabaseSession session,
    RewardEntry row, {
    _is.ColumnSelections<RewardEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardEntry>(
      row,
      columns: columns?.call(RewardEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardEntry>(
      id,
      columnValues: columnValues(RewardEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardEntry>(
      columnValues: columnValues(RewardEntry.t.updateTable),
      where: where(RewardEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardEntry]s in the list and returns the deleted rows.
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
  Future<List<RewardEntry>> delete(
    _is.DatabaseSession session,
    List<RewardEntry> rows, {
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardEntry>(
      rows,
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardEntry].
  Future<RewardEntry> deleteRow(
    _is.DatabaseSession session,
    RewardEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardEntry>(
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
  Future<List<RewardEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardEntryTable> where,
    _is.OrderByBuilder<RewardEntryTable>? orderBy,
    _is.OrderByListBuilder<RewardEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardEntry>(
      where: where(RewardEntry.t),
      orderBy: orderBy?.call(RewardEntry.t),
      orderByList: orderByList?.call(RewardEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardEntry>(
      where: where?.call(RewardEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardEntry>(
      where: where(RewardEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
