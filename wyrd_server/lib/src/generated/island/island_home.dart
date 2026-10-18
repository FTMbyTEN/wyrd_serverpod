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

/// A home someone bought on a plot in one of the island's estates (Ajah, Lekki, Ikoyi, Banana Island).
/// [plot] is <estate>:<n> from IslandMeEndpoint.estates; its [style] (bungalow, duplex, loft, mansion,
/// villa...) comes from there too. Everyone also keeps their free starter BQ on HQ Row (their profile).
abstract class IslandHome
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandHome._({
    this.id,
    required this.authUserId,
    required this.plot,
    required this.style,
    required this.price,
    required this.boughtAt,
  });

  factory IslandHome({
    int? id,
    required _is.UuidValue authUserId,
    required String plot,
    required String style,
    required int price,
    required DateTime boughtAt,
  }) = _IslandHomeImpl;

  factory IslandHome.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandHome(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      plot: jsonSerialization['plot'] as String,
      style: jsonSerialization['style'] as String,
      price: jsonSerialization['price'] as int,
      boughtAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['boughtAt'],
      ),
    );
  }

  static final t = IslandHomeTable();

  static const db = IslandHomeRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String plot;

  String style;

  int price;

  DateTime boughtAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandHome]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandHome copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? plot,
    String? style,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandHome',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'plot': plot,
      'style': style,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandHome',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'plot': plot,
      'style': style,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  static IslandHomeInclude include() {
    return IslandHomeInclude._();
  }

  static IslandHomeIncludeList includeList({
    _is.WhereExpressionBuilder<IslandHomeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    IslandHomeInclude? include,
  }) {
    return IslandHomeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandHomeImpl extends IslandHome {
  _IslandHomeImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String plot,
    required String style,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         plot: plot,
         style: style,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandHome]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandHome copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? plot,
    String? style,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandHome(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      plot: plot ?? this.plot,
      style: style ?? this.style,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}

class IslandHomeUpdateTable extends _is.UpdateTable<IslandHomeTable> {
  IslandHomeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> plot(String value) => _is.ColumnValue(
    table.plot,
    value,
  );

  _is.ColumnValue<String, String> style(String value) => _is.ColumnValue(
    table.style,
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

class IslandHomeTable extends _is.Table<int?> {
  IslandHomeTable({super.tableRelation}) : super(tableName: 'island_home') {
    updateTable = IslandHomeUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    plot = _is.ColumnString(
      'plot',
      this,
    );
    style = _is.ColumnString(
      'style',
      this,
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

  late final IslandHomeUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString plot;

  late final _is.ColumnString style;

  late final _is.ColumnInt price;

  late final _is.ColumnDateTime boughtAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    plot,
    style,
    price,
    boughtAt,
  ];
}

class IslandHomeInclude extends _is.IncludeObject {
  IslandHomeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandHome.t;
}

class IslandHomeIncludeList extends _is.IncludeList {
  IslandHomeIncludeList._({
    _is.WhereExpressionBuilder<IslandHomeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandHome.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandHome.t;
}

class IslandHomeRepository {
  const IslandHomeRepository._();

  /// Returns a list of [IslandHome]s matching the given query parameters.
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
  Future<List<IslandHome>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandHomeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandHome>(
      where: where?.call(IslandHome.t),
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandHome] matching the given query parameters.
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
  Future<IslandHome?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandHomeTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandHome>(
      where: where?.call(IslandHome.t),
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandHome] by its [id] or null if no such row exists.
  Future<IslandHome?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandHome>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandHome]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandHome]s will have their `id` fields set.
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
  Future<List<IslandHome>> insert(
    _is.DatabaseSession session,
    List<IslandHome> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandHome>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandHome] and returns the inserted row.
  ///
  /// The returned [IslandHome] will have its `id` field set.
  Future<IslandHome> insertRow(
    _is.DatabaseSession session,
    IslandHome row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandHome>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandHome]s in the list and returns the resulting rows.
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
  /// The returned [IslandHome]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandHome>> upsert(
    _is.DatabaseSession session,
    List<IslandHome> rows, {
    required _is.ColumnSelections<IslandHomeTable> conflictColumns,
    _is.ColumnSelections<IslandHomeTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandHomeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandHome>(
      rows,
      conflictColumns: conflictColumns(IslandHome.t),
      updateColumns: updateColumns?.call(IslandHome.t),
      updateWhere: updateWhere?.call(IslandHome.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandHome] and returns the resulting row.
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
  /// The returned [IslandHome] will have its `id` field set.
  Future<IslandHome?> upsertRow(
    _is.DatabaseSession session,
    IslandHome row, {
    required _is.ColumnSelections<IslandHomeTable> conflictColumns,
    _is.ColumnSelections<IslandHomeTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandHomeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandHome>(
      row,
      conflictColumns: conflictColumns(IslandHome.t),
      updateColumns: updateColumns?.call(IslandHome.t),
      updateWhere: updateWhere?.call(IslandHome.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandHome]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandHome>> update(
    _is.DatabaseSession session,
    List<IslandHome> rows, {
    _is.ColumnSelections<IslandHomeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandHome>(
      rows,
      columns: columns?.call(IslandHome.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandHome]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandHome> updateRow(
    _is.DatabaseSession session,
    IslandHome row, {
    _is.ColumnSelections<IslandHomeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandHome>(
      row,
      columns: columns?.call(IslandHome.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandHome] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandHome?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandHomeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandHome>(
      id,
      columnValues: columnValues(IslandHome.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandHome]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandHome>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandHomeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandHomeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandHome>(
      columnValues: columnValues(IslandHome.t.updateTable),
      where: where(IslandHome.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandHome]s in the list and returns the deleted rows.
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
  Future<List<IslandHome>> delete(
    _is.DatabaseSession session,
    List<IslandHome> rows, {
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandHome>(
      rows,
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandHome].
  Future<IslandHome> deleteRow(
    _is.DatabaseSession session,
    IslandHome row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandHome>(
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
  Future<List<IslandHome>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandHomeTable> where,
    _is.OrderByBuilder<IslandHomeTable>? orderBy,
    _is.OrderByListBuilder<IslandHomeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandHome>(
      where: where(IslandHome.t),
      orderBy: orderBy?.call(IslandHome.t),
      orderByList: orderByList?.call(IslandHome.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandHomeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandHome>(
      where: where?.call(IslandHome.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandHome] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandHomeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandHome>(
      where: where(IslandHome.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
