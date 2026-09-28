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

abstract class RatingVote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RatingVote._({
    this.id,
    required this.authUserId,
    required this.kind,
    required this.key,
    required this.value,
  });

  factory RatingVote({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String key,
    required double value,
  }) = _RatingVoteImpl;

  factory RatingVote.fromJson(Map<String, dynamic> jsonSerialization) {
    return RatingVote(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      kind: jsonSerialization['kind'] as String,
      key: jsonSerialization['key'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
    );
  }

  static final t = RatingVoteTable();

  static const db = RatingVoteRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String kind;

  String key;

  double value;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RatingVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RatingVote copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? kind,
    String? key,
    double? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RatingVote',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'key': key,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RatingVote',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'key': key,
      'value': value,
    };
  }

  static RatingVoteInclude include() {
    return RatingVoteInclude._();
  }

  static RatingVoteIncludeList includeList({
    _is.WhereExpressionBuilder<RatingVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    RatingVoteInclude? include,
  }) {
    return RatingVoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingVoteImpl extends RatingVote {
  _RatingVoteImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String kind,
    required String key,
    required double value,
  }) : super._(
         id: id,
         authUserId: authUserId,
         kind: kind,
         key: key,
         value: value,
       );

  /// Returns a shallow copy of this [RatingVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RatingVote copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? kind,
    String? key,
    double? value,
  }) {
    return RatingVote(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      kind: kind ?? this.kind,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}

class RatingVoteUpdateTable extends _is.UpdateTable<RatingVoteTable> {
  RatingVoteUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<double, double> value(double value) => _is.ColumnValue(
    table.value,
    value,
  );
}

class RatingVoteTable extends _is.Table<int?> {
  RatingVoteTable({super.tableRelation}) : super(tableName: 'rating_vote') {
    updateTable = RatingVoteUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    key = _is.ColumnString(
      'key',
      this,
    );
    value = _is.ColumnDouble(
      'value',
      this,
    );
  }

  late final RatingVoteUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString kind;

  late final _is.ColumnString key;

  late final _is.ColumnDouble value;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    kind,
    key,
    value,
  ];
}

class RatingVoteInclude extends _is.IncludeObject {
  RatingVoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RatingVote.t;
}

class RatingVoteIncludeList extends _is.IncludeList {
  RatingVoteIncludeList._({
    _is.WhereExpressionBuilder<RatingVoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RatingVote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RatingVote.t;
}

class RatingVoteRepository {
  const RatingVoteRepository._();

  /// Returns a list of [RatingVote]s matching the given query parameters.
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
  Future<List<RatingVote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RatingVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RatingVote>(
      where: where?.call(RatingVote.t),
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RatingVote] matching the given query parameters.
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
  Future<RatingVote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RatingVoteTable>? where,
    int? offset,
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RatingVote>(
      where: where?.call(RatingVote.t),
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RatingVote] by its [id] or null if no such row exists.
  Future<RatingVote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RatingVote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RatingVote]s in the list and returns the inserted rows.
  ///
  /// The returned [RatingVote]s will have their `id` fields set.
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
  Future<List<RatingVote>> insert(
    _is.DatabaseSession session,
    List<RatingVote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RatingVote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RatingVote] and returns the inserted row.
  ///
  /// The returned [RatingVote] will have its `id` field set.
  Future<RatingVote> insertRow(
    _is.DatabaseSession session,
    RatingVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RatingVote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RatingVote]s in the list and returns the resulting rows.
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
  /// The returned [RatingVote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RatingVote>> upsert(
    _is.DatabaseSession session,
    List<RatingVote> rows, {
    required _is.ColumnSelections<RatingVoteTable> conflictColumns,
    _is.ColumnSelections<RatingVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<RatingVoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RatingVote>(
      rows,
      conflictColumns: conflictColumns(RatingVote.t),
      updateColumns: updateColumns?.call(RatingVote.t),
      updateWhere: updateWhere?.call(RatingVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RatingVote] and returns the resulting row.
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
  /// The returned [RatingVote] will have its `id` field set.
  Future<RatingVote?> upsertRow(
    _is.DatabaseSession session,
    RatingVote row, {
    required _is.ColumnSelections<RatingVoteTable> conflictColumns,
    _is.ColumnSelections<RatingVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<RatingVoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RatingVote>(
      row,
      conflictColumns: conflictColumns(RatingVote.t),
      updateColumns: updateColumns?.call(RatingVote.t),
      updateWhere: updateWhere?.call(RatingVote.t),
      transaction: transaction,
    );
  }

  /// Updates all [RatingVote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RatingVote>> update(
    _is.DatabaseSession session,
    List<RatingVote> rows, {
    _is.ColumnSelections<RatingVoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RatingVote>(
      rows,
      columns: columns?.call(RatingVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RatingVote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RatingVote> updateRow(
    _is.DatabaseSession session,
    RatingVote row, {
    _is.ColumnSelections<RatingVoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RatingVote>(
      row,
      columns: columns?.call(RatingVote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RatingVote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RatingVote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RatingVoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RatingVote>(
      id,
      columnValues: columnValues(RatingVote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RatingVote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RatingVote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RatingVoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RatingVoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RatingVote>(
      columnValues: columnValues(RatingVote.t.updateTable),
      where: where(RatingVote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RatingVote]s in the list and returns the deleted rows.
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
  Future<List<RatingVote>> delete(
    _is.DatabaseSession session,
    List<RatingVote> rows, {
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RatingVote>(
      rows,
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RatingVote].
  Future<RatingVote> deleteRow(
    _is.DatabaseSession session,
    RatingVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RatingVote>(
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
  Future<List<RatingVote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RatingVoteTable> where,
    _is.OrderByBuilder<RatingVoteTable>? orderBy,
    _is.OrderByListBuilder<RatingVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RatingVote>(
      where: where(RatingVote.t),
      orderBy: orderBy?.call(RatingVote.t),
      orderByList: orderByList?.call(RatingVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RatingVoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RatingVote>(
      where: where?.call(RatingVote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RatingVote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RatingVoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RatingVote>(
      where: where(RatingVote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
