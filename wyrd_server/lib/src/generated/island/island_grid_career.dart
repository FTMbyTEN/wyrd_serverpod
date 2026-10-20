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

/// A player's National Grid career on one track (control, lineman, solar, plant): the server's own record of their
/// experience and level (1 Trainee .. 5 Chief). Pay is by this level, never by what the phone says.
abstract class IslandGridCareer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandGridCareer._({
    this.id,
    required this.authUserId,
    required this.track,
    required this.xp,
    required this.level,
    this.examAfter,
  });

  factory IslandGridCareer({
    int? id,
    required _is.UuidValue authUserId,
    required String track,
    required int xp,
    required int level,
    DateTime? examAfter,
  }) = _IslandGridCareerImpl;

  factory IslandGridCareer.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGridCareer(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      track: jsonSerialization['track'] as String,
      xp: jsonSerialization['xp'] as int,
      level: jsonSerialization['level'] as int,
      examAfter: jsonSerialization['examAfter'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['examAfter']),
    );
  }

  static final t = IslandGridCareerTable();

  static const db = IslandGridCareerRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String track;

  int xp;

  int level;

  /// a failed certification can be retaken after this
  DateTime? examAfter;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandGridCareer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandGridCareer copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? track,
    int? xp,
    int? level,
    DateTime? examAfter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGridCareer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'track': track,
      'xp': xp,
      'level': level,
      if (examAfter != null) 'examAfter': examAfter?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGridCareer',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'track': track,
      'xp': xp,
      'level': level,
      if (examAfter != null) 'examAfter': examAfter?.toJson(),
    };
  }

  static IslandGridCareerInclude include() {
    return IslandGridCareerInclude._();
  }

  static IslandGridCareerIncludeList includeList({
    _is.WhereExpressionBuilder<IslandGridCareerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    IslandGridCareerInclude? include,
  }) {
    return IslandGridCareerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGridCareerImpl extends IslandGridCareer {
  _IslandGridCareerImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String track,
    required int xp,
    required int level,
    DateTime? examAfter,
  }) : super._(
         id: id,
         authUserId: authUserId,
         track: track,
         xp: xp,
         level: level,
         examAfter: examAfter,
       );

  /// Returns a shallow copy of this [IslandGridCareer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandGridCareer copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? track,
    int? xp,
    int? level,
    Object? examAfter = _Undefined,
  }) {
    return IslandGridCareer(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      track: track ?? this.track,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      examAfter: examAfter is DateTime? ? examAfter : this.examAfter,
    );
  }
}

class IslandGridCareerUpdateTable
    extends _is.UpdateTable<IslandGridCareerTable> {
  IslandGridCareerUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> track(String value) => _is.ColumnValue(
    table.track,
    value,
  );

  _is.ColumnValue<int, int> xp(int value) => _is.ColumnValue(
    table.xp,
    value,
  );

  _is.ColumnValue<int, int> level(int value) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> examAfter(DateTime? value) =>
      _is.ColumnValue(
        table.examAfter,
        value,
      );
}

class IslandGridCareerTable extends _is.Table<int?> {
  IslandGridCareerTable({super.tableRelation})
    : super(tableName: 'island_grid_career') {
    updateTable = IslandGridCareerUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    track = _is.ColumnString(
      'track',
      this,
    );
    xp = _is.ColumnInt(
      'xp',
      this,
    );
    level = _is.ColumnInt(
      'level',
      this,
    );
    examAfter = _is.ColumnDateTime(
      'examAfter',
      this,
    );
  }

  late final IslandGridCareerUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString track;

  late final _is.ColumnInt xp;

  late final _is.ColumnInt level;

  /// a failed certification can be retaken after this
  late final _is.ColumnDateTime examAfter;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    track,
    xp,
    level,
    examAfter,
  ];
}

class IslandGridCareerInclude extends _is.IncludeObject {
  IslandGridCareerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandGridCareer.t;
}

