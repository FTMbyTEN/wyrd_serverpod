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

abstract class Synapse
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Synapse._({
    this.id,
    required this.a,
    required this.b,
    required this.weight,
    required this.fires,
    required this.lastFired,
  });

  factory Synapse({
    int? id,
    required String a,
    required String b,
    required double weight,
    required int fires,
    required DateTime lastFired,
  }) = _SynapseImpl;

  factory Synapse.fromJson(Map<String, dynamic> jsonSerialization) {
    return Synapse(
      id: jsonSerialization['id'] as int?,
      a: jsonSerialization['a'] as String,
      b: jsonSerialization['b'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      fires: jsonSerialization['fires'] as int,
      lastFired: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastFired'],
      ),
    );
  }

  static final t = SynapseTable();

  static const db = SynapseRepository._();

  @override
  int? id;

  String a;

  String b;

  double weight;

  int fires;

  DateTime lastFired;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Synapse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Synapse copyWith({
    int? id,
    String? a,
    String? b,
    double? weight,
    int? fires,
    DateTime? lastFired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Synapse',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
      'lastFired': lastFired.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Synapse',
      if (id != null) 'id': id,
      'a': a,
      'b': b,
      'weight': weight,
      'fires': fires,
      'lastFired': lastFired.toJson(),
    };
  }

  static SynapseInclude include() {
    return SynapseInclude._();
  }

  static SynapseIncludeList includeList({
    _is.WhereExpressionBuilder<SynapseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    SynapseInclude? include,
  }) {
    return SynapseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SynapseImpl extends Synapse {
  _SynapseImpl({
    int? id,
    required String a,
    required String b,
    required double weight,
    required int fires,
    required DateTime lastFired,
  }) : super._(
         id: id,
         a: a,
         b: b,
         weight: weight,
         fires: fires,
         lastFired: lastFired,
       );

  /// Returns a shallow copy of this [Synapse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Synapse copyWith({
    Object? id = _Undefined,
    String? a,
    String? b,
    double? weight,
    int? fires,
    DateTime? lastFired,
  }) {
    return Synapse(
      id: id is int? ? id : this.id,
      a: a ?? this.a,
      b: b ?? this.b,
      weight: weight ?? this.weight,
      fires: fires ?? this.fires,
      lastFired: lastFired ?? this.lastFired,
    );
  }
}

class SynapseUpdateTable extends _is.UpdateTable<SynapseTable> {
  SynapseUpdateTable(super.table);

  _is.ColumnValue<String, String> a(String value) => _is.ColumnValue(
    table.a,
    value,
  );

  _is.ColumnValue<String, String> b(String value) => _is.ColumnValue(
    table.b,
    value,
  );

  _is.ColumnValue<double, double> weight(double value) => _is.ColumnValue(
    table.weight,
    value,
  );

  _is.ColumnValue<int, int> fires(int value) => _is.ColumnValue(
    table.fires,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastFired(DateTime value) =>
      _is.ColumnValue(
        table.lastFired,
        value,
      );
}

class SynapseTable extends _is.Table<int?> {
  SynapseTable({super.tableRelation}) : super(tableName: 'synapse') {
    updateTable = SynapseUpdateTable(this);
    a = _is.ColumnString(
      'a',
      this,
    );
    b = _is.ColumnString(
      'b',
      this,
    );
    weight = _is.ColumnDouble(
      'weight',
      this,
    );
    fires = _is.ColumnInt(
      'fires',
      this,
    );
    lastFired = _is.ColumnDateTime(
      'lastFired',
      this,
    );
  }

  late final SynapseUpdateTable updateTable;

  late final _is.ColumnString a;

  late final _is.ColumnString b;

  late final _is.ColumnDouble weight;

  late final _is.ColumnInt fires;

  late final _is.ColumnDateTime lastFired;

