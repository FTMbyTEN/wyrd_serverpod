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

abstract class DiaryEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DiaryEntry._({
    this.id,
    required this.date,
    required this.timestamp,
    required this.content,
  });

  factory DiaryEntry({
    int? id,
    required String date,
    required DateTime timestamp,
    required String content,
  }) = _DiaryEntryImpl;

  factory DiaryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiaryEntry(
      id: jsonSerialization['id'] as int?,
      date: jsonSerialization['date'] as String,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      content: jsonSerialization['content'] as String,
    );
  }

  static final t = DiaryEntryTable();

  static const db = DiaryEntryRepository._();

  @override
  int? id;

  String date;

  DateTime timestamp;

  String content;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiaryEntry copyWith({
    int? id,
    String? date,
    DateTime? timestamp,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiaryEntry',
      if (id != null) 'id': id,
      'date': date,
      'timestamp': timestamp.toJson(),
      'content': content,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiaryEntry',
      if (id != null) 'id': id,
      'date': date,
      'timestamp': timestamp.toJson(),
      'content': content,
    };
  }

  static DiaryEntryInclude include() {
    return DiaryEntryInclude._();
  }

  static DiaryEntryIncludeList includeList({
    _is.WhereExpressionBuilder<DiaryEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    DiaryEntryInclude? include,
  }) {
    return DiaryEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiaryEntryImpl extends DiaryEntry {
  _DiaryEntryImpl({
    int? id,
    required String date,
    required DateTime timestamp,
    required String content,
  }) : super._(
         id: id,
         date: date,
         timestamp: timestamp,
         content: content,
       );

  /// Returns a shallow copy of this [DiaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiaryEntry copyWith({
    Object? id = _Undefined,
    String? date,
    DateTime? timestamp,
    String? content,
  }) {
    return DiaryEntry(
      id: id is int? ? id : this.id,
      date: date ?? this.date,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
    );
  }
}

class DiaryEntryUpdateTable extends _is.UpdateTable<DiaryEntryTable> {
  DiaryEntryUpdateTable(super.table);

  _is.ColumnValue<String, String> date(String value) => _is.ColumnValue(
    table.date,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> content(String value) => _is.ColumnValue(
    table.content,
    value,
  );
}

class DiaryEntryTable extends _is.Table<int?> {
  DiaryEntryTable({super.tableRelation}) : super(tableName: 'diary_entry') {
    updateTable = DiaryEntryUpdateTable(this);
    date = _is.ColumnString(
      'date',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    content = _is.ColumnString(
      'content',
      this,
    );
  }

  late final DiaryEntryUpdateTable updateTable;

  late final _is.ColumnString date;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString content;

  @override
  List<_is.Column> get columns => [
    id,
    date,
    timestamp,
    content,
  ];
}

class DiaryEntryInclude extends _is.IncludeObject {
  DiaryEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiaryEntry.t;
}

class DiaryEntryIncludeList extends _is.IncludeList {
  DiaryEntryIncludeList._({
    _is.WhereExpressionBuilder<DiaryEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiaryEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiaryEntry.t;
}

class DiaryEntryRepository {
  const DiaryEntryRepository._();

  /// Returns a list of [DiaryEntry]s matching the given query parameters.
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
  Future<List<DiaryEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiaryEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiaryEntry>(
      where: where?.call(DiaryEntry.t),
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiaryEntry] matching the given query parameters.
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
  Future<DiaryEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiaryEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiaryEntry>(
      where: where?.call(DiaryEntry.t),
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiaryEntry] by its [id] or null if no such row exists.
  Future<DiaryEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiaryEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiaryEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [DiaryEntry]s will have their `id` fields set.
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
  Future<List<DiaryEntry>> insert(
    _is.DatabaseSession session,
    List<DiaryEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiaryEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiaryEntry] and returns the inserted row.
  ///
  /// The returned [DiaryEntry] will have its `id` field set.
  Future<DiaryEntry> insertRow(
    _is.DatabaseSession session,
    DiaryEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiaryEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiaryEntry]s in the list and returns the resulting rows.
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
  /// The returned [DiaryEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiaryEntry>> upsert(
    _is.DatabaseSession session,
    List<DiaryEntry> rows, {
    required _is.ColumnSelections<DiaryEntryTable> conflictColumns,
    _is.ColumnSelections<DiaryEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<DiaryEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiaryEntry>(
      rows,
      conflictColumns: conflictColumns(DiaryEntry.t),
      updateColumns: updateColumns?.call(DiaryEntry.t),
      updateWhere: updateWhere?.call(DiaryEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiaryEntry] and returns the resulting row.
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
  /// The returned [DiaryEntry] will have its `id` field set.
  Future<DiaryEntry?> upsertRow(
    _is.DatabaseSession session,
    DiaryEntry row, {
    required _is.ColumnSelections<DiaryEntryTable> conflictColumns,
    _is.ColumnSelections<DiaryEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<DiaryEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiaryEntry>(
      row,
      conflictColumns: conflictColumns(DiaryEntry.t),
      updateColumns: updateColumns?.call(DiaryEntry.t),
      updateWhere: updateWhere?.call(DiaryEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiaryEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiaryEntry>> update(
    _is.DatabaseSession session,
    List<DiaryEntry> rows, {
    _is.ColumnSelections<DiaryEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiaryEntry>(
      rows,
      columns: columns?.call(DiaryEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiaryEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiaryEntry> updateRow(
    _is.DatabaseSession session,
    DiaryEntry row, {
    _is.ColumnSelections<DiaryEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiaryEntry>(
      row,
      columns: columns?.call(DiaryEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiaryEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiaryEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiaryEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiaryEntry>(
      id,
      columnValues: columnValues(DiaryEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiaryEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiaryEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiaryEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DiaryEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiaryEntry>(
      columnValues: columnValues(DiaryEntry.t.updateTable),
      where: where(DiaryEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiaryEntry]s in the list and returns the deleted rows.
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
  Future<List<DiaryEntry>> delete(
    _is.DatabaseSession session,
    List<DiaryEntry> rows, {
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiaryEntry>(
      rows,
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiaryEntry].
  Future<DiaryEntry> deleteRow(
    _is.DatabaseSession session,
    DiaryEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiaryEntry>(
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
  Future<List<DiaryEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiaryEntryTable> where,
    _is.OrderByBuilder<DiaryEntryTable>? orderBy,
    _is.OrderByListBuilder<DiaryEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiaryEntry>(
      where: where(DiaryEntry.t),
      orderBy: orderBy?.call(DiaryEntry.t),
      orderByList: orderByList?.call(DiaryEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiaryEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiaryEntry>(
      where: where?.call(DiaryEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiaryEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiaryEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiaryEntry>(
      where: where(DiaryEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
