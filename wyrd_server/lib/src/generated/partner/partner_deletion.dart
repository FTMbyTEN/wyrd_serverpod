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

/// A deletion a partner asked for (one conversation, or everything for a user reference), so it can be confirmed.
abstract class PartnerDeletion
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerDeletion._({
    this.id,
    required this.deletionId,
    required this.partner,
    required this.env,
    required this.what,
    required this.status,
    required this.createdAt,
    this.doneAt,
  });

  factory PartnerDeletion({
    int? id,
    required String deletionId,
    required String partner,
    required String env,
    required String what,
    required String status,
    required DateTime createdAt,
    DateTime? doneAt,
  }) = _PartnerDeletionImpl;

  factory PartnerDeletion.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerDeletion(
      id: jsonSerialization['id'] as int?,
      deletionId: jsonSerialization['deletionId'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      what: jsonSerialization['what'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  static final t = PartnerDeletionTable();

  static const db = PartnerDeletionRepository._();

  @override
  int? id;

  String deletionId;

  String partner;

  String env;

  String what;

  String status;

  DateTime createdAt;

  DateTime? doneAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerDeletion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerDeletion copyWith({
    int? id,
    String? deletionId,
    String? partner,
    String? env,
    String? what,
    String? status,
    DateTime? createdAt,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerDeletion',
      if (id != null) 'id': id,
      'deletionId': deletionId,
      'partner': partner,
      'env': env,
      'what': what,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerDeletion',
      if (id != null) 'id': id,
      'deletionId': deletionId,
      'partner': partner,
      'env': env,
      'what': what,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  static PartnerDeletionInclude include() {
    return PartnerDeletionInclude._();
  }

  static PartnerDeletionIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerDeletionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    PartnerDeletionInclude? include,
  }) {
    return PartnerDeletionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerDeletionImpl extends PartnerDeletion {
  _PartnerDeletionImpl({
    int? id,
    required String deletionId,
    required String partner,
    required String env,
    required String what,
    required String status,
    required DateTime createdAt,
    DateTime? doneAt,
  }) : super._(
         id: id,
         deletionId: deletionId,
         partner: partner,
         env: env,
         what: what,
         status: status,
         createdAt: createdAt,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [PartnerDeletion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerDeletion copyWith({
    Object? id = _Undefined,
    String? deletionId,
    String? partner,
    String? env,
    String? what,
    String? status,
    DateTime? createdAt,
    Object? doneAt = _Undefined,
  }) {
    return PartnerDeletion(
      id: id is int? ? id : this.id,
      deletionId: deletionId ?? this.deletionId,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      what: what ?? this.what,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}

class PartnerDeletionUpdateTable extends _is.UpdateTable<PartnerDeletionTable> {
  PartnerDeletionUpdateTable(super.table);

  _is.ColumnValue<String, String> deletionId(String value) => _is.ColumnValue(
    table.deletionId,
    value,
  );

  _is.ColumnValue<String, String> partner(String value) => _is.ColumnValue(
    table.partner,
    value,
  );

  _is.ColumnValue<String, String> env(String value) => _is.ColumnValue(
    table.env,
    value,
  );

  _is.ColumnValue<String, String> what(String value) => _is.ColumnValue(
    table.what,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> doneAt(DateTime? value) =>
      _is.ColumnValue(
        table.doneAt,
        value,
      );
}

class PartnerDeletionTable extends _is.Table<int?> {
  PartnerDeletionTable({super.tableRelation})
    : super(tableName: 'partner_deletion') {
    updateTable = PartnerDeletionUpdateTable(this);
    deletionId = _is.ColumnString(
      'deletionId',
      this,
    );
    partner = _is.ColumnString(
      'partner',
      this,
    );
    env = _is.ColumnString(
      'env',
      this,
    );
    what = _is.ColumnString(
      'what',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    doneAt = _is.ColumnDateTime(
      'doneAt',
      this,
    );
  }

  late final PartnerDeletionUpdateTable updateTable;

  late final _is.ColumnString deletionId;

  late final _is.ColumnString partner;

  late final _is.ColumnString env;

  late final _is.ColumnString what;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime doneAt;

  @override
  List<_is.Column> get columns => [
    id,
    deletionId,
    partner,
    env,
    what,
    status,
    createdAt,
    doneAt,
  ];
}

class PartnerDeletionInclude extends _is.IncludeObject {
  PartnerDeletionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerDeletion.t;
}

class PartnerDeletionIncludeList extends _is.IncludeList {
  PartnerDeletionIncludeList._({
    _is.WhereExpressionBuilder<PartnerDeletionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerDeletion.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerDeletion.t;
}

class PartnerDeletionRepository {
  const PartnerDeletionRepository._();

  /// Returns a list of [PartnerDeletion]s matching the given query parameters.
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
  Future<List<PartnerDeletion>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerDeletionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerDeletion>(
      where: where?.call(PartnerDeletion.t),
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerDeletion] matching the given query parameters.
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
  Future<PartnerDeletion?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerDeletionTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerDeletion>(
      where: where?.call(PartnerDeletion.t),
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerDeletion] by its [id] or null if no such row exists.
  Future<PartnerDeletion?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerDeletion>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerDeletion]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerDeletion]s will have their `id` fields set.
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
  Future<List<PartnerDeletion>> insert(
    _is.DatabaseSession session,
    List<PartnerDeletion> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerDeletion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerDeletion] and returns the inserted row.
  ///
  /// The returned [PartnerDeletion] will have its `id` field set.
  Future<PartnerDeletion> insertRow(
    _is.DatabaseSession session,
    PartnerDeletion row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerDeletion>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerDeletion]s in the list and returns the resulting rows.
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
  /// The returned [PartnerDeletion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerDeletion>> upsert(
    _is.DatabaseSession session,
    List<PartnerDeletion> rows, {
    required _is.ColumnSelections<PartnerDeletionTable> conflictColumns,
    _is.ColumnSelections<PartnerDeletionTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerDeletionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerDeletion>(
      rows,
      conflictColumns: conflictColumns(PartnerDeletion.t),
      updateColumns: updateColumns?.call(PartnerDeletion.t),
      updateWhere: updateWhere?.call(PartnerDeletion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerDeletion] and returns the resulting row.
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
  /// The returned [PartnerDeletion] will have its `id` field set.
  Future<PartnerDeletion?> upsertRow(
    _is.DatabaseSession session,
    PartnerDeletion row, {
    required _is.ColumnSelections<PartnerDeletionTable> conflictColumns,
    _is.ColumnSelections<PartnerDeletionTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerDeletionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerDeletion>(
      row,
      conflictColumns: conflictColumns(PartnerDeletion.t),
      updateColumns: updateColumns?.call(PartnerDeletion.t),
      updateWhere: updateWhere?.call(PartnerDeletion.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerDeletion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerDeletion>> update(
    _is.DatabaseSession session,
    List<PartnerDeletion> rows, {
    _is.ColumnSelections<PartnerDeletionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerDeletion>(
      rows,
      columns: columns?.call(PartnerDeletion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerDeletion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerDeletion> updateRow(
    _is.DatabaseSession session,
    PartnerDeletion row, {
    _is.ColumnSelections<PartnerDeletionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerDeletion>(
      row,
      columns: columns?.call(PartnerDeletion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerDeletion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerDeletion?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerDeletionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerDeletion>(
      id,
      columnValues: columnValues(PartnerDeletion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerDeletion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerDeletion>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerDeletionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PartnerDeletionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerDeletion>(
      columnValues: columnValues(PartnerDeletion.t.updateTable),
      where: where(PartnerDeletion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerDeletion]s in the list and returns the deleted rows.
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
  Future<List<PartnerDeletion>> delete(
    _is.DatabaseSession session,
    List<PartnerDeletion> rows, {
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerDeletion>(
      rows,
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerDeletion].
  Future<PartnerDeletion> deleteRow(
    _is.DatabaseSession session,
    PartnerDeletion row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerDeletion>(
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
  Future<List<PartnerDeletion>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerDeletionTable> where,
    _is.OrderByBuilder<PartnerDeletionTable>? orderBy,
    _is.OrderByListBuilder<PartnerDeletionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerDeletion>(
      where: where(PartnerDeletion.t),
      orderBy: orderBy?.call(PartnerDeletion.t),
      orderByList: orderByList?.call(PartnerDeletion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerDeletionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerDeletion>(
      where: where?.call(PartnerDeletion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerDeletion] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerDeletionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerDeletion>(
      where: where(PartnerDeletion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
