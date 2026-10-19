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

/// A withdrawal of available real earnings. [amountKobo] leaves the available earnings (the gross debit); [feeKobo]
/// is the provider fee; [feePayer] says who bears it (player: they receive amount - fee; house: paid from the fee
/// allowance). An unknown outcome stays in flight until reconciled -- never retried under a new ref.
abstract class RewardWithdrawal
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardWithdrawal._({
    this.id,
    required this.authUserId,
    required this.amountKobo,
    required this.feeKobo,
    required this.feePayer,
    required this.ref,
    required this.idemKey,
    required this.status,
    required this.provider,
    this.providerRef,
    required this.beneficiary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RewardWithdrawal({
    int? id,
    required _is.UuidValue authUserId,
    required int amountKobo,
    required int feeKobo,
    required String feePayer,
    required String ref,
    required String idemKey,
    required String status,
    required String provider,
    String? providerRef,
    required String beneficiary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RewardWithdrawalImpl;

  factory RewardWithdrawal.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardWithdrawal(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      amountKobo: jsonSerialization['amountKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      feePayer: jsonSerialization['feePayer'] as String,
      ref: jsonSerialization['ref'] as String,
      idemKey: jsonSerialization['idemKey'] as String,
      status: jsonSerialization['status'] as String,
      provider: jsonSerialization['provider'] as String,
      providerRef: jsonSerialization['providerRef'] as String?,
      beneficiary: jsonSerialization['beneficiary'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RewardWithdrawalTable();

  static const db = RewardWithdrawalRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  int amountKobo;

  int feeKobo;

  String feePayer;

  String ref;

  String idemKey;

  /// requested | submitted | pending | paid | failed | returned | unknown
  String status;

  String provider;

  String? providerRef;

  String beneficiary;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardWithdrawal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardWithdrawal copyWith({
    int? id,
    _is.UuidValue? authUserId,
    int? amountKobo,
    int? feeKobo,
    String? feePayer,
    String? ref,
    String? idemKey,
    String? status,
    String? provider,
    String? providerRef,
    String? beneficiary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardWithdrawal',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'amountKobo': amountKobo,
      'feeKobo': feeKobo,
      'feePayer': feePayer,
      'ref': ref,
      'idemKey': idemKey,
      'status': status,
      'provider': provider,
      if (providerRef != null) 'providerRef': providerRef,
      'beneficiary': beneficiary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardWithdrawal',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'amountKobo': amountKobo,
      'feeKobo': feeKobo,
      'feePayer': feePayer,
      'ref': ref,
      'idemKey': idemKey,
      'status': status,
      'provider': provider,
      if (providerRef != null) 'providerRef': providerRef,
      'beneficiary': beneficiary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RewardWithdrawalInclude include() {
    return RewardWithdrawalInclude._();
  }

  static RewardWithdrawalIncludeList includeList({
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    RewardWithdrawalInclude? include,
  }) {
    return RewardWithdrawalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardWithdrawalImpl extends RewardWithdrawal {
  _RewardWithdrawalImpl({
    int? id,
    required _is.UuidValue authUserId,
    required int amountKobo,
    required int feeKobo,
    required String feePayer,
    required String ref,
    required String idemKey,
    required String status,
    required String provider,
    String? providerRef,
    required String beneficiary,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         amountKobo: amountKobo,
         feeKobo: feeKobo,
         feePayer: feePayer,
         ref: ref,
         idemKey: idemKey,
         status: status,
         provider: provider,
         providerRef: providerRef,
         beneficiary: beneficiary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardWithdrawal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardWithdrawal copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    int? amountKobo,
    int? feeKobo,
    String? feePayer,
    String? ref,
    String? idemKey,
    String? status,
    String? provider,
    Object? providerRef = _Undefined,
    String? beneficiary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RewardWithdrawal(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      amountKobo: amountKobo ?? this.amountKobo,
      feeKobo: feeKobo ?? this.feeKobo,
      feePayer: feePayer ?? this.feePayer,
      ref: ref ?? this.ref,
      idemKey: idemKey ?? this.idemKey,
      status: status ?? this.status,
      provider: provider ?? this.provider,
      providerRef: providerRef is String? ? providerRef : this.providerRef,
      beneficiary: beneficiary ?? this.beneficiary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RewardWithdrawalUpdateTable
    extends _is.UpdateTable<RewardWithdrawalTable> {
  RewardWithdrawalUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> amountKobo(int value) => _is.ColumnValue(
    table.amountKobo,
    value,
  );

  _is.ColumnValue<int, int> feeKobo(int value) => _is.ColumnValue(
    table.feeKobo,
    value,
  );

  _is.ColumnValue<String, String> feePayer(String value) => _is.ColumnValue(
    table.feePayer,
    value,
  );

  _is.ColumnValue<String, String> ref(String value) => _is.ColumnValue(
    table.ref,
    value,
  );

  _is.ColumnValue<String, String> idemKey(String value) => _is.ColumnValue(
    table.idemKey,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> providerRef(String? value) => _is.ColumnValue(
    table.providerRef,
    value,
  );

  _is.ColumnValue<String, String> beneficiary(String value) => _is.ColumnValue(
    table.beneficiary,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RewardWithdrawalTable extends _is.Table<int?> {
  RewardWithdrawalTable({super.tableRelation})
    : super(tableName: 'reward_withdrawal') {
    updateTable = RewardWithdrawalUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    amountKobo = _is.ColumnInt(
      'amountKobo',
      this,
    );
    feeKobo = _is.ColumnInt(
      'feeKobo',
      this,
    );
    feePayer = _is.ColumnString(
      'feePayer',
      this,
    );
    ref = _is.ColumnString(
      'ref',
      this,
    );
    idemKey = _is.ColumnString(
      'idemKey',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    provider = _is.ColumnString(
      'provider',
      this,
    );
    providerRef = _is.ColumnString(
      'providerRef',
      this,
    );
    beneficiary = _is.ColumnString(
      'beneficiary',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RewardWithdrawalUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt amountKobo;

  late final _is.ColumnInt feeKobo;

  late final _is.ColumnString feePayer;

  late final _is.ColumnString ref;

  late final _is.ColumnString idemKey;

  /// requested | submitted | pending | paid | failed | returned | unknown
  late final _is.ColumnString status;

  late final _is.ColumnString provider;

  late final _is.ColumnString providerRef;

  late final _is.ColumnString beneficiary;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    amountKobo,
    feeKobo,
    feePayer,
    ref,
    idemKey,
    status,
    provider,
    providerRef,
    beneficiary,
    createdAt,
    updatedAt,
  ];
}

class RewardWithdrawalInclude extends _is.IncludeObject {
  RewardWithdrawalInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardWithdrawal.t;
}

class RewardWithdrawalIncludeList extends _is.IncludeList {
  RewardWithdrawalIncludeList._({
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardWithdrawal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardWithdrawal.t;
}

class RewardWithdrawalRepository {
  const RewardWithdrawalRepository._();

  /// Returns a list of [RewardWithdrawal]s matching the given query parameters.
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
  Future<List<RewardWithdrawal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardWithdrawal>(
      where: where?.call(RewardWithdrawal.t),
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardWithdrawal] matching the given query parameters.
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
  Future<RewardWithdrawal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardWithdrawal>(
      where: where?.call(RewardWithdrawal.t),
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardWithdrawal] by its [id] or null if no such row exists.
  Future<RewardWithdrawal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardWithdrawal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardWithdrawal]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardWithdrawal]s will have their `id` fields set.
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
  Future<List<RewardWithdrawal>> insert(
    _is.DatabaseSession session,
    List<RewardWithdrawal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardWithdrawal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardWithdrawal] and returns the inserted row.
  ///
  /// The returned [RewardWithdrawal] will have its `id` field set.
  Future<RewardWithdrawal> insertRow(
    _is.DatabaseSession session,
    RewardWithdrawal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardWithdrawal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardWithdrawal]s in the list and returns the resulting rows.
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
  /// The returned [RewardWithdrawal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardWithdrawal>> upsert(
    _is.DatabaseSession session,
    List<RewardWithdrawal> rows, {
    required _is.ColumnSelections<RewardWithdrawalTable> conflictColumns,
    _is.ColumnSelections<RewardWithdrawalTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardWithdrawal>(
      rows,
      conflictColumns: conflictColumns(RewardWithdrawal.t),
      updateColumns: updateColumns?.call(RewardWithdrawal.t),
      updateWhere: updateWhere?.call(RewardWithdrawal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardWithdrawal] and returns the resulting row.
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
  /// The returned [RewardWithdrawal] will have its `id` field set.
  Future<RewardWithdrawal?> upsertRow(
    _is.DatabaseSession session,
    RewardWithdrawal row, {
    required _is.ColumnSelections<RewardWithdrawalTable> conflictColumns,
    _is.ColumnSelections<RewardWithdrawalTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardWithdrawal>(
      row,
      conflictColumns: conflictColumns(RewardWithdrawal.t),
      updateColumns: updateColumns?.call(RewardWithdrawal.t),
      updateWhere: updateWhere?.call(RewardWithdrawal.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardWithdrawal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardWithdrawal>> update(
    _is.DatabaseSession session,
    List<RewardWithdrawal> rows, {
    _is.ColumnSelections<RewardWithdrawalTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardWithdrawal>(
      rows,
      columns: columns?.call(RewardWithdrawal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardWithdrawal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardWithdrawal> updateRow(
    _is.DatabaseSession session,
    RewardWithdrawal row, {
    _is.ColumnSelections<RewardWithdrawalTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardWithdrawal>(
      row,
      columns: columns?.call(RewardWithdrawal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardWithdrawal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardWithdrawal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardWithdrawalUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardWithdrawal>(
      id,
      columnValues: columnValues(RewardWithdrawal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardWithdrawal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardWithdrawal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardWithdrawalUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RewardWithdrawalTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardWithdrawal>(
      columnValues: columnValues(RewardWithdrawal.t.updateTable),
      where: where(RewardWithdrawal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardWithdrawal]s in the list and returns the deleted rows.
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
  Future<List<RewardWithdrawal>> delete(
    _is.DatabaseSession session,
    List<RewardWithdrawal> rows, {
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardWithdrawal>(
      rows,
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardWithdrawal].
  Future<RewardWithdrawal> deleteRow(
    _is.DatabaseSession session,
    RewardWithdrawal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardWithdrawal>(
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
  Future<List<RewardWithdrawal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardWithdrawalTable> where,
    _is.OrderByBuilder<RewardWithdrawalTable>? orderBy,
    _is.OrderByListBuilder<RewardWithdrawalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardWithdrawal>(
      where: where(RewardWithdrawal.t),
      orderBy: orderBy?.call(RewardWithdrawal.t),
      orderByList: orderByList?.call(RewardWithdrawal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardWithdrawalTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardWithdrawal>(
      where: where?.call(RewardWithdrawal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardWithdrawal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardWithdrawalTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardWithdrawal>(
      where: where(RewardWithdrawal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
