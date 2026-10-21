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

/// Naira bought with real money through Flutterwave. Created pending when checkout starts; credited exactly once, after
/// the server itself has asked Flutterwave that the payment succeeded for the right amount.
abstract class IslandTopUp
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandTopUp._({
    this.id,
    required this.authUserId,
    required this.txRef,
    required this.pack,
    required this.amountNgn,
    required this.naira,
    required this.status,
    this.flwId,
    this.flwAccount,
    this.payTo,
    required this.createdAt,
    this.paidAt,
  });

  factory IslandTopUp({
    int? id,
    required _is.UuidValue authUserId,
    required String txRef,
    required String pack,
    required int amountNgn,
    required int naira,
    required String status,
    String? flwId,
    String? flwAccount,
    String? payTo,
    required DateTime createdAt,
    DateTime? paidAt,
  }) = _IslandTopUpImpl;

  factory IslandTopUp.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandTopUp(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      txRef: jsonSerialization['txRef'] as String,
      pack: jsonSerialization['pack'] as String,
      amountNgn: jsonSerialization['amountNgn'] as int,
      naira: jsonSerialization['naira'] as int,
      status: jsonSerialization['status'] as String,
      flwId: jsonSerialization['flwId'] as String?,
      flwAccount: jsonSerialization['flwAccount'] as String?,
      payTo: jsonSerialization['payTo'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
    );
  }

  static final t = IslandTopUpTable();

  static const db = IslandTopUpRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// our reference for the payment (Flutterwave's tx_ref)
  String txRef;

  String pack;

  /// what the player pays, in real naira
  int amountNgn;

  /// what lands in their game wallet
  int naira;

  /// pending, paid or failed
  String status;

  /// Flutterwave's own id for the transaction, once it reports one
  String? flwId;

  /// Flutterwave v4: the one-time virtual account this purchase is paid into (van_...)
  String? flwAccount;

  /// where to pay it, as shown to the player (JSON: account, bank, amount, expires)
  String? payTo;

  DateTime createdAt;

  DateTime? paidAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandTopUp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandTopUp copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? txRef,
    String? pack,
    int? amountNgn,
    int? naira,
    String? status,
    String? flwId,
    String? flwAccount,
    String? payTo,
    DateTime? createdAt,
    DateTime? paidAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandTopUp',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'txRef': txRef,
      'pack': pack,
      'amountNgn': amountNgn,
      'naira': naira,
      'status': status,
      if (flwId != null) 'flwId': flwId,
      if (flwAccount != null) 'flwAccount': flwAccount,
      if (payTo != null) 'payTo': payTo,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandTopUp',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'txRef': txRef,
      'pack': pack,
      'amountNgn': amountNgn,
      'naira': naira,
      'status': status,
      if (flwId != null) 'flwId': flwId,
      if (flwAccount != null) 'flwAccount': flwAccount,
      if (payTo != null) 'payTo': payTo,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
    };
  }

  static IslandTopUpInclude include() {
    return IslandTopUpInclude._();
  }

  static IslandTopUpIncludeList includeList({
    _is.WhereExpressionBuilder<IslandTopUpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    IslandTopUpInclude? include,
  }) {
    return IslandTopUpIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandTopUpImpl extends IslandTopUp {
  _IslandTopUpImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String txRef,
    required String pack,
    required int amountNgn,
    required int naira,
    required String status,
    String? flwId,
    String? flwAccount,
    String? payTo,
    required DateTime createdAt,
    DateTime? paidAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         txRef: txRef,
         pack: pack,
         amountNgn: amountNgn,
         naira: naira,
         status: status,
         flwId: flwId,
         flwAccount: flwAccount,
         payTo: payTo,
         createdAt: createdAt,
         paidAt: paidAt,
       );

  /// Returns a shallow copy of this [IslandTopUp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandTopUp copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? txRef,
    String? pack,
    int? amountNgn,
    int? naira,
    String? status,
    Object? flwId = _Undefined,
    Object? flwAccount = _Undefined,
    Object? payTo = _Undefined,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
  }) {
    return IslandTopUp(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      txRef: txRef ?? this.txRef,
      pack: pack ?? this.pack,
      amountNgn: amountNgn ?? this.amountNgn,
      naira: naira ?? this.naira,
      status: status ?? this.status,
      flwId: flwId is String? ? flwId : this.flwId,
      flwAccount: flwAccount is String? ? flwAccount : this.flwAccount,
      payTo: payTo is String? ? payTo : this.payTo,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
    );
  }
}

class IslandTopUpUpdateTable extends _is.UpdateTable<IslandTopUpTable> {
  IslandTopUpUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> txRef(String value) => _is.ColumnValue(
    table.txRef,
    value,
  );

  _is.ColumnValue<String, String> pack(String value) => _is.ColumnValue(
    table.pack,
    value,
  );

  _is.ColumnValue<int, int> amountNgn(int value) => _is.ColumnValue(
    table.amountNgn,
    value,
  );

