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

/// One business transaction in the rewards ledger: its entries (RewardEntry) always sum to zero, in one unit. Never
/// edited or deleted (a database trigger refuses it); a mistake is put right by a new, linked journal.
abstract class RewardJournal
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardJournal._({
    this.id,
    required this.ref,
    required this.idemKey,
    required this.unit,
    required this.kind,
    required this.memo,
    this.linkRef,
    required this.actor,
    required this.createdAt,
  });

  factory RewardJournal({
    int? id,
    required String ref,
    required String idemKey,
    required String unit,
    required String kind,
    required String memo,
    String? linkRef,
    required String actor,
    required DateTime createdAt,
  }) = _RewardJournalImpl;

  factory RewardJournal.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardJournal(
      id: jsonSerialization['id'] as int?,
      ref: jsonSerialization['ref'] as String,
      idemKey: jsonSerialization['idemKey'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: jsonSerialization['kind'] as String,
      memo: jsonSerialization['memo'] as String,
      linkRef: jsonSerialization['linkRef'] as String?,
      actor: jsonSerialization['actor'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RewardJournalTable();

  static const db = RewardJournalRepository._();

  @override
  int? id;

  /// unique human reference, e.g. FJ-ACC-123
  String ref;

  /// the caller's idempotency key: the same key never posts twice
  String idemKey;

  /// GN | NGN
  String unit;

  /// fund | issue | reserve | release | earn | mature | withdraw | payout_paid | payout_fee | payout_failed | payout_returned | game_reward | levy | adjust
  String kind;

  String memo;

  /// the business record this belongs to (e.g. acc:12, wd:FJW-...)
  String? linkRef;

  /// who posted it: system, or a user / admin id
  String actor;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardJournal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardJournal copyWith({
    int? id,
    String? ref,
    String? idemKey,
    String? unit,
    String? kind,
    String? memo,
    String? linkRef,
    String? actor,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardJournal',
      if (id != null) 'id': id,
      'ref': ref,
      'idemKey': idemKey,
      'unit': unit,
      'kind': kind,
      'memo': memo,
      if (linkRef != null) 'linkRef': linkRef,
      'actor': actor,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardJournal',
      if (id != null) 'id': id,
      'ref': ref,
      'idemKey': idemKey,
      'unit': unit,
      'kind': kind,
      'memo': memo,
      if (linkRef != null) 'linkRef': linkRef,
      'actor': actor,
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardJournalInclude include() {
    return RewardJournalInclude._();
  }

  static RewardJournalIncludeList includeList({
    _is.WhereExpressionBuilder<RewardJournalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    RewardJournalInclude? include,
  }) {
    return RewardJournalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardJournalImpl extends RewardJournal {
  _RewardJournalImpl({
    int? id,
    required String ref,
    required String idemKey,
    required String unit,
    required String kind,
    required String memo,
    String? linkRef,
    required String actor,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ref: ref,
         idemKey: idemKey,
         unit: unit,
         kind: kind,
         memo: memo,
         linkRef: linkRef,
         actor: actor,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardJournal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardJournal copyWith({
    Object? id = _Undefined,
    String? ref,
    String? idemKey,
    String? unit,
    String? kind,
    String? memo,
    Object? linkRef = _Undefined,
    String? actor,
    DateTime? createdAt,
  }) {
    return RewardJournal(
      id: id is int? ? id : this.id,
      ref: ref ?? this.ref,
      idemKey: idemKey ?? this.idemKey,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      memo: memo ?? this.memo,
      linkRef: linkRef is String? ? linkRef : this.linkRef,
      actor: actor ?? this.actor,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardJournalUpdateTable extends _is.UpdateTable<RewardJournalTable> {
  RewardJournalUpdateTable(super.table);

  _is.ColumnValue<String, String> ref(String value) => _is.ColumnValue(
    table.ref,
    value,
  );

  _is.ColumnValue<String, String> idemKey(String value) => _is.ColumnValue(
    table.idemKey,
    value,
  );

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(
    table.unit,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> memo(String value) => _is.ColumnValue(
    table.memo,
    value,
  );

  _is.ColumnValue<String, String> linkRef(String? value) => _is.ColumnValue(
    table.linkRef,
    value,
  );

  _is.ColumnValue<String, String> actor(String value) => _is.ColumnValue(
    table.actor,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RewardJournalTable extends _is.Table<int?> {
  RewardJournalTable({super.tableRelation})
    : super(tableName: 'reward_journal') {
    updateTable = RewardJournalUpdateTable(this);
    ref = _is.ColumnString(
      'ref',
      this,
    );
    idemKey = _is.ColumnString(
      'idemKey',
      this,
    );
    unit = _is.ColumnString(
      'unit',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    memo = _is.ColumnString(
      'memo',
      this,
    );
    linkRef = _is.ColumnString(
      'linkRef',
      this,
    );
    actor = _is.ColumnString(
      'actor',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RewardJournalUpdateTable updateTable;

  /// unique human reference, e.g. FJ-ACC-123
  late final _is.ColumnString ref;

  /// the caller's idempotency key: the same key never posts twice
  late final _is.ColumnString idemKey;

  /// GN | NGN
  late final _is.ColumnString unit;

  /// fund | issue | reserve | release | earn | mature | withdraw | payout_paid | payout_fee | payout_failed | payout_returned | game_reward | levy | adjust
  late final _is.ColumnString kind;

  late final _is.ColumnString memo;

  /// the business record this belongs to (e.g. acc:12, wd:FJW-...)
  late final _is.ColumnString linkRef;

  /// who posted it: system, or a user / admin id
  late final _is.ColumnString actor;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ref,
    idemKey,
    unit,
    kind,
    memo,
    linkRef,
    actor,
    createdAt,
  ];
}

class RewardJournalInclude extends _is.IncludeObject {
  RewardJournalInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardJournal.t;
}

class RewardJournalIncludeList extends _is.IncludeList {
  RewardJournalIncludeList._({
    _is.WhereExpressionBuilder<RewardJournalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardJournal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardJournal.t;
}

class RewardJournalRepository {
  const RewardJournalRepository._();

  /// Returns a list of [RewardJournal]s matching the given query parameters.
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
  Future<List<RewardJournal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardJournalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardJournal>(
      where: where?.call(RewardJournal.t),
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardJournal] matching the given query parameters.
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
  Future<RewardJournal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardJournalTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardJournal>(
      where: where?.call(RewardJournal.t),
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardJournal] by its [id] or null if no such row exists.
  Future<RewardJournal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardJournal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardJournal]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardJournal]s will have their `id` fields set.
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
  Future<List<RewardJournal>> insert(
    _is.DatabaseSession session,
    List<RewardJournal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardJournal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardJournal] and returns the inserted row.
  ///
  /// The returned [RewardJournal] will have its `id` field set.
  Future<RewardJournal> insertRow(
    _is.DatabaseSession session,
    RewardJournal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardJournal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardJournal]s in the list and returns the resulting rows.
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
  /// The returned [RewardJournal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardJournal>> upsert(
    _is.DatabaseSession session,
    List<RewardJournal> rows, {
    required _is.ColumnSelections<RewardJournalTable> conflictColumns,
    _is.ColumnSelections<RewardJournalTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardJournalTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardJournal>(
      rows,
      conflictColumns: conflictColumns(RewardJournal.t),
      updateColumns: updateColumns?.call(RewardJournal.t),
      updateWhere: updateWhere?.call(RewardJournal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardJournal] and returns the resulting row.
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
  /// The returned [RewardJournal] will have its `id` field set.
  Future<RewardJournal?> upsertRow(
    _is.DatabaseSession session,
    RewardJournal row, {
    required _is.ColumnSelections<RewardJournalTable> conflictColumns,
    _is.ColumnSelections<RewardJournalTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardJournalTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardJournal>(
      row,
      conflictColumns: conflictColumns(RewardJournal.t),
      updateColumns: updateColumns?.call(RewardJournal.t),
      updateWhere: updateWhere?.call(RewardJournal.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardJournal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardJournal>> update(
    _is.DatabaseSession session,
    List<RewardJournal> rows, {
    _is.ColumnSelections<RewardJournalTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardJournal>(
      rows,
      columns: columns?.call(RewardJournal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardJournal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardJournal> updateRow(
    _is.DatabaseSession session,
    RewardJournal row, {
    _is.ColumnSelections<RewardJournalTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardJournal>(
      row,
      columns: columns?.call(RewardJournal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardJournal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardJournal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardJournalUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardJournal>(
      id,
      columnValues: columnValues(RewardJournal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardJournal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardJournal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardJournalUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardJournalTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardJournal>(
      columnValues: columnValues(RewardJournal.t.updateTable),
      where: where(RewardJournal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardJournal]s in the list and returns the deleted rows.
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
  Future<List<RewardJournal>> delete(
    _is.DatabaseSession session,
    List<RewardJournal> rows, {
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardJournal>(
      rows,
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardJournal].
  Future<RewardJournal> deleteRow(
    _is.DatabaseSession session,
    RewardJournal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardJournal>(
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
  Future<List<RewardJournal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardJournalTable> where,
    _is.OrderByBuilder<RewardJournalTable>? orderBy,
    _is.OrderByListBuilder<RewardJournalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardJournal>(
      where: where(RewardJournal.t),
      orderBy: orderBy?.call(RewardJournal.t),
      orderByList: orderByList?.call(RewardJournal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardJournalTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardJournal>(
      where: where?.call(RewardJournal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardJournal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardJournalTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardJournal>(
      where: where(RewardJournal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
