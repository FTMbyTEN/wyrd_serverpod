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

abstract class Chat implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Chat._({
    this.id,
    required this.authUserId,
    this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat({
    int? id,
    required _is.UuidValue authUserId,
    String? title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatImpl;

  factory Chat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chat(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChatTable();

  static const db = ChatRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// from the first message, once there is one
  String? title;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Chat copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (title != null) 'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (title != null) 'title': title,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChatInclude include() {
    return ChatInclude._();
  }

  static ChatIncludeList includeList({
    _is.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    ChatInclude? include,
  }) {
    return ChatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required _is.UuidValue authUserId,
    String? title,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         title: title,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Chat copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? title = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      title: title is String? ? title : this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChatUpdateTable extends _is.UpdateTable<ChatTable> {
  ChatUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> title(String? value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ChatTable extends _is.Table<int?> {
  ChatTable({super.tableRelation}) : super(tableName: 'chat') {
    updateTable = ChatUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ChatUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// from the first message, once there is one
  late final _is.ColumnString title;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    title,
    createdAt,
    updatedAt,
  ];
}

class ChatInclude extends _is.IncludeObject {
  ChatInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Chat.t;
}

class ChatIncludeList extends _is.IncludeList {
  ChatIncludeList._({
    _is.WhereExpressionBuilder<ChatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chat.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Chat.t;
}

class ChatRepository {
  const ChatRepository._();

  /// Returns a list of [Chat]s matching the given query parameters.
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
  Future<List<Chat>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Chat] matching the given query parameters.
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
  Future<Chat?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatTable>? where,
    int? offset,
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Chat] by its [id] or null if no such row exists.
  Future<Chat?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Chat>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Chat]s in the list and returns the inserted rows.
  ///
  /// The returned [Chat]s will have their `id` fields set.
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
  Future<List<Chat>> insert(
    _is.DatabaseSession session,
    List<Chat> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Chat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Chat] and returns the inserted row.
  ///
  /// The returned [Chat] will have its `id` field set.
  Future<Chat> insertRow(
    _is.DatabaseSession session,
    Chat row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Chat>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Chat]s in the list and returns the resulting rows.
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
  /// The returned [Chat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chat>> upsert(
    _is.DatabaseSession session,
    List<Chat> rows, {
    required _is.ColumnSelections<ChatTable> conflictColumns,
    _is.ColumnSelections<ChatTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Chat>(
      rows,
      conflictColumns: conflictColumns(Chat.t),
      updateColumns: updateColumns?.call(Chat.t),
      updateWhere: updateWhere?.call(Chat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Chat] and returns the resulting row.
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
  /// The returned [Chat] will have its `id` field set.
  Future<Chat?> upsertRow(
    _is.DatabaseSession session,
    Chat row, {
    required _is.ColumnSelections<ChatTable> conflictColumns,
    _is.ColumnSelections<ChatTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Chat>(
      row,
      conflictColumns: conflictColumns(Chat.t),
      updateColumns: updateColumns?.call(Chat.t),
      updateWhere: updateWhere?.call(Chat.t),
      transaction: transaction,
    );
  }

  /// Updates all [Chat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chat>> update(
    _is.DatabaseSession session,
    List<Chat> rows, {
    _is.ColumnSelections<ChatTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Chat>(
      rows,
      columns: columns?.call(Chat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Chat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Chat> updateRow(
    _is.DatabaseSession session,
    Chat row, {
    _is.ColumnSelections<ChatTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Chat>(
      row,
      columns: columns?.call(Chat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Chat?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChatUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Chat>(
      id,
      columnValues: columnValues(Chat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Chat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chat>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChatUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChatTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Chat>(
      columnValues: columnValues(Chat.t.updateTable),
      where: where(Chat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Chat]s in the list and returns the deleted rows.
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
  Future<List<Chat>> delete(
    _is.DatabaseSession session,
    List<Chat> rows, {
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Chat>(
      rows,
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Chat].
  Future<Chat> deleteRow(
    _is.DatabaseSession session,
    Chat row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Chat>(
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
  Future<List<Chat>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatTable> where,
    _is.OrderByBuilder<ChatTable>? orderBy,
    _is.OrderByListBuilder<ChatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Chat>(
      where: where(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Chat>(
      where: where?.call(Chat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Chat] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Chat>(
      where: where(Chat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
