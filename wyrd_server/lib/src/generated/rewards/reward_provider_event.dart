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

/// A payout provider's callback or status report, kept once per provider event id (duplicates are ignored).
abstract class RewardProviderEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardProviderEvent._({
    this.id,
    required this.provider,
    required this.eventId,
    required this.payoutRef,
    required this.status,
    required this.signatureOk,
    required this.outcome,
    required this.receivedAt,
  });

  factory RewardProviderEvent({
    int? id,
    required String provider,
    required String eventId,
    required String payoutRef,
    required String status,
    required bool signatureOk,
    required String outcome,
    required DateTime receivedAt,
  }) = _RewardProviderEventImpl;

  factory RewardProviderEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardProviderEvent(
      id: jsonSerialization['id'] as int?,
      provider: jsonSerialization['provider'] as String,
      eventId: jsonSerialization['eventId'] as String,
      payoutRef: jsonSerialization['payoutRef'] as String,
      status: jsonSerialization['status'] as String,
      signatureOk: _is.BoolJsonExtension.fromJson(
        jsonSerialization['signatureOk'],
      ),
      outcome: jsonSerialization['outcome'] as String,
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  static final t = RewardProviderEventTable();

  static const db = RewardProviderEventRepository._();

  @override
  int? id;

  String provider;

  String eventId;

  String payoutRef;

  /// submitted | pending | paid | failed | returned
  String status;

  bool signatureOk;

  /// applied | ignored_duplicate | ignored_out_of_order | rejected_signature | unknown_payout
  String outcome;

  DateTime receivedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardProviderEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardProviderEvent copyWith({
    int? id,
    String? provider,
    String? eventId,
    String? payoutRef,
    String? status,
    bool? signatureOk,
    String? outcome,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardProviderEvent',
      if (id != null) 'id': id,
      'provider': provider,
      'eventId': eventId,
      'payoutRef': payoutRef,
      'status': status,
      'signatureOk': signatureOk,
      'outcome': outcome,
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardProviderEvent',
      if (id != null) 'id': id,
      'provider': provider,
      'eventId': eventId,
      'payoutRef': payoutRef,
      'status': status,
      'signatureOk': signatureOk,
      'outcome': outcome,
      'receivedAt': receivedAt.toJson(),
    };
  }

  static RewardProviderEventInclude include() {
    return RewardProviderEventInclude._();
  }

  static RewardProviderEventIncludeList includeList({
    _is.WhereExpressionBuilder<RewardProviderEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    RewardProviderEventInclude? include,
  }) {
    return RewardProviderEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardProviderEventImpl extends RewardProviderEvent {
  _RewardProviderEventImpl({
    int? id,
    required String provider,
    required String eventId,
    required String payoutRef,
    required String status,
    required bool signatureOk,
    required String outcome,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         provider: provider,
         eventId: eventId,
         payoutRef: payoutRef,
         status: status,
         signatureOk: signatureOk,
         outcome: outcome,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [RewardProviderEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardProviderEvent copyWith({
    Object? id = _Undefined,
    String? provider,
    String? eventId,
    String? payoutRef,
    String? status,
    bool? signatureOk,
    String? outcome,
    DateTime? receivedAt,
  }) {
    return RewardProviderEvent(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      eventId: eventId ?? this.eventId,
      payoutRef: payoutRef ?? this.payoutRef,
      status: status ?? this.status,
      signatureOk: signatureOk ?? this.signatureOk,
      outcome: outcome ?? this.outcome,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}

class RewardProviderEventUpdateTable
    extends _is.UpdateTable<RewardProviderEventTable> {
  RewardProviderEventUpdateTable(super.table);

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> eventId(String value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> payoutRef(String value) => _is.ColumnValue(
    table.payoutRef,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<bool, bool> signatureOk(bool value) => _is.ColumnValue(
    table.signatureOk,
    value,
  );

  _is.ColumnValue<String, String> outcome(String value) => _is.ColumnValue(
    table.outcome,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _is.ColumnValue(
        table.receivedAt,
        value,
      );
}

class RewardProviderEventTable extends _is.Table<int?> {
  RewardProviderEventTable({super.tableRelation})
    : super(tableName: 'reward_provider_event') {
    updateTable = RewardProviderEventUpdateTable(this);
    provider = _is.ColumnString(
      'provider',
      this,
    );
    eventId = _is.ColumnString(
      'eventId',
      this,
    );
    payoutRef = _is.ColumnString(
      'payoutRef',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    signatureOk = _is.ColumnBool(
      'signatureOk',
      this,
    );
    outcome = _is.ColumnString(
      'outcome',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final RewardProviderEventUpdateTable updateTable;

  late final _is.ColumnString provider;

  late final _is.ColumnString eventId;

  late final _is.ColumnString payoutRef;

  /// submitted | pending | paid | failed | returned
  late final _is.ColumnString status;

  late final _is.ColumnBool signatureOk;

  /// applied | ignored_duplicate | ignored_out_of_order | rejected_signature | unknown_payout
  late final _is.ColumnString outcome;

  late final _is.ColumnDateTime receivedAt;

  @override
  List<_is.Column> get columns => [
    id,
    provider,
    eventId,
    payoutRef,
    status,
    signatureOk,
    outcome,
    receivedAt,
  ];
}

class RewardProviderEventInclude extends _is.IncludeObject {
  RewardProviderEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardProviderEvent.t;
}

class RewardProviderEventIncludeList extends _is.IncludeList {
  RewardProviderEventIncludeList._({
    _is.WhereExpressionBuilder<RewardProviderEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardProviderEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardProviderEvent.t;
}

class RewardProviderEventRepository {
  const RewardProviderEventRepository._();

  /// Returns a list of [RewardProviderEvent]s matching the given query parameters.
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
  Future<List<RewardProviderEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardProviderEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardProviderEvent>(
      where: where?.call(RewardProviderEvent.t),
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardProviderEvent] matching the given query parameters.
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
  Future<RewardProviderEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardProviderEventTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardProviderEvent>(
      where: where?.call(RewardProviderEvent.t),
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardProviderEvent] by its [id] or null if no such row exists.
  Future<RewardProviderEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardProviderEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardProviderEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardProviderEvent]s will have their `id` fields set.
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
  Future<List<RewardProviderEvent>> insert(
    _is.DatabaseSession session,
    List<RewardProviderEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardProviderEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardProviderEvent] and returns the inserted row.
  ///
  /// The returned [RewardProviderEvent] will have its `id` field set.
  Future<RewardProviderEvent> insertRow(
    _is.DatabaseSession session,
    RewardProviderEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardProviderEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardProviderEvent]s in the list and returns the resulting rows.
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
  /// The returned [RewardProviderEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardProviderEvent>> upsert(
    _is.DatabaseSession session,
    List<RewardProviderEvent> rows, {
    required _is.ColumnSelections<RewardProviderEventTable> conflictColumns,
    _is.ColumnSelections<RewardProviderEventTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardProviderEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardProviderEvent>(
      rows,
      conflictColumns: conflictColumns(RewardProviderEvent.t),
      updateColumns: updateColumns?.call(RewardProviderEvent.t),
      updateWhere: updateWhere?.call(RewardProviderEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardProviderEvent] and returns the resulting row.
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
  /// The returned [RewardProviderEvent] will have its `id` field set.
  Future<RewardProviderEvent?> upsertRow(
    _is.DatabaseSession session,
    RewardProviderEvent row, {
    required _is.ColumnSelections<RewardProviderEventTable> conflictColumns,
    _is.ColumnSelections<RewardProviderEventTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardProviderEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardProviderEvent>(
      row,
      conflictColumns: conflictColumns(RewardProviderEvent.t),
      updateColumns: updateColumns?.call(RewardProviderEvent.t),
      updateWhere: updateWhere?.call(RewardProviderEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardProviderEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardProviderEvent>> update(
    _is.DatabaseSession session,
    List<RewardProviderEvent> rows, {
    _is.ColumnSelections<RewardProviderEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardProviderEvent>(
      rows,
      columns: columns?.call(RewardProviderEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardProviderEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardProviderEvent> updateRow(
    _is.DatabaseSession session,
    RewardProviderEvent row, {
    _is.ColumnSelections<RewardProviderEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardProviderEvent>(
      row,
      columns: columns?.call(RewardProviderEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardProviderEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardProviderEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardProviderEventUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardProviderEvent>(
      id,
      columnValues: columnValues(RewardProviderEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardProviderEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardProviderEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardProviderEventUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RewardProviderEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardProviderEvent>(
      columnValues: columnValues(RewardProviderEvent.t.updateTable),
      where: where(RewardProviderEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardProviderEvent]s in the list and returns the deleted rows.
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
  Future<List<RewardProviderEvent>> delete(
    _is.DatabaseSession session,
    List<RewardProviderEvent> rows, {
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardProviderEvent>(
      rows,
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardProviderEvent].
  Future<RewardProviderEvent> deleteRow(
    _is.DatabaseSession session,
    RewardProviderEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardProviderEvent>(
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
  Future<List<RewardProviderEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardProviderEventTable> where,
    _is.OrderByBuilder<RewardProviderEventTable>? orderBy,
    _is.OrderByListBuilder<RewardProviderEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardProviderEvent>(
      where: where(RewardProviderEvent.t),
      orderBy: orderBy?.call(RewardProviderEvent.t),
      orderByList: orderByList?.call(RewardProviderEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardProviderEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardProviderEvent>(
      where: where?.call(RewardProviderEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardProviderEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardProviderEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardProviderEvent>(
      where: where(RewardProviderEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
