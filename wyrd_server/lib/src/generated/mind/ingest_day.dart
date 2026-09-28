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

abstract class IngestDay
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IngestDay._({
    this.id,
    required this.day,
    required this.kept,
    required this.duplicates,
    required this.quarantined,
    required this.reasons,
    required this.categories,
  });

  factory IngestDay({
    int? id,
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
  }) = _IngestDayImpl;

  factory IngestDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngestDay(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      kept: jsonSerialization['kept'] as int,
      duplicates: jsonSerialization['duplicates'] as int,
      quarantined: jsonSerialization['quarantined'] as int,
      reasons: _i9sln91s.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['reasons'],
      ),
      categories: _i9sln91s.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['categories'],
      ),
    );
  }

  static final t = IngestDayTable();

  static const db = IngestDayRepository._();

  @override
  int? id;

  String day;

  int kept;

  int duplicates;

  int quarantined;

  Map<String, int> reasons;

  Map<String, int> categories;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IngestDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IngestDay copyWith({
    int? id,
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngestDay',
      if (id != null) 'id': id,
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngestDay',
      if (id != null) 'id': id,
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
    };
  }

  static IngestDayInclude include() {
    return IngestDayInclude._();
  }

  static IngestDayIncludeList includeList({
    _is.WhereExpressionBuilder<IngestDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    IngestDayInclude? include,
  }) {
    return IngestDayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngestDayImpl extends IngestDay {
  _IngestDayImpl({
    int? id,
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
  }) : super._(
         id: id,
         day: day,
         kept: kept,
         duplicates: duplicates,
         quarantined: quarantined,
         reasons: reasons,
         categories: categories,
       );

  /// Returns a shallow copy of this [IngestDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IngestDay copyWith({
    Object? id = _Undefined,
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
  }) {
    return IngestDay(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      kept: kept ?? this.kept,
      duplicates: duplicates ?? this.duplicates,
      quarantined: quarantined ?? this.quarantined,
      reasons:
          reasons ??
          this.reasons.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      categories:
          categories ??
          this.categories.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
    );
  }
}

class IngestDayUpdateTable extends _is.UpdateTable<IngestDayTable> {
  IngestDayUpdateTable(super.table);

  _is.ColumnValue<String, String> day(String value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<int, int> kept(int value) => _is.ColumnValue(
    table.kept,
    value,
  );

  _is.ColumnValue<int, int> duplicates(int value) => _is.ColumnValue(
    table.duplicates,
    value,
  );

  _is.ColumnValue<int, int> quarantined(int value) => _is.ColumnValue(
    table.quarantined,
    value,
  );

  _is.ColumnValue<Map<String, int>, Map<String, int>> reasons(
    Map<String, int> value,
  ) => _is.ColumnValue(
    table.reasons,
    value,
  );

  _is.ColumnValue<Map<String, int>, Map<String, int>> categories(
    Map<String, int> value,
  ) => _is.ColumnValue(
    table.categories,
    value,
  );
}

class IngestDayTable extends _is.Table<int?> {
  IngestDayTable({super.tableRelation}) : super(tableName: 'ingest_day') {
    updateTable = IngestDayUpdateTable(this);
    day = _is.ColumnString(
      'day',
      this,
    );
    kept = _is.ColumnInt(
      'kept',
      this,
    );
    duplicates = _is.ColumnInt(
      'duplicates',
      this,
    );
    quarantined = _is.ColumnInt(
      'quarantined',
      this,
    );
    reasons = _is.ColumnSerializable<Map<String, int>>(
      'reasons',
      this,
    );
    categories = _is.ColumnSerializable<Map<String, int>>(
      'categories',
      this,
    );
  }

  late final IngestDayUpdateTable updateTable;

  late final _is.ColumnString day;

  late final _is.ColumnInt kept;

  late final _is.ColumnInt duplicates;

  late final _is.ColumnInt quarantined;

  late final _is.ColumnSerializable<Map<String, int>> reasons;

  late final _is.ColumnSerializable<Map<String, int>> categories;

