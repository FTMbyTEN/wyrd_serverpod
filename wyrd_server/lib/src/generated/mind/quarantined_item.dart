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
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;

abstract class QuarantinedItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuarantinedItem._({
    this.id,
    required this.timestamp,
    required this.source,
    required this.title,
    this.url,
    this.extract,
    required this.score,
    required this.reasons,
  });

  factory QuarantinedItem({
    int? id,
    required DateTime timestamp,
    required String source,
    required String title,
    String? url,
    String? extract,
    required double score,
    required List<String> reasons,
  }) = _QuarantinedItemImpl;

  factory QuarantinedItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuarantinedItem(
      id: jsonSerialization['id'] as int?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      source: jsonSerialization['source'] as String,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String?,
      extract: jsonSerialization['extract'] as String?,
      score: (jsonSerialization['score'] as num).toDouble(),
      reasons: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['reasons'],
      ),
    );
  }

  static final t = QuarantinedItemTable();

  static const db = QuarantinedItemRepository._();

  @override
  int? id;

  DateTime timestamp;

  String source;

  String title;

  String? url;

  String? extract;

  double score;

  List<String> reasons;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuarantinedItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuarantinedItem copyWith({
    int? id,
    DateTime? timestamp,
    String? source,
    String? title,
    String? url,
    String? extract,
    double? score,
    List<String>? reasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuarantinedItem',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'source': source,
      'title': title,
      if (url != null) 'url': url,
      if (extract != null) 'extract': extract,
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuarantinedItem',
      if (id != null) 'id': id,
      'timestamp': timestamp.toJson(),
      'source': source,
      'title': title,
      if (url != null) 'url': url,
      if (extract != null) 'extract': extract,
      'score': score,
      'reasons': reasons.toJson(),
    };
  }

  static QuarantinedItemInclude include() {
    return QuarantinedItemInclude._();
  }

  static QuarantinedItemIncludeList includeList({
    _is.WhereExpressionBuilder<QuarantinedItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    QuarantinedItemInclude? include,
  }) {
    return QuarantinedItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuarantinedItemImpl extends QuarantinedItem {
  _QuarantinedItemImpl({
    int? id,
    required DateTime timestamp,
    required String source,
    required String title,
    String? url,
    String? extract,
    required double score,
    required List<String> reasons,
  }) : super._(
         id: id,
         timestamp: timestamp,
         source: source,
         title: title,
         url: url,
         extract: extract,
         score: score,
         reasons: reasons,
       );

  /// Returns a shallow copy of this [QuarantinedItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuarantinedItem copyWith({
    Object? id = _Undefined,
    DateTime? timestamp,
    String? source,
    String? title,
    Object? url = _Undefined,
    Object? extract = _Undefined,
    double? score,
    List<String>? reasons,
  }) {
    return QuarantinedItem(
      id: id is int? ? id : this.id,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      title: title ?? this.title,
      url: url is String? ? url : this.url,
      extract: extract is String? ? extract : this.extract,
      score: score ?? this.score,
      reasons: reasons ?? this.reasons.map((e0) => e0).toList(),
    );
  }
}

