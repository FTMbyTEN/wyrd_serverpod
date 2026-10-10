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

/// What NAIJA 2099's city has seen, kept to teach WYRD -- anonymous and counted, never personal: how many times
/// something happened at one place in one hour (cars queued at a junction, crashes on a street, rides to a
/// district...). Only from players who agreed to let WYRD learn from their play. No player is stored with it.
abstract class CitySignal
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CitySignal._({
    this.id,
    required this.hour,
    required this.kind,
    required this.place,
    required this.times,
    required this.total,
  });

  factory CitySignal({
    int? id,
    required DateTime hour,
    required String kind,
    required String place,
    required int times,
    required double total,
  }) = _CitySignalImpl;

  factory CitySignal.fromJson(Map<String, dynamic> jsonSerialization) {
    return CitySignal(
      id: jsonSerialization['id'] as int?,
      hour: _is.DateTimeJsonExtension.fromJson(jsonSerialization['hour']),
      kind: jsonSerialization['kind'] as String,
      place: jsonSerialization['place'] as String,
      times: jsonSerialization['times'] as int,
      total: (jsonSerialization['total'] as num).toDouble(),
    );
  }

  static final t = CitySignalTable();

  static const db = CitySignalRepository._();

  @override
  int? id;

  /// the hour it happened in (UTC, on the hour)
  DateTime hour;

  /// queue | ride | air | crash | redlight | speeding | caught | lost | call | switch
  String kind;

  /// a street, junction or district name from the game's map (at most 60 characters)
  String place;

  /// how many times
  int times;

  /// a quantity summed over them, where the kind has one (cars waiting, km ridden, km/h...)
  double total;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CitySignal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CitySignal copyWith({
    int? id,
    DateTime? hour,
    String? kind,
    String? place,
    int? times,
    double? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CitySignal',
      if (id != null) 'id': id,
      'hour': hour.toJson(),
      'kind': kind,
      'place': place,
      'times': times,
      'total': total,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CitySignal',
      if (id != null) 'id': id,
      'hour': hour.toJson(),
      'kind': kind,
      'place': place,
      'times': times,
      'total': total,
    };
  }

  static CitySignalInclude include() {
    return CitySignalInclude._();
  }

  static CitySignalIncludeList includeList({
    _is.WhereExpressionBuilder<CitySignalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    CitySignalInclude? include,
  }) {
    return CitySignalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CitySignalImpl extends CitySignal {
  _CitySignalImpl({
    int? id,
    required DateTime hour,
    required String kind,
    required String place,
    required int times,
    required double total,
  }) : super._(
         id: id,
         hour: hour,
         kind: kind,
         place: place,
         times: times,
         total: total,
       );

  /// Returns a shallow copy of this [CitySignal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CitySignal copyWith({
    Object? id = _Undefined,
    DateTime? hour,
    String? kind,
    String? place,
    int? times,
    double? total,
  }) {
    return CitySignal(
      id: id is int? ? id : this.id,
      hour: hour ?? this.hour,
      kind: kind ?? this.kind,
      place: place ?? this.place,
      times: times ?? this.times,
      total: total ?? this.total,
    );
  }
}