  _is.ColumnValue<int, int> naira(int value) => _is.ColumnValue(
    table.naira,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> flwId(String? value) => _is.ColumnValue(
    table.flwId,
    value,
  );

  _is.ColumnValue<String, String> flwAccount(String? value) => _is.ColumnValue(
    table.flwAccount,
    value,
  );

  _is.ColumnValue<String, String> payTo(String? value) => _is.ColumnValue(
    table.payTo,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) =>
      _is.ColumnValue(
        table.paidAt,
        value,
      );
}

class IslandTopUpTable extends _is.Table<int?> {
  IslandTopUpTable({super.tableRelation}) : super(tableName: 'island_topup') {
    updateTable = IslandTopUpUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    txRef = _is.ColumnString(
      'txRef',
      this,
    );
    pack = _is.ColumnString(
      'pack',
      this,
    );
    amountNgn = _is.ColumnInt(
      'amountNgn',
      this,
    );
    naira = _is.ColumnInt(
      'naira',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    flwId = _is.ColumnString(
      'flwId',
      this,
    );
    flwAccount = _is.ColumnString(
      'flwAccount',
      this,
    );
    payTo = _is.ColumnString(
      'payTo',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    paidAt = _is.ColumnDateTime(
      'paidAt',
      this,
    );
  }

  late final IslandTopUpUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// our reference for the payment (Flutterwave's tx_ref)
  late final _is.ColumnString txRef;

  late final _is.ColumnString pack;

  /// what the player pays, in real naira
  late final _is.ColumnInt amountNgn;

  /// what lands in their game wallet
  late final _is.ColumnInt naira;

  /// pending, paid or failed
  late final _is.ColumnString status;

  /// Flutterwave's own id for the transaction, once it reports one
  late final _is.ColumnString flwId;

  /// Flutterwave v4: the one-time virtual account this purchase is paid into (van_...)
  late final _is.ColumnString flwAccount;

  /// where to pay it, as shown to the player (JSON: account, bank, amount, expires)
  late final _is.ColumnString payTo;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime paidAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    txRef,
    pack,
    amountNgn,
    naira,
    status,
    flwId,
    flwAccount,
    payTo,
    createdAt,
    paidAt,
  ];
}

class IslandTopUpInclude extends _is.IncludeObject {
  IslandTopUpInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandTopUp.t;
}

class IslandTopUpIncludeList extends _is.IncludeList {
  IslandTopUpIncludeList._({
    _is.WhereExpressionBuilder<IslandTopUpTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandTopUp.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandTopUp.t;
}

class IslandTopUpRepository {
  const IslandTopUpRepository._();

  /// Returns a list of [IslandTopUp]s matching the given query parameters.
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
  Future<List<IslandTopUp>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTopUpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandTopUp>(
      where: where?.call(IslandTopUp.t),
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandTopUp] matching the given query parameters.
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
  Future<IslandTopUp?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTopUpTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandTopUp>(
      where: where?.call(IslandTopUp.t),
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandTopUp] by its [id] or null if no such row exists.
  Future<IslandTopUp?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandTopUp>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandTopUp]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandTopUp]s will have their `id` fields set.
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
  Future<List<IslandTopUp>> insert(
    _is.DatabaseSession session,
    List<IslandTopUp> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandTopUp>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandTopUp] and returns the inserted row.
  ///
  /// The returned [IslandTopUp] will have its `id` field set.
  Future<IslandTopUp> insertRow(
    _is.DatabaseSession session,
    IslandTopUp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandTopUp>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandTopUp]s in the list and returns the resulting rows.
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
  /// The returned [IslandTopUp]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTopUp>> upsert(
    _is.DatabaseSession session,
    List<IslandTopUp> rows, {
    required _is.ColumnSelections<IslandTopUpTable> conflictColumns,
    _is.ColumnSelections<IslandTopUpTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTopUpTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandTopUp>(
      rows,
      conflictColumns: conflictColumns(IslandTopUp.t),
      updateColumns: updateColumns?.call(IslandTopUp.t),
      updateWhere: updateWhere?.call(IslandTopUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandTopUp] and returns the resulting row.
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
  /// The returned [IslandTopUp] will have its `id` field set.
  Future<IslandTopUp?> upsertRow(
    _is.DatabaseSession session,
    IslandTopUp row, {
    required _is.ColumnSelections<IslandTopUpTable> conflictColumns,
    _is.ColumnSelections<IslandTopUpTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandTopUpTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandTopUp>(
      row,
      conflictColumns: conflictColumns(IslandTopUp.t),
      updateColumns: updateColumns?.call(IslandTopUp.t),
      updateWhere: updateWhere?.call(IslandTopUp.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTopUp]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTopUp>> update(
    _is.DatabaseSession session,
    List<IslandTopUp> rows, {
    _is.ColumnSelections<IslandTopUpTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandTopUp>(
      rows,
      columns: columns?.call(IslandTopUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandTopUp]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandTopUp> updateRow(
    _is.DatabaseSession session,
    IslandTopUp row, {
    _is.ColumnSelections<IslandTopUpTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandTopUp>(
      row,
      columns: columns?.call(IslandTopUp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandTopUp] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandTopUp?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandTopUpUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandTopUp>(
      id,
      columnValues: columnValues(IslandTopUp.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandTopUp]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandTopUp>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandTopUpUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandTopUpTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandTopUp>(
      columnValues: columnValues(IslandTopUp.t.updateTable),
      where: where(IslandTopUp.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandTopUp]s in the list and returns the deleted rows.
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
  Future<List<IslandTopUp>> delete(
    _is.DatabaseSession session,
    List<IslandTopUp> rows, {
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandTopUp>(
      rows,
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandTopUp].
  Future<IslandTopUp> deleteRow(
    _is.DatabaseSession session,
    IslandTopUp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandTopUp>(
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
  Future<List<IslandTopUp>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTopUpTable> where,
    _is.OrderByBuilder<IslandTopUpTable>? orderBy,
    _is.OrderByListBuilder<IslandTopUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandTopUp>(
      where: where(IslandTopUp.t),
      orderBy: orderBy?.call(IslandTopUp.t),
      orderByList: orderByList?.call(IslandTopUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandTopUpTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandTopUp>(
      where: where?.call(IslandTopUp.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandTopUp] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandTopUpTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandTopUp>(
      where: where(IslandTopUp.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
