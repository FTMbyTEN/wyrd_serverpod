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

/// One design proposal for the open world, from WYRD (or the owner) in the design studio. Approved
/// proposals of a live kind (mission, npc_lines, tuning, event) change the game at once; ideas and
/// rules are a backlog to build.
abstract class CityDesignNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CityDesignNote._({
    this.id,
    required this.author,
    required this.kind,
    required this.title,
    required this.body,
    this.payload,
    required this.status,
    required this.createdAt,
    this.decidedAt,
  });

  factory CityDesignNote({
    int? id,
    required String author,
    required String kind,
    required String title,
    required String body,
    String? payload,
    required String status,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _CityDesignNoteImpl;

  factory CityDesignNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityDesignNote(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as String,
      kind: jsonSerialization['kind'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      payload: jsonSerialization['payload'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = CityDesignNoteTable();

  static const db = CityDesignNoteRepository._();

  @override
  int? id;

  /// 'wyrd' or 'owner'
  String author;

  /// idea | rule | mission | npc_lines | tuning | event
  String kind;

  String title;

  String body;

  /// for live kinds: the checked settings, as JSON
  String? payload;

  /// proposed | approved | rejected
  String status;

  DateTime createdAt;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CityDesignNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CityDesignNote copyWith({
    int? id,
    String? author,
    String? kind,
    String? title,
    String? body,
    String? payload,
    String? status,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityDesignNote',
      if (id != null) 'id': id,
      'author': author,
      'kind': kind,
      'title': title,
      'body': body,
      if (payload != null) 'payload': payload,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CityDesignNote',
      if (id != null) 'id': id,
      'author': author,
      'kind': kind,
      'title': title,
      'body': body,
      if (payload != null) 'payload': payload,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  static CityDesignNoteInclude include() {
    return CityDesignNoteInclude._();
  }

  static CityDesignNoteIncludeList includeList({
    _is.WhereExpressionBuilder<CityDesignNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    CityDesignNoteInclude? include,
  }) {
    return CityDesignNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityDesignNoteImpl extends CityDesignNote {
  _CityDesignNoteImpl({
    int? id,
    required String author,
    required String kind,
    required String title,
    required String body,
    String? payload,
    required String status,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         author: author,
         kind: kind,
         title: title,
         body: body,
         payload: payload,
         status: status,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [CityDesignNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CityDesignNote copyWith({
    Object? id = _Undefined,
    String? author,
    String? kind,
    String? title,
    String? body,
    Object? payload = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return CityDesignNote(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload is String? ? payload : this.payload,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class CityDesignNoteUpdateTable extends _is.UpdateTable<CityDesignNoteTable> {
  CityDesignNoteUpdateTable(super.table);

  _is.ColumnValue<String, String> author(String value) => _is.ColumnValue(
    table.author,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<String, String> payload(String? value) => _is.ColumnValue(
    table.payload,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class CityDesignNoteTable extends _is.Table<int?> {
  CityDesignNoteTable({super.tableRelation})
    : super(tableName: 'city_design_note') {
    updateTable = CityDesignNoteUpdateTable(this);
    author = _is.ColumnString(
      'author',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    body = _is.ColumnString(
      'body',
      this,
    );
    payload = _is.ColumnString(
      'payload',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final CityDesignNoteUpdateTable updateTable;

  /// 'wyrd' or 'owner'
  late final _is.ColumnString author;

  /// idea | rule | mission | npc_lines | tuning | event
  late final _is.ColumnString kind;

  late final _is.ColumnString title;

  late final _is.ColumnString body;

  /// for live kinds: the checked settings, as JSON
  late final _is.ColumnString payload;

  /// proposed | approved | rejected
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    author,
    kind,
    title,
    body,
    payload,
    status,
    createdAt,
    decidedAt,
  ];
}

class CityDesignNoteInclude extends _is.IncludeObject {
  CityDesignNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CityDesignNote.t;
}

class CityDesignNoteIncludeList extends _is.IncludeList {
  CityDesignNoteIncludeList._({
    _is.WhereExpressionBuilder<CityDesignNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CityDesignNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CityDesignNote.t;
}

class CityDesignNoteRepository {
  const CityDesignNoteRepository._();

  /// Returns a list of [CityDesignNote]s matching the given query parameters.
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
  Future<List<CityDesignNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityDesignNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CityDesignNote>(
      where: where?.call(CityDesignNote.t),
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CityDesignNote] matching the given query parameters.
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
  Future<CityDesignNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityDesignNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CityDesignNote>(
      where: where?.call(CityDesignNote.t),
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CityDesignNote] by its [id] or null if no such row exists.
  Future<CityDesignNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CityDesignNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CityDesignNote]s in the list and returns the inserted rows.
  ///
  /// The returned [CityDesignNote]s will have their `id` fields set.
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
  Future<List<CityDesignNote>> insert(
    _is.DatabaseSession session,
    List<CityDesignNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CityDesignNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CityDesignNote] and returns the inserted row.
  ///
  /// The returned [CityDesignNote] will have its `id` field set.
  Future<CityDesignNote> insertRow(
    _is.DatabaseSession session,
    CityDesignNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CityDesignNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CityDesignNote]s in the list and returns the resulting rows.
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
  /// The returned [CityDesignNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityDesignNote>> upsert(
    _is.DatabaseSession session,
    List<CityDesignNote> rows, {
    required _is.ColumnSelections<CityDesignNoteTable> conflictColumns,
    _is.ColumnSelections<CityDesignNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<CityDesignNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CityDesignNote>(
      rows,
      conflictColumns: conflictColumns(CityDesignNote.t),
      updateColumns: updateColumns?.call(CityDesignNote.t),
      updateWhere: updateWhere?.call(CityDesignNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CityDesignNote] and returns the resulting row.
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
  /// The returned [CityDesignNote] will have its `id` field set.
  Future<CityDesignNote?> upsertRow(
    _is.DatabaseSession session,
    CityDesignNote row, {
    required _is.ColumnSelections<CityDesignNoteTable> conflictColumns,
    _is.ColumnSelections<CityDesignNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<CityDesignNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CityDesignNote>(
      row,
      conflictColumns: conflictColumns(CityDesignNote.t),
      updateColumns: updateColumns?.call(CityDesignNote.t),
      updateWhere: updateWhere?.call(CityDesignNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [CityDesignNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityDesignNote>> update(
    _is.DatabaseSession session,
    List<CityDesignNote> rows, {
    _is.ColumnSelections<CityDesignNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CityDesignNote>(
      rows,
      columns: columns?.call(CityDesignNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CityDesignNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CityDesignNote> updateRow(
    _is.DatabaseSession session,
    CityDesignNote row, {
    _is.ColumnSelections<CityDesignNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CityDesignNote>(
      row,
      columns: columns?.call(CityDesignNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CityDesignNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CityDesignNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CityDesignNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CityDesignNote>(
      id,
      columnValues: columnValues(CityDesignNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CityDesignNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityDesignNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CityDesignNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CityDesignNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CityDesignNote>(
      columnValues: columnValues(CityDesignNote.t.updateTable),
      where: where(CityDesignNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CityDesignNote]s in the list and returns the deleted rows.
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
  Future<List<CityDesignNote>> delete(
    _is.DatabaseSession session,
    List<CityDesignNote> rows, {
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CityDesignNote>(
      rows,
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CityDesignNote].
  Future<CityDesignNote> deleteRow(
    _is.DatabaseSession session,
    CityDesignNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CityDesignNote>(
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
  Future<List<CityDesignNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityDesignNoteTable> where,
    _is.OrderByBuilder<CityDesignNoteTable>? orderBy,
    _is.OrderByListBuilder<CityDesignNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CityDesignNote>(
      where: where(CityDesignNote.t),
      orderBy: orderBy?.call(CityDesignNote.t),
      orderByList: orderByList?.call(CityDesignNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityDesignNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CityDesignNote>(
      where: where?.call(CityDesignNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CityDesignNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityDesignNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CityDesignNote>(
      where: where(CityDesignNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
