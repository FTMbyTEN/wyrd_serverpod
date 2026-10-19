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

/// Operational switches, changed by admins (audited): funded_jobs_paused (no new acceptances), payouts_paused (no new
/// payout submissions). Pausing never deletes or reduces a liability.
abstract class RewardSwitch
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardSwitch._({
    this.id,
    required this.key,
    required this.enabled,
    this.updatedBy,
    required this.updatedAt,
  });

  factory RewardSwitch({
    int? id,
    required String key,
    required bool enabled,
    _is.UuidValue? updatedBy,
    required DateTime updatedAt,
  }) = _RewardSwitchImpl;

  factory RewardSwitch.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardSwitch(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      updatedBy: jsonSerialization['updatedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['updatedBy']),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RewardSwitchTable();

  static const db = RewardSwitchRepository._();

  @override
  int? id;

  String key;

  bool enabled;

  _is.UuidValue? updatedBy;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardSwitch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardSwitch copyWith({
    int? id,
    String? key,
    bool? enabled,
    _is.UuidValue? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardSwitch',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardSwitch',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RewardSwitchInclude include() {
    return RewardSwitchInclude._();
  }

  static RewardSwitchIncludeList includeList({
    _is.WhereExpressionBuilder<RewardSwitchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    RewardSwitchInclude? include,
  }) {
    return RewardSwitchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardSwitchImpl extends RewardSwitch {
  _RewardSwitchImpl({
    int? id,
    required String key,
    required bool enabled,
    _is.UuidValue? updatedBy,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         key: key,
         enabled: enabled,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardSwitch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardSwitch copyWith({
    Object? id = _Undefined,
    String? key,
    bool? enabled,
    Object? updatedBy = _Undefined,
    DateTime? updatedAt,
  }) {
    return RewardSwitch(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      updatedBy: updatedBy is _is.UuidValue? ? updatedBy : this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RewardSwitchUpdateTable extends _is.UpdateTable<RewardSwitchTable> {
  RewardSwitchUpdateTable(super.table);

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<bool, bool> enabled(bool value) => _is.ColumnValue(
    table.enabled,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> updatedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.updatedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RewardSwitchTable extends _is.Table<int?> {
  RewardSwitchTable({super.tableRelation}) : super(tableName: 'reward_switch') {
    updateTable = RewardSwitchUpdateTable(this);
    key = _is.ColumnString(
      'key',
      this,
    );
    enabled = _is.ColumnBool(
      'enabled',
      this,
    );
    updatedBy = _is.ColumnUuid(
      'updatedBy',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RewardSwitchUpdateTable updateTable;

  late final _is.ColumnString key;

  late final _is.ColumnBool enabled;

  late final _is.ColumnUuid updatedBy;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    key,
    enabled,
    updatedBy,
    updatedAt,
  ];
}

class RewardSwitchInclude extends _is.IncludeObject {
  RewardSwitchInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardSwitch.t;
}

class RewardSwitchIncludeList extends _is.IncludeList {
  RewardSwitchIncludeList._({
    _is.WhereExpressionBuilder<RewardSwitchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardSwitch.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardSwitch.t;
}

class RewardSwitchRepository {
  const RewardSwitchRepository._();

  /// Returns a list of [RewardSwitch]s matching the given query parameters.
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
  Future<List<RewardSwitch>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardSwitchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardSwitch>(
      where: where?.call(RewardSwitch.t),
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardSwitch] matching the given query parameters.
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
  Future<RewardSwitch?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardSwitchTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardSwitch>(
      where: where?.call(RewardSwitch.t),
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardSwitch] by its [id] or null if no such row exists.
  Future<RewardSwitch?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardSwitch>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardSwitch]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardSwitch]s will have their `id` fields set.
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
  Future<List<RewardSwitch>> insert(
    _is.DatabaseSession session,
    List<RewardSwitch> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardSwitch>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardSwitch] and returns the inserted row.
  ///
  /// The returned [RewardSwitch] will have its `id` field set.
  Future<RewardSwitch> insertRow(
    _is.DatabaseSession session,
    RewardSwitch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardSwitch>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardSwitch]s in the list and returns the resulting rows.
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
  /// The returned [RewardSwitch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardSwitch>> upsert(
    _is.DatabaseSession session,
    List<RewardSwitch> rows, {
    required _is.ColumnSelections<RewardSwitchTable> conflictColumns,
    _is.ColumnSelections<RewardSwitchTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardSwitchTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardSwitch>(
      rows,
      conflictColumns: conflictColumns(RewardSwitch.t),
      updateColumns: updateColumns?.call(RewardSwitch.t),
      updateWhere: updateWhere?.call(RewardSwitch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardSwitch] and returns the resulting row.
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
  /// The returned [RewardSwitch] will have its `id` field set.
  Future<RewardSwitch?> upsertRow(
    _is.DatabaseSession session,
    RewardSwitch row, {
    required _is.ColumnSelections<RewardSwitchTable> conflictColumns,
    _is.ColumnSelections<RewardSwitchTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardSwitchTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardSwitch>(
      row,
      conflictColumns: conflictColumns(RewardSwitch.t),
      updateColumns: updateColumns?.call(RewardSwitch.t),
      updateWhere: updateWhere?.call(RewardSwitch.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardSwitch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardSwitch>> update(
    _is.DatabaseSession session,
    List<RewardSwitch> rows, {
    _is.ColumnSelections<RewardSwitchTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardSwitch>(
      rows,
      columns: columns?.call(RewardSwitch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardSwitch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardSwitch> updateRow(
    _is.DatabaseSession session,
    RewardSwitch row, {
    _is.ColumnSelections<RewardSwitchTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardSwitch>(
      row,
      columns: columns?.call(RewardSwitch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardSwitch] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardSwitch?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardSwitchUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardSwitch>(
      id,
      columnValues: columnValues(RewardSwitch.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardSwitch]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardSwitch>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardSwitchUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardSwitchTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardSwitch>(
      columnValues: columnValues(RewardSwitch.t.updateTable),
      where: where(RewardSwitch.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardSwitch]s in the list and returns the deleted rows.
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
  Future<List<RewardSwitch>> delete(
    _is.DatabaseSession session,
    List<RewardSwitch> rows, {
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardSwitch>(
      rows,
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardSwitch].
  Future<RewardSwitch> deleteRow(
    _is.DatabaseSession session,
    RewardSwitch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardSwitch>(
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
  Future<List<RewardSwitch>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardSwitchTable> where,
    _is.OrderByBuilder<RewardSwitchTable>? orderBy,
    _is.OrderByListBuilder<RewardSwitchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardSwitch>(
      where: where(RewardSwitch.t),
      orderBy: orderBy?.call(RewardSwitch.t),
      orderByList: orderByList?.call(RewardSwitch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardSwitchTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardSwitch>(
      where: where?.call(RewardSwitch.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardSwitch] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardSwitchTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardSwitch>(
      where: where(RewardSwitch.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
