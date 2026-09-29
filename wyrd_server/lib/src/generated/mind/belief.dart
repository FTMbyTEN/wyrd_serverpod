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

abstract class Belief implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Belief._({
    this.id,
    required this.a,
    required this.b,
    required this.claim,
    required this.evidenceIds,
    required this.sources,
    required this.against,
    required this.confidence,
    required this.status,
    required this.origin,
    required this.tests,
    required this.createdAt,
    required this.updatedAt,
    required this.testedAt,
  });

  factory Belief({
    int? id,
    required String a,
    required String b,
    required String claim,
    required List<int> evidenceIds,
    required int sources,
    required int against,
    required double confidence,
    required String status,
    required String origin,
    required int tests,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime testedAt,
  }) = _BeliefImpl;

  factory Belief.fromJson(Map<String, dynamic> jsonSerialization) {
    return Belief(
      id: jsonSerialization['id'] as int?,
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      claim: jsonSerialization['claim'] as String,
      evidenceIds: _i9sln91s.Protocol().deserialize<List<int>>(
        jsonSerialization['evidenceIds'],
      ),
      sources: jsonSerialization['sources'] as int,
      against: jsonSerialization['against'] as int,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      origin: jsonSerialization['origin'] as String,
      tests: jsonSerialization['tests'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      testedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['testedAt'],
      ),
    );
  }

  static final t = BeliefTable();

  static const db = BeliefRepository._();

  @override
  int? id;

  String a;

  String b;

  String claim;

  List<int> evidenceIds;

  int sources;

  int against;

  double confidence;

  String status;

  String origin;

  int tests;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime testedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Belief]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Belief copyWith({
    int? id,
    String? a,
    String? b,
    String? claim,
    List<int>? evidenceIds,
    int? sources,
    int? against,
    double? confidence,
    String? status,
    String? origin,
    int? tests,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? testedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Belief',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'claim': claim,
      'evidenceIds': evidenceIds.toJson(),
      'sources': sources,
      'against': against,
      'confidence': confidence,
      'status': status,
      'origin': origin,
      'tests': tests,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'testedAt': testedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Belief',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'claim': claim,
      'evidenceIds': evidenceIds.toJson(),
      'sources': sources,
      'against': against,
      'confidence': confidence,
      'status': status,
      'origin': origin,
      'tests': tests,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'testedAt': testedAt.toJson(),
    };
  }

  static BeliefInclude include() {
    return BeliefInclude._();
  }

  static BeliefIncludeList includeList({
    _is.WhereExpressionBuilder<BeliefTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    BeliefInclude? include,
  }) {
    return BeliefIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BeliefImpl extends Belief {
  _BeliefImpl({
    int? id,
    required String a,
    required String b,
    required String claim,
    required List<int> evidenceIds,
    required int sources,
    required int against,
    required double confidence,
    required String status,
    required String origin,
    required int tests,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime testedAt,
  }) : super._(
         id: id,
         a: a,
         b: b,
         claim: claim,
         evidenceIds: evidenceIds,
         sources: sources,
         against: against,
         confidence: confidence,
         status: status,
         origin: origin,
         tests: tests,
         createdAt: createdAt,
         updatedAt: updatedAt,
         testedAt: testedAt,
       );

  /// Returns a shallow copy of this [Belief]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Belief copyWith({
    Object? id = _Undefined,
    String? a,
    String? b,
    String? claim,
    List<int>? evidenceIds,
    int? sources,
    int? against,
    double? confidence,
    String? status,
    String? origin,
    int? tests,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? testedAt,
  }) {
    return Belief(
      id: id is int? ? id : this.id,
      a: a ?? this.a,
      b: b ?? this.b,
      claim: claim ?? this.claim,
      evidenceIds: evidenceIds ?? this.evidenceIds.map((e0) => e0).toList(),
      sources: sources ?? this.sources,
      against: against ?? this.against,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      origin: origin ?? this.origin,
      tests: tests ?? this.tests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      testedAt: testedAt ?? this.testedAt,
    );
  }
}

class BeliefUpdateTable extends _is.UpdateTable<BeliefTable> {
  BeliefUpdateTable(super.table);

  _is.ColumnValue<String, String> a(String value) => _is.ColumnValue(
    table.a,
    value,
  );

  _is.ColumnValue<String, String> b(String value) => _is.ColumnValue(
    table.b,
    value,
  );

  _is.ColumnValue<String, String> claim(String value) => _is.ColumnValue(
    table.claim,
    value,
  );

  _is.ColumnValue<List<int>, List<int>> evidenceIds(List<int> value) =>
      _is.ColumnValue(
        table.evidenceIds,
        value,
      );

  _is.ColumnValue<int, int> sources(int value) => _is.ColumnValue(
    table.sources,
    value,
  );

  _is.ColumnValue<int, int> against(int value) => _is.ColumnValue(
    table.against,
    value,
  );

