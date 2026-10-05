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

/// WYRD's own charter for its open-world Lagos, written by WYRD: how it means to deal with players,
/// and the board of missions it has written for them. Rewritten about once a week.
abstract class CityCharter
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CityCharter._({
    this.id,
    required this.charter,
    required this.missions,
    required this.author,
    required this.writtenAt,
  });

  factory CityCharter({
    int? id,
    required String charter,
    required String missions,
    required String author,
    required DateTime writtenAt,
  }) = _CityCharterImpl;

  factory CityCharter.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityCharter(
      id: jsonSerialization['id'] as int?,
      charter: jsonSerialization['charter'] as String,
      missions: jsonSerialization['missions'] as String,
      author: jsonSerialization['author'] as String,
      writtenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['writtenAt'],
      ),
    );
  }

  static final t = CityCharterTable();

  static const db = CityCharterRepository._();

  @override
  int? id;

  /// how WYRD, as the Authority, wishes to interact with players (its words)
  String charter;

  /// the mission board, as JSON: [{id, kind, title, brief, street, reward, minStanding}]
  String missions;

  /// 'wyrd' when WYRD wrote it, 'seed' for the starting board
  String author;

  DateTime writtenAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CityCharter]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CityCharter copyWith({
    int? id,
    String? charter,
    String? missions,
    String? author,
    DateTime? writtenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityCharter',
      if (id != null) 'id': id,
      'charter': charter,
      'missions': missions,
      'author': author,
      'writtenAt': writtenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CityCharter',
      if (id != null) 'id': id,
      'charter': charter,
      'missions': missions,
      'author': author,
      'writtenAt': writtenAt.toJson(),
    };
  }

  static CityCharterInclude include() {
    return CityCharterInclude._();
  }

  static CityCharterIncludeList includeList({
    _is.WhereExpressionBuilder<CityCharterTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    CityCharterInclude? include,
  }) {
    return CityCharterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityCharterImpl extends CityCharter {
  _CityCharterImpl({
    int? id,
    required String charter,
    required String missions,
    required String author,
    required DateTime writtenAt,
  }) : super._(
         id: id,
         charter: charter,
         missions: missions,
         author: author,
         writtenAt: writtenAt,
       );

  /// Returns a shallow copy of this [CityCharter]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CityCharter copyWith({
    Object? id = _Undefined,
    String? charter,
    String? missions,
    String? author,
    DateTime? writtenAt,
  }) {
    return CityCharter(
      id: id is int? ? id : this.id,
      charter: charter ?? this.charter,
      missions: missions ?? this.missions,
      author: author ?? this.author,
      writtenAt: writtenAt ?? this.writtenAt,
    );
  }
}

class CityCharterUpdateTable extends _is.UpdateTable<CityCharterTable> {
  CityCharterUpdateTable(super.table);

  _is.ColumnValue<String, String> charter(String value) => _is.ColumnValue(
    table.charter,
    value,
  );

  _is.ColumnValue<String, String> missions(String value) => _is.ColumnValue(
    table.missions,
    value,
  );

  _is.ColumnValue<String, String> author(String value) => _is.ColumnValue(
    table.author,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> writtenAt(DateTime value) =>
      _is.ColumnValue(
        table.writtenAt,
        value,
      );
}

class CityCharterTable extends _is.Table<int?> {
  CityCharterTable({super.tableRelation}) : super(tableName: 'city_charter') {
    updateTable = CityCharterUpdateTable(this);
    charter = _is.ColumnString(
      'charter',
      this,
    );
    missions = _is.ColumnString(
      'missions',
      this,
    );
    author = _is.ColumnString(
      'author',
      this,
    );
    writtenAt = _is.ColumnDateTime(
      'writtenAt',
      this,
    );
  }

  late final CityCharterUpdateTable updateTable;

  /// how WYRD, as the Authority, wishes to interact with players (its words)
  late final _is.ColumnString charter;

  /// the mission board, as JSON: [{id, kind, title, brief, street, reward, minStanding}]
  late final _is.ColumnString missions;

  /// 'wyrd' when WYRD wrote it, 'seed' for the starting board
  late final _is.ColumnString author;

  late final _is.ColumnDateTime writtenAt;

