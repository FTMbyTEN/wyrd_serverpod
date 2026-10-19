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

/// An outfit someone bought at a Lagos Island boutique (Idumota, Falomo, Circle Mall) or on the Fashion app. One row per
/// outfit; [item] is an id from IslandMeEndpoint.outfitCatalog. What they're wearing is the last field of their look.
abstract class IslandOutfit
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandOutfit._({
    this.id,
    required this.authUserId,
    required this.item,
    required this.price,
    required this.boughtAt,
  });

  factory IslandOutfit({
    int? id,
    required _is.UuidValue authUserId,
    required String item,
    required int price,
    required DateTime boughtAt,
  }) = _IslandOutfitImpl;

  factory IslandOutfit.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandOutfit(
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

  static final t = IslandOutfitTable();

  static const db = IslandOutfitRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String item;

  int price;

  DateTime boughtAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandOutfit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandOutfit copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandOutfit',
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
      '__className__': 'IslandOutfit',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'item': item,
      'price': price,
      'boughtAt': boughtAt.toJson(),
    };
  }

  static IslandOutfitInclude include() {
    return IslandOutfitInclude._();
  }

  static IslandOutfitIncludeList includeList({
    _is.WhereExpressionBuilder<IslandOutfitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    IslandOutfitInclude? include,
  }) {
    return IslandOutfitIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandOutfitImpl extends IslandOutfit {
  _IslandOutfitImpl({
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

  /// Returns a shallow copy of this [IslandOutfit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandOutfit copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? item,
    int? price,
    DateTime? boughtAt,
  }) {
    return IslandOutfit(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      item: item ?? this.item,
      price: price ?? this.price,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}

class IslandOutfitUpdateTable extends _is.UpdateTable<IslandOutfitTable> {
  IslandOutfitUpdateTable(super.table);

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

class IslandOutfitTable extends _is.Table<int?> {
  IslandOutfitTable({super.tableRelation}) : super(tableName: 'island_outfit') {
    updateTable = IslandOutfitUpdateTable(this);
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

  late final IslandOutfitUpdateTable updateTable;

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

class IslandOutfitInclude extends _is.IncludeObject {
  IslandOutfitInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandOutfit.t;
}

class IslandOutfitIncludeList extends _is.IncludeList {
  IslandOutfitIncludeList._({
    _is.WhereExpressionBuilder<IslandOutfitTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandOutfit.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandOutfit.t;
}

class IslandOutfitRepository {
  const IslandOutfitRepository._();

  /// Returns a list of [IslandOutfit]s matching the given query parameters.
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
  Future<List<IslandOutfit>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandOutfitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandOutfit>(
      where: where?.call(IslandOutfit.t),
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandOutfit] matching the given query parameters.
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
  Future<IslandOutfit?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandOutfitTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandOutfit>(
      where: where?.call(IslandOutfit.t),
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandOutfit] by its [id] or null if no such row exists.
  Future<IslandOutfit?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandOutfit>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandOutfit]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandOutfit]s will have their `id` fields set.
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
  Future<List<IslandOutfit>> insert(
    _is.DatabaseSession session,
    List<IslandOutfit> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandOutfit>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandOutfit] and returns the inserted row.
  ///
  /// The returned [IslandOutfit] will have its `id` field set.
  Future<IslandOutfit> insertRow(
    _is.DatabaseSession session,
    IslandOutfit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandOutfit>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandOutfit]s in the list and returns the resulting rows.
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
  /// The returned [IslandOutfit]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandOutfit>> upsert(
    _is.DatabaseSession session,
    List<IslandOutfit> rows, {
    required _is.ColumnSelections<IslandOutfitTable> conflictColumns,
    _is.ColumnSelections<IslandOutfitTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandOutfitTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandOutfit>(
      rows,
      conflictColumns: conflictColumns(IslandOutfit.t),
      updateColumns: updateColumns?.call(IslandOutfit.t),
      updateWhere: updateWhere?.call(IslandOutfit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandOutfit] and returns the resulting row.
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
  /// The returned [IslandOutfit] will have its `id` field set.
  Future<IslandOutfit?> upsertRow(
    _is.DatabaseSession session,
    IslandOutfit row, {
    required _is.ColumnSelections<IslandOutfitTable> conflictColumns,
    _is.ColumnSelections<IslandOutfitTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandOutfitTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandOutfit>(
      row,
      conflictColumns: conflictColumns(IslandOutfit.t),
      updateColumns: updateColumns?.call(IslandOutfit.t),
      updateWhere: updateWhere?.call(IslandOutfit.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandOutfit]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandOutfit>> update(
    _is.DatabaseSession session,
    List<IslandOutfit> rows, {
    _is.ColumnSelections<IslandOutfitTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandOutfit>(
      rows,
      columns: columns?.call(IslandOutfit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandOutfit]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandOutfit> updateRow(
    _is.DatabaseSession session,
    IslandOutfit row, {
    _is.ColumnSelections<IslandOutfitTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandOutfit>(
      row,
      columns: columns?.call(IslandOutfit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandOutfit] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandOutfit?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandOutfitUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandOutfit>(
      id,
      columnValues: columnValues(IslandOutfit.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandOutfit]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandOutfit>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandOutfitUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandOutfitTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandOutfit>(
      columnValues: columnValues(IslandOutfit.t.updateTable),
      where: where(IslandOutfit.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandOutfit]s in the list and returns the deleted rows.
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
  Future<List<IslandOutfit>> delete(
    _is.DatabaseSession session,
    List<IslandOutfit> rows, {
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandOutfit>(
      rows,
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandOutfit].
  Future<IslandOutfit> deleteRow(
    _is.DatabaseSession session,
    IslandOutfit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandOutfit>(
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
  Future<List<IslandOutfit>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandOutfitTable> where,
    _is.OrderByBuilder<IslandOutfitTable>? orderBy,
    _is.OrderByListBuilder<IslandOutfitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandOutfit>(
      where: where(IslandOutfit.t),
      orderBy: orderBy?.call(IslandOutfit.t),
      orderByList: orderByList?.call(IslandOutfit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandOutfitTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandOutfit>(
      where: where?.call(IslandOutfit.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandOutfit] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandOutfitTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandOutfit>(
      where: where(IslandOutfit.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
