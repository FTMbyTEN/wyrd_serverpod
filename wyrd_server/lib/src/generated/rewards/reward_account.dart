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

/// One account in the rewards ledger. [unit] is GN (Game Naira, whole naira) or NGN (real naira, in kobo); a journal
/// only ever moves one unit. [balance] is a cache of the account's entries, updated in the same transaction as them
/// and checked by the reconciliation report. System accounts have a fixed [code] (e.g. ngn:fund:uncommitted,
/// gn:treasury); a player's real earnings live in ngn:earn:pending:{user}, ngn:earn:available:{user} and
/// ngn:payout:inflight:{user}.
abstract class RewardAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardAccount._({
    this.id,
    required this.code,
    required this.unit,
    required this.kind,
    this.ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required this.updatedAt,
  }) : balance = balance ?? 0,
       mayGoNegative = mayGoNegative ?? false;

  factory RewardAccount({
    int? id,
    required String code,
    required String unit,
    required String kind,
    _is.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required DateTime updatedAt,
  }) = _RewardAccountImpl;

  factory RewardAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardAccount(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: jsonSerialization['kind'] as String,
      ownerUserId: jsonSerialization['ownerUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['ownerUserId'],
            ),
      balance: jsonSerialization['balance'] as int?,
      mayGoNegative: jsonSerialization['mayGoNegative'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['mayGoNegative']),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RewardAccountTable();

  static const db = RewardAccountRepository._();

  @override
  int? id;

  String code;

  /// GN | NGN
  String unit;

  /// fund | reserve | earnings | payout | treasury | source | sink
  String kind;

  _is.UuidValue? ownerUserId;

  /// in the unit's minor units (GN: naira, NGN: kobo)
  int balance;

  /// only source accounts (external money in, authorised issuance) may go below zero
  bool mayGoNegative;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardAccount copyWith({
    int? id,
    String? code,
    String? unit,
    String? kind,
    _is.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardAccount',
      if (id != null) 'id': id,
      'code': code,
      'unit': unit,
      'kind': kind,
      if (ownerUserId != null) 'ownerUserId': ownerUserId?.toJson(),
      'balance': balance,
      'mayGoNegative': mayGoNegative,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardAccount',
      if (id != null) 'id': id,
      'code': code,
      'unit': unit,
      'kind': kind,
      if (ownerUserId != null) 'ownerUserId': ownerUserId?.toJson(),
      'balance': balance,
      'mayGoNegative': mayGoNegative,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RewardAccountInclude include() {
    return RewardAccountInclude._();
  }

  static RewardAccountIncludeList includeList({
    _is.WhereExpressionBuilder<RewardAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    RewardAccountInclude? include,
  }) {
    return RewardAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardAccountImpl extends RewardAccount {
  _RewardAccountImpl({
    int? id,
    required String code,
    required String unit,
    required String kind,
    _is.UuidValue? ownerUserId,
    int? balance,
    bool? mayGoNegative,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         code: code,
         unit: unit,
         kind: kind,
         ownerUserId: ownerUserId,
         balance: balance,
         mayGoNegative: mayGoNegative,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardAccount copyWith({
    Object? id = _Undefined,
    String? code,
    String? unit,
    String? kind,
    Object? ownerUserId = _Undefined,
    int? balance,
    bool? mayGoNegative,
    DateTime? updatedAt,
  }) {
    return RewardAccount(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      ownerUserId: ownerUserId is _is.UuidValue?
          ? ownerUserId
          : this.ownerUserId,
      balance: balance ?? this.balance,
      mayGoNegative: mayGoNegative ?? this.mayGoNegative,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RewardAccountUpdateTable extends _is.UpdateTable<RewardAccountTable> {
  RewardAccountUpdateTable(super.table);

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
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

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.ownerUserId,
    value,
  );

  _is.ColumnValue<int, int> balance(int value) => _is.ColumnValue(
    table.balance,
    value,
  );

  _is.ColumnValue<bool, bool> mayGoNegative(bool value) => _is.ColumnValue(
    table.mayGoNegative,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RewardAccountTable extends _is.Table<int?> {
  RewardAccountTable({super.tableRelation})
    : super(tableName: 'reward_account') {
    updateTable = RewardAccountUpdateTable(this);
    code = _is.ColumnString(
      'code',
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
    ownerUserId = _is.ColumnUuid(
      'ownerUserId',
      this,
    );
    balance = _is.ColumnInt(
      'balance',
      this,
      hasDefault: true,
    );
    mayGoNegative = _is.ColumnBool(
      'mayGoNegative',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RewardAccountUpdateTable updateTable;

  late final _is.ColumnString code;

  /// GN | NGN
  late final _is.ColumnString unit;

  /// fund | reserve | earnings | payout | treasury | source | sink
  late final _is.ColumnString kind;

  late final _is.ColumnUuid ownerUserId;

  /// in the unit's minor units (GN: naira, NGN: kobo)
  late final _is.ColumnInt balance;

  /// only source accounts (external money in, authorised issuance) may go below zero
  late final _is.ColumnBool mayGoNegative;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    code,
    unit,
    kind,
    ownerUserId,
    balance,
    mayGoNegative,
    updatedAt,
  ];
}

class RewardAccountInclude extends _is.IncludeObject {
  RewardAccountInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardAccount.t;
}

class RewardAccountIncludeList extends _is.IncludeList {
  RewardAccountIncludeList._({
    _is.WhereExpressionBuilder<RewardAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardAccount.t;
}

class RewardAccountRepository {
  const RewardAccountRepository._();

  /// Returns a list of [RewardAccount]s matching the given query parameters.
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
  Future<List<RewardAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardAccount>(
      where: where?.call(RewardAccount.t),
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardAccount] matching the given query parameters.
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
  Future<RewardAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardAccount>(
      where: where?.call(RewardAccount.t),
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardAccount] by its [id] or null if no such row exists.
  Future<RewardAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardAccount]s will have their `id` fields set.
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
  Future<List<RewardAccount>> insert(
    _is.DatabaseSession session,
    List<RewardAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardAccount] and returns the inserted row.
  ///
  /// The returned [RewardAccount] will have its `id` field set.
  Future<RewardAccount> insertRow(
    _is.DatabaseSession session,
    RewardAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardAccount]s in the list and returns the resulting rows.
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
  /// The returned [RewardAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardAccount>> upsert(
    _is.DatabaseSession session,
    List<RewardAccount> rows, {
    required _is.ColumnSelections<RewardAccountTable> conflictColumns,
    _is.ColumnSelections<RewardAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardAccount>(
      rows,
      conflictColumns: conflictColumns(RewardAccount.t),
      updateColumns: updateColumns?.call(RewardAccount.t),
      updateWhere: updateWhere?.call(RewardAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardAccount] and returns the resulting row.
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
  /// The returned [RewardAccount] will have its `id` field set.
  Future<RewardAccount?> upsertRow(
    _is.DatabaseSession session,
    RewardAccount row, {
    required _is.ColumnSelections<RewardAccountTable> conflictColumns,
    _is.ColumnSelections<RewardAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardAccount>(
      row,
      conflictColumns: conflictColumns(RewardAccount.t),
      updateColumns: updateColumns?.call(RewardAccount.t),
      updateWhere: updateWhere?.call(RewardAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardAccount>> update(
    _is.DatabaseSession session,
    List<RewardAccount> rows, {
    _is.ColumnSelections<RewardAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardAccount>(
      rows,
      columns: columns?.call(RewardAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardAccount> updateRow(
    _is.DatabaseSession session,
    RewardAccount row, {
    _is.ColumnSelections<RewardAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardAccount>(
      row,
      columns: columns?.call(RewardAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardAccountUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardAccount>(
      id,
      columnValues: columnValues(RewardAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardAccountUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardAccount>(
      columnValues: columnValues(RewardAccount.t.updateTable),
      where: where(RewardAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardAccount]s in the list and returns the deleted rows.
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
  Future<List<RewardAccount>> delete(
    _is.DatabaseSession session,
    List<RewardAccount> rows, {
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardAccount>(
      rows,
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardAccount].
  Future<RewardAccount> deleteRow(
    _is.DatabaseSession session,
    RewardAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardAccount>(
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
  Future<List<RewardAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardAccountTable> where,
    _is.OrderByBuilder<RewardAccountTable>? orderBy,
    _is.OrderByListBuilder<RewardAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardAccount>(
      where: where(RewardAccount.t),
      orderBy: orderBy?.call(RewardAccount.t),
      orderByList: orderByList?.call(RewardAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardAccount>(
      where: where?.call(RewardAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardAccount>(
      where: where(RewardAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
