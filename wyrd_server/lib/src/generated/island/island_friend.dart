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

/// A friend request between two Lagosians, and then the friendship: pending until the other one accepts or declines.
/// One row per pair and direction; accepting turns it into a friendship both of them see.
abstract class IslandFriend
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandFriend._({
    this.id,
    required this.fromUser,
    required this.toUser,
    required this.status,
    this.note,
    required this.createdAt,
    this.decidedAt,
  });

  factory IslandFriend({
    int? id,
    required _is.UuidValue fromUser,
    required _is.UuidValue toUser,
    required String status,
    String? note,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _IslandFriendImpl;

  factory IslandFriend.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandFriend(
      id: jsonSerialization['id'] as int?,
      fromUser: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['fromUser'],
      ),
      toUser: _is.UuidValueJsonExtension.fromJson(jsonSerialization['toUser']),
      status: jsonSerialization['status'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = IslandFriendTable();

  static const db = IslandFriendRepository._();

  @override
  int? id;

  _is.UuidValue fromUser;

  _is.UuidValue toUser;

  /// pending | accepted | declined
  String status;

  /// a short hello with the request (optional)
  String? note;

  DateTime createdAt;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandFriend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandFriend copyWith({
    int? id,
    _is.UuidValue? fromUser,
    _is.UuidValue? toUser,
    String? status,
    String? note,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandFriend',
      if (id != null) 'id': id,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandFriend',
      if (id != null) 'id': id,
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  static IslandFriendInclude include() {
    return IslandFriendInclude._();
  }

  static IslandFriendIncludeList includeList({
    _is.WhereExpressionBuilder<IslandFriendTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    IslandFriendInclude? include,
  }) {
    return IslandFriendIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandFriendImpl extends IslandFriend {
  _IslandFriendImpl({
    int? id,
    required _is.UuidValue fromUser,
    required _is.UuidValue toUser,
    required String status,
    String? note,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         fromUser: fromUser,
         toUser: toUser,
         status: status,
         note: note,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [IslandFriend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandFriend copyWith({
    Object? id = _Undefined,
    _is.UuidValue? fromUser,
    _is.UuidValue? toUser,
    String? status,
    Object? note = _Undefined,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return IslandFriend(
      id: id is int? ? id : this.id,
      fromUser: fromUser ?? this.fromUser,
      toUser: toUser ?? this.toUser,
      status: status ?? this.status,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class IslandFriendUpdateTable extends _is.UpdateTable<IslandFriendTable> {
  IslandFriendUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> fromUser(_is.UuidValue value) =>
      _is.ColumnValue(
        table.fromUser,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> toUser(_is.UuidValue value) =>
      _is.ColumnValue(
        table.toUser,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class IslandFriendTable extends _is.Table<int?> {
  IslandFriendTable({super.tableRelation}) : super(tableName: 'island_friend') {
    updateTable = IslandFriendUpdateTable(this);
    fromUser = _is.ColumnUuid(
      'fromUser',
      this,
    );
    toUser = _is.ColumnUuid(
      'toUser',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final IslandFriendUpdateTable updateTable;

  late final _is.ColumnUuid fromUser;

  late final _is.ColumnUuid toUser;

  /// pending | accepted | declined
  late final _is.ColumnString status;

  /// a short hello with the request (optional)
  late final _is.ColumnString note;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    fromUser,
    toUser,
    status,
    note,
    createdAt,
    decidedAt,
  ];
}

class IslandFriendInclude extends _is.IncludeObject {
  IslandFriendInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandFriend.t;
}

class IslandFriendIncludeList extends _is.IncludeList {
  IslandFriendIncludeList._({
    _is.WhereExpressionBuilder<IslandFriendTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandFriend.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandFriend.t;
}

class IslandFriendRepository {
  const IslandFriendRepository._();

  /// Returns a list of [IslandFriend]s matching the given query parameters.
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
  Future<List<IslandFriend>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFriendTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandFriend>(
      where: where?.call(IslandFriend.t),
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandFriend] matching the given query parameters.
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
  Future<IslandFriend?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFriendTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandFriend>(
      where: where?.call(IslandFriend.t),
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandFriend] by its [id] or null if no such row exists.
  Future<IslandFriend?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandFriend>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandFriend]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandFriend]s will have their `id` fields set.
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
  Future<List<IslandFriend>> insert(
    _is.DatabaseSession session,
    List<IslandFriend> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandFriend>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandFriend] and returns the inserted row.
  ///
  /// The returned [IslandFriend] will have its `id` field set.
  Future<IslandFriend> insertRow(
    _is.DatabaseSession session,
    IslandFriend row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandFriend>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandFriend]s in the list and returns the resulting rows.
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
  /// The returned [IslandFriend]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFriend>> upsert(
    _is.DatabaseSession session,
    List<IslandFriend> rows, {
    required _is.ColumnSelections<IslandFriendTable> conflictColumns,
    _is.ColumnSelections<IslandFriendTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandFriendTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandFriend>(
      rows,
      conflictColumns: conflictColumns(IslandFriend.t),
      updateColumns: updateColumns?.call(IslandFriend.t),
      updateWhere: updateWhere?.call(IslandFriend.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandFriend] and returns the resulting row.
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
  /// The returned [IslandFriend] will have its `id` field set.
  Future<IslandFriend?> upsertRow(
    _is.DatabaseSession session,
    IslandFriend row, {
    required _is.ColumnSelections<IslandFriendTable> conflictColumns,
    _is.ColumnSelections<IslandFriendTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandFriendTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandFriend>(
      row,
      conflictColumns: conflictColumns(IslandFriend.t),
      updateColumns: updateColumns?.call(IslandFriend.t),
      updateWhere: updateWhere?.call(IslandFriend.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandFriend]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFriend>> update(
    _is.DatabaseSession session,
    List<IslandFriend> rows, {
    _is.ColumnSelections<IslandFriendTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandFriend>(
      rows,
      columns: columns?.call(IslandFriend.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandFriend]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandFriend> updateRow(
    _is.DatabaseSession session,
    IslandFriend row, {
    _is.ColumnSelections<IslandFriendTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandFriend>(
      row,
      columns: columns?.call(IslandFriend.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandFriend] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandFriend?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandFriendUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandFriend>(
      id,
      columnValues: columnValues(IslandFriend.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandFriend]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFriend>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandFriendUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandFriendTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandFriend>(
      columnValues: columnValues(IslandFriend.t.updateTable),
      where: where(IslandFriend.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandFriend]s in the list and returns the deleted rows.
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
  Future<List<IslandFriend>> delete(
    _is.DatabaseSession session,
    List<IslandFriend> rows, {
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandFriend>(
      rows,
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandFriend].
  Future<IslandFriend> deleteRow(
    _is.DatabaseSession session,
    IslandFriend row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandFriend>(
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
  Future<List<IslandFriend>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandFriendTable> where,
    _is.OrderByBuilder<IslandFriendTable>? orderBy,
    _is.OrderByListBuilder<IslandFriendTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandFriend>(
      where: where(IslandFriend.t),
      orderBy: orderBy?.call(IslandFriend.t),
      orderByList: orderByList?.call(IslandFriend.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFriendTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandFriend>(
      where: where?.call(IslandFriend.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandFriend] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandFriendTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandFriend>(
      where: where(IslandFriend.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
