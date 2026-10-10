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

/// One movement of naira, kept for good: the player's side ([amount], + in / - out) and the city account on the other
/// side ([counter]), so every entry balances. Written only by Bank.post, in the same database transaction that changes
/// the player's balance; never edited (a mistake is put right by a reversing entry). [key] makes each action pay or
/// charge once, however often it's retried.
abstract class NairaEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  NairaEntry._({
    this.id,
    required this.key,
    required this.authUserId,
    required this.amount,
    required this.balanceAfter,
    required this.kind,
    required this.counter,
    required this.memo,
    String? status,
    this.reverses,
    required this.createdAt,
  }) : status = status ?? 'posted';

  factory NairaEntry({
    int? id,
    required String key,
    required _is.UuidValue authUserId,
    required int amount,
    required int balanceAfter,
    required String kind,
    required String counter,
    required String memo,
    String? status,
    int? reverses,
    required DateTime createdAt,
  }) = _NairaEntryImpl;

  factory NairaEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return NairaEntry(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      amount: jsonSerialization['amount'] as int,
      balanceAfter: jsonSerialization['balanceAfter'] as int,
      kind: jsonSerialization['kind'] as String,
      counter: jsonSerialization['counter'] as String,
      memo: jsonSerialization['memo'] as String,
      status: jsonSerialization['status'] as String?,
      reverses: jsonSerialization['reverses'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = NairaEntryTable();

  static const db = NairaEntryRepository._();

  @override
  int? id;

  /// what this movement is, once: e.g. job:{id}, rent:{home}:{week}, ride:{user}:{bucket}
  String key;

  _is.UuidValue authUserId;

  /// + naira in, - naira out
  int amount;

  /// the player's balance just after it
  int balanceAfter;

  /// open | fare | ride | air | rent | home | fine | fee | job | mission | guide | story | place | refund | grant
  String kind;

  /// the other side: city:treasury, city:transport, city:landlord, city:courts, city:market, city:services
  String counter;

  /// what the player reads on the receipt
  String memo;

  /// posted | reversed
  String status;

  /// the entry this one reverses, if it's a reversal
  int? reverses;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [NairaEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NairaEntry copyWith({
    int? id,
    String? key,
    _is.UuidValue? authUserId,
    int? amount,
    int? balanceAfter,
    String? kind,
    String? counter,
    String? memo,
    String? status,
    int? reverses,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NairaEntry',
      if (id != null) 'id': id,
      'key': key,
      'authUserId': authUserId.toJson(),
      'amount': amount,
      'balanceAfter': balanceAfter,
      'kind': kind,
      'counter': counter,
      'memo': memo,
      'status': status,
      if (reverses != null) 'reverses': reverses,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NairaEntry',
      if (id != null) 'id': id,
      'key': key,
      'authUserId': authUserId.toJson(),
      'amount': amount,
      'balanceAfter': balanceAfter,
      'kind': kind,
      'counter': counter,
      'memo': memo,
      'status': status,
      if (reverses != null) 'reverses': reverses,
      'createdAt': createdAt.toJson(),
    };
  }

  static NairaEntryInclude include() {
    return NairaEntryInclude._();
  }

  static NairaEntryIncludeList includeList({
    _is.WhereExpressionBuilder<NairaEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    NairaEntryInclude? include,
  }) {
    return NairaEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NairaEntryImpl extends NairaEntry {
  _NairaEntryImpl({
    int? id,
    required String key,
    required _is.UuidValue authUserId,
    required int amount,
    required int balanceAfter,
    required String kind,
    required String counter,
    required String memo,
    String? status,
    int? reverses,
    required DateTime createdAt,
  }) : super._(
         id: id,
         key: key,
         authUserId: authUserId,
         amount: amount,
         balanceAfter: balanceAfter,
         kind: kind,
         counter: counter,
         memo: memo,
         status: status,
         reverses: reverses,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NairaEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NairaEntry copyWith({
    Object? id = _Undefined,
    String? key,
    _is.UuidValue? authUserId,
    int? amount,
    int? balanceAfter,
    String? kind,
    String? counter,
    String? memo,
    String? status,
    Object? reverses = _Undefined,
    DateTime? createdAt,
  }) {
    return NairaEntry(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      authUserId: authUserId ?? this.authUserId,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      kind: kind ?? this.kind,
      counter: counter ?? this.counter,
      memo: memo ?? this.memo,
      status: status ?? this.status,
      reverses: reverses is int? ? reverses : this.reverses,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NairaEntryUpdateTable extends _is.UpdateTable<NairaEntryTable> {
  NairaEntryUpdateTable(super.table);

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<int, int> balanceAfter(int value) => _is.ColumnValue(
    table.balanceAfter,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> counter(String value) => _is.ColumnValue(
    table.counter,
    value,
  );

  _is.ColumnValue<String, String> memo(String value) => _is.ColumnValue(
    table.memo,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> reverses(int? value) => _is.ColumnValue(
    table.reverses,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class NairaEntryTable extends _is.Table<int?> {
  NairaEntryTable({super.tableRelation}) : super(tableName: 'naira_entry') {
    updateTable = NairaEntryUpdateTable(this);
    key = _is.ColumnString(
      'key',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
    balanceAfter = _is.ColumnInt(
      'balanceAfter',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    counter = _is.ColumnString(
      'counter',
      this,
    );
    memo = _is.ColumnString(
      'memo',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    reverses = _is.ColumnInt(
      'reverses',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final NairaEntryUpdateTable updateTable;

  /// what this movement is, once: e.g. job:{id}, rent:{home}:{week}, ride:{user}:{bucket}
  late final _is.ColumnString key;

  late final _is.ColumnUuid authUserId;

  /// + naira in, - naira out
  late final _is.ColumnInt amount;

  /// the player's balance just after it
  late final _is.ColumnInt balanceAfter;

  /// open | fare | ride | air | rent | home | fine | fee | job | mission | guide | story | place | refund | grant
  late final _is.ColumnString kind;

  /// the other side: city:treasury, city:transport, city:landlord, city:courts, city:market, city:services
  late final _is.ColumnString counter;

  /// what the player reads on the receipt
  late final _is.ColumnString memo;

  /// posted | reversed
  late final _is.ColumnString status;

  /// the entry this one reverses, if it's a reversal
  late final _is.ColumnInt reverses;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    key,
    authUserId,
    amount,
    balanceAfter,
    kind,
    counter,
    memo,
    status,
    reverses,
    createdAt,
  ];
}

class NairaEntryInclude extends _is.IncludeObject {
  NairaEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => NairaEntry.t;
}

class NairaEntryIncludeList extends _is.IncludeList {
  NairaEntryIncludeList._({
    _is.WhereExpressionBuilder<NairaEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NairaEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => NairaEntry.t;
}

class NairaEntryRepository {
  const NairaEntryRepository._();

  /// Returns a list of [NairaEntry]s matching the given query parameters.
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
  Future<List<NairaEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NairaEntry>(
      where: where?.call(NairaEntry.t),
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NairaEntry] matching the given query parameters.
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
  Future<NairaEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NairaEntry>(
      where: where?.call(NairaEntry.t),
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NairaEntry] by its [id] or null if no such row exists.
  Future<NairaEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NairaEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NairaEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [NairaEntry]s will have their `id` fields set.
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
  Future<List<NairaEntry>> insert(
    _is.DatabaseSession session,
    List<NairaEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<NairaEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [NairaEntry] and returns the inserted row.
  ///
  /// The returned [NairaEntry] will have its `id` field set.
  Future<NairaEntry> insertRow(
    _is.DatabaseSession session,
    NairaEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<NairaEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [NairaEntry]s in the list and returns the resulting rows.
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
  /// The returned [NairaEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaEntry>> upsert(
    _is.DatabaseSession session,
    List<NairaEntry> rows, {
    required _is.ColumnSelections<NairaEntryTable> conflictColumns,
    _is.ColumnSelections<NairaEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<NairaEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<NairaEntry>(
      rows,
      conflictColumns: conflictColumns(NairaEntry.t),
      updateColumns: updateColumns?.call(NairaEntry.t),
      updateWhere: updateWhere?.call(NairaEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [NairaEntry] and returns the resulting row.
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
  /// The returned [NairaEntry] will have its `id` field set.
  Future<NairaEntry?> upsertRow(
    _is.DatabaseSession session,
    NairaEntry row, {
    required _is.ColumnSelections<NairaEntryTable> conflictColumns,
    _is.ColumnSelections<NairaEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<NairaEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<NairaEntry>(
      row,
      conflictColumns: conflictColumns(NairaEntry.t),
      updateColumns: updateColumns?.call(NairaEntry.t),
      updateWhere: updateWhere?.call(NairaEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [NairaEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaEntry>> update(
    _is.DatabaseSession session,
    List<NairaEntry> rows, {
    _is.ColumnSelections<NairaEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<NairaEntry>(
      rows,
      columns: columns?.call(NairaEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [NairaEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NairaEntry> updateRow(
    _is.DatabaseSession session,
    NairaEntry row, {
    _is.ColumnSelections<NairaEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<NairaEntry>(
      row,
      columns: columns?.call(NairaEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NairaEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NairaEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<NairaEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<NairaEntry>(
      id,
      columnValues: columnValues(NairaEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NairaEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NairaEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<NairaEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<NairaEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<NairaEntry>(
      columnValues: columnValues(NairaEntry.t.updateTable),
      where: where(NairaEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [NairaEntry]s in the list and returns the deleted rows.
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
  Future<List<NairaEntry>> delete(
    _is.DatabaseSession session,
    List<NairaEntry> rows, {
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<NairaEntry>(
      rows,
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [NairaEntry].
  Future<NairaEntry> deleteRow(
    _is.DatabaseSession session,
    NairaEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NairaEntry>(
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
  Future<List<NairaEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NairaEntryTable> where,
    _is.OrderByBuilder<NairaEntryTable>? orderBy,
    _is.OrderByListBuilder<NairaEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<NairaEntry>(
      where: where(NairaEntry.t),
      orderBy: orderBy?.call(NairaEntry.t),
      orderByList: orderByList?.call(NairaEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NairaEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<NairaEntry>(
      where: where?.call(NairaEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NairaEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NairaEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NairaEntry>(
      where: where(NairaEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
