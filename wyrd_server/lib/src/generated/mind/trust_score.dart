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

abstract class TrustScore
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TrustScore._({
    this.id,
    required this.kind,
    required this.key,
    required this.good,
    required this.bad,
    required this.score,
    required this.updatedAt,
  });

  factory TrustScore({
    int? id,
    required String kind,
    required String key,
    required double good,
    required double bad,
    required double score,
    required DateTime updatedAt,
  }) = _TrustScoreImpl;

  factory TrustScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrustScore(
      id: jsonSerialization['id'] as int?,
      kind: jsonSerialization['kind'] as String,
      key: jsonSerialization['key'] as String,
      good: (jsonSerialization['good'] as num).toDouble(),
      bad: (jsonSerialization['bad'] as num).toDouble(),
      score: (jsonSerialization['score'] as num).toDouble(),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = TrustScoreTable();

  static const db = TrustScoreRepository._();

  @override
  int? id;

  String kind;

  String key;

  double good;

  double bad;

  double score;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrustScore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TrustScore copyWith({
    int? id,
    String? kind,
    String? key,
    double? good,
    double? bad,
    double? score,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrustScore',
      if (id != null) 'id': id,
      'kind': kind,
      'key': key,
      'good': good,
      'bad': bad,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrustScore',
      if (id != null) 'id': id,
      'kind': kind,
      'key': key,
      'good': good,
      'bad': bad,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static TrustScoreInclude include() {
    return TrustScoreInclude._();
  }

  static TrustScoreIncludeList includeList({
    _is.WhereExpressionBuilder<TrustScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    TrustScoreInclude? include,
  }) {
    return TrustScoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrustScoreImpl extends TrustScore {
  _TrustScoreImpl({
    int? id,
    required String kind,
    required String key,
    required double good,
    required double bad,
    required double score,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         kind: kind,
         key: key,
         good: good,
         bad: bad,
         score: score,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TrustScore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TrustScore copyWith({
    Object? id = _Undefined,
    String? kind,
    String? key,
    double? good,
    double? bad,
    double? score,
    DateTime? updatedAt,
  }) {
    return TrustScore(
      id: id is int? ? id : this.id,
      kind: kind ?? this.kind,
      key: key ?? this.key,
      good: good ?? this.good,
      bad: bad ?? this.bad,
      score: score ?? this.score,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TrustScoreUpdateTable extends _is.UpdateTable<TrustScoreTable> {
  TrustScoreUpdateTable(super.table);

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<double, double> good(double value) => _is.ColumnValue(
    table.good,
    value,
  );

  _is.ColumnValue<double, double> bad(double value) => _is.ColumnValue(
    table.bad,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class TrustScoreTable extends _is.Table<int?> {
  TrustScoreTable({super.tableRelation}) : super(tableName: 'trust_score') {
    updateTable = TrustScoreUpdateTable(this);
    kind = _is.ColumnString(
      'kind',
      this,
    );
    key = _is.ColumnString(
      'key',
      this,
    );
    good = _is.ColumnDouble(
      'good',
      this,
    );
    bad = _is.ColumnDouble(
      'bad',
      this,
    );
    score = _is.ColumnDouble(
      'score',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final TrustScoreUpdateTable updateTable;

  late final _is.ColumnString kind;

  late final _is.ColumnString key;

  late final _is.ColumnDouble good;

  late final _is.ColumnDouble bad;

  late final _is.ColumnDouble score;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    kind,
    key,
    good,
    bad,
    score,
    updatedAt,
  ];
}

class TrustScoreInclude extends _is.IncludeObject {
  TrustScoreInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TrustScore.t;
}

class TrustScoreIncludeList extends _is.IncludeList {
  TrustScoreIncludeList._({
    _is.WhereExpressionBuilder<TrustScoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrustScore.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TrustScore.t;
}

class TrustScoreRepository {
  const TrustScoreRepository._();

  /// Returns a list of [TrustScore]s matching the given query parameters.
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
  Future<List<TrustScore>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrustScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrustScore>(
      where: where?.call(TrustScore.t),
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrustScore] matching the given query parameters.
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
  Future<TrustScore?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrustScoreTable>? where,
    int? offset,
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrustScore>(
      where: where?.call(TrustScore.t),
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrustScore] by its [id] or null if no such row exists.
  Future<TrustScore?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrustScore>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrustScore]s in the list and returns the inserted rows.
  ///
  /// The returned [TrustScore]s will have their `id` fields set.
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
  Future<List<TrustScore>> insert(
    _is.DatabaseSession session,
    List<TrustScore> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TrustScore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TrustScore] and returns the inserted row.
  ///
  /// The returned [TrustScore] will have its `id` field set.
  Future<TrustScore> insertRow(
    _is.DatabaseSession session,
    TrustScore row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrustScore>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TrustScore]s in the list and returns the resulting rows.
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
  /// The returned [TrustScore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrustScore>> upsert(
    _is.DatabaseSession session,
    List<TrustScore> rows, {
    required _is.ColumnSelections<TrustScoreTable> conflictColumns,
    _is.ColumnSelections<TrustScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<TrustScoreTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TrustScore>(
      rows,
      conflictColumns: conflictColumns(TrustScore.t),
      updateColumns: updateColumns?.call(TrustScore.t),
      updateWhere: updateWhere?.call(TrustScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TrustScore] and returns the resulting row.
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
  /// The returned [TrustScore] will have its `id` field set.
  Future<TrustScore?> upsertRow(
    _is.DatabaseSession session,
    TrustScore row, {
    required _is.ColumnSelections<TrustScoreTable> conflictColumns,
    _is.ColumnSelections<TrustScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<TrustScoreTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TrustScore>(
      row,
      conflictColumns: conflictColumns(TrustScore.t),
      updateColumns: updateColumns?.call(TrustScore.t),
      updateWhere: updateWhere?.call(TrustScore.t),
      transaction: transaction,
    );
  }

  /// Updates all [TrustScore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrustScore>> update(
    _is.DatabaseSession session,
    List<TrustScore> rows, {
    _is.ColumnSelections<TrustScoreTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TrustScore>(
      rows,
      columns: columns?.call(TrustScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TrustScore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrustScore> updateRow(
    _is.DatabaseSession session,
    TrustScore row, {
    _is.ColumnSelections<TrustScoreTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrustScore>(
      row,
      columns: columns?.call(TrustScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrustScore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrustScore?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TrustScoreUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TrustScore>(
      id,
      columnValues: columnValues(TrustScore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrustScore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TrustScore>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TrustScoreUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TrustScoreTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TrustScore>(
      columnValues: columnValues(TrustScore.t.updateTable),
      where: where(TrustScore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TrustScore]s in the list and returns the deleted rows.
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
  Future<List<TrustScore>> delete(
    _is.DatabaseSession session,
    List<TrustScore> rows, {
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TrustScore>(
      rows,
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TrustScore].
  Future<TrustScore> deleteRow(
    _is.DatabaseSession session,
    TrustScore row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrustScore>(
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
  Future<List<TrustScore>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrustScoreTable> where,
    _is.OrderByBuilder<TrustScoreTable>? orderBy,
    _is.OrderByListBuilder<TrustScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TrustScore>(
      where: where(TrustScore.t),
      orderBy: orderBy?.call(TrustScore.t),
      orderByList: orderByList?.call(TrustScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrustScoreTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TrustScore>(
      where: where?.call(TrustScore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrustScore] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrustScoreTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrustScore>(
      where: where(TrustScore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
