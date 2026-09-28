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

abstract class ChatThread
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ChatThread._({
    this.id,
    required this.authUserId,
    required this.subject,
    this.lastReadUrl,
    this.lastReadTitle,
    this.lastReadItemId,
    this.lastPassage,
    this.nextOffset,
    required this.updatedAt,
  });

  factory ChatThread({
    int? id,
    required _is.UuidValue authUserId,
    required List<String> subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    required DateTime updatedAt,
  }) = _ChatThreadImpl;

  factory ChatThread.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatThread(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      subject: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['subject'],
      ),
      lastReadUrl: jsonSerialization['lastReadUrl'] as String?,
      lastReadTitle: jsonSerialization['lastReadTitle'] as String?,
      lastReadItemId: jsonSerialization['lastReadItemId'] as int?,
      lastPassage: jsonSerialization['lastPassage'] as String?,
      nextOffset: jsonSerialization['nextOffset'] as int?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChatThreadTable();

  static const db = ChatThreadRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  List<String> subject;

  String? lastReadUrl;

  String? lastReadTitle;

  int? lastReadItemId;

  String? lastPassage;

  int? nextOffset;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChatThread]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChatThread copyWith({
    int? id,
    _is.UuidValue? authUserId,
    List<String>? subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatThread',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'subject': subject.toJson(),
      if (lastReadUrl != null) 'lastReadUrl': lastReadUrl,
      if (lastReadTitle != null) 'lastReadTitle': lastReadTitle,
      if (lastReadItemId != null) 'lastReadItemId': lastReadItemId,
      if (lastPassage != null) 'lastPassage': lastPassage,
      if (nextOffset != null) 'nextOffset': nextOffset,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatThread',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'subject': subject.toJson(),
      if (lastReadUrl != null) 'lastReadUrl': lastReadUrl,
      if (lastReadTitle != null) 'lastReadTitle': lastReadTitle,
      if (lastReadItemId != null) 'lastReadItemId': lastReadItemId,
      if (lastPassage != null) 'lastPassage': lastPassage,
      if (nextOffset != null) 'nextOffset': nextOffset,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChatThreadInclude include() {
    return ChatThreadInclude._();
  }

  static ChatThreadIncludeList includeList({
    _is.WhereExpressionBuilder<ChatThreadTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    ChatThreadInclude? include,
  }) {
    return ChatThreadIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatThreadImpl extends ChatThread {
  _ChatThreadImpl({
    int? id,
    required _is.UuidValue authUserId,
    required List<String> subject,
    String? lastReadUrl,
    String? lastReadTitle,
    int? lastReadItemId,
    String? lastPassage,
    int? nextOffset,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         subject: subject,
         lastReadUrl: lastReadUrl,
         lastReadTitle: lastReadTitle,
         lastReadItemId: lastReadItemId,
         lastPassage: lastPassage,
         nextOffset: nextOffset,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChatThread]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChatThread copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    List<String>? subject,
    Object? lastReadUrl = _Undefined,
    Object? lastReadTitle = _Undefined,
    Object? lastReadItemId = _Undefined,
    Object? lastPassage = _Undefined,
    Object? nextOffset = _Undefined,
    DateTime? updatedAt,
  }) {
    return ChatThread(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      subject: subject ?? this.subject.map((e0) => e0).toList(),
      lastReadUrl: lastReadUrl is String? ? lastReadUrl : this.lastReadUrl,
      lastReadTitle: lastReadTitle is String?
          ? lastReadTitle
          : this.lastReadTitle,
      lastReadItemId: lastReadItemId is int?
          ? lastReadItemId
          : this.lastReadItemId,
      lastPassage: lastPassage is String? ? lastPassage : this.lastPassage,
      nextOffset: nextOffset is int? ? nextOffset : this.nextOffset,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChatThreadUpdateTable extends _is.UpdateTable<ChatThreadTable> {
  ChatThreadUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> subject(List<String> value) =>
      _is.ColumnValue(
        table.subject,
        value,
      );

  _is.ColumnValue<String, String> lastReadUrl(String? value) => _is.ColumnValue(
    table.lastReadUrl,
    value,
  );

  _is.ColumnValue<String, String> lastReadTitle(String? value) =>
      _is.ColumnValue(
        table.lastReadTitle,
        value,
      );

  _is.ColumnValue<int, int> lastReadItemId(int? value) => _is.ColumnValue(
    table.lastReadItemId,
    value,
  );

  _is.ColumnValue<String, String> lastPassage(String? value) => _is.ColumnValue(
    table.lastPassage,
    value,
  );

  _is.ColumnValue<int, int> nextOffset(int? value) => _is.ColumnValue(
    table.nextOffset,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ChatThreadTable extends _is.Table<int?> {
  ChatThreadTable({super.tableRelation}) : super(tableName: 'chat_thread') {
    updateTable = ChatThreadUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    subject = _is.ColumnSerializable<List<String>>(
      'subject',
      this,
    );
    lastReadUrl = _is.ColumnString(
      'lastReadUrl',
      this,
    );
    lastReadTitle = _is.ColumnString(
      'lastReadTitle',
      this,
    );
    lastReadItemId = _is.ColumnInt(
      'lastReadItemId',
      this,
    );
    lastPassage = _is.ColumnString(
      'lastPassage',
      this,
    );
    nextOffset = _is.ColumnInt(
      'nextOffset',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ChatThreadUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnSerializable<List<String>> subject;

  late final _is.ColumnString lastReadUrl;

  late final _is.ColumnString lastReadTitle;

  late final _is.ColumnInt lastReadItemId;

  late final _is.ColumnString lastPassage;

  late final _is.ColumnInt nextOffset;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    subject,
    lastReadUrl,
    lastReadTitle,
    lastReadItemId,
    lastPassage,
    nextOffset,
    updatedAt,
  ];
}

class ChatThreadInclude extends _is.IncludeObject {
  ChatThreadInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ChatThread.t;
}

class ChatThreadIncludeList extends _is.IncludeList {
  ChatThreadIncludeList._({
    _is.WhereExpressionBuilder<ChatThreadTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatThread.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChatThread.t;
}

class ChatThreadRepository {
  const ChatThreadRepository._();

  /// Returns a list of [ChatThread]s matching the given query parameters.
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
  Future<List<ChatThread>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatThreadTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChatThread>(
      where: where?.call(ChatThread.t),
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChatThread] matching the given query parameters.
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
  Future<ChatThread?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatThreadTable>? where,
    int? offset,
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChatThread>(
      where: where?.call(ChatThread.t),
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChatThread] by its [id] or null if no such row exists.
  Future<ChatThread?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChatThread>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChatThread]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatThread]s will have their `id` fields set.
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
  Future<List<ChatThread>> insert(
    _is.DatabaseSession session,
    List<ChatThread> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChatThread>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChatThread] and returns the inserted row.
  ///
  /// The returned [ChatThread] will have its `id` field set.
  Future<ChatThread> insertRow(
    _is.DatabaseSession session,
    ChatThread row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatThread>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChatThread]s in the list and returns the resulting rows.
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
  /// The returned [ChatThread]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatThread>> upsert(
    _is.DatabaseSession session,
    List<ChatThread> rows, {
    required _is.ColumnSelections<ChatThreadTable> conflictColumns,
    _is.ColumnSelections<ChatThreadTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatThreadTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChatThread>(
      rows,
      conflictColumns: conflictColumns(ChatThread.t),
      updateColumns: updateColumns?.call(ChatThread.t),
      updateWhere: updateWhere?.call(ChatThread.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChatThread] and returns the resulting row.
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
  /// The returned [ChatThread] will have its `id` field set.
  Future<ChatThread?> upsertRow(
    _is.DatabaseSession session,
    ChatThread row, {
    required _is.ColumnSelections<ChatThreadTable> conflictColumns,
    _is.ColumnSelections<ChatThreadTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatThreadTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChatThread>(
      row,
      conflictColumns: conflictColumns(ChatThread.t),
      updateColumns: updateColumns?.call(ChatThread.t),
      updateWhere: updateWhere?.call(ChatThread.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChatThread]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatThread>> update(
    _is.DatabaseSession session,
    List<ChatThread> rows, {
    _is.ColumnSelections<ChatThreadTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChatThread>(
      rows,
      columns: columns?.call(ChatThread.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChatThread]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatThread> updateRow(
    _is.DatabaseSession session,
    ChatThread row, {
    _is.ColumnSelections<ChatThreadTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatThread>(
      row,
      columns: columns?.call(ChatThread.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatThread] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChatThread?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChatThreadUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChatThread>(
      id,
      columnValues: columnValues(ChatThread.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChatThread]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatThread>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChatThreadUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChatThreadTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChatThread>(
      columnValues: columnValues(ChatThread.t.updateTable),
      where: where(ChatThread.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChatThread]s in the list and returns the deleted rows.
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
  Future<List<ChatThread>> delete(
    _is.DatabaseSession session,
    List<ChatThread> rows, {
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChatThread>(
      rows,
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChatThread].
  Future<ChatThread> deleteRow(
    _is.DatabaseSession session,
    ChatThread row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatThread>(
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
  Future<List<ChatThread>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatThreadTable> where,
    _is.OrderByBuilder<ChatThreadTable>? orderBy,
    _is.OrderByListBuilder<ChatThreadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChatThread>(
      where: where(ChatThread.t),
      orderBy: orderBy?.call(ChatThread.t),
      orderByList: orderByList?.call(ChatThread.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatThreadTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChatThread>(
      where: where?.call(ChatThread.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChatThread] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatThreadTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChatThread>(
      where: where(ChatThread.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
