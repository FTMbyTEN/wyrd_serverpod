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

/// A car someone bought at a Lagos Island dealer. [active] is the one they drive (and park outside where they are).
abstract class IslandCar
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandCar._({
    this.id,
    required this.authUserId,
    required this.model,
    required this.color,
    required this.price,
    required this.dealer,
    bool? active,
    required this.boughtAt,
  }) : active = active ?? false;

  factory IslandCar({
    int? id,
    required _is.UuidValue authUserId,
    required String model,
    required String color,
    required int price,
    required String dealer,
    bool? active,
    required DateTime boughtAt,
  }) = _IslandCarImpl;

  factory IslandCar.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandCar(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      model: jsonSerialization['model'] as String,
      color: jsonSerialization['color'] as String,
      price: jsonSerialization['price'] as int,
      dealer: jsonSerialization['dealer'] as String,
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      boughtAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['boughtAt'],
      ),
    );
  }

  static final t = IslandCarTable();

  static const db = IslandCarRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// a model id from the dealer catalogue
  String model;

  String color;

  int price;

  String dealer;

  bool active;

  DateTime boughtAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandCar]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandCar copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? model,
    String? color,
    int? price,
    String? dealer,
    bool? active,
    DateTime? boughtAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandCar',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'color': color,
      'price': price,
      'dealer': dealer,
      'active': active,
      'boughtAt': boughtAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandCar',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'model': model,
      'color': color,
      'price': price,
      'dealer': dealer,
      'active': active,
      'boughtAt': boughtAt.toJson(),
    };
  }

  static IslandCarInclude include() {
    return IslandCarInclude._();
  }

  static IslandCarIncludeList includeList({
    _is.WhereExpressionBuilder<IslandCarTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    IslandCarInclude? include,
  }) {
    return IslandCarIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandCarImpl extends IslandCar {
  _IslandCarImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String model,
    required String color,
    required int price,
    required String dealer,
    bool? active,
    required DateTime boughtAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         model: model,
         color: color,
         price: price,
         dealer: dealer,
         active: active,
         boughtAt: boughtAt,
       );

  /// Returns a shallow copy of this [IslandCar]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandCar copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? model,
    String? color,
    int? price,
    String? dealer,
    bool? active,
    DateTime? boughtAt,
  }) {
    return IslandCar(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      model: model ?? this.model,
      color: color ?? this.color,
      price: price ?? this.price,
      dealer: dealer ?? this.dealer,
      active: active ?? this.active,
      boughtAt: boughtAt ?? this.boughtAt,
    );
  }
}

class IslandCarUpdateTable extends _is.UpdateTable<IslandCarTable> {
  IslandCarUpdateTable(super.table);

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

  _is.ColumnValue<String, String> color(String value) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<int, int> price(int value) => _is.ColumnValue(
    table.price,
    value,
  );

  _is.ColumnValue<String, String> dealer(String value) => _is.ColumnValue(
    table.dealer,
    value,
  );

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> boughtAt(DateTime value) =>
      _is.ColumnValue(
        table.boughtAt,
        value,
      );
}

class IslandCarTable extends _is.Table<int?> {
  IslandCarTable({super.tableRelation}) : super(tableName: 'island_car') {
    updateTable = IslandCarUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    model = _is.ColumnString(
      'model',
      this,
    );
    color = _is.ColumnString(
      'color',
      this,
    );
    price = _is.ColumnInt(
      'price',
      this,
    );
    dealer = _is.ColumnString(
      'dealer',
      this,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    boughtAt = _is.ColumnDateTime(
      'boughtAt',
      this,
    );
  }

  late final IslandCarUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// a model id from the dealer catalogue
  late final _is.ColumnString model;

  late final _is.ColumnString color;

  late final _is.ColumnInt price;

  late final _is.ColumnString dealer;

  late final _is.ColumnBool active;

  late final _is.ColumnDateTime boughtAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    model,
    color,
    price,
    dealer,
    active,
    boughtAt,
  ];
}

class IslandCarInclude extends _is.IncludeObject {
  IslandCarInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandCar.t;
}

class IslandCarIncludeList extends _is.IncludeList {
  IslandCarIncludeList._({
    _is.WhereExpressionBuilder<IslandCarTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandCar.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandCar.t;
}

class IslandCarRepository {
  const IslandCarRepository._();

  /// Returns a list of [IslandCar]s matching the given query parameters.
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
  Future<List<IslandCar>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandCarTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandCar>(
      where: where?.call(IslandCar.t),
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandCar] matching the given query parameters.
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
  Future<IslandCar?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandCarTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandCar>(
      where: where?.call(IslandCar.t),
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandCar] by its [id] or null if no such row exists.
  Future<IslandCar?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandCar>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandCar]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandCar]s will have their `id` fields set.
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
  Future<List<IslandCar>> insert(
    _is.DatabaseSession session,
    List<IslandCar> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandCar>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandCar] and returns the inserted row.
  ///
  /// The returned [IslandCar] will have its `id` field set.
  Future<IslandCar> insertRow(
    _is.DatabaseSession session,
    IslandCar row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandCar>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandCar]s in the list and returns the resulting rows.
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
  /// The returned [IslandCar]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandCar>> upsert(
    _is.DatabaseSession session,
    List<IslandCar> rows, {
    required _is.ColumnSelections<IslandCarTable> conflictColumns,
    _is.ColumnSelections<IslandCarTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandCarTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandCar>(
      rows,
      conflictColumns: conflictColumns(IslandCar.t),
      updateColumns: updateColumns?.call(IslandCar.t),
      updateWhere: updateWhere?.call(IslandCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandCar] and returns the resulting row.
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
  /// The returned [IslandCar] will have its `id` field set.
  Future<IslandCar?> upsertRow(
    _is.DatabaseSession session,
    IslandCar row, {
    required _is.ColumnSelections<IslandCarTable> conflictColumns,
    _is.ColumnSelections<IslandCarTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandCarTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandCar>(
      row,
      conflictColumns: conflictColumns(IslandCar.t),
      updateColumns: updateColumns?.call(IslandCar.t),
      updateWhere: updateWhere?.call(IslandCar.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandCar]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandCar>> update(
    _is.DatabaseSession session,
    List<IslandCar> rows, {
    _is.ColumnSelections<IslandCarTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandCar>(
      rows,
      columns: columns?.call(IslandCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandCar]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandCar> updateRow(
    _is.DatabaseSession session,
    IslandCar row, {
    _is.ColumnSelections<IslandCarTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandCar>(
      row,
      columns: columns?.call(IslandCar.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandCar] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandCar?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandCarUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandCar>(
      id,
      columnValues: columnValues(IslandCar.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandCar]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandCar>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandCarUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandCarTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandCar>(
      columnValues: columnValues(IslandCar.t.updateTable),
      where: where(IslandCar.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandCar]s in the list and returns the deleted rows.
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
  Future<List<IslandCar>> delete(
    _is.DatabaseSession session,
    List<IslandCar> rows, {
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandCar>(
      rows,
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandCar].
  Future<IslandCar> deleteRow(
    _is.DatabaseSession session,
    IslandCar row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandCar>(
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
  Future<List<IslandCar>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandCarTable> where,
    _is.OrderByBuilder<IslandCarTable>? orderBy,
    _is.OrderByListBuilder<IslandCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandCar>(
      where: where(IslandCar.t),
      orderBy: orderBy?.call(IslandCar.t),
      orderByList: orderByList?.call(IslandCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandCarTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandCar>(
      where: where?.call(IslandCar.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandCar] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandCarTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandCar>(
      where: where(IslandCar.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
