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

/// Money added to the Real Rewards Fund (NGN) or Game Naira issued to the City Treasury (GN): proposed by one admin
/// with its evidence (e.g. the bank statement line), approved by a different one. Only an approved record posts.
abstract class RewardFunding
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardFunding._({
    this.id,
    required this.unit,
    required this.amount,
    required this.evidence,
    required this.status,
    required this.proposedBy,
    this.approvedBy,
    this.journalRef,
    required this.createdAt,
    this.decidedAt,
  });

  factory RewardFunding({
    int? id,
    required String unit,
    required int amount,
    required String evidence,
    required String status,
    required _is.UuidValue proposedBy,
    _is.UuidValue? approvedBy,
    String? journalRef,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _RewardFundingImpl;

  factory RewardFunding.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardFunding(
      id: jsonSerialization['id'] as int?,
      unit: jsonSerialization['unit'] as String,
      amount: jsonSerialization['amount'] as int,
      evidence: jsonSerialization['evidence'] as String,
      status: jsonSerialization['status'] as String,
      proposedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['proposedBy'],
      ),
      approvedBy: jsonSerialization['approvedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedBy'],
            ),
      journalRef: jsonSerialization['journalRef'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = RewardFundingTable();

  static const db = RewardFundingRepository._();

  @override
  int? id;

  /// GN | NGN
  String unit;

  int amount;

  String evidence;

  /// proposed | approved | rejected
  String status;

  _is.UuidValue proposedBy;

  _is.UuidValue? approvedBy;

  String? journalRef;

  DateTime createdAt;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardFunding]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardFunding copyWith({
    int? id,
    String? unit,
    int? amount,
    String? evidence,
    String? status,
    _is.UuidValue? proposedBy,
    _is.UuidValue? approvedBy,
    String? journalRef,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardFunding',
      if (id != null) 'id': id,
      'unit': unit,
      'amount': amount,
      'evidence': evidence,
      'status': status,
      'proposedBy': proposedBy.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (journalRef != null) 'journalRef': journalRef,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardFunding',
      if (id != null) 'id': id,
      'unit': unit,
      'amount': amount,
      'evidence': evidence,
      'status': status,
      'proposedBy': proposedBy.toJson(),
      if (approvedBy != null) 'approvedBy': approvedBy?.toJson(),
      if (journalRef != null) 'journalRef': journalRef,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  static RewardFundingInclude include() {
    return RewardFundingInclude._();
  }

  static RewardFundingIncludeList includeList({
    _is.WhereExpressionBuilder<RewardFundingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    RewardFundingInclude? include,
  }) {
    return RewardFundingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardFundingImpl extends RewardFunding {
  _RewardFundingImpl({
    int? id,
    required String unit,
    required int amount,
    required String evidence,
    required String status,
    required _is.UuidValue proposedBy,
    _is.UuidValue? approvedBy,
    String? journalRef,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         unit: unit,
         amount: amount,
         evidence: evidence,
         status: status,
         proposedBy: proposedBy,
         approvedBy: approvedBy,
         journalRef: journalRef,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [RewardFunding]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardFunding copyWith({
    Object? id = _Undefined,
    String? unit,
    int? amount,
    String? evidence,
    String? status,
    _is.UuidValue? proposedBy,
    Object? approvedBy = _Undefined,
    Object? journalRef = _Undefined,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return RewardFunding(
      id: id is int? ? id : this.id,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      evidence: evidence ?? this.evidence,
      status: status ?? this.status,
      proposedBy: proposedBy ?? this.proposedBy,
      approvedBy: approvedBy is _is.UuidValue? ? approvedBy : this.approvedBy,
      journalRef: journalRef is String? ? journalRef : this.journalRef,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class RewardFundingUpdateTable extends _is.UpdateTable<RewardFundingTable> {
  RewardFundingUpdateTable(super.table);

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(
    table.unit,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<String, String> evidence(String value) => _is.ColumnValue(
    table.evidence,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> proposedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.proposedBy,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> approvedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.approvedBy,
    value,
  );

  _is.ColumnValue<String, String> journalRef(String? value) => _is.ColumnValue(
    table.journalRef,
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

class RewardFundingTable extends _is.Table<int?> {
  RewardFundingTable({super.tableRelation})
    : super(tableName: 'reward_funding') {
    updateTable = RewardFundingUpdateTable(this);
    unit = _is.ColumnString(
      'unit',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
    );
    evidence = _is.ColumnString(
      'evidence',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    proposedBy = _is.ColumnUuid(
      'proposedBy',
      this,
    );
    approvedBy = _is.ColumnUuid(
      'approvedBy',
      this,
    );
    journalRef = _is.ColumnString(
      'journalRef',
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

  late final RewardFundingUpdateTable updateTable;

  /// GN | NGN
  late final _is.ColumnString unit;

  late final _is.ColumnInt amount;

  late final _is.ColumnString evidence;

  /// proposed | approved | rejected
  late final _is.ColumnString status;

  late final _is.ColumnUuid proposedBy;

  late final _is.ColumnUuid approvedBy;

  late final _is.ColumnString journalRef;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    unit,
    amount,
    evidence,
    status,
    proposedBy,
    approvedBy,
    journalRef,
    createdAt,
    decidedAt,
  ];
}

class RewardFundingInclude extends _is.IncludeObject {
  RewardFundingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardFunding.t;
}

class RewardFundingIncludeList extends _is.IncludeList {
  RewardFundingIncludeList._({
    _is.WhereExpressionBuilder<RewardFundingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardFunding.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardFunding.t;
}

class RewardFundingRepository {
  const RewardFundingRepository._();

  /// Returns a list of [RewardFunding]s matching the given query parameters.
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
  Future<List<RewardFunding>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardFundingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardFunding>(
      where: where?.call(RewardFunding.t),
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardFunding] matching the given query parameters.
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
  Future<RewardFunding?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardFundingTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardFunding>(
      where: where?.call(RewardFunding.t),
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardFunding] by its [id] or null if no such row exists.
  Future<RewardFunding?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardFunding>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardFunding]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardFunding]s will have their `id` fields set.
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
  Future<List<RewardFunding>> insert(
    _is.DatabaseSession session,
    List<RewardFunding> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardFunding>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardFunding] and returns the inserted row.
  ///
  /// The returned [RewardFunding] will have its `id` field set.
  Future<RewardFunding> insertRow(
    _is.DatabaseSession session,
    RewardFunding row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardFunding>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardFunding]s in the list and returns the resulting rows.
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
  /// The returned [RewardFunding]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardFunding>> upsert(
    _is.DatabaseSession session,
    List<RewardFunding> rows, {
    required _is.ColumnSelections<RewardFundingTable> conflictColumns,
    _is.ColumnSelections<RewardFundingTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardFundingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardFunding>(
      rows,
      conflictColumns: conflictColumns(RewardFunding.t),
      updateColumns: updateColumns?.call(RewardFunding.t),
      updateWhere: updateWhere?.call(RewardFunding.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardFunding] and returns the resulting row.
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
  /// The returned [RewardFunding] will have its `id` field set.
  Future<RewardFunding?> upsertRow(
    _is.DatabaseSession session,
    RewardFunding row, {
    required _is.ColumnSelections<RewardFundingTable> conflictColumns,
    _is.ColumnSelections<RewardFundingTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardFundingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardFunding>(
      row,
      conflictColumns: conflictColumns(RewardFunding.t),
      updateColumns: updateColumns?.call(RewardFunding.t),
      updateWhere: updateWhere?.call(RewardFunding.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardFunding]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardFunding>> update(
    _is.DatabaseSession session,
    List<RewardFunding> rows, {
    _is.ColumnSelections<RewardFundingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardFunding>(
      rows,
      columns: columns?.call(RewardFunding.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardFunding]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardFunding> updateRow(
    _is.DatabaseSession session,
    RewardFunding row, {
    _is.ColumnSelections<RewardFundingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardFunding>(
      row,
      columns: columns?.call(RewardFunding.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardFunding] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardFunding?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardFundingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardFunding>(
      id,
      columnValues: columnValues(RewardFunding.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardFunding]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardFunding>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardFundingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardFundingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardFunding>(
      columnValues: columnValues(RewardFunding.t.updateTable),
      where: where(RewardFunding.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardFunding]s in the list and returns the deleted rows.
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
  Future<List<RewardFunding>> delete(
    _is.DatabaseSession session,
    List<RewardFunding> rows, {
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardFunding>(
      rows,
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardFunding].
  Future<RewardFunding> deleteRow(
    _is.DatabaseSession session,
    RewardFunding row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardFunding>(
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
  Future<List<RewardFunding>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardFundingTable> where,
    _is.OrderByBuilder<RewardFundingTable>? orderBy,
    _is.OrderByListBuilder<RewardFundingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardFunding>(
      where: where(RewardFunding.t),
      orderBy: orderBy?.call(RewardFunding.t),
      orderByList: orderByList?.call(RewardFunding.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardFundingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardFunding>(
      where: where?.call(RewardFunding.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardFunding] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardFundingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardFunding>(
      where: where(RewardFunding.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