class IslandGridCareerIncludeList extends _is.IncludeList {
  IslandGridCareerIncludeList._({
    _is.WhereExpressionBuilder<IslandGridCareerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandGridCareer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandGridCareer.t;
}

class IslandGridCareerRepository {
  const IslandGridCareerRepository._();

  /// Returns a list of [IslandGridCareer]s matching the given query parameters.
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
  Future<List<IslandGridCareer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridCareerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandGridCareer>(
      where: where?.call(IslandGridCareer.t),
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandGridCareer] matching the given query parameters.
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
  Future<IslandGridCareer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridCareerTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandGridCareer>(
      where: where?.call(IslandGridCareer.t),
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandGridCareer] by its [id] or null if no such row exists.
  Future<IslandGridCareer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandGridCareer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandGridCareer]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandGridCareer]s will have their `id` fields set.
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
  Future<List<IslandGridCareer>> insert(
    _is.DatabaseSession session,
    List<IslandGridCareer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandGridCareer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandGridCareer] and returns the inserted row.
  ///
  /// The returned [IslandGridCareer] will have its `id` field set.
  Future<IslandGridCareer> insertRow(
    _is.DatabaseSession session,
    IslandGridCareer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandGridCareer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandGridCareer]s in the list and returns the resulting rows.
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
  /// The returned [IslandGridCareer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridCareer>> upsert(
    _is.DatabaseSession session,
    List<IslandGridCareer> rows, {
    required _is.ColumnSelections<IslandGridCareerTable> conflictColumns,
    _is.ColumnSelections<IslandGridCareerTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGridCareerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandGridCareer>(
      rows,
      conflictColumns: conflictColumns(IslandGridCareer.t),
      updateColumns: updateColumns?.call(IslandGridCareer.t),
      updateWhere: updateWhere?.call(IslandGridCareer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandGridCareer] and returns the resulting row.
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
  /// The returned [IslandGridCareer] will have its `id` field set.
  Future<IslandGridCareer?> upsertRow(
    _is.DatabaseSession session,
    IslandGridCareer row, {
    required _is.ColumnSelections<IslandGridCareerTable> conflictColumns,
    _is.ColumnSelections<IslandGridCareerTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGridCareerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandGridCareer>(
      row,
      conflictColumns: conflictColumns(IslandGridCareer.t),
      updateColumns: updateColumns?.call(IslandGridCareer.t),
      updateWhere: updateWhere?.call(IslandGridCareer.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGridCareer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridCareer>> update(
    _is.DatabaseSession session,
    List<IslandGridCareer> rows, {
    _is.ColumnSelections<IslandGridCareerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandGridCareer>(
      rows,
      columns: columns?.call(IslandGridCareer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandGridCareer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandGridCareer> updateRow(
    _is.DatabaseSession session,
    IslandGridCareer row, {
    _is.ColumnSelections<IslandGridCareerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandGridCareer>(
      row,
      columns: columns?.call(IslandGridCareer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandGridCareer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandGridCareer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandGridCareerUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandGridCareer>(
      id,
      columnValues: columnValues(IslandGridCareer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGridCareer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGridCareer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandGridCareerUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<IslandGridCareerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandGridCareer>(
      columnValues: columnValues(IslandGridCareer.t.updateTable),
      where: where(IslandGridCareer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandGridCareer]s in the list and returns the deleted rows.
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
  Future<List<IslandGridCareer>> delete(
    _is.DatabaseSession session,
    List<IslandGridCareer> rows, {
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandGridCareer>(
      rows,
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandGridCareer].
  Future<IslandGridCareer> deleteRow(
    _is.DatabaseSession session,
    IslandGridCareer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandGridCareer>(
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
  Future<List<IslandGridCareer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGridCareerTable> where,
    _is.OrderByBuilder<IslandGridCareerTable>? orderBy,
    _is.OrderByListBuilder<IslandGridCareerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandGridCareer>(
      where: where(IslandGridCareer.t),
      orderBy: orderBy?.call(IslandGridCareer.t),
      orderByList: orderByList?.call(IslandGridCareer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGridCareerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandGridCareer>(
      where: where?.call(IslandGridCareer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandGridCareer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGridCareerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandGridCareer>(
      where: where(IslandGridCareer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
