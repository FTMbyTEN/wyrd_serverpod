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

/// The inside of a building: its furniture, as JSON [{k: kind, x, z, r: quarter turns, c: colour}].
/// [key] is hq:<slot> for an HQ (its owner arranges it) or place:<id> for a club, the casino, the
/// tower and the rest (WYRD's operator arranges those).
abstract class IslandRoom
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandRoom._({
    this.id,
    required this.key,
    required this.layout,
    required this.updatedAt,
  });

  factory IslandRoom({
    int? id,
    required String key,
    required String layout,
    required DateTime updatedAt,
  }) = _IslandRoomImpl;

  factory IslandRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandRoom(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      layout: jsonSerialization['layout'] as String,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = IslandRoomTable();

  static const db = IslandRoomRepository._();

  @override
  int? id;

  String key;

  String layout;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandRoom copyWith({
    int? id,
    String? key,
    String? layout,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandRoom',
      if (id != null) 'id': id,
      'key': key,
      'layout': layout,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandRoom',
      if (id != null) 'id': id,
      'key': key,
      'layout': layout,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IslandRoomInclude include() {
    return IslandRoomInclude._();
  }

  static IslandRoomIncludeList includeList({
    _is.WhereExpressionBuilder<IslandRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    IslandRoomInclude? include,
  }) {
    return IslandRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandRoomImpl extends IslandRoom {
  _IslandRoomImpl({
    int? id,
    required String key,
    required String layout,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         key: key,
         layout: layout,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IslandRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandRoom copyWith({
    Object? id = _Undefined,
    String? key,
    String? layout,
    DateTime? updatedAt,
  }) {
    return IslandRoom(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      layout: layout ?? this.layout,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IslandRoomUpdateTable extends _is.UpdateTable<IslandRoomTable> {
  IslandRoomUpdateTable(super.table);

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<String, String> layout(String value) => _is.ColumnValue(
    table.layout,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class IslandRoomTable extends _is.Table<int?> {
  IslandRoomTable({super.tableRelation}) : super(tableName: 'island_room') {
    updateTable = IslandRoomUpdateTable(this);
    key = _is.ColumnString(
      'key',
      this,
    );
    layout = _is.ColumnString(
      'layout',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final IslandRoomUpdateTable updateTable;

  late final _is.ColumnString key;

  late final _is.ColumnString layout;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    key,
    layout,
    updatedAt,
  ];
}

class IslandRoomInclude extends _is.IncludeObject {
  IslandRoomInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandRoom.t;
}

class IslandRoomIncludeList extends _is.IncludeList {
  IslandRoomIncludeList._({
    _is.WhereExpressionBuilder<IslandRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandRoom.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandRoom.t;
}

class IslandRoomRepository {
  const IslandRoomRepository._();

  /// Returns a list of [IslandRoom]s matching the given query parameters.
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
  Future<List<IslandRoom>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandRoom>(
      where: where?.call(IslandRoom.t),
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandRoom] matching the given query parameters.
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
  Future<IslandRoom?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandRoomTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandRoom>(
      where: where?.call(IslandRoom.t),
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandRoom] by its [id] or null if no such row exists.
  Future<IslandRoom?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandRoom>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandRoom]s will have their `id` fields set.
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
  Future<List<IslandRoom>> insert(
    _is.DatabaseSession session,
    List<IslandRoom> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandRoom>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandRoom] and returns the inserted row.
  ///
  /// The returned [IslandRoom] will have its `id` field set.
  Future<IslandRoom> insertRow(
    _is.DatabaseSession session,
    IslandRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandRoom]s in the list and returns the resulting rows.
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
  /// The returned [IslandRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandRoom>> upsert(
    _is.DatabaseSession session,
    List<IslandRoom> rows, {
    required _is.ColumnSelections<IslandRoomTable> conflictColumns,
    _is.ColumnSelections<IslandRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandRoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandRoom>(
      rows,
      conflictColumns: conflictColumns(IslandRoom.t),
      updateColumns: updateColumns?.call(IslandRoom.t),
      updateWhere: updateWhere?.call(IslandRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandRoom] and returns the resulting row.
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
  /// The returned [IslandRoom] will have its `id` field set.
  Future<IslandRoom?> upsertRow(
    _is.DatabaseSession session,
    IslandRoom row, {
    required _is.ColumnSelections<IslandRoomTable> conflictColumns,
    _is.ColumnSelections<IslandRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandRoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandRoom>(
      row,
      conflictColumns: conflictColumns(IslandRoom.t),
      updateColumns: updateColumns?.call(IslandRoom.t),
      updateWhere: updateWhere?.call(IslandRoom.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandRoom>> update(
    _is.DatabaseSession session,
    List<IslandRoom> rows, {
    _is.ColumnSelections<IslandRoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandRoom>(
      rows,
      columns: columns?.call(IslandRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandRoom> updateRow(
    _is.DatabaseSession session,
    IslandRoom row, {
    _is.ColumnSelections<IslandRoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandRoom>(
      row,
      columns: columns?.call(IslandRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandRoom?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandRoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandRoom>(
      id,
      columnValues: columnValues(IslandRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandRoom>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandRoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandRoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandRoom>(
      columnValues: columnValues(IslandRoom.t.updateTable),
      where: where(IslandRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandRoom]s in the list and returns the deleted rows.
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
  Future<List<IslandRoom>> delete(
    _is.DatabaseSession session,
    List<IslandRoom> rows, {
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandRoom>(
      rows,
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandRoom].
  Future<IslandRoom> deleteRow(
    _is.DatabaseSession session,
    IslandRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandRoom>(
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
  Future<List<IslandRoom>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandRoomTable> where,
    _is.OrderByBuilder<IslandRoomTable>? orderBy,
    _is.OrderByListBuilder<IslandRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandRoom>(
      where: where(IslandRoom.t),
      orderBy: orderBy?.call(IslandRoom.t),
      orderByList: orderByList?.call(IslandRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandRoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandRoom>(
      where: where?.call(IslandRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandRoom] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandRoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandRoom>(
      where: where(IslandRoom.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
