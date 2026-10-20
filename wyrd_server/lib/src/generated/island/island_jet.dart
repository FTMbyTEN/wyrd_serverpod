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

/// A private jet someone owns at Lagos Island Airport (one each): its kind, its registration (5N-XXX, Nigeria's
/// prefix), its livery (an index into the game's colours), and whether the owner's name is shown on its hangar.
abstract class IslandJet
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandJet._({
    this.id,
    required this.authUserId,
    required this.model,
    required this.tail,
    required this.livery,
    bool? showName,
    required this.price,
    required this.boughtAt,
  }) : showName = showName ?? false;

  factory IslandJet({
    int? id,
    required _is.UuidValue authUserId,
    required String model,
    required String tail,
    required int livery,
    bool? showName,
    required int price,
    required DateTime boughtAt,
  }) = _IslandJetImpl;

  factory IslandJet.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJet(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      model: jsonSerialization['model'] as String,
      tail: jsonSerialization['tail'] as String,
      livery: jsonSerialization['livery'] as int,
      showName: jsonSerialization['showName'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['showName']),
      price: jsonSerialization['price'] as int,
      boughtAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['boughtAt'],
      ),
    );
  }

  static final t = IslandJetTable();

  static const db = IslandJetRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// light | midsize | heavy (IslandMeEndpoint.jetCatalog)
  String model;

  String tail;

  int livery;

  /// the owner's island name on the hangar door (off unless they turn it on)
  bool showName;

  int price;

  DateTime boughtAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandJet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandJet copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? model,
    String? tail,
    int? livery,
    bool? showName,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'tail': tail,
      'livery': livery,
      'showName': showName,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'tail': tail,
      'livery': livery,
      'showName': showName,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  static IslandJetInclude include() {
    return IslandJetInclude._();
  }

  static IslandJetIncludeList includeList({
    _is.WhereExpressionBuilder<IslandJetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    IslandJetInclude? include,
  }) {
    return IslandJetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandJetImpl extends IslandJet {
  _IslandJetImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String model,
    required String tail,
    required int livery,
    bool? showName,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         model: model,
         tail: tail,
         livery: livery,
         showName: showName,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandJet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandJet copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? model,
    String? tail,
    int? livery,
    bool? showName,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandJet(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      model: model ?? this.model,
      tail: tail ?? this.tail,
      livery: livery ?? this.livery,
      showName: showName ?? this.showName,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}

class IslandJetUpdateTable extends _is.UpdateTable<IslandJetTable> {
  IslandJetUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> model(String value) => _is.ColumnValue(
    table.model,
    value,
  );

  _is.ColumnValue<String, String> tail(String value) => _is.ColumnValue(
    table.tail,
    value,
  );

  _is.ColumnValue<int, int> livery(int value) => _is.ColumnValue(
    table.livery,
    value,
  );

  _is.ColumnValue<bool, bool> showName(bool value) => _is.ColumnValue(
    table.showName,
    value,
  );

  _is.ColumnValue<int, int> price(int value) => _is.ColumnValue(
    table.price,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> boughtAt(DateTime value) =>
      _is.ColumnValue(
        table.boughtAt,
        value,
      );
}

class IslandJetTable extends _is.Table<int?> {
  IslandJetTable({super.tableRelation}) : super(tableName: 'island_jet') {
    updateTable = IslandJetUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    model = _is.ColumnString(
      'model',
      this,
    );
    tail = _is.ColumnString(
      'tail',
      this,
    );
    livery = _is.ColumnInt(
      'livery',
      this,
    );
    showName = _is.ColumnBool(
      'showName',
      this,
      hasDefault: true,
    );
    price = _is.ColumnInt(
      'price',
      this,
    );
    boughtAt = _is.ColumnDateTime(
      'boughtAt',
      this,
    );
  }

  late final IslandJetUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// light | midsize | heavy (IslandMeEndpoint.jetCatalog)
  late final _is.ColumnString model;

  late final _is.ColumnString tail;

  late final _is.ColumnInt livery;

  /// the owner's island name on the hangar door (off unless they turn it on)
  late final _is.ColumnBool showName;

  late final _is.ColumnInt price;

  late final _is.ColumnDateTime boughtAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    model,
    tail,
    livery,
    showName,
    price,
    boughtAt,
  ];
}

class IslandJetInclude extends _is.IncludeObject {
  IslandJetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandJet.t;
}

class IslandJetIncludeList extends _is.IncludeList {
  IslandJetIncludeList._({
    _is.WhereExpressionBuilder<IslandJetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandJet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandJet.t;
}

class IslandJetRepository {
  const IslandJetRepository._();

  /// Returns a list of [IslandJet]s matching the given query parameters.
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
  Future<List<IslandJet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandJet>(
      where: where?.call(IslandJet.t),
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandJet] matching the given query parameters.
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
  Future<IslandJet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJetTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandJet>(
      where: where?.call(IslandJet.t),
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandJet] by its [id] or null if no such row exists.
  Future<IslandJet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandJet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandJet]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandJet]s will have their `id` fields set.
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
  Future<List<IslandJet>> insert(
    _is.DatabaseSession session,
    List<IslandJet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandJet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandJet] and returns the inserted row.
  ///
  /// The returned [IslandJet] will have its `id` field set.
  Future<IslandJet> insertRow(
    _is.DatabaseSession session,
    IslandJet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandJet>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandJet]s in the list and returns the resulting rows.
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
  /// The returned [IslandJet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJet>> upsert(
    _is.DatabaseSession session,
    List<IslandJet> rows, {
    required _is.ColumnSelections<IslandJetTable> conflictColumns,
    _is.ColumnSelections<IslandJetTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandJet>(
      rows,
      conflictColumns: conflictColumns(IslandJet.t),
      updateColumns: updateColumns?.call(IslandJet.t),
      updateWhere: updateWhere?.call(IslandJet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandJet] and returns the resulting row.
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
  /// The returned [IslandJet] will have its `id` field set.
  Future<IslandJet?> upsertRow(
    _is.DatabaseSession session,
    IslandJet row, {
    required _is.ColumnSelections<IslandJetTable> conflictColumns,
    _is.ColumnSelections<IslandJetTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandJet>(
      row,
      conflictColumns: conflictColumns(IslandJet.t),
      updateColumns: updateColumns?.call(IslandJet.t),
      updateWhere: updateWhere?.call(IslandJet.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJet>> update(
    _is.DatabaseSession session,
    List<IslandJet> rows, {
    _is.ColumnSelections<IslandJetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandJet>(
      rows,
      columns: columns?.call(IslandJet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandJet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandJet> updateRow(
    _is.DatabaseSession session,
    IslandJet row, {
    _is.ColumnSelections<IslandJetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandJet>(
      row,
      columns: columns?.call(IslandJet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandJet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandJet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandJetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandJet>(
      id,
      columnValues: columnValues(IslandJet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandJetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandJetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandJet>(
      columnValues: columnValues(IslandJet.t.updateTable),
      where: where(IslandJet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandJet]s in the list and returns the deleted rows.
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
  Future<List<IslandJet>> delete(
    _is.DatabaseSession session,
    List<IslandJet> rows, {
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandJet>(
      rows,
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandJet].
  Future<IslandJet> deleteRow(
    _is.DatabaseSession session,
    IslandJet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandJet>(
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
  Future<List<IslandJet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJetTable> where,
    _is.OrderByBuilder<IslandJetTable>? orderBy,
    _is.OrderByListBuilder<IslandJetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandJet>(
      where: where(IslandJet.t),
      orderBy: orderBy?.call(IslandJet.t),
      orderByList: orderByList?.call(IslandJet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandJet>(
      where: where?.call(IslandJet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandJet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandJet>(
      where: where(IslandJet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