  _is.ColumnValue<double, double> confidence(double value) => _is.ColumnValue(
    table.confidence,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> origin(String value) => _is.ColumnValue(
    table.origin,
    value,
  );

  _is.ColumnValue<int, int> tests(int value) => _is.ColumnValue(
    table.tests,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> testedAt(DateTime value) =>
      _is.ColumnValue(
        table.testedAt,
        value,
      );
}

class BeliefTable extends _is.Table<int?> {
  BeliefTable({super.tableRelation}) : super(tableName: 'belief') {
    updateTable = BeliefUpdateTable(this);
    a = _is.ColumnString(
      'a',
      this,
    );
    b = _is.ColumnString(
      'b',
      this,
    );
    claim = _is.ColumnString(
      'claim',
      this,
    );
    evidenceIds = _is.ColumnSerializable<List<int>>(
      'evidenceIds',
      this,
    );
    sources = _is.ColumnInt(
      'sources',
      this,
    );
    against = _is.ColumnInt(
      'against',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    origin = _is.ColumnString(
      'origin',
      this,
    );
    tests = _is.ColumnInt(
      'tests',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
    testedAt = _is.ColumnDateTime(
      'testedAt',
      this,
    );
  }

  late final BeliefUpdateTable updateTable;

  late final _is.ColumnString a;

  late final _is.ColumnString b;

  late final _is.ColumnString claim;

  late final _is.ColumnSerializable<List<int>> evidenceIds;

  late final _is.ColumnInt sources;

  late final _is.ColumnInt against;

  late final _is.ColumnDouble confidence;

  late final _is.ColumnString status;

  late final _is.ColumnString origin;

  late final _is.ColumnInt tests;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime testedAt;

  @override
  List<_is.Column> get columns => [
    id,
    a,
    b,
    claim,
    evidenceIds,
    sources,
    against,
    confidence,
    status,
    origin,
    tests,
    createdAt,
    updatedAt,
    testedAt,
  ];
}

class BeliefInclude extends _is.IncludeObject {
  BeliefInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Belief.t;
}

class BeliefIncludeList extends _is.IncludeList {
  BeliefIncludeList._({
    _is.WhereExpressionBuilder<BeliefTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Belief.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Belief.t;
}

class BeliefRepository {
  const BeliefRepository._();

  /// Returns a list of [Belief]s matching the given query parameters.
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
  Future<List<Belief>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BeliefTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Belief>(
      where: where?.call(Belief.t),
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Belief] matching the given query parameters.
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
  Future<Belief?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BeliefTable>? where,
    int? offset,
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Belief>(
      where: where?.call(Belief.t),
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Belief] by its [id] or null if no such row exists.
  Future<Belief?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Belief>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Belief]s in the list and returns the inserted rows.
  ///
  /// The returned [Belief]s will have their `id` fields set.
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
  Future<List<Belief>> insert(
    _is.DatabaseSession session,
    List<Belief> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Belief>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Belief] and returns the inserted row.
  ///
  /// The returned [Belief] will have its `id` field set.
  Future<Belief> insertRow(
    _is.DatabaseSession session,
    Belief row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Belief>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Belief]s in the list and returns the resulting rows.
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
  /// The returned [Belief]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Belief>> upsert(
    _is.DatabaseSession session,
    List<Belief> rows, {
    required _is.ColumnSelections<BeliefTable> conflictColumns,
    _is.ColumnSelections<BeliefTable>? updateColumns,
    _is.WhereExpressionBuilder<BeliefTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Belief>(
      rows,
      conflictColumns: conflictColumns(Belief.t),
      updateColumns: updateColumns?.call(Belief.t),
      updateWhere: updateWhere?.call(Belief.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Belief] and returns the resulting row.
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
  /// The returned [Belief] will have its `id` field set.
  Future<Belief?> upsertRow(
    _is.DatabaseSession session,
    Belief row, {
    required _is.ColumnSelections<BeliefTable> conflictColumns,
    _is.ColumnSelections<BeliefTable>? updateColumns,
    _is.WhereExpressionBuilder<BeliefTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Belief>(
      row,
      conflictColumns: conflictColumns(Belief.t),
      updateColumns: updateColumns?.call(Belief.t),
      updateWhere: updateWhere?.call(Belief.t),
      transaction: transaction,
    );
  }

  /// Updates all [Belief]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Belief>> update(
    _is.DatabaseSession session,
    List<Belief> rows, {
    _is.ColumnSelections<BeliefTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Belief>(
      rows,
      columns: columns?.call(Belief.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Belief]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Belief> updateRow(
    _is.DatabaseSession session,
    Belief row, {
    _is.ColumnSelections<BeliefTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Belief>(
      row,
      columns: columns?.call(Belief.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Belief] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Belief?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BeliefUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Belief>(
      id,
      columnValues: columnValues(Belief.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Belief]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Belief>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BeliefUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BeliefTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Belief>(
      columnValues: columnValues(Belief.t.updateTable),
      where: where(Belief.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Belief]s in the list and returns the deleted rows.
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
  Future<List<Belief>> delete(
    _is.DatabaseSession session,
    List<Belief> rows, {
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Belief>(
      rows,
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Belief].
  Future<Belief> deleteRow(
    _is.DatabaseSession session,
    Belief row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Belief>(
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
  Future<List<Belief>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BeliefTable> where,
    _is.OrderByBuilder<BeliefTable>? orderBy,
    _is.OrderByListBuilder<BeliefTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Belief>(
      where: where(Belief.t),
      orderBy: orderBy?.call(Belief.t),
      orderByList: orderByList?.call(Belief.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BeliefTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Belief>(
      where: where?.call(Belief.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Belief] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BeliefTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Belief>(
      where: where(Belief.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