  @override
  List<_is.Column> get columns => [
    id,
    charter,
    missions,
    author,
    writtenAt,
  ];
}

class CityCharterInclude extends _is.IncludeObject {
  CityCharterInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CityCharter.t;
}

class CityCharterIncludeList extends _is.IncludeList {
  CityCharterIncludeList._({
    _is.WhereExpressionBuilder<CityCharterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CityCharter.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CityCharter.t;
}

class CityCharterRepository {
  const CityCharterRepository._();

  /// Returns a list of [CityCharter]s matching the given query parameters.
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
  Future<List<CityCharter>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityCharterTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CityCharter>(
      where: where?.call(CityCharter.t),
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CityCharter] matching the given query parameters.
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
  Future<CityCharter?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityCharterTable>? where,
    int? offset,
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CityCharter>(
      where: where?.call(CityCharter.t),
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CityCharter] by its [id] or null if no such row exists.
  Future<CityCharter?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CityCharter>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CityCharter]s in the list and returns the inserted rows.
  ///
  /// The returned [CityCharter]s will have their `id` fields set.
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
  Future<List<CityCharter>> insert(
    _is.DatabaseSession session,
    List<CityCharter> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CityCharter>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CityCharter] and returns the inserted row.
  ///
  /// The returned [CityCharter] will have its `id` field set.
  Future<CityCharter> insertRow(
    _is.DatabaseSession session,
    CityCharter row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CityCharter>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CityCharter]s in the list and returns the resulting rows.
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
  /// The returned [CityCharter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityCharter>> upsert(
    _is.DatabaseSession session,
    List<CityCharter> rows, {
    required _is.ColumnSelections<CityCharterTable> conflictColumns,
    _is.ColumnSelections<CityCharterTable>? updateColumns,
    _is.WhereExpressionBuilder<CityCharterTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CityCharter>(
      rows,
      conflictColumns: conflictColumns(CityCharter.t),
      updateColumns: updateColumns?.call(CityCharter.t),
      updateWhere: updateWhere?.call(CityCharter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CityCharter] and returns the resulting row.
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
  /// The returned [CityCharter] will have its `id` field set.
  Future<CityCharter?> upsertRow(
    _is.DatabaseSession session,
    CityCharter row, {
    required _is.ColumnSelections<CityCharterTable> conflictColumns,
    _is.ColumnSelections<CityCharterTable>? updateColumns,
    _is.WhereExpressionBuilder<CityCharterTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CityCharter>(
      row,
      conflictColumns: conflictColumns(CityCharter.t),
      updateColumns: updateColumns?.call(CityCharter.t),
      updateWhere: updateWhere?.call(CityCharter.t),
      transaction: transaction,
    );
  }

  /// Updates all [CityCharter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityCharter>> update(
    _is.DatabaseSession session,
    List<CityCharter> rows, {
    _is.ColumnSelections<CityCharterTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CityCharter>(
      rows,
      columns: columns?.call(CityCharter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CityCharter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CityCharter> updateRow(
    _is.DatabaseSession session,
    CityCharter row, {
    _is.ColumnSelections<CityCharterTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CityCharter>(
      row,
      columns: columns?.call(CityCharter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CityCharter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CityCharter?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CityCharterUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CityCharter>(
      id,
      columnValues: columnValues(CityCharter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CityCharter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityCharter>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CityCharterUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CityCharterTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CityCharter>(
      columnValues: columnValues(CityCharter.t.updateTable),
      where: where(CityCharter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CityCharter]s in the list and returns the deleted rows.
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
  Future<List<CityCharter>> delete(
    _is.DatabaseSession session,
    List<CityCharter> rows, {
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CityCharter>(
      rows,
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CityCharter].
  Future<CityCharter> deleteRow(
    _is.DatabaseSession session,
    CityCharter row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CityCharter>(
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
  Future<List<CityCharter>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityCharterTable> where,
    _is.OrderByBuilder<CityCharterTable>? orderBy,
    _is.OrderByListBuilder<CityCharterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CityCharter>(
      where: where(CityCharter.t),
      orderBy: orderBy?.call(CityCharter.t),
      orderByList: orderByList?.call(CityCharter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityCharterTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CityCharter>(
      where: where?.call(CityCharter.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CityCharter] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityCharterTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CityCharter>(
      where: where(CityCharter.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
