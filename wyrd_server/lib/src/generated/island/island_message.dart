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

/// One message in an encrypted group: ciphertext only.
abstract class IslandMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandMessage._({
    this.id,
    required this.groupId,
    required this.senderId,
    required this.ct,
    required this.createdAt,
  });

  factory IslandMessage({
    int? id,
    required int groupId,
    required _is.UuidValue senderId,
    required String ct,
    required DateTime createdAt,
  }) = _IslandMessageImpl;

  factory IslandMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandMessage(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      senderId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderId'],
      ),
      ct: jsonSerialization['ct'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandMessageTable();

  static const db = IslandMessageRepository._();

  @override
  int? id;

  int groupId;

  _is.UuidValue senderId;

  /// base64 iv.ciphertext (AES-GCM, the group key)
  String ct;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandMessage copyWith({
    int? id,
    int? groupId,
    _is.UuidValue? senderId,
    String? ct,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandMessage',
      if (id != null) 'id': id,
      'groupId': groupId,
      'senderId': senderId.toJson(),
      'ct': ct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandMessage',
      if (id != null) 'id': id,
      'groupId': groupId,
      'senderId': senderId.toJson(),
      'ct': ct,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandMessageInclude include() {
    return IslandMessageInclude._();
  }

  static IslandMessageIncludeList includeList({
    _is.WhereExpressionBuilder<IslandMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    IslandMessageInclude? include,
  }) {
    return IslandMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandMessageImpl extends IslandMessage {
  _IslandMessageImpl({
    int? id,
    required int groupId,
    required _is.UuidValue senderId,
    required String ct,
    required DateTime createdAt,
  }) : super._(
         id: id,
         groupId: groupId,
         senderId: senderId,
         ct: ct,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandMessage copyWith({
    Object? id = _Undefined,
    int? groupId,
    _is.UuidValue? senderId,
    String? ct,
    DateTime? createdAt,
  }) {
    return IslandMessage(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      senderId: senderId ?? this.senderId,
      ct: ct ?? this.ct,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandMessageUpdateTable extends _is.UpdateTable<IslandMessageTable> {
  IslandMessageUpdateTable(super.table);

  _is.ColumnValue<int, int> groupId(int value) => _is.ColumnValue(
    table.groupId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> senderId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.senderId,
        value,
      );

  _is.ColumnValue<String, String> ct(String value) => _is.ColumnValue(
    table.ct,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandMessageTable extends _is.Table<int?> {
  IslandMessageTable({super.tableRelation})
    : super(tableName: 'island_message') {
    updateTable = IslandMessageUpdateTable(this);
    groupId = _is.ColumnInt(
      'groupId',
      this,
    );
    senderId = _is.ColumnUuid(
      'senderId',
      this,
    );
    ct = _is.ColumnString(
      'ct',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandMessageUpdateTable updateTable;

  late final _is.ColumnInt groupId;

  late final _is.ColumnUuid senderId;

  /// base64 iv.ciphertext (AES-GCM, the group key)
  late final _is.ColumnString ct;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    groupId,
    senderId,
    ct,
    createdAt,
  ];
}

class IslandMessageInclude extends _is.IncludeObject {
  IslandMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandMessage.t;
}

class IslandMessageIncludeList extends _is.IncludeList {
  IslandMessageIncludeList._({
    _is.WhereExpressionBuilder<IslandMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandMessage.t;
}

class IslandMessageRepository {
  const IslandMessageRepository._();

  /// Returns a list of [IslandMessage]s matching the given query parameters.
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
  Future<List<IslandMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandMessage>(
      where: where?.call(IslandMessage.t),
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandMessage] matching the given query parameters.
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
  Future<IslandMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandMessage>(
      where: where?.call(IslandMessage.t),
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandMessage] by its [id] or null if no such row exists.
  Future<IslandMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandMessage]s will have their `id` fields set.
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
  Future<List<IslandMessage>> insert(
    _is.DatabaseSession session,
    List<IslandMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandMessage] and returns the inserted row.
  ///
  /// The returned [IslandMessage] will have its `id` field set.
  Future<IslandMessage> insertRow(
    _is.DatabaseSession session,
    IslandMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandMessage]s in the list and returns the resulting rows.
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
  /// The returned [IslandMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMessage>> upsert(
    _is.DatabaseSession session,
    List<IslandMessage> rows, {
    required _is.ColumnSelections<IslandMessageTable> conflictColumns,
    _is.ColumnSelections<IslandMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandMessage>(
      rows,
      conflictColumns: conflictColumns(IslandMessage.t),
      updateColumns: updateColumns?.call(IslandMessage.t),
      updateWhere: updateWhere?.call(IslandMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandMessage] and returns the resulting row.
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
  /// The returned [IslandMessage] will have its `id` field set.
  Future<IslandMessage?> upsertRow(
    _is.DatabaseSession session,
    IslandMessage row, {
    required _is.ColumnSelections<IslandMessageTable> conflictColumns,
    _is.ColumnSelections<IslandMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandMessage>(
      row,
      conflictColumns: conflictColumns(IslandMessage.t),
      updateColumns: updateColumns?.call(IslandMessage.t),
      updateWhere: updateWhere?.call(IslandMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMessage>> update(
    _is.DatabaseSession session,
    List<IslandMessage> rows, {
    _is.ColumnSelections<IslandMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandMessage>(
      rows,
      columns: columns?.call(IslandMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandMessage> updateRow(
    _is.DatabaseSession session,
    IslandMessage row, {
    _is.ColumnSelections<IslandMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandMessage>(
      row,
      columns: columns?.call(IslandMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandMessageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandMessage>(
      id,
      columnValues: columnValues(IslandMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandMessageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandMessage>(
      columnValues: columnValues(IslandMessage.t.updateTable),
      where: where(IslandMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandMessage]s in the list and returns the deleted rows.
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
  Future<List<IslandMessage>> delete(
    _is.DatabaseSession session,
    List<IslandMessage> rows, {
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandMessage>(
      rows,
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandMessage].
  Future<IslandMessage> deleteRow(
    _is.DatabaseSession session,
    IslandMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandMessage>(
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
  Future<List<IslandMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandMessageTable> where,
    _is.OrderByBuilder<IslandMessageTable>? orderBy,
    _is.OrderByListBuilder<IslandMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandMessage>(
      where: where(IslandMessage.t),
      orderBy: orderBy?.call(IslandMessage.t),
      orderByList: orderByList?.call(IslandMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandMessage>(
      where: where?.call(IslandMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandMessage>(
      where: where(IslandMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
