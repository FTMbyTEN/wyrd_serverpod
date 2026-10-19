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

/// A funded-jobs campaign: offers belong to it; pausing it stops new acceptances only (earned rewards are untouched).
abstract class FundedCampaign
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FundedCampaign._({
    this.id,
    required this.name,
    required this.status,
    required this.createdBy,
    required this.createdAt,
  });

  factory FundedCampaign({
    int? id,
    required String name,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) = _FundedCampaignImpl;

  factory FundedCampaign.fromJson(Map<String, dynamic> jsonSerialization) {
    return FundedCampaign(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FundedCampaignTable();

  static const db = FundedCampaignRepository._();

  @override
  int? id;

  String name;

  /// active | paused | closed
  String status;

  String createdBy;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FundedCampaign]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FundedCampaign copyWith({
    int? id,
    String? name,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FundedCampaign',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FundedCampaign',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  static FundedCampaignInclude include() {
    return FundedCampaignInclude._();
  }

  static FundedCampaignIncludeList includeList({
    _is.WhereExpressionBuilder<FundedCampaignTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    FundedCampaignInclude? include,
  }) {
    return FundedCampaignIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FundedCampaignImpl extends FundedCampaign {
  _FundedCampaignImpl({
    int? id,
    required String name,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         status: status,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FundedCampaign]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FundedCampaign copyWith({
    Object? id = _Undefined,
    String? name,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return FundedCampaign(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FundedCampaignUpdateTable extends _is.UpdateTable<FundedCampaignTable> {
  FundedCampaignUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
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

class FundedCampaignTable extends _is.Table<int?> {
  FundedCampaignTable({super.tableRelation})
    : super(tableName: 'funded_campaign') {
    updateTable = FundedCampaignUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    status = _is.ColumnString(
      'status',
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

  late final FundedCampaignUpdateTable updateTable;

  late final _is.ColumnString name;

  /// active | paused | closed
  late final _is.ColumnString status;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    status,
    createdBy,
    createdAt,
  ];
}

class FundedCampaignInclude extends _is.IncludeObject {
  FundedCampaignInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FundedCampaign.t;
}

class FundedCampaignIncludeList extends _is.IncludeList {
  FundedCampaignIncludeList._({
    _is.WhereExpressionBuilder<FundedCampaignTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FundedCampaign.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FundedCampaign.t;
}

class FundedCampaignRepository {
  const FundedCampaignRepository._();

  /// Returns a list of [FundedCampaign]s matching the given query parameters.
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
  Future<List<FundedCampaign>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FundedCampaignTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FundedCampaign>(
      where: where?.call(FundedCampaign.t),
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FundedCampaign] matching the given query parameters.
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
  Future<FundedCampaign?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FundedCampaignTable>? where,
    int? offset,
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FundedCampaign>(
      where: where?.call(FundedCampaign.t),
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FundedCampaign] by its [id] or null if no such row exists.
  Future<FundedCampaign?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FundedCampaign>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FundedCampaign]s in the list and returns the inserted rows.
  ///
  /// The returned [FundedCampaign]s will have their `id` fields set.
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
  Future<List<FundedCampaign>> insert(
    _is.DatabaseSession session,
    List<FundedCampaign> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FundedCampaign>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FundedCampaign] and returns the inserted row.
  ///
  /// The returned [FundedCampaign] will have its `id` field set.
  Future<FundedCampaign> insertRow(
    _is.DatabaseSession session,
    FundedCampaign row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FundedCampaign>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FundedCampaign]s in the list and returns the resulting rows.
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
  /// The returned [FundedCampaign]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FundedCampaign>> upsert(
    _is.DatabaseSession session,
    List<FundedCampaign> rows, {
    required _is.ColumnSelections<FundedCampaignTable> conflictColumns,
    _is.ColumnSelections<FundedCampaignTable>? updateColumns,
    _is.WhereExpressionBuilder<FundedCampaignTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FundedCampaign>(
      rows,
      conflictColumns: conflictColumns(FundedCampaign.t),
      updateColumns: updateColumns?.call(FundedCampaign.t),
      updateWhere: updateWhere?.call(FundedCampaign.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FundedCampaign] and returns the resulting row.
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
  /// The returned [FundedCampaign] will have its `id` field set.
  Future<FundedCampaign?> upsertRow(
    _is.DatabaseSession session,
    FundedCampaign row, {
    required _is.ColumnSelections<FundedCampaignTable> conflictColumns,
    _is.ColumnSelections<FundedCampaignTable>? updateColumns,
    _is.WhereExpressionBuilder<FundedCampaignTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FundedCampaign>(
      row,
      conflictColumns: conflictColumns(FundedCampaign.t),
      updateColumns: updateColumns?.call(FundedCampaign.t),
      updateWhere: updateWhere?.call(FundedCampaign.t),
      transaction: transaction,
    );
  }

  /// Updates all [FundedCampaign]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FundedCampaign>> update(
    _is.DatabaseSession session,
    List<FundedCampaign> rows, {
    _is.ColumnSelections<FundedCampaignTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FundedCampaign>(
      rows,
      columns: columns?.call(FundedCampaign.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FundedCampaign]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FundedCampaign> updateRow(
    _is.DatabaseSession session,
    FundedCampaign row, {
    _is.ColumnSelections<FundedCampaignTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FundedCampaign>(
      row,
      columns: columns?.call(FundedCampaign.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FundedCampaign] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FundedCampaign?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FundedCampaignUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FundedCampaign>(
      id,
      columnValues: columnValues(FundedCampaign.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FundedCampaign]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FundedCampaign>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FundedCampaignUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FundedCampaignTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FundedCampaign>(
      columnValues: columnValues(FundedCampaign.t.updateTable),
      where: where(FundedCampaign.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FundedCampaign]s in the list and returns the deleted rows.
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
  Future<List<FundedCampaign>> delete(
    _is.DatabaseSession session,
    List<FundedCampaign> rows, {
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FundedCampaign>(
      rows,
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FundedCampaign].
  Future<FundedCampaign> deleteRow(
    _is.DatabaseSession session,
    FundedCampaign row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FundedCampaign>(
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
  Future<List<FundedCampaign>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FundedCampaignTable> where,
    _is.OrderByBuilder<FundedCampaignTable>? orderBy,
    _is.OrderByListBuilder<FundedCampaignTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FundedCampaign>(
      where: where(FundedCampaign.t),
      orderBy: orderBy?.call(FundedCampaign.t),
      orderByList: orderByList?.call(FundedCampaign.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FundedCampaignTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FundedCampaign>(
      where: where?.call(FundedCampaign.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FundedCampaign] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FundedCampaignTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FundedCampaign>(
      where: where(FundedCampaign.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
