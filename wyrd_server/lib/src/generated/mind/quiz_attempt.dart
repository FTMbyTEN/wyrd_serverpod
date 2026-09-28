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
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;

abstract class QuizAttempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuizAttempt._({
    this.id,
    required this.authUserId,
    this.readingItemId,
    required this.title,
    required this.correct,
    required this.total,
    required this.missed,
    required this.at,
  });

  factory QuizAttempt({
    int? id,
    required _is.UuidValue authUserId,
    int? readingItemId,
    required String title,
    required int correct,
    required int total,
    required List<String> missed,
    required DateTime at,
  }) = _QuizAttemptImpl;

  factory QuizAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAttempt(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      readingItemId: jsonSerialization['readingItemId'] as int?,
      title: jsonSerialization['title'] as String,
      correct: jsonSerialization['correct'] as int,
      total: jsonSerialization['total'] as int,
      missed: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['missed'],
      ),
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  static final t = QuizAttemptTable();

  static const db = QuizAttemptRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  int? readingItemId;

  String title;

  int correct;

  int total;

  List<String> missed;

  DateTime at;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizAttempt copyWith({
    int? id,
    _is.UuidValue? authUserId,
    int? readingItemId,
    String? title,
    int? correct,
    int? total,
    List<String>? missed,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (readingItemId != null) 'readingItemId': readingItemId,
      'title': title,
      'correct': correct,
      'total': total,
      'missed': missed.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (readingItemId != null) 'readingItemId': readingItemId,
      'title': title,
      'correct': correct,
      'total': total,
      'missed': missed.toJson(),
      'at': at.toJson(),
    };
  }

  static QuizAttemptInclude include() {
    return QuizAttemptInclude._();
  }

  static QuizAttemptIncludeList includeList({
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    QuizAttemptInclude? include,
  }) {
    return QuizAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAttemptImpl extends QuizAttempt {
  _QuizAttemptImpl({
    int? id,
    required _is.UuidValue authUserId,
    int? readingItemId,
    required String title,
    required int correct,
    required int total,
    required List<String> missed,
    required DateTime at,
  }) : super._(
         id: id,
         authUserId: authUserId,
         readingItemId: readingItemId,
         title: title,
         correct: correct,
         total: total,
         missed: missed,
         at: at,
       );

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizAttempt copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? readingItemId = _Undefined,
    String? title,
    int? correct,
    int? total,
    List<String>? missed,
    DateTime? at,
  }) {
    return QuizAttempt(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      readingItemId: readingItemId is int? ? readingItemId : this.readingItemId,
      title: title ?? this.title,
      correct: correct ?? this.correct,
      total: total ?? this.total,
      missed: missed ?? this.missed.map((e0) => e0).toList(),
      at: at ?? this.at,
    );
  }
}

class QuizAttemptUpdateTable extends _is.UpdateTable<QuizAttemptTable> {
  QuizAttemptUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> readingItemId(int? value) => _is.ColumnValue(
    table.readingItemId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<int, int> correct(int value) => _is.ColumnValue(
    table.correct,
    value,
  );

  _is.ColumnValue<int, int> total(int value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> missed(List<String> value) =>
      _is.ColumnValue(
        table.missed,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );
}

class QuizAttemptTable extends _is.Table<int?> {
  QuizAttemptTable({super.tableRelation}) : super(tableName: 'quiz_attempt') {
    updateTable = QuizAttemptUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    readingItemId = _is.ColumnInt(
      'readingItemId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    correct = _is.ColumnInt(
      'correct',
      this,
    );
    total = _is.ColumnInt(
      'total',
      this,
    );
    missed = _is.ColumnSerializable<List<String>>(
      'missed',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
    );
  }

  late final QuizAttemptUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt readingItemId;

  late final _is.ColumnString title;

  late final _is.ColumnInt correct;

  late final _is.ColumnInt total;

  late final _is.ColumnSerializable<List<String>> missed;

  late final _is.ColumnDateTime at;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    readingItemId,
    title,
    correct,
    total,
    missed,
    at,
  ];
}

class QuizAttemptInclude extends _is.IncludeObject {
  QuizAttemptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuizAttempt.t;
}

class QuizAttemptIncludeList extends _is.IncludeList {
  QuizAttemptIncludeList._({
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuizAttempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuizAttempt.t;
}

class QuizAttemptRepository {
  const QuizAttemptRepository._();

  /// Returns a list of [QuizAttempt]s matching the given query parameters.
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
  Future<List<QuizAttempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuizAttempt] matching the given query parameters.
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
  Future<QuizAttempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuizAttempt] by its [id] or null if no such row exists.
  Future<QuizAttempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuizAttempt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuizAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [QuizAttempt]s will have their `id` fields set.
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
  Future<List<QuizAttempt>> insert(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuizAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuizAttempt] and returns the inserted row.
  ///
  /// The returned [QuizAttempt] will have its `id` field set.
  Future<QuizAttempt> insertRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuizAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuizAttempt]s in the list and returns the resulting rows.
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
  /// The returned [QuizAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> upsert(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    required _is.ColumnSelections<QuizAttemptTable> conflictColumns,
    _is.ColumnSelections<QuizAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuizAttempt>(
      rows,
      conflictColumns: conflictColumns(QuizAttempt.t),
      updateColumns: updateColumns?.call(QuizAttempt.t),
      updateWhere: updateWhere?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuizAttempt] and returns the resulting row.
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
  /// The returned [QuizAttempt] will have its `id` field set.
  Future<QuizAttempt?> upsertRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    required _is.ColumnSelections<QuizAttemptTable> conflictColumns,
    _is.ColumnSelections<QuizAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuizAttempt>(
      row,
      conflictColumns: conflictColumns(QuizAttempt.t),
      updateColumns: updateColumns?.call(QuizAttempt.t),
      updateWhere: updateWhere?.call(QuizAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> update(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.ColumnSelections<QuizAttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuizAttempt>(
      rows,
      columns: columns?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuizAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuizAttempt> updateRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.ColumnSelections<QuizAttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuizAttempt>(
      row,
      columns: columns?.call(QuizAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuizAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuizAttempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuizAttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuizAttempt>(
      id,
      columnValues: columnValues(QuizAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuizAttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuizAttempt>(
      columnValues: columnValues(QuizAttempt.t.updateTable),
      where: where(QuizAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuizAttempt]s in the list and returns the deleted rows.
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
  Future<List<QuizAttempt>> delete(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuizAttempt>(
      rows,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuizAttempt].
  Future<QuizAttempt> deleteRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuizAttempt>(
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
  Future<List<QuizAttempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuizAttempt>(
      where: where(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuizAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuizAttempt>(
      where: where(QuizAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
