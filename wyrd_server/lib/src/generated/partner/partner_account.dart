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

/// What a partner has paid for in one environment: staging is an allowance (requests and an end date); production
/// has no allowance (null) and is billed on usage.
abstract class PartnerAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerAccount._({
    this.id,
    required this.partner,
    required this.env,
    this.allowance,
    int? used,
    this.validUntil,
    this.note,
    required this.createdAt,
  }) : used = used ?? 0;

  factory PartnerAccount({
    int? id,
    required String partner,
    required String env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    required DateTime createdAt,
  }) = _PartnerAccountImpl;

  factory PartnerAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerAccount(
      id: jsonSerialization['id'] as int?,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      allowance: jsonSerialization['allowance'] as int?,
      used: jsonSerialization['used'] as int?,
      validUntil: jsonSerialization['validUntil'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['validUntil']),
      note: jsonSerialization['note'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PartnerAccountTable();

  static const db = PartnerAccountRepository._();

  @override
  int? id;

  String partner;

  String env;

  int? allowance;

  int used;

  DateTime? validUntil;

  /// how it was paid for (the owner's note), for the record
  String? note;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerAccount copyWith({
    int? id,
    String? partner,
    String? env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerAccount',
      if (id != null) 'id': id,
      'partner': partner,
      'env': env,
      if (allowance != null) 'allowance': allowance,
      'used': used,
      if (validUntil != null) 'validUntil': validUntil?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerAccount',
      if (id != null) 'id': id,
      'partner': partner,
      'env': env,
      if (allowance != null) 'allowance': allowance,
      'used': used,
      if (validUntil != null) 'validUntil': validUntil?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static PartnerAccountInclude include() {
    return PartnerAccountInclude._();
  }

  static PartnerAccountIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    PartnerAccountInclude? include,
  }) {
    return PartnerAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerAccountImpl extends PartnerAccount {
  _PartnerAccountImpl({
    int? id,
    required String partner,
    required String env,
    int? allowance,
    int? used,
    DateTime? validUntil,
    String? note,
    required DateTime createdAt,
  }) : super._(
         id: id,
         partner: partner,
         env: env,
         allowance: allowance,
         used: used,
         validUntil: validUntil,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PartnerAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerAccount copyWith({
    Object? id = _Undefined,
    String? partner,
    String? env,
    Object? allowance = _Undefined,
    int? used,
    Object? validUntil = _Undefined,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return PartnerAccount(
      id: id is int? ? id : this.id,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      allowance: allowance is int? ? allowance : this.allowance,
      used: used ?? this.used,
      validUntil: validUntil is DateTime? ? validUntil : this.validUntil,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PartnerAccountUpdateTable extends _is.UpdateTable<PartnerAccountTable> {
  PartnerAccountUpdateTable(super.table);

  _is.ColumnValue<String, String> partner(String value) => _is.ColumnValue(
    table.partner,
    value,
  );

  _is.ColumnValue<String, String> env(String value) => _is.ColumnValue(
    table.env,
    value,
  );

  _is.ColumnValue<int, int> allowance(int? value) => _is.ColumnValue(
    table.allowance,
    value,
  );

  _is.ColumnValue<int, int> used(int value) => _is.ColumnValue(
    table.used,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> validUntil(DateTime? value) =>
      _is.ColumnValue(
        table.validUntil,
        value,
      );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PartnerAccountTable extends _is.Table<int?> {
  PartnerAccountTable({super.tableRelation})
    : super(tableName: 'partner_account') {
    updateTable = PartnerAccountUpdateTable(this);
    partner = _is.ColumnString(
      'partner',
      this,
    );
    env = _is.ColumnString(
      'env',
      this,
    );
    allowance = _is.ColumnInt(
      'allowance',
      this,
    );
    used = _is.ColumnInt(
      'used',
      this,
      hasDefault: true,
    );
    validUntil = _is.ColumnDateTime(
      'validUntil',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PartnerAccountUpdateTable updateTable;

  late final _is.ColumnString partner;

  late final _is.ColumnString env;

  late final _is.ColumnInt allowance;

  late final _is.ColumnInt used;

  late final _is.ColumnDateTime validUntil;

  /// how it was paid for (the owner's note), for the record
  late final _is.ColumnString note;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    partner,
    env,
    allowance,
    used,
    validUntil,
    note,
    createdAt,
  ];
}

class PartnerAccountInclude extends _is.IncludeObject {
  PartnerAccountInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerAccount.t;
}

class PartnerAccountIncludeList extends _is.IncludeList {
  PartnerAccountIncludeList._({
    _is.WhereExpressionBuilder<PartnerAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerAccount.t;
}

class PartnerAccountRepository {
  const PartnerAccountRepository._();

  /// Returns a list of [PartnerAccount]s matching the given query parameters.
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
  Future<List<PartnerAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerAccount>(
      where: where?.call(PartnerAccount.t),
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerAccount] matching the given query parameters.
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
  Future<PartnerAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerAccount>(
      where: where?.call(PartnerAccount.t),
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerAccount] by its [id] or null if no such row exists.
  Future<PartnerAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerAccount]s will have their `id` fields set.
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
  Future<List<PartnerAccount>> insert(
    _is.DatabaseSession session,
    List<PartnerAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerAccount] and returns the inserted row.
  ///
  /// The returned [PartnerAccount] will have its `id` field set.
  Future<PartnerAccount> insertRow(
    _is.DatabaseSession session,
    PartnerAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerAccount]s in the list and returns the resulting rows.
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
  /// The returned [PartnerAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerAccount>> upsert(
    _is.DatabaseSession session,
    List<PartnerAccount> rows, {
    required _is.ColumnSelections<PartnerAccountTable> conflictColumns,
    _is.ColumnSelections<PartnerAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerAccount>(
      rows,
      conflictColumns: conflictColumns(PartnerAccount.t),
      updateColumns: updateColumns?.call(PartnerAccount.t),
      updateWhere: updateWhere?.call(PartnerAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerAccount] and returns the resulting row.
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
  /// The returned [PartnerAccount] will have its `id` field set.
  Future<PartnerAccount?> upsertRow(
    _is.DatabaseSession session,
    PartnerAccount row, {
    required _is.ColumnSelections<PartnerAccountTable> conflictColumns,
    _is.ColumnSelections<PartnerAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerAccount>(
      row,
      conflictColumns: conflictColumns(PartnerAccount.t),
      updateColumns: updateColumns?.call(PartnerAccount.t),
      updateWhere: updateWhere?.call(PartnerAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerAccount>> update(
    _is.DatabaseSession session,
    List<PartnerAccount> rows, {
    _is.ColumnSelections<PartnerAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerAccount>(
      rows,
      columns: columns?.call(PartnerAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerAccount> updateRow(
    _is.DatabaseSession session,
    PartnerAccount row, {
    _is.ColumnSelections<PartnerAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerAccount>(
      row,
      columns: columns?.call(PartnerAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerAccountUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerAccount>(
      id,
      columnValues: columnValues(PartnerAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerAccountUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PartnerAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerAccount>(
      columnValues: columnValues(PartnerAccount.t.updateTable),
      where: where(PartnerAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerAccount]s in the list and returns the deleted rows.
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
  Future<List<PartnerAccount>> delete(
    _is.DatabaseSession session,
    List<PartnerAccount> rows, {
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerAccount>(
      rows,
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerAccount].
  Future<PartnerAccount> deleteRow(
    _is.DatabaseSession session,
    PartnerAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerAccount>(
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
  Future<List<PartnerAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerAccountTable> where,
    _is.OrderByBuilder<PartnerAccountTable>? orderBy,
    _is.OrderByListBuilder<PartnerAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerAccount>(
      where: where(PartnerAccount.t),
      orderBy: orderBy?.call(PartnerAccount.t),
      orderByList: orderByList?.call(PartnerAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerAccount>(
      where: where?.call(PartnerAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerAccount>(
      where: where(PartnerAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
