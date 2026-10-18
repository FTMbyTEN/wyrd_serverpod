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

/// A piece of furniture someone bought at the Eko Home Store. One row per piece; [item] is a store id
/// (k:<model>) from IslandMeEndpoint.furnitureCatalog. Where it stands is in the room's layout.
abstract class IslandFurniture
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandFurniture._({
    this.id,
    required this.authUserId,
    required this.item,
    required this.price,
    required this.boughtAt,
  });

  factory IslandFurniture({
    int? id,
    required _is.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) = _IslandFurnitureImpl;

  factory IslandFurniture.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandFurniture(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      item: jsonSerialization['item'] as String,
      price: jsonSerialization['price'] as int,
      boughtAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['boughtAt'],
      ),
    );
  }

  static final t = IslandFurnitureTable();

  static const db = IslandFurnitureRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String item;

  int price;

  DateTime boughtAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandFurniture]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandFurniture copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandFurniture',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'item': item,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandFurniture',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'item': item,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  static IslandFurnitureInclude include() {
    return IslandFurnitureInclude._();
  }

  static IslandFurnitureIncludeList includeList({
    _is.WhereExpressionBuilder<IslandFurnitureTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    IslandFurnitureInclude? include,
  }) {
    return IslandFurnitureIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandFurnitureImpl extends IslandFurniture {
  _IslandFurnitureImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         item: item,
         price: price,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandFurniture]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandFurniture copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandFurniture(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      item: item ?? this.item,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}

class IslandFurnitureUpdateTable extends _is.UpdateTable<IslandFurnitureTable> {
  IslandFurnitureUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> item(String value) => _is.ColumnValue(
    table.item,
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

class IslandFurnitureTable extends _is.Table<int?> {
  IslandFurnitureTable({super.tableRelation})
    : super(tableName: 'island_furniture') {
    updateTable = IslandFurnitureUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    item = _is.ColumnString(
      'item',
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

  late final IslandFurnitureUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString item;

  late final _is.ColumnInt price;

  late final _is.ColumnDateTime boughtAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    item,
    price,
    boughtAt,
  ];
}

class IslandFurnitureInclude extends _is.IncludeObject {
  IslandFurnitureInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandFurniture.t;
}

class IslandFurnitureIncludeList extends _is.IncludeList {
  IslandFurnitureIncludeList._({
    _is.WhereExpressionBuilder<IslandFurnitureTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandFurniture.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandFurniture.t;
}

class IslandFurnitureRepository {
  const IslandFurnitureRepository._();

  /// Returns a list of [IslandFurniture]s matching the given query parameters.
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
  Future<List<IslandFurniture>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFurnitureTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandFurniture>(
      where: where?.call(IslandFurniture.t),
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandFurniture] matching the given query parameters.
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
  Future<IslandFurniture?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFurnitureTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandFurniture>(
      where: where?.call(IslandFurniture.t),
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandFurniture] by its [id] or null if no such row exists.
  Future<IslandFurniture?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandFurniture>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandFurniture]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandFurniture]s will have their `id` fields set.
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
  Future<List<IslandFurniture>> insert(
    _is.DatabaseSession session,
    List<IslandFurniture> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandFurniture>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandFurniture] and returns the inserted row.
  ///
  /// The returned [IslandFurniture] will have its `id` field set.
  Future<IslandFurniture> insertRow(
    _is.DatabaseSession session,
    IslandFurniture row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandFurniture>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandFurniture]s in the list and returns the resulting rows.
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
  /// The returned [IslandFurniture]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFurniture>> upsert(
    _is.DatabaseSession session,
    List<IslandFurniture> rows, {
    required _is.ColumnSelections<IslandFurnitureTable> conflictColumns,
    _is.ColumnSelections<IslandFurnitureTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandFurnitureTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandFurniture>(
      rows,
      conflictColumns: conflictColumns(IslandFurniture.t),
      updateColumns: updateColumns?.call(IslandFurniture.t),
      updateWhere: updateWhere?.call(IslandFurniture.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandFurniture] and returns the resulting row.
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
  /// The returned [IslandFurniture] will have its `id` field set.
  Future<IslandFurniture?> upsertRow(
    _is.DatabaseSession session,
    IslandFurniture row, {
    required _is.ColumnSelections<IslandFurnitureTable> conflictColumns,
    _is.ColumnSelections<IslandFurnitureTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandFurnitureTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandFurniture>(
      row,
      conflictColumns: conflictColumns(IslandFurniture.t),
      updateColumns: updateColumns?.call(IslandFurniture.t),
      updateWhere: updateWhere?.call(IslandFurniture.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandFurniture]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFurniture>> update(
    _is.DatabaseSession session,
    List<IslandFurniture> rows, {
    _is.ColumnSelections<IslandFurnitureTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandFurniture>(
      rows,
      columns: columns?.call(IslandFurniture.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandFurniture]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandFurniture> updateRow(
    _is.DatabaseSession session,
    IslandFurniture row, {
    _is.ColumnSelections<IslandFurnitureTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandFurniture>(
      row,
      columns: columns?.call(IslandFurniture.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandFurniture] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandFurniture?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandFurnitureUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandFurniture>(
      id,
      columnValues: columnValues(IslandFurniture.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandFurniture]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandFurniture>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandFurnitureUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<IslandFurnitureTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandFurniture>(
      columnValues: columnValues(IslandFurniture.t.updateTable),
      where: where(IslandFurniture.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandFurniture]s in the list and returns the deleted rows.
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
  Future<List<IslandFurniture>> delete(
    _is.DatabaseSession session,
    List<IslandFurniture> rows, {
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandFurniture>(
      rows,
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandFurniture].
  Future<IslandFurniture> deleteRow(
    _is.DatabaseSession session,
    IslandFurniture row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandFurniture>(
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
  Future<List<IslandFurniture>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandFurnitureTable> where,
    _is.OrderByBuilder<IslandFurnitureTable>? orderBy,
    _is.OrderByListBuilder<IslandFurnitureTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandFurniture>(
      where: where(IslandFurniture.t),
      orderBy: orderBy?.call(IslandFurniture.t),
      orderByList: orderByList?.call(IslandFurniture.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandFurnitureTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandFurniture>(
      where: where?.call(IslandFurniture.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandFurniture] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandFurnitureTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandFurniture>(
      where: where(IslandFurniture.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