class CitySignalUpdateTable extends _is.UpdateTable<CitySignalTable> {
  CitySignalUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> hour(DateTime value) => _is.ColumnValue(
    table.hour,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> place(String value) => _is.ColumnValue(
    table.place,
    value,
  );

  _is.ColumnValue<int, int> times(int value) => _is.ColumnValue(
    table.times,
    value,
  );

  _is.ColumnValue<double, double> total(double value) => _is.ColumnValue(
    table.total,
    value,
  );
}

class CitySignalTable extends _is.Table<int?> {
  CitySignalTable({super.tableRelation}) : super(tableName: 'city_signal') {
    updateTable = CitySignalUpdateTable(this);
    hour = _is.ColumnDateTime(
      'hour',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    place = _is.ColumnString(
      'place',
      this,
    );
    times = _is.ColumnInt(
      'times',
      this,
    );
    total = _is.ColumnDouble(
      'total',
      this,
    );
  }

  late final CitySignalUpdateTable updateTable;

  /// the hour it happened in (UTC, on the hour)
  late final _is.ColumnDateTime hour;

  /// queue | ride | air | crash | redlight | speeding | caught | lost | call | switch
  late final _is.ColumnString kind;

  /// a street, junction or district name from the game's map (at most 60 characters)
  late final _is.ColumnString place;

  /// how many times
  late final _is.ColumnInt times;

  /// a quantity summed over them, where the kind has one (cars waiting, km ridden, km/h...)
  late final _is.ColumnDouble total;

  @override
  List<_is.Column> get columns => [
    id,
    hour,
    kind,
    place,
    times,
    total,
  ];
}

class CitySignalInclude extends _is.IncludeObject {
  CitySignalInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CitySignal.t;
}

class CitySignalIncludeList extends _is.IncludeList {
  CitySignalIncludeList._({
    _is.WhereExpressionBuilder<CitySignalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CitySignal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CitySignal.t;
}

class CitySignalRepository {
  const CitySignalRepository._();

  /// Returns a list of [CitySignal]s matching the given query parameters.
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
  Future<List<CitySignal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CitySignalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CitySignal>(
      where: where?.call(CitySignal.t),
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CitySignal] matching the given query parameters.
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
  Future<CitySignal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CitySignalTable>? where,
    int? offset,
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CitySignal>(
      where: where?.call(CitySignal.t),
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CitySignal] by its [id] or null if no such row exists.
  Future<CitySignal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CitySignal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CitySignal]s in the list and returns the inserted rows.
  ///
  /// The returned [CitySignal]s will have their `id` fields set.
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
  Future<List<CitySignal>> insert(
    _is.DatabaseSession session,
    List<CitySignal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CitySignal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CitySignal] and returns the inserted row.
  ///
  /// The returned [CitySignal] will have its `id` field set.
  Future<CitySignal> insertRow(
    _is.DatabaseSession session,
    CitySignal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CitySignal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CitySignal]s in the list and returns the resulting rows.
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
  /// The returned [CitySignal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CitySignal>> upsert(
    _is.DatabaseSession session,
    List<CitySignal> rows, {
    required _is.ColumnSelections<CitySignalTable> conflictColumns,
    _is.ColumnSelections<CitySignalTable>? updateColumns,
    _is.WhereExpressionBuilder<CitySignalTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CitySignal>(
      rows,
      conflictColumns: conflictColumns(CitySignal.t),
      updateColumns: updateColumns?.call(CitySignal.t),
      updateWhere: updateWhere?.call(CitySignal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CitySignal] and returns the resulting row.
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
  /// The returned [CitySignal] will have its `id` field set.
  Future<CitySignal?> upsertRow(
    _is.DatabaseSession session,
    CitySignal row, {
    required _is.ColumnSelections<CitySignalTable> conflictColumns,
    _is.ColumnSelections<CitySignalTable>? updateColumns,
    _is.WhereExpressionBuilder<CitySignalTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CitySignal>(
      row,
      conflictColumns: conflictColumns(CitySignal.t),
      updateColumns: updateColumns?.call(CitySignal.t),
      updateWhere: updateWhere?.call(CitySignal.t),
      transaction: transaction,
    );
  }

  /// Updates all [CitySignal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CitySignal>> update(
    _is.DatabaseSession session,
    List<CitySignal> rows, {
    _is.ColumnSelections<CitySignalTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CitySignal>(
      rows,
      columns: columns?.call(CitySignal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CitySignal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CitySignal> updateRow(
    _is.DatabaseSession session,
    CitySignal row, {
    _is.ColumnSelections<CitySignalTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CitySignal>(
      row,
      columns: columns?.call(CitySignal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CitySignal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CitySignal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CitySignalUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CitySignal>(
      id,
      columnValues: columnValues(CitySignal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CitySignal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CitySignal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CitySignalUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CitySignalTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CitySignal>(
      columnValues: columnValues(CitySignal.t.updateTable),
      where: where(CitySignal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CitySignal]s in the list and returns the deleted rows.
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
  Future<List<CitySignal>> delete(
    _is.DatabaseSession session,
    List<CitySignal> rows, {
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CitySignal>(
      rows,
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CitySignal].
  Future<CitySignal> deleteRow(
    _is.DatabaseSession session,
    CitySignal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CitySignal>(
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
  Future<List<CitySignal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CitySignalTable> where,
    _is.OrderByBuilder<CitySignalTable>? orderBy,
    _is.OrderByListBuilder<CitySignalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CitySignal>(
      where: where(CitySignal.t),
      orderBy: orderBy?.call(CitySignal.t),
      orderByList: orderByList?.call(CitySignal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CitySignalTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CitySignal>(
      where: where?.call(CitySignal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CitySignal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CitySignalTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CitySignal>(
      where: where(CitySignal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
