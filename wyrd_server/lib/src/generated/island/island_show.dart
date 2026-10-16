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

/// A show at the arena: an artist performs live for the people holding tickets. WYRD's operator checks
/// each before tickets go on sale (status on_sale).
abstract class IslandShow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandShow._({
    this.id,
    required this.hostUserId,
    required this.artist,
    required this.title,
    required this.startsAt,
    int? minutes,
    required this.price,
    int? capacity,
    String? status,
    required this.createdAt,
  }) : minutes = minutes ?? 60,
       capacity = capacity ?? 500,
       status = status ?? 'pending';

  factory IslandShow({
    int? id,
    required _is.UuidValue hostUserId,
    required String artist,
    required String title,
    required DateTime startsAt,
    int? minutes,
    required int price,
    int? capacity,
    String? status,
    required DateTime createdAt,
  }) = _IslandShowImpl;

  factory IslandShow.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandShow(
      id: jsonSerialization['id'] as int?,
      hostUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['hostUserId'],
      ),
      artist: jsonSerialization['artist'] as String,
      title: jsonSerialization['title'] as String,
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      minutes: jsonSerialization['minutes'] as int?,
      price: jsonSerialization['price'] as int,
      capacity: jsonSerialization['capacity'] as int?,
      status: jsonSerialization['status'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandShowTable();

  static const db = IslandShowRepository._();

  @override
  int? id;

  _is.UuidValue hostUserId;

  String artist;

  String title;

  DateTime startsAt;

  /// how long it runs
  int minutes;

  /// ticket price in naira (play money), 0 for free
  int price;

  int capacity;

  /// pending | on_sale | rejected | cancelled
  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandShow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandShow copyWith({
    int? id,
    _is.UuidValue? hostUserId,
    String? artist,
    String? title,
    DateTime? startsAt,
    int? minutes,
    int? price,
    int? capacity,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandShow',
      if (id != null) 'id': id,
      'hostUserId': hostUserId.toJson(),
      'artist': artist,
      'title': title,
      'startsAt': startsAt.toJson(),
      'minutes': minutes,
      'price': price,
      'capacity': capacity,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandShow',
      if (id != null) 'id': id,
      'hostUserId': hostUserId.toJson(),
      'artist': artist,
      'title': title,
      'startsAt': startsAt.toJson(),
      'minutes': minutes,
      'price': price,
      'capacity': capacity,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandShowInclude include() {
    return IslandShowInclude._();
  }

  static IslandShowIncludeList includeList({
    _is.WhereExpressionBuilder<IslandShowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    IslandShowInclude? include,
  }) {
    return IslandShowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandShowImpl extends IslandShow {
  _IslandShowImpl({
    int? id,
    required _is.UuidValue hostUserId,
    required String artist,
    required String title,
    required DateTime startsAt,
    int? minutes,
    required int price,
    int? capacity,
    String? status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         hostUserId: hostUserId,
         artist: artist,
         title: title,
         startsAt: startsAt,
         minutes: minutes,
         price: price,
         capacity: capacity,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandShow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandShow copyWith({
    Object? id = _Undefined,
    _is.UuidValue? hostUserId,
    String? artist,
    String? title,
    DateTime? startsAt,
    int? minutes,
    int? price,
    int? capacity,
    String? status,
    DateTime? createdAt,
  }) {
    return IslandShow(
      id: id is int? ? id : this.id,
      hostUserId: hostUserId ?? this.hostUserId,
      artist: artist ?? this.artist,
      title: title ?? this.title,
      startsAt: startsAt ?? this.startsAt,
      minutes: minutes ?? this.minutes,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandShowUpdateTable extends _is.UpdateTable<IslandShowTable> {
  IslandShowUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> hostUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.hostUserId,
    value,
  );

  _is.ColumnValue<String, String> artist(String value) => _is.ColumnValue(
    table.artist,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _is.ColumnValue(
        table.startsAt,
        value,
      );

  _is.ColumnValue<int, int> minutes(int value) => _is.ColumnValue(
    table.minutes,
    value,
  );

  _is.ColumnValue<int, int> price(int value) => _is.ColumnValue(
    table.price,
    value,
  );

  _is.ColumnValue<int, int> capacity(int value) => _is.ColumnValue(
    table.capacity,
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
}

class IslandShowTable extends _is.Table<int?> {
  IslandShowTable({super.tableRelation}) : super(tableName: 'island_show') {
    updateTable = IslandShowUpdateTable(this);
    hostUserId = _is.ColumnUuid(
      'hostUserId',
      this,
    );
    artist = _is.ColumnString(
      'artist',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    startsAt = _is.ColumnDateTime(
      'startsAt',
      this,
    );
    minutes = _is.ColumnInt(
      'minutes',
      this,
      hasDefault: true,
    );
    price = _is.ColumnInt(
      'price',
      this,
    );
    capacity = _is.ColumnInt(
      'capacity',
      this,
      hasDefault: true,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandShowUpdateTable updateTable;

  late final _is.ColumnUuid hostUserId;

  late final _is.ColumnString artist;

  late final _is.ColumnString title;

  late final _is.ColumnDateTime startsAt;

  /// how long it runs
  late final _is.ColumnInt minutes;

  /// ticket price in naira (play money), 0 for free
  late final _is.ColumnInt price;

  late final _is.ColumnInt capacity;

  /// pending | on_sale | rejected | cancelled
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    hostUserId,
    artist,
    title,
    startsAt,
    minutes,
    price,
    capacity,
    status,
    createdAt,
  ];
}

class IslandShowInclude extends _is.IncludeObject {
  IslandShowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandShow.t;
}

class IslandShowIncludeList extends _is.IncludeList {
  IslandShowIncludeList._({
    _is.WhereExpressionBuilder<IslandShowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandShow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandShow.t;
}

class IslandShowRepository {
  const IslandShowRepository._();

  /// Returns a list of [IslandShow]s matching the given query parameters.
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
  Future<List<IslandShow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandShowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandShow>(
      where: where?.call(IslandShow.t),
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandShow] matching the given query parameters.
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
  Future<IslandShow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandShowTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandShow>(
      where: where?.call(IslandShow.t),
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandShow] by its [id] or null if no such row exists.
  Future<IslandShow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandShow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandShow]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandShow]s will have their `id` fields set.
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
  Future<List<IslandShow>> insert(
    _is.DatabaseSession session,
    List<IslandShow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandShow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandShow] and returns the inserted row.
  ///
  /// The returned [IslandShow] will have its `id` field set.
  Future<IslandShow> insertRow(
    _is.DatabaseSession session,
    IslandShow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandShow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandShow]s in the list and returns the resulting rows.
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
  /// The returned [IslandShow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandShow>> upsert(
    _is.DatabaseSession session,
    List<IslandShow> rows, {
    required _is.ColumnSelections<IslandShowTable> conflictColumns,
    _is.ColumnSelections<IslandShowTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandShowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandShow>(
      rows,
      conflictColumns: conflictColumns(IslandShow.t),
      updateColumns: updateColumns?.call(IslandShow.t),
      updateWhere: updateWhere?.call(IslandShow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandShow] and returns the resulting row.
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
  /// The returned [IslandShow] will have its `id` field set.
  Future<IslandShow?> upsertRow(
    _is.DatabaseSession session,
    IslandShow row, {
    required _is.ColumnSelections<IslandShowTable> conflictColumns,
    _is.ColumnSelections<IslandShowTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandShowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandShow>(
      row,
      conflictColumns: conflictColumns(IslandShow.t),
      updateColumns: updateColumns?.call(IslandShow.t),
      updateWhere: updateWhere?.call(IslandShow.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandShow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandShow>> update(
    _is.DatabaseSession session,
    List<IslandShow> rows, {
    _is.ColumnSelections<IslandShowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandShow>(
      rows,
      columns: columns?.call(IslandShow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandShow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandShow> updateRow(
    _is.DatabaseSession session,
    IslandShow row, {
    _is.ColumnSelections<IslandShowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandShow>(
      row,
      columns: columns?.call(IslandShow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandShow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandShow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandShowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandShow>(
      id,
      columnValues: columnValues(IslandShow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandShow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandShow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandShowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandShowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandShow>(
      columnValues: columnValues(IslandShow.t.updateTable),
      where: where(IslandShow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandShow]s in the list and returns the deleted rows.
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
  Future<List<IslandShow>> delete(
    _is.DatabaseSession session,
    List<IslandShow> rows, {
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandShow>(
      rows,
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandShow].
  Future<IslandShow> deleteRow(
    _is.DatabaseSession session,
    IslandShow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandShow>(
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
  Future<List<IslandShow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandShowTable> where,
    _is.OrderByBuilder<IslandShowTable>? orderBy,
    _is.OrderByListBuilder<IslandShowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandShow>(
      where: where(IslandShow.t),
      orderBy: orderBy?.call(IslandShow.t),
      orderByList: orderByList?.call(IslandShow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandShowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandShow>(
      where: where?.call(IslandShow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandShow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandShowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandShow>(
      where: where(IslandShow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
