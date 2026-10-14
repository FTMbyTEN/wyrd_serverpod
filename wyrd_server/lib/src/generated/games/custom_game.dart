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

/// A game WYRD programmed for someone at their request (build_game, written in the background):
/// one self-contained HTML document, played full screen in a sandboxed frame from their Games tab.
abstract class CustomGame
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CustomGame._({
    this.id,
    required this.authUserId,
    required this.title,
    required this.blurb,
    required this.html,
    this.status,
    this.wyrdBest,
    this.wyrdRounds,
    this.wyrdParams,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomGame({
    int? id,
    required _is.UuidValue authUserId,
    required String title,
    required String blurb,
    required String html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CustomGameImpl;

  factory CustomGame.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomGame(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String,
      blurb: jsonSerialization['blurb'] as String,
      html: jsonSerialization['html'] as String,
      status: jsonSerialization['status'] as String?,
      wyrdBest: jsonSerialization['wyrdBest'] as int?,
      wyrdRounds: jsonSerialization['wyrdRounds'] as int?,
      wyrdParams: jsonSerialization['wyrdParams'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CustomGameTable();

  static const db = CustomGameRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String title;

  String blurb;

  String html;

  String? status;

  int? wyrdBest;

  int? wyrdRounds;

  String? wyrdParams;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CustomGame]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomGame copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? title,
    String? blurb,
    String? html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomGame',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'blurb': blurb,
      'html': html,
      if (status != null) 'status': status,
      if (wyrdBest != null) 'wyrdBest': wyrdBest,
      if (wyrdRounds != null) 'wyrdRounds': wyrdRounds,
      if (wyrdParams != null) 'wyrdParams': wyrdParams,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomGame',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'blurb': blurb,
      'html': html,
      if (status != null) 'status': status,
      if (wyrdBest != null) 'wyrdBest': wyrdBest,
      if (wyrdRounds != null) 'wyrdRounds': wyrdRounds,
      if (wyrdParams != null) 'wyrdParams': wyrdParams,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CustomGameInclude include() {
    return CustomGameInclude._();
  }

  static CustomGameIncludeList includeList({
    _is.WhereExpressionBuilder<CustomGameTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    CustomGameInclude? include,
  }) {
    return CustomGameIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomGameImpl extends CustomGame {
  _CustomGameImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String title,
    required String blurb,
    required String html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         title: title,
         blurb: blurb,
         html: html,
         status: status,
         wyrdBest: wyrdBest,
         wyrdRounds: wyrdRounds,
         wyrdParams: wyrdParams,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CustomGame]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomGame copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? title,
    String? blurb,
    String? html,
    Object? status = _Undefined,
    Object? wyrdBest = _Undefined,
    Object? wyrdRounds = _Undefined,
    Object? wyrdParams = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomGame(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      title: title ?? this.title,
      blurb: blurb ?? this.blurb,
      html: html ?? this.html,
      status: status is String? ? status : this.status,
      wyrdBest: wyrdBest is int? ? wyrdBest : this.wyrdBest,
      wyrdRounds: wyrdRounds is int? ? wyrdRounds : this.wyrdRounds,
      wyrdParams: wyrdParams is String? ? wyrdParams : this.wyrdParams,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CustomGameUpdateTable extends _is.UpdateTable<CustomGameTable> {
  CustomGameUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> blurb(String value) => _is.ColumnValue(
    table.blurb,
    value,
  );

  _is.ColumnValue<String, String> html(String value) => _is.ColumnValue(
    table.html,
    value,
  );

  _is.ColumnValue<String, String> status(String? value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> wyrdBest(int? value) => _is.ColumnValue(
    table.wyrdBest,
    value,
  );

  _is.ColumnValue<int, int> wyrdRounds(int? value) => _is.ColumnValue(
    table.wyrdRounds,
    value,
  );

  _is.ColumnValue<String, String> wyrdParams(String? value) => _is.ColumnValue(
    table.wyrdParams,
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

class CustomGameTable extends _is.Table<int?> {
  CustomGameTable({super.tableRelation}) : super(tableName: 'custom_game') {
    updateTable = CustomGameUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    blurb = _is.ColumnString(
      'blurb',
      this,
    );
    html = _is.ColumnString(
      'html',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    wyrdBest = _is.ColumnInt(
      'wyrdBest',
      this,
    );
    wyrdRounds = _is.ColumnInt(
      'wyrdRounds',
      this,
    );
    wyrdParams = _is.ColumnString(
      'wyrdParams',
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

  late final CustomGameUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString title;

  late final _is.ColumnString blurb;

  late final _is.ColumnString html;

  late final _is.ColumnString status;

  late final _is.ColumnInt wyrdBest;

  late final _is.ColumnInt wyrdRounds;

  late final _is.ColumnString wyrdParams;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    title,
    blurb,
    html,
    status,
    wyrdBest,
    wyrdRounds,
    wyrdParams,
    createdAt,
    updatedAt,
  ];
}

class CustomGameInclude extends _is.IncludeObject {
  CustomGameInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CustomGame.t;
}

class CustomGameIncludeList extends _is.IncludeList {
  CustomGameIncludeList._({
    _is.WhereExpressionBuilder<CustomGameTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CustomGame.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CustomGame.t;
}

class CustomGameRepository {
  const CustomGameRepository._();

  /// Returns a list of [CustomGame]s matching the given query parameters.
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
  Future<List<CustomGame>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomGameTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CustomGame>(
      where: where?.call(CustomGame.t),
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CustomGame] matching the given query parameters.
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
  Future<CustomGame?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomGameTable>? where,
    int? offset,
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CustomGame>(
      where: where?.call(CustomGame.t),
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CustomGame] by its [id] or null if no such row exists.
  Future<CustomGame?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CustomGame>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CustomGame]s in the list and returns the inserted rows.
  ///
  /// The returned [CustomGame]s will have their `id` fields set.
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
  Future<List<CustomGame>> insert(
    _is.DatabaseSession session,
    List<CustomGame> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CustomGame>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CustomGame] and returns the inserted row.
  ///
  /// The returned [CustomGame] will have its `id` field set.
  Future<CustomGame> insertRow(
    _is.DatabaseSession session,
    CustomGame row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CustomGame>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CustomGame]s in the list and returns the resulting rows.
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
  /// The returned [CustomGame]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomGame>> upsert(
    _is.DatabaseSession session,
    List<CustomGame> rows, {
    required _is.ColumnSelections<CustomGameTable> conflictColumns,
    _is.ColumnSelections<CustomGameTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomGameTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CustomGame>(
      rows,
      conflictColumns: conflictColumns(CustomGame.t),
      updateColumns: updateColumns?.call(CustomGame.t),
      updateWhere: updateWhere?.call(CustomGame.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CustomGame] and returns the resulting row.
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
  /// The returned [CustomGame] will have its `id` field set.
  Future<CustomGame?> upsertRow(
    _is.DatabaseSession session,
    CustomGame row, {
    required _is.ColumnSelections<CustomGameTable> conflictColumns,
    _is.ColumnSelections<CustomGameTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomGameTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CustomGame>(
      row,
      conflictColumns: conflictColumns(CustomGame.t),
      updateColumns: updateColumns?.call(CustomGame.t),
      updateWhere: updateWhere?.call(CustomGame.t),
      transaction: transaction,
    );
  }

  /// Updates all [CustomGame]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomGame>> update(
    _is.DatabaseSession session,
    List<CustomGame> rows, {
    _is.ColumnSelections<CustomGameTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CustomGame>(
      rows,
      columns: columns?.call(CustomGame.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CustomGame]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CustomGame> updateRow(
    _is.DatabaseSession session,
    CustomGame row, {
    _is.ColumnSelections<CustomGameTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CustomGame>(
      row,
      columns: columns?.call(CustomGame.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CustomGame] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CustomGame?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CustomGameUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CustomGame>(
      id,
      columnValues: columnValues(CustomGame.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CustomGame]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomGame>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CustomGameUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CustomGameTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CustomGame>(
      columnValues: columnValues(CustomGame.t.updateTable),
      where: where(CustomGame.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CustomGame]s in the list and returns the deleted rows.
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
  Future<List<CustomGame>> delete(
    _is.DatabaseSession session,
    List<CustomGame> rows, {
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CustomGame>(
      rows,
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CustomGame].
  Future<CustomGame> deleteRow(
    _is.DatabaseSession session,
    CustomGame row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CustomGame>(
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
  Future<List<CustomGame>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomGameTable> where,
    _is.OrderByBuilder<CustomGameTable>? orderBy,
    _is.OrderByListBuilder<CustomGameTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CustomGame>(
      where: where(CustomGame.t),
      orderBy: orderBy?.call(CustomGame.t),
      orderByList: orderByList?.call(CustomGame.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomGameTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CustomGame>(
      where: where?.call(CustomGame.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CustomGame] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomGameTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CustomGame>(
      where: where(CustomGame.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
