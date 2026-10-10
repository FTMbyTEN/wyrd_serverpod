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

/// One message in a partner conversation: the customer's (user) or WYRD's (assistant).
abstract class PartnerMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerMessage._({
    this.id,
    required this.convId,
    required this.msgId,
    required this.role,
    required this.text,
    required this.createdAt,
  });

  factory PartnerMessage({
    int? id,
    required String convId,
    required String msgId,
    required String role,
    required String text,
    required DateTime createdAt,
  }) = _PartnerMessageImpl;

  factory PartnerMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerMessage(
      id: jsonSerialization['id'] as int?,
      convId: jsonSerialization['convId'] as String,
      msgId: jsonSerialization['msgId'] as String,
      role: jsonSerialization['role'] as String,
      text: jsonSerialization['text'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PartnerMessageTable();

  static const db = PartnerMessageRepository._();

  @override
  int? id;

  String convId;

  String msgId;

  String role;

  String text;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerMessage copyWith({
    int? id,
    String? convId,
    String? msgId,
    String? role,
    String? text,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerMessage',
      if (id != null) 'id': id,
      'convId': convId,
      'msgId': msgId,
      'role': role,
      'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerMessage',
      if (id != null) 'id': id,
      'convId': convId,
      'msgId': msgId,
      'role': role,
      'text': text,
      'createdAt': createdAt.toJson(),
    };
  }

  static PartnerMessageInclude include() {
    return PartnerMessageInclude._();
  }

  static PartnerMessageIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    PartnerMessageInclude? include,
  }) {
    return PartnerMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerMessageImpl extends PartnerMessage {
  _PartnerMessageImpl({
    int? id,
    required String convId,
    required String msgId,
    required String role,
    required String text,
    required DateTime createdAt,
  }) : super._(
         id: id,
         convId: convId,
         msgId: msgId,
         role: role,
         text: text,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PartnerMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerMessage copyWith({
    Object? id = _Undefined,
    String? convId,
    String? msgId,
    String? role,
    String? text,
    DateTime? createdAt,
  }) {
    return PartnerMessage(
      id: id is int? ? id : this.id,
      convId: convId ?? this.convId,
      msgId: msgId ?? this.msgId,
      role: role ?? this.role,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PartnerMessageUpdateTable extends _is.UpdateTable<PartnerMessageTable> {
  PartnerMessageUpdateTable(super.table);

  _is.ColumnValue<String, String> convId(String value) => _is.ColumnValue(
    table.convId,
    value,
  );

  _is.ColumnValue<String, String> msgId(String value) => _is.ColumnValue(
    table.msgId,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PartnerMessageTable extends _is.Table<int?> {
  PartnerMessageTable({super.tableRelation})
    : super(tableName: 'partner_message') {
    updateTable = PartnerMessageUpdateTable(this);
    convId = _is.ColumnString(
      'convId',
      this,
    );
    msgId = _is.ColumnString(
      'msgId',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PartnerMessageUpdateTable updateTable;

  late final _is.ColumnString convId;

  late final _is.ColumnString msgId;

  late final _is.ColumnString role;

  late final _is.ColumnString text;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    convId,
    msgId,
    role,
    text,
    createdAt,
  ];
}

class PartnerMessageInclude extends _is.IncludeObject {
  PartnerMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerMessage.t;
}

class PartnerMessageIncludeList extends _is.IncludeList {
  PartnerMessageIncludeList._({
    _is.WhereExpressionBuilder<PartnerMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerMessage.t;
}

class PartnerMessageRepository {
  const PartnerMessageRepository._();

  /// Returns a list of [PartnerMessage]s matching the given query parameters.
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
  Future<List<PartnerMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerMessage>(
      where: where?.call(PartnerMessage.t),
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerMessage] matching the given query parameters.
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
  Future<PartnerMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerMessage>(
      where: where?.call(PartnerMessage.t),
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerMessage] by its [id] or null if no such row exists.
  Future<PartnerMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerMessage]s will have their `id` fields set.
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
  Future<List<PartnerMessage>> insert(
    _is.DatabaseSession session,
    List<PartnerMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerMessage] and returns the inserted row.
  ///
  /// The returned [PartnerMessage] will have its `id` field set.
  Future<PartnerMessage> insertRow(
    _is.DatabaseSession session,
    PartnerMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerMessage]s in the list and returns the resulting rows.
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
  /// The returned [PartnerMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerMessage>> upsert(
    _is.DatabaseSession session,
    List<PartnerMessage> rows, {
    required _is.ColumnSelections<PartnerMessageTable> conflictColumns,
    _is.ColumnSelections<PartnerMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerMessage>(
      rows,
      conflictColumns: conflictColumns(PartnerMessage.t),
      updateColumns: updateColumns?.call(PartnerMessage.t),
      updateWhere: updateWhere?.call(PartnerMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerMessage] and returns the resulting row.
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
  /// The returned [PartnerMessage] will have its `id` field set.
  Future<PartnerMessage?> upsertRow(
    _is.DatabaseSession session,
    PartnerMessage row, {
    required _is.ColumnSelections<PartnerMessageTable> conflictColumns,
    _is.ColumnSelections<PartnerMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerMessage>(
      row,
      conflictColumns: conflictColumns(PartnerMessage.t),
      updateColumns: updateColumns?.call(PartnerMessage.t),
      updateWhere: updateWhere?.call(PartnerMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerMessage>> update(
    _is.DatabaseSession session,
    List<PartnerMessage> rows, {
    _is.ColumnSelections<PartnerMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerMessage>(
      rows,
      columns: columns?.call(PartnerMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerMessage> updateRow(
    _is.DatabaseSession session,
    PartnerMessage row, {
    _is.ColumnSelections<PartnerMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerMessage>(
      row,
      columns: columns?.call(PartnerMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerMessageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerMessage>(
      id,
      columnValues: columnValues(PartnerMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerMessageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PartnerMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerMessage>(
      columnValues: columnValues(PartnerMessage.t.updateTable),
      where: where(PartnerMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerMessage]s in the list and returns the deleted rows.
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
  Future<List<PartnerMessage>> delete(
    _is.DatabaseSession session,
    List<PartnerMessage> rows, {
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerMessage>(
      rows,
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerMessage].
  Future<PartnerMessage> deleteRow(
    _is.DatabaseSession session,
    PartnerMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerMessage>(
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
  Future<List<PartnerMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerMessageTable> where,
    _is.OrderByBuilder<PartnerMessageTable>? orderBy,
    _is.OrderByListBuilder<PartnerMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerMessage>(
      where: where(PartnerMessage.t),
      orderBy: orderBy?.call(PartnerMessage.t),
      orderByList: orderByList?.call(PartnerMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerMessage>(
      where: where?.call(PartnerMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerMessage>(
      where: where(PartnerMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