  @override
  List<_is.Column> get columns => [
    id,
    day,
    kept,
    duplicates,
    quarantined,
    reasons,
    categories,
  ];
}

class IngestDayInclude extends _is.IncludeObject {
  IngestDayInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IngestDay.t;
}

class IngestDayIncludeList extends _is.IncludeList {
  IngestDayIncludeList._({
    _is.WhereExpressionBuilder<IngestDayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IngestDay.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IngestDay.t;
}

class IngestDayRepository {
  const IngestDayRepository._();

  /// Returns a list of [IngestDay]s matching the given query parameters.
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
  Future<List<IngestDay>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngestDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IngestDay>(
      where: where?.call(IngestDay.t),
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IngestDay] matching the given query parameters.
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
  Future<IngestDay?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngestDayTable>? where,
    int? offset,
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IngestDay>(
      where: where?.call(IngestDay.t),
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IngestDay] by its [id] or null if no such row exists.
  Future<IngestDay?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IngestDay>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IngestDay]s in the list and returns the inserted rows.
  ///
  /// The returned [IngestDay]s will have their `id` fields set.
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
  Future<List<IngestDay>> insert(
    _is.DatabaseSession session,
    List<IngestDay> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IngestDay>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IngestDay] and returns the inserted row.
  ///
  /// The returned [IngestDay] will have its `id` field set.
  Future<IngestDay> insertRow(
    _is.DatabaseSession session,
    IngestDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IngestDay>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IngestDay]s in the list and returns the resulting rows.
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
  /// The returned [IngestDay]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngestDay>> upsert(
    _is.DatabaseSession session,
    List<IngestDay> rows, {
    required _is.ColumnSelections<IngestDayTable> conflictColumns,
    _is.ColumnSelections<IngestDayTable>? updateColumns,
    _is.WhereExpressionBuilder<IngestDayTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IngestDay>(
      rows,
      conflictColumns: conflictColumns(IngestDay.t),
      updateColumns: updateColumns?.call(IngestDay.t),
      updateWhere: updateWhere?.call(IngestDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IngestDay] and returns the resulting row.
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
  /// The returned [IngestDay] will have its `id` field set.
  Future<IngestDay?> upsertRow(
    _is.DatabaseSession session,
    IngestDay row, {
    required _is.ColumnSelections<IngestDayTable> conflictColumns,
    _is.ColumnSelections<IngestDayTable>? updateColumns,
    _is.WhereExpressionBuilder<IngestDayTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IngestDay>(
      row,
      conflictColumns: conflictColumns(IngestDay.t),
      updateColumns: updateColumns?.call(IngestDay.t),
      updateWhere: updateWhere?.call(IngestDay.t),
      transaction: transaction,
    );
  }

  /// Updates all [IngestDay]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngestDay>> update(
    _is.DatabaseSession session,
    List<IngestDay> rows, {
    _is.ColumnSelections<IngestDayTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IngestDay>(
      rows,
      columns: columns?.call(IngestDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IngestDay]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IngestDay> updateRow(
    _is.DatabaseSession session,
    IngestDay row, {
    _is.ColumnSelections<IngestDayTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IngestDay>(
      row,
      columns: columns?.call(IngestDay.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngestDay] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IngestDay?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IngestDayUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IngestDay>(
      id,
      columnValues: columnValues(IngestDay.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IngestDay]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IngestDay>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IngestDayUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IngestDayTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IngestDay>(
      columnValues: columnValues(IngestDay.t.updateTable),
      where: where(IngestDay.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IngestDay]s in the list and returns the deleted rows.
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
  Future<List<IngestDay>> delete(
    _is.DatabaseSession session,
    List<IngestDay> rows, {
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IngestDay>(
      rows,
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IngestDay].
  Future<IngestDay> deleteRow(
    _is.DatabaseSession session,
    IngestDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IngestDay>(
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
  Future<List<IngestDay>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IngestDayTable> where,
    _is.OrderByBuilder<IngestDayTable>? orderBy,
    _is.OrderByListBuilder<IngestDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IngestDay>(
      where: where(IngestDay.t),
      orderBy: orderBy?.call(IngestDay.t),
      orderByList: orderByList?.call(IngestDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IngestDayTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IngestDay>(
      where: where?.call(IngestDay.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IngestDay] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IngestDayTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IngestDay>(
      where: where(IngestDay.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
