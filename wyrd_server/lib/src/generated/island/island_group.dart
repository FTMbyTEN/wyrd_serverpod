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

/// An encrypted chat (two people or a group). The server holds only ciphertext: the group's name is
/// encrypted with the group key, and each member's copy of that key is wrapped for them in the browser.
abstract class IslandGroup
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandGroup._({
    this.id,
    required this.createdBy,
    required this.nameCt,
    required this.createdAt,
  });

  factory IslandGroup({
    int? id,
    required _is.UuidValue createdBy,
    required String nameCt,
    required DateTime createdAt,
  }) = _IslandGroupImpl;

  factory IslandGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandGroup(
      id: jsonSerialization['id'] as int?,
      createdBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdBy'],
      ),
      nameCt: jsonSerialization['nameCt'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandGroupTable();

  static const db = IslandGroupRepository._();

  @override
  int? id;

  _is.UuidValue createdBy;

  /// the name, encrypted with the group key (base64 iv.ciphertext)
  String nameCt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandGroup copyWith({
    int? id,
    _is.UuidValue? createdBy,
    String? nameCt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandGroup',
      if (id != null) 'id': id,
      'createdBy': createdBy.toJson(),
      'nameCt': nameCt,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandGroup',
      if (id != null) 'id': id,
      'createdBy': createdBy.toJson(),
      'nameCt': nameCt,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandGroupInclude include() {
    return IslandGroupInclude._();
  }

  static IslandGroupIncludeList includeList({
    _is.WhereExpressionBuilder<IslandGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    IslandGroupInclude? include,
  }) {
    return IslandGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandGroupImpl extends IslandGroup {
  _IslandGroupImpl({
    int? id,
    required _is.UuidValue createdBy,
    required String nameCt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         createdBy: createdBy,
         nameCt: nameCt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandGroup]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandGroup copyWith({
    Object? id = _Undefined,
    _is.UuidValue? createdBy,
    String? nameCt,
    DateTime? createdAt,
  }) {
    return IslandGroup(
      id: id is int? ? id : this.id,
      createdBy: createdBy ?? this.createdBy,
      nameCt: nameCt ?? this.nameCt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandGroupUpdateTable extends _is.UpdateTable<IslandGroupTable> {
  IslandGroupUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> createdBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<String, String> nameCt(String value) => _is.ColumnValue(
    table.nameCt,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandGroupTable extends _is.Table<int?> {
  IslandGroupTable({super.tableRelation}) : super(tableName: 'island_group') {
    updateTable = IslandGroupUpdateTable(this);
    createdBy = _is.ColumnUuid(
      'createdBy',
      this,
    );
    nameCt = _is.ColumnString(
      'nameCt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandGroupUpdateTable updateTable;

  late final _is.ColumnUuid createdBy;

  /// the name, encrypted with the group key (base64 iv.ciphertext)
  late final _is.ColumnString nameCt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    createdBy,
    nameCt,
    createdAt,
  ];
}

class IslandGroupInclude extends _is.IncludeObject {
  IslandGroupInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandGroup.t;
}

class IslandGroupIncludeList extends _is.IncludeList {
  IslandGroupIncludeList._({
    _is.WhereExpressionBuilder<IslandGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandGroup.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandGroup.t;
}

class IslandGroupRepository {
  const IslandGroupRepository._();

  /// Returns a list of [IslandGroup]s matching the given query parameters.
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
  Future<List<IslandGroup>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGroupTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandGroup>(
      where: where?.call(IslandGroup.t),
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandGroup] matching the given query parameters.
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
  Future<IslandGroup?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGroupTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandGroup>(
      where: where?.call(IslandGroup.t),
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandGroup] by its [id] or null if no such row exists.
  Future<IslandGroup?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandGroup>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandGroup]s will have their `id` fields set.
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
  Future<List<IslandGroup>> insert(
    _is.DatabaseSession session,
    List<IslandGroup> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandGroup>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandGroup] and returns the inserted row.
  ///
  /// The returned [IslandGroup] will have its `id` field set.
  Future<IslandGroup> insertRow(
    _is.DatabaseSession session,
    IslandGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandGroup]s in the list and returns the resulting rows.
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
  /// The returned [IslandGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGroup>> upsert(
    _is.DatabaseSession session,
    List<IslandGroup> rows, {
    required _is.ColumnSelections<IslandGroupTable> conflictColumns,
    _is.ColumnSelections<IslandGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGroupTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandGroup>(
      rows,
      conflictColumns: conflictColumns(IslandGroup.t),
      updateColumns: updateColumns?.call(IslandGroup.t),
      updateWhere: updateWhere?.call(IslandGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandGroup] and returns the resulting row.
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
  /// The returned [IslandGroup] will have its `id` field set.
  Future<IslandGroup?> upsertRow(
    _is.DatabaseSession session,
    IslandGroup row, {
    required _is.ColumnSelections<IslandGroupTable> conflictColumns,
    _is.ColumnSelections<IslandGroupTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandGroupTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandGroup>(
      row,
      conflictColumns: conflictColumns(IslandGroup.t),
      updateColumns: updateColumns?.call(IslandGroup.t),
      updateWhere: updateWhere?.call(IslandGroup.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGroup>> update(
    _is.DatabaseSession session,
    List<IslandGroup> rows, {
    _is.ColumnSelections<IslandGroupTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandGroup>(
      rows,
      columns: columns?.call(IslandGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandGroup> updateRow(
    _is.DatabaseSession session,
    IslandGroup row, {
    _is.ColumnSelections<IslandGroupTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandGroup>(
      row,
      columns: columns?.call(IslandGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandGroup] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandGroup?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandGroupUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandGroup>(
      id,
      columnValues: columnValues(IslandGroup.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandGroup]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandGroup>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandGroupUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandGroupTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandGroup>(
      columnValues: columnValues(IslandGroup.t.updateTable),
      where: where(IslandGroup.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandGroup]s in the list and returns the deleted rows.
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
  Future<List<IslandGroup>> delete(
    _is.DatabaseSession session,
    List<IslandGroup> rows, {
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandGroup>(
      rows,
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandGroup].
  Future<IslandGroup> deleteRow(
    _is.DatabaseSession session,
    IslandGroup row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandGroup>(
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
  Future<List<IslandGroup>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGroupTable> where,
    _is.OrderByBuilder<IslandGroupTable>? orderBy,
    _is.OrderByListBuilder<IslandGroupTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandGroup>(
      where: where(IslandGroup.t),
      orderBy: orderBy?.call(IslandGroup.t),
      orderByList: orderByList?.call(IslandGroup.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandGroupTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandGroup>(
      where: where?.call(IslandGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandGroup] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandGroupTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandGroup>(
      where: where(IslandGroup.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
