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

/// A versioned reward policy. Once a job offer uses a version it is never changed; a new policy is a new version.
/// The cash share is in basis points of the reward basis (1 basis unit = 1 naira), the cash rounded down to the whole naira.
abstract class RewardPolicy
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardPolicy._({
    this.id,
    required this.version,
    required this.cashShareBp,
    required this.feeAllowanceKobo,
    required this.holdHours,
    required this.createdBy,
    required this.createdAt,
  });

  factory RewardPolicy({
    int? id,
    required int version,
    required int cashShareBp,
    required int feeAllowanceKobo,
    required int holdHours,
    required String createdBy,
    required DateTime createdAt,
  }) = _RewardPolicyImpl;

  factory RewardPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardPolicy(
      id: jsonSerialization['id'] as int?,
      version: jsonSerialization['version'] as int,
      cashShareBp: jsonSerialization['cashShareBp'] as int,
      feeAllowanceKobo: jsonSerialization['feeAllowanceKobo'] as int,
      holdHours: jsonSerialization['holdHours'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RewardPolicyTable();

  static const db = RewardPolicyRepository._();

  @override
  int? id;

  int version;

  /// 167 = 1.67%
  int cashShareBp;

  /// payout-cost allowance reserved with each cash reward, in kobo
  int feeAllowanceKobo;

  /// how long a cash reward stays pending (the verification hold) before it can be withdrawn
  int holdHours;

  String createdBy;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardPolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardPolicy copyWith({
    int? id,
    int? version,
    int? cashShareBp,
    int? feeAllowanceKobo,
    int? holdHours,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardPolicy',
      if (id != null) 'id': id,
      'version': version,
      'cashShareBp': cashShareBp,
      'feeAllowanceKobo': feeAllowanceKobo,
      'holdHours': holdHours,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardPolicy',
      if (id != null) 'id': id,
      'version': version,
      'cashShareBp': cashShareBp,
      'feeAllowanceKobo': feeAllowanceKobo,
      'holdHours': holdHours,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardPolicyInclude include() {
    return RewardPolicyInclude._();
  }

  static RewardPolicyIncludeList includeList({
    _is.WhereExpressionBuilder<RewardPolicyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    RewardPolicyInclude? include,
  }) {
    return RewardPolicyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardPolicyImpl extends RewardPolicy {
  _RewardPolicyImpl({
    int? id,
    required int version,
    required int cashShareBp,
    required int feeAllowanceKobo,
    required int holdHours,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         version: version,
         cashShareBp: cashShareBp,
         feeAllowanceKobo: feeAllowanceKobo,
         holdHours: holdHours,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardPolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardPolicy copyWith({
    Object? id = _Undefined,
    int? version,
    int? cashShareBp,
    int? feeAllowanceKobo,
    int? holdHours,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return RewardPolicy(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      cashShareBp: cashShareBp ?? this.cashShareBp,
      feeAllowanceKobo: feeAllowanceKobo ?? this.feeAllowanceKobo,
      holdHours: holdHours ?? this.holdHours,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardPolicyUpdateTable extends _is.UpdateTable<RewardPolicyTable> {
  RewardPolicyUpdateTable(super.table);

  _is.ColumnValue<int, int> version(int value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<int, int> cashShareBp(int value) => _is.ColumnValue(
    table.cashShareBp,
    value,
  );

  _is.ColumnValue<int, int> feeAllowanceKobo(int value) => _is.ColumnValue(
    table.feeAllowanceKobo,
    value,
  );

  _is.ColumnValue<int, int> holdHours(int value) => _is.ColumnValue(
    table.holdHours,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RewardPolicyTable extends _is.Table<int?> {
  RewardPolicyTable({super.tableRelation}) : super(tableName: 'reward_policy') {
    updateTable = RewardPolicyUpdateTable(this);
    version = _is.ColumnInt(
      'version',
      this,
    );
    cashShareBp = _is.ColumnInt(
      'cashShareBp',
      this,
    );
    feeAllowanceKobo = _is.ColumnInt(
      'feeAllowanceKobo',
      this,
    );
    holdHours = _is.ColumnInt(
      'holdHours',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RewardPolicyUpdateTable updateTable;

  late final _is.ColumnInt version;

  /// 167 = 1.67%
  late final _is.ColumnInt cashShareBp;

  /// payout-cost allowance reserved with each cash reward, in kobo
  late final _is.ColumnInt feeAllowanceKobo;

  /// how long a cash reward stays pending (the verification hold) before it can be withdrawn
  late final _is.ColumnInt holdHours;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    version,
    cashShareBp,
    feeAllowanceKobo,
    holdHours,
    createdBy,
    createdAt,
  ];
}

class RewardPolicyInclude extends _is.IncludeObject {
  RewardPolicyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardPolicy.t;
}

class RewardPolicyIncludeList extends _is.IncludeList {
  RewardPolicyIncludeList._({
    _is.WhereExpressionBuilder<RewardPolicyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardPolicy.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardPolicy.t;
}

class RewardPolicyRepository {
  const RewardPolicyRepository._();

  /// Returns a list of [RewardPolicy]s matching the given query parameters.
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
  Future<List<RewardPolicy>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPolicyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardPolicy>(
      where: where?.call(RewardPolicy.t),
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardPolicy] matching the given query parameters.
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
  Future<RewardPolicy?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPolicyTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardPolicy>(
      where: where?.call(RewardPolicy.t),
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardPolicy] by its [id] or null if no such row exists.
  Future<RewardPolicy?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardPolicy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardPolicy]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardPolicy]s will have their `id` fields set.
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
  Future<List<RewardPolicy>> insert(
    _is.DatabaseSession session,
    List<RewardPolicy> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardPolicy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardPolicy] and returns the inserted row.
  ///
  /// The returned [RewardPolicy] will have its `id` field set.
  Future<RewardPolicy> insertRow(
    _is.DatabaseSession session,
    RewardPolicy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardPolicy>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardPolicy]s in the list and returns the resulting rows.
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
  /// The returned [RewardPolicy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPolicy>> upsert(
    _is.DatabaseSession session,
    List<RewardPolicy> rows, {
    required _is.ColumnSelections<RewardPolicyTable> conflictColumns,
    _is.ColumnSelections<RewardPolicyTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardPolicyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardPolicy>(
      rows,
      conflictColumns: conflictColumns(RewardPolicy.t),
      updateColumns: updateColumns?.call(RewardPolicy.t),
      updateWhere: updateWhere?.call(RewardPolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardPolicy] and returns the resulting row.
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
  /// The returned [RewardPolicy] will have its `id` field set.
  Future<RewardPolicy?> upsertRow(
    _is.DatabaseSession session,
    RewardPolicy row, {
    required _is.ColumnSelections<RewardPolicyTable> conflictColumns,
    _is.ColumnSelections<RewardPolicyTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardPolicyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardPolicy>(
      row,
      conflictColumns: conflictColumns(RewardPolicy.t),
      updateColumns: updateColumns?.call(RewardPolicy.t),
      updateWhere: updateWhere?.call(RewardPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardPolicy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPolicy>> update(
    _is.DatabaseSession session,
    List<RewardPolicy> rows, {
    _is.ColumnSelections<RewardPolicyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardPolicy>(
      rows,
      columns: columns?.call(RewardPolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardPolicy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardPolicy> updateRow(
    _is.DatabaseSession session,
    RewardPolicy row, {
    _is.ColumnSelections<RewardPolicyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardPolicy>(
      row,
      columns: columns?.call(RewardPolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardPolicy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardPolicy?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardPolicyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardPolicy>(
      id,
      columnValues: columnValues(RewardPolicy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardPolicy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPolicy>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardPolicyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardPolicyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardPolicy>(
      columnValues: columnValues(RewardPolicy.t.updateTable),
      where: where(RewardPolicy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardPolicy]s in the list and returns the deleted rows.
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
  Future<List<RewardPolicy>> delete(
    _is.DatabaseSession session,
    List<RewardPolicy> rows, {
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardPolicy>(
      rows,
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardPolicy].
  Future<RewardPolicy> deleteRow(
    _is.DatabaseSession session,
    RewardPolicy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardPolicy>(
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
  Future<List<RewardPolicy>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardPolicyTable> where,
    _is.OrderByBuilder<RewardPolicyTable>? orderBy,
    _is.OrderByListBuilder<RewardPolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardPolicy>(
      where: where(RewardPolicy.t),
      orderBy: orderBy?.call(RewardPolicy.t),
      orderByList: orderByList?.call(RewardPolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPolicyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardPolicy>(
      where: where?.call(RewardPolicy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardPolicy] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardPolicyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardPolicy>(
      where: where(RewardPolicy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