class QuarantinedItemUpdateTable extends _is.UpdateTable<QuarantinedItemTable> {
  QuarantinedItemUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> url(String? value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> extract(String? value) => _is.ColumnValue(
    table.extract,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> reasons(List<String> value) =>
      _is.ColumnValue(
        table.reasons,
        value,
      );
}

class QuarantinedItemTable extends _is.Table<int?> {
  QuarantinedItemTable({super.tableRelation})
    : super(tableName: 'quarantined_item') {
    updateTable = QuarantinedItemUpdateTable(this);
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    extract = _is.ColumnString(
      'extract',
      this,
    );
    score = _is.ColumnDouble(
      'score',
      this,
    );
    reasons = _is.ColumnSerializable<List<String>>(
      'reasons',
      this,
    );
  }

  late final QuarantinedItemUpdateTable updateTable;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString source;

  late final _is.ColumnString title;

  late final _is.ColumnString url;

  late final _is.ColumnString extract;

  late final _is.ColumnDouble score;

  late final _is.ColumnSerializable<List<String>> reasons;

  @override
  List<_is.Column> get columns => [
    id,
    timestamp,
    source,
    title,
    url,
    extract,
    score,
    reasons,
  ];
}

class QuarantinedItemInclude extends _is.IncludeObject {
  QuarantinedItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuarantinedItem.t;
}

class QuarantinedItemIncludeList extends _is.IncludeList {
  QuarantinedItemIncludeList._({
    _is.WhereExpressionBuilder<QuarantinedItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuarantinedItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuarantinedItem.t;
}

class QuarantinedItemRepository {
  const QuarantinedItemRepository._();

  /// Returns a list of [QuarantinedItem]s matching the given query parameters.
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
  Future<List<QuarantinedItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuarantinedItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuarantinedItem>(
      where: where?.call(QuarantinedItem.t),
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuarantinedItem] matching the given query parameters.
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
  Future<QuarantinedItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuarantinedItemTable>? where,
    int? offset,
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuarantinedItem>(
      where: where?.call(QuarantinedItem.t),
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuarantinedItem] by its [id] or null if no such row exists.
  Future<QuarantinedItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuarantinedItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuarantinedItem]s in the list and returns the inserted rows.
  ///
  /// The returned [QuarantinedItem]s will have their `id` fields set.
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
  Future<List<QuarantinedItem>> insert(
    _is.DatabaseSession session,
    List<QuarantinedItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuarantinedItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuarantinedItem] and returns the inserted row.
  ///
  /// The returned [QuarantinedItem] will have its `id` field set.
  Future<QuarantinedItem> insertRow(
    _is.DatabaseSession session,
    QuarantinedItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuarantinedItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuarantinedItem]s in the list and returns the resulting rows.
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
  /// The returned [QuarantinedItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuarantinedItem>> upsert(
    _is.DatabaseSession session,
    List<QuarantinedItem> rows, {
    required _is.ColumnSelections<QuarantinedItemTable> conflictColumns,
    _is.ColumnSelections<QuarantinedItemTable>? updateColumns,
    _is.WhereExpressionBuilder<QuarantinedItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuarantinedItem>(
      rows,
      conflictColumns: conflictColumns(QuarantinedItem.t),
      updateColumns: updateColumns?.call(QuarantinedItem.t),
      updateWhere: updateWhere?.call(QuarantinedItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuarantinedItem] and returns the resulting row.
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
  /// The returned [QuarantinedItem] will have its `id` field set.
  Future<QuarantinedItem?> upsertRow(
    _is.DatabaseSession session,
    QuarantinedItem row, {
    required _is.ColumnSelections<QuarantinedItemTable> conflictColumns,
    _is.ColumnSelections<QuarantinedItemTable>? updateColumns,
    _is.WhereExpressionBuilder<QuarantinedItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuarantinedItem>(
      row,
      conflictColumns: conflictColumns(QuarantinedItem.t),
      updateColumns: updateColumns?.call(QuarantinedItem.t),
      updateWhere: updateWhere?.call(QuarantinedItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuarantinedItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuarantinedItem>> update(
    _is.DatabaseSession session,
    List<QuarantinedItem> rows, {
    _is.ColumnSelections<QuarantinedItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuarantinedItem>(
      rows,
      columns: columns?.call(QuarantinedItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuarantinedItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuarantinedItem> updateRow(
    _is.DatabaseSession session,
    QuarantinedItem row, {
    _is.ColumnSelections<QuarantinedItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuarantinedItem>(
      row,
      columns: columns?.call(QuarantinedItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuarantinedItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuarantinedItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuarantinedItemUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuarantinedItem>(
      id,
      columnValues: columnValues(QuarantinedItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuarantinedItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuarantinedItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuarantinedItemUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<QuarantinedItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuarantinedItem>(
      columnValues: columnValues(QuarantinedItem.t.updateTable),
      where: where(QuarantinedItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuarantinedItem]s in the list and returns the deleted rows.
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
  Future<List<QuarantinedItem>> delete(
    _is.DatabaseSession session,
    List<QuarantinedItem> rows, {
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuarantinedItem>(
      rows,
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuarantinedItem].
  Future<QuarantinedItem> deleteRow(
    _is.DatabaseSession session,
    QuarantinedItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuarantinedItem>(
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
  Future<List<QuarantinedItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuarantinedItemTable> where,
    _is.OrderByBuilder<QuarantinedItemTable>? orderBy,
    _is.OrderByListBuilder<QuarantinedItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuarantinedItem>(
      where: where(QuarantinedItem.t),
      orderBy: orderBy?.call(QuarantinedItem.t),
      orderByList: orderByList?.call(QuarantinedItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuarantinedItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuarantinedItem>(
      where: where?.call(QuarantinedItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuarantinedItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuarantinedItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuarantinedItem>(
      where: where(QuarantinedItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
