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

abstract class CopLogEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CopLogEntry._({
    this.id,
    required this.timestamp,
    required this.kind,
    required this.configKey,
    required this.oldValueJson,
    required this.newValueJson,
    required this.reason,
    required this.verdict,
  });

  factory CopLogEntry({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String configKey,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
    required String verdict,
  }) = _CopLogEntryImpl;

  factory CopLogEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return CopLogEntry(
      id: jsonSerialization['id'] as int?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      kind: jsonSerialization['kind'] as String,
      configKey: jsonSerialization['configKey'] as String,
      oldValueJson: jsonSerialization['oldValueJson'] as String,
      newValueJson: jsonSerialization['newValueJson'] as String,
      reason: jsonSerialization['reason'] as String,
      verdict: jsonSerialization['verdict'] as String,
    );
  }

  static final t = CopLogEntryTable();

  static const db = CopLogEntryRepository._();

  @override
  int? id;

  DateTime timestamp;

  String kind;

  String configKey;

  String oldValueJson;

  String newValueJson;

  String reason;

  String verdict;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CopLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CopLogEntry copyWith({
    int? id,
    DateTime? timestamp,
    String? kind,
    String? configKey,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? verdict,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CopLogEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'configKey': configKey,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
      'verdict': verdict,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CopLogEntry',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'configKey': configKey,
      'oldValueJson': oldValueJson,
      'newValueJson': newValueJson,
      'reason': reason,
      'verdict': verdict,
    };
  }

  static CopLogEntryInclude include() {
    return CopLogEntryInclude._();
  }

  static CopLogEntryIncludeList includeList({
    _is.WhereExpressionBuilder<CopLogEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    CopLogEntryInclude? include,
  }) {
    return CopLogEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CopLogEntryImpl extends CopLogEntry {
  _CopLogEntryImpl({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String configKey,
    required String oldValueJson,
    required String newValueJson,
    required String reason,
    required String verdict,
  }) : super._(
         id: id,
         timestamp: timestamp,
         kind: kind,
         configKey: configKey,
         oldValueJson: oldValueJson,
         newValueJson: newValueJson,
         reason: reason,
         verdict: verdict,
       );

  /// Returns a shallow copy of this [CopLogEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CopLogEntry copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? kind,
    String? configKey,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
    String? verdict,
  }) {
    return CopLogEntry(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      kind: kind ?? this.kind,
      configKey: configKey ?? this.configKey,
      oldValueJson: oldValueJson ?? this.oldValueJson,
      newValueJson: newValueJson ?? this.newValueJson,
      reason: reason ?? this.reason,
      verdict: verdict ?? this.verdict,
    );
  }
}

class CopLogEntryUpdateTable extends _is.UpdateTable<CopLogEntryTable> {
  CopLogEntryUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> configKey(String value) => _is.ColumnValue(
    table.configKey,
    value,
  );

  _is.ColumnValue<String, String> oldValueJson(String value) => _is.ColumnValue(
    table.oldValueJson,
    value,
  );