  @override
  List<_is.Column> get columns => [
    id,
    a,
    b,
    weight,
    fires,
    lastFired,
  ];
}

class SynapseInclude extends _is.IncludeObject {
  SynapseInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Synapse.t;
}

class SynapseIncludeList extends _is.IncludeList {
  SynapseIncludeList._({
    _is.WhereExpressionBuilder<SynapseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Synapse.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Synapse.t;
}

class SynapseRepository {
  const SynapseRepository._();

  /// Returns a list of [Synapse]s matching the given query parameters.
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
  Future<List<Synapse>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SynapseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Synapse>(
      where: where?.call(Synapse.t),
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Synapse] matching the given query parameters.
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
  Future<Synapse?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SynapseTable>? where,
    int? offset,
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Synapse>(
      where: where?.call(Synapse.t),
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Synapse] by its [id] or null if no such row exists.
  Future<Synapse?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Synapse>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Synapse]s in the list and returns the inserted rows.
  ///
  /// The returned [Synapse]s will have their `id` fields set.
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
  Future<List<Synapse>> insert(
    _is.DatabaseSession session,
    List<Synapse> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Synapse>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Synapse] and returns the inserted row.
  ///
  /// The returned [Synapse] will have its `id` field set.
  Future<Synapse> insertRow(
    _is.DatabaseSession session,
    Synapse row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Synapse>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Synapse]s in the list and returns the resulting rows.
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
  /// The returned [Synapse]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Synapse>> upsert(
    _is.DatabaseSession session,
    List<Synapse> rows, {
    required _is.ColumnSelections<SynapseTable> conflictColumns,
    _is.ColumnSelections<SynapseTable>? updateColumns,
    _is.WhereExpressionBuilder<SynapseTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Synapse>(
      rows,
      conflictColumns: conflictColumns(Synapse.t),
      updateColumns: updateColumns?.call(Synapse.t),
      updateWhere: updateWhere?.call(Synapse.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Synapse] and returns the resulting row.
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
  /// The returned [Synapse] will have its `id` field set.
  Future<Synapse?> upsertRow(
    _is.DatabaseSession session,
    Synapse row, {
    required _is.ColumnSelections<SynapseTable> conflictColumns,
    _is.ColumnSelections<SynapseTable>? updateColumns,
    _is.WhereExpressionBuilder<SynapseTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Synapse>(
      row,
      conflictColumns: conflictColumns(Synapse.t),
      updateColumns: updateColumns?.call(Synapse.t),
      updateWhere: updateWhere?.call(Synapse.t),
      transaction: transaction,
    );
  }

  /// Updates all [Synapse]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Synapse>> update(
    _is.DatabaseSession session,
    List<Synapse> rows, {
    _is.ColumnSelections<SynapseTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Synapse>(
      rows,
      columns: columns?.call(Synapse.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Synapse]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Synapse> updateRow(
    _is.DatabaseSession session,
    Synapse row, {
    _is.ColumnSelections<SynapseTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Synapse>(
      row,
      columns: columns?.call(Synapse.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Synapse] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Synapse?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SynapseUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Synapse>(
      id,
      columnValues: columnValues(Synapse.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Synapse]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Synapse>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SynapseUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SynapseTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Synapse>(
      columnValues: columnValues(Synapse.t.updateTable),
      where: where(Synapse.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Synapse]s in the list and returns the deleted rows.
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
  Future<List<Synapse>> delete(
    _is.DatabaseSession session,
    List<Synapse> rows, {
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Synapse>(
      rows,
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Synapse].
  Future<Synapse> deleteRow(
    _is.DatabaseSession session,
    Synapse row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Synapse>(
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
  Future<List<Synapse>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SynapseTable> where,
    _is.OrderByBuilder<SynapseTable>? orderBy,
    _is.OrderByListBuilder<SynapseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Synapse>(
      where: where(Synapse.t),
      orderBy: orderBy?.call(Synapse.t),
      orderByList: orderByList?.call(Synapse.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SynapseTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Synapse>(
      where: where?.call(Synapse.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Synapse] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SynapseTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Synapse>(
      where: where(Synapse.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
