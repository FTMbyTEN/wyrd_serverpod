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

abstract class ReasoningNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ReasoningNote._({
    this.id,
    required this.timestamp,
    required this.kind,
    required this.content,
  });

  factory ReasoningNote({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String content,
  }) = _ReasoningNoteImpl;

  factory ReasoningNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReasoningNote(
      id: jsonSerialization['id'] as int?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      kind: jsonSerialization['kind'] as String,
      content: jsonSerialization['content'] as String,
    );
  }

  static final t = ReasoningNoteTable();

  static const db = ReasoningNoteRepository._();

  @override
  int? id;

  DateTime timestamp;

  String kind;

  String content;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReasoningNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReasoningNote copyWith({
    int? id,
    DateTime? timestamp,
    String? kind,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReasoningNote',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'content': content,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReasoningNote',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'kind': kind,
      'content': content,
    };
  }

  static ReasoningNoteInclude include() {
    return ReasoningNoteInclude._();
  }

  static ReasoningNoteIncludeList includeList({
    _is.WhereExpressionBuilder<ReasoningNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    ReasoningNoteInclude? include,
  }) {
    return ReasoningNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReasoningNoteImpl extends ReasoningNote {
  _ReasoningNoteImpl({
    int? id,
    required DateTime timestamp,
    required String kind,
    required String content,
  }) : super._(
         id: id,
         timestamp: timestamp,
         kind: kind,
         content: content,
       );

  /// Returns a shallow copy of this [ReasoningNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReasoningNote copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? kind,
    String? content,
  }) {
    return ReasoningNote(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      kind: kind ?? this.kind,
      content: content ?? this.content,
    );
  }
}

class ReasoningNoteUpdateTable extends _is.UpdateTable<ReasoningNoteTable> {
  ReasoningNoteUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> content(String value) => _is.ColumnValue(
    table.content,
    value,
  );
}

class ReasoningNoteTable extends _is.Table<int?> {
  ReasoningNoteTable({super.tableRelation})
    : super(tableName: 'reasoning_note') {
    updateTable = ReasoningNoteUpdateTable(this);
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    content = _is.ColumnString(
      'content',
      this,
    );
  }

  late final ReasoningNoteUpdateTable updateTable;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString kind;

  late final _is.ColumnString content;

  @override
  List<_is.Column> get columns => [
    id,
    timestamp,
    kind,
    content,
  ];
}

class ReasoningNoteInclude extends _is.IncludeObject {
  ReasoningNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReasoningNote.t;
}

class ReasoningNoteIncludeList extends _is.IncludeList {
  ReasoningNoteIncludeList._({
    _is.WhereExpressionBuilder<ReasoningNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReasoningNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReasoningNote.t;
}

class ReasoningNoteRepository {
  const ReasoningNoteRepository._();

  /// Returns a list of [ReasoningNote]s matching the given query parameters.
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
  Future<List<ReasoningNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReasoningNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReasoningNote>(
      where: where?.call(ReasoningNote.t),
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReasoningNote] matching the given query parameters.
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
  Future<ReasoningNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReasoningNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReasoningNote>(
      where: where?.call(ReasoningNote.t),
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReasoningNote] by its [id] or null if no such row exists.
  Future<ReasoningNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReasoningNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReasoningNote]s in the list and returns the inserted rows.
  ///
  /// The returned [ReasoningNote]s will have their `id` fields set.
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
  Future<List<ReasoningNote>> insert(
    _is.DatabaseSession session,
    List<ReasoningNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReasoningNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReasoningNote] and returns the inserted row.
  ///
  /// The returned [ReasoningNote] will have its `id` field set.
  Future<ReasoningNote> insertRow(
    _is.DatabaseSession session,
    ReasoningNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReasoningNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReasoningNote]s in the list and returns the resulting rows.
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
  /// The returned [ReasoningNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReasoningNote>> upsert(
    _is.DatabaseSession session,
    List<ReasoningNote> rows, {
    required _is.ColumnSelections<ReasoningNoteTable> conflictColumns,
    _is.ColumnSelections<ReasoningNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<ReasoningNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReasoningNote>(
      rows,
      conflictColumns: conflictColumns(ReasoningNote.t),
      updateColumns: updateColumns?.call(ReasoningNote.t),
      updateWhere: updateWhere?.call(ReasoningNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReasoningNote] and returns the resulting row.
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
  /// The returned [ReasoningNote] will have its `id` field set.
  Future<ReasoningNote?> upsertRow(
    _is.DatabaseSession session,
    ReasoningNote row, {
    required _is.ColumnSelections<ReasoningNoteTable> conflictColumns,
    _is.ColumnSelections<ReasoningNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<ReasoningNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReasoningNote>(
      row,
      conflictColumns: conflictColumns(ReasoningNote.t),
      updateColumns: updateColumns?.call(ReasoningNote.t),
      updateWhere: updateWhere?.call(ReasoningNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReasoningNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReasoningNote>> update(
    _is.DatabaseSession session,
    List<ReasoningNote> rows, {
    _is.ColumnSelections<ReasoningNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReasoningNote>(
      rows,
      columns: columns?.call(ReasoningNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReasoningNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReasoningNote> updateRow(
    _is.DatabaseSession session,
    ReasoningNote row, {
    _is.ColumnSelections<ReasoningNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReasoningNote>(
      row,
      columns: columns?.call(ReasoningNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReasoningNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReasoningNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReasoningNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReasoningNote>(
      id,
      columnValues: columnValues(ReasoningNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReasoningNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReasoningNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReasoningNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReasoningNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReasoningNote>(
      columnValues: columnValues(ReasoningNote.t.updateTable),
      where: where(ReasoningNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReasoningNote]s in the list and returns the deleted rows.
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
  Future<List<ReasoningNote>> delete(
    _is.DatabaseSession session,
    List<ReasoningNote> rows, {
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReasoningNote>(
      rows,
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReasoningNote].
  Future<ReasoningNote> deleteRow(
    _is.DatabaseSession session,
    ReasoningNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReasoningNote>(
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
  Future<List<ReasoningNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReasoningNoteTable> where,
    _is.OrderByBuilder<ReasoningNoteTable>? orderBy,
    _is.OrderByListBuilder<ReasoningNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReasoningNote>(
      where: where(ReasoningNote.t),
      orderBy: orderBy?.call(ReasoningNote.t),
      orderByList: orderByList?.call(ReasoningNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReasoningNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReasoningNote>(
      where: where?.call(ReasoningNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReasoningNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReasoningNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReasoningNote>(
      where: where(ReasoningNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