  _is.ColumnValue<String, String> newValueJson(String value) => _is.ColumnValue(
    table.newValueJson,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<String, String> verdict(String value) => _is.ColumnValue(
    table.verdict,
    value,
  );
}

class CopLogEntryTable extends _is.Table<int?> {
  CopLogEntryTable({super.tableRelation}) : super(tableName: 'cop_log_entry') {
    updateTable = CopLogEntryUpdateTable(this);
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    configKey = _is.ColumnString(
      'configKey',
      this,
    );
    oldValueJson = _is.ColumnString(
      'oldValueJson',
      this,
    );
    newValueJson = _is.ColumnString(
      'newValueJson',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    verdict = _is.ColumnString(
      'verdict',
      this,
    );
  }

  late final CopLogEntryUpdateTable updateTable;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString kind;

  late final _is.ColumnString configKey;

  late final _is.ColumnString oldValueJson;

  late final _is.ColumnString newValueJson;

  late final _is.ColumnString reason;

  late final _is.ColumnString verdict;

  @override
  List<_is.Column> get columns => [
    id,
    timestamp,
    kind,
    configKey,
    oldValueJson,
    newValueJson,
    reason,
    verdict,
  ];
}

class CopLogEntryInclude extends _is.IncludeObject {
  CopLogEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CopLogEntry.t;
}

class CopLogEntryIncludeList extends _is.IncludeList {
  CopLogEntryIncludeList._({
    _is.WhereExpressionBuilder<CopLogEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CopLogEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CopLogEntry.t;
}

class CopLogEntryRepository {
  const CopLogEntryRepository._();

  /// Returns a list of [CopLogEntry]s matching the given query parameters.
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
  Future<List<CopLogEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CopLogEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CopLogEntry>(
      where: where?.call(CopLogEntry.t),
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CopLogEntry] matching the given query parameters.
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
  Future<CopLogEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CopLogEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CopLogEntry>(
      where: where?.call(CopLogEntry.t),
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CopLogEntry] by its [id] or null if no such row exists.
  Future<CopLogEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CopLogEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CopLogEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [CopLogEntry]s will have their `id` fields set.
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
  Future<List<CopLogEntry>> insert(
    _is.DatabaseSession session,
    List<CopLogEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CopLogEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CopLogEntry] and returns the inserted row.
  ///
  /// The returned [CopLogEntry] will have its `id` field set.
  Future<CopLogEntry> insertRow(
    _is.DatabaseSession session,
    CopLogEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CopLogEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CopLogEntry]s in the list and returns the resulting rows.
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
  /// The returned [CopLogEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CopLogEntry>> upsert(
    _is.DatabaseSession session,
    List<CopLogEntry> rows, {
    required _is.ColumnSelections<CopLogEntryTable> conflictColumns,
    _is.ColumnSelections<CopLogEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<CopLogEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CopLogEntry>(
      rows,
      conflictColumns: conflictColumns(CopLogEntry.t),
      updateColumns: updateColumns?.call(CopLogEntry.t),
      updateWhere: updateWhere?.call(CopLogEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CopLogEntry] and returns the resulting row.
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
  /// The returned [CopLogEntry] will have its `id` field set.
  Future<CopLogEntry?> upsertRow(
    _is.DatabaseSession session,
    CopLogEntry row, {
    required _is.ColumnSelections<CopLogEntryTable> conflictColumns,
    _is.ColumnSelections<CopLogEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<CopLogEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CopLogEntry>(
      row,
      conflictColumns: conflictColumns(CopLogEntry.t),
      updateColumns: updateColumns?.call(CopLogEntry.t),
      updateWhere: updateWhere?.call(CopLogEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [CopLogEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CopLogEntry>> update(
    _is.DatabaseSession session,
    List<CopLogEntry> rows, {
    _is.ColumnSelections<CopLogEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CopLogEntry>(
      rows,
      columns: columns?.call(CopLogEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CopLogEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CopLogEntry> updateRow(
    _is.DatabaseSession session,
    CopLogEntry row, {
    _is.ColumnSelections<CopLogEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CopLogEntry>(
      row,
      columns: columns?.call(CopLogEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CopLogEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CopLogEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CopLogEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CopLogEntry>(
      id,
      columnValues: columnValues(CopLogEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CopLogEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CopLogEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CopLogEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CopLogEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CopLogEntry>(
      columnValues: columnValues(CopLogEntry.t.updateTable),
      where: where(CopLogEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CopLogEntry]s in the list and returns the deleted rows.
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
  Future<List<CopLogEntry>> delete(
    _is.DatabaseSession session,
    List<CopLogEntry> rows, {
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CopLogEntry>(
      rows,
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CopLogEntry].
  Future<CopLogEntry> deleteRow(
    _is.DatabaseSession session,
    CopLogEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CopLogEntry>(
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
  Future<List<CopLogEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CopLogEntryTable> where,
    _is.OrderByBuilder<CopLogEntryTable>? orderBy,
    _is.OrderByListBuilder<CopLogEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CopLogEntry>(
      where: where(CopLogEntry.t),
      orderBy: orderBy?.call(CopLogEntry.t),
      orderByList: orderByList?.call(CopLogEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CopLogEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CopLogEntry>(
      where: where?.call(CopLogEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CopLogEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CopLogEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CopLogEntry>(
      where: where(CopLogEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
