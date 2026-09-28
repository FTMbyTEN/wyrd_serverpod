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

abstract class ReadingItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ReadingItem._({
    this.id,
    required this.authUserId,
    required this.url,
    required this.title,
    required this.kind,
    this.nextOffset,
    this.lastOffset,
    required this.total,
    this.source,
    this.author,
    this.partIndex,
    this.partCount,
    this.partTitle,
    this.partUrl,
    required this.startedAt,
    required this.updatedAt,
  });

  factory ReadingItem({
    int? id,
    required _is.UuidValue authUserId,
    required String url,
    required String title,
    required String kind,
    int? nextOffset,
    int? lastOffset,
    required int total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    required DateTime startedAt,
    required DateTime updatedAt,
  }) = _ReadingItemImpl;

  factory ReadingItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingItem(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      url: jsonSerialization['url'] as String,
      title: jsonSerialization['title'] as String,
      kind: jsonSerialization['kind'] as String,
      nextOffset: jsonSerialization['nextOffset'] as int?,
      lastOffset: jsonSerialization['lastOffset'] as int?,
      total: jsonSerialization['total'] as int,
      source: jsonSerialization['source'] as String?,
      author: jsonSerialization['author'] as String?,
      partIndex: jsonSerialization['partIndex'] as int?,
      partCount: jsonSerialization['partCount'] as int?,
      partTitle: jsonSerialization['partTitle'] as String?,
      partUrl: jsonSerialization['partUrl'] as String?,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ReadingItemTable();

  static const db = ReadingItemRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String url;

  String title;

  String kind;

  int? nextOffset;

  int? lastOffset;

  int total;

  String? source;

  String? author;

  int? partIndex;

  int? partCount;

  String? partTitle;

  String? partUrl;

  DateTime startedAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReadingItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReadingItem copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? url,
    String? title,
    String? kind,
    int? nextOffset,
    int? lastOffset,
    int? total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    DateTime? startedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingItem',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'url': url,
      'title': title,
      'kind': kind,
      if (nextOffset != null) 'nextOffset': nextOffset,
      if (lastOffset != null) 'lastOffset': lastOffset,
      'total': total,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (partIndex != null) 'partIndex': partIndex,
      if (partCount != null) 'partCount': partCount,
      if (partTitle != null) 'partTitle': partTitle,
      if (partUrl != null) 'partUrl': partUrl,
      'startedAt': startedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingItem',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'url': url,
      'title': title,
      'kind': kind,
      if (nextOffset != null) 'nextOffset': nextOffset,
      if (lastOffset != null) 'lastOffset': lastOffset,
      'total': total,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (partIndex != null) 'partIndex': partIndex,
      if (partCount != null) 'partCount': partCount,
      if (partTitle != null) 'partTitle': partTitle,
      if (partUrl != null) 'partUrl': partUrl,
      'startedAt': startedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ReadingItemInclude include() {
    return ReadingItemInclude._();
  }

  static ReadingItemIncludeList includeList({
    _is.WhereExpressionBuilder<ReadingItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    ReadingItemInclude? include,
  }) {
    return ReadingItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReadingItemImpl extends ReadingItem {
  _ReadingItemImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String url,
    required String title,
    required String kind,
    int? nextOffset,
    int? lastOffset,
    required int total,
    String? source,
    String? author,
    int? partIndex,
    int? partCount,
    String? partTitle,
    String? partUrl,
    required DateTime startedAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         url: url,
         title: title,
         kind: kind,
         nextOffset: nextOffset,
         lastOffset: lastOffset,
         total: total,
         source: source,
         author: author,
         partIndex: partIndex,
         partCount: partCount,
         partTitle: partTitle,
         partUrl: partUrl,
         startedAt: startedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReadingItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReadingItem copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? url,
    String? title,
    String? kind,
    Object? nextOffset = _Undefined,
    Object? lastOffset = _Undefined,
    int? total,
    Object? source = _Undefined,
    Object? author = _Undefined,
    Object? partIndex = _Undefined,
    Object? partCount = _Undefined,
    Object? partTitle = _Undefined,
    Object? partUrl = _Undefined,
    DateTime? startedAt,
    DateTime? updatedAt,
  }) {
    return ReadingItem(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      url: url ?? this.url,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      nextOffset: nextOffset is int? ? nextOffset : this.nextOffset,
      lastOffset: lastOffset is int? ? lastOffset : this.lastOffset,
      total: total ?? this.total,
      source: source is String? ? source : this.source,
      author: author is String? ? author : this.author,
      partIndex: partIndex is int? ? partIndex : this.partIndex,
      partCount: partCount is int? ? partCount : this.partCount,
      partTitle: partTitle is String? ? partTitle : this.partTitle,
      partUrl: partUrl is String? ? partUrl : this.partUrl,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReadingItemUpdateTable extends _is.UpdateTable<ReadingItemTable> {
  ReadingItemUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> url(String value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> nextOffset(int? value) => _is.ColumnValue(
    table.nextOffset,
    value,
  );

  _is.ColumnValue<int, int> lastOffset(int? value) => _is.ColumnValue(
    table.lastOffset,
    value,
  );

  _is.ColumnValue<int, int> total(int value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<String, String> source(String? value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> author(String? value) => _is.ColumnValue(
    table.author,
    value,
  );

  _is.ColumnValue<int, int> partIndex(int? value) => _is.ColumnValue(
    table.partIndex,
    value,
  );

  _is.ColumnValue<int, int> partCount(int? value) => _is.ColumnValue(
    table.partCount,
    value,
  );

  _is.ColumnValue<String, String> partTitle(String? value) => _is.ColumnValue(
    table.partTitle,
    value,
  );

  _is.ColumnValue<String, String> partUrl(String? value) => _is.ColumnValue(
    table.partUrl,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ReadingItemTable extends _is.Table<int?> {
  ReadingItemTable({super.tableRelation}) : super(tableName: 'reading_item') {
    updateTable = ReadingItemUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    nextOffset = _is.ColumnInt(
      'nextOffset',
      this,
    );
    lastOffset = _is.ColumnInt(
      'lastOffset',
      this,
    );
    total = _is.ColumnInt(
      'total',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    author = _is.ColumnString(
      'author',
      this,
    );
    partIndex = _is.ColumnInt(
      'partIndex',
      this,
    );
    partCount = _is.ColumnInt(
      'partCount',
      this,
    );
    partTitle = _is.ColumnString(
      'partTitle',
      this,
    );
    partUrl = _is.ColumnString(
      'partUrl',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ReadingItemUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString url;

  late final _is.ColumnString title;

  late final _is.ColumnString kind;

  late final _is.ColumnInt nextOffset;

  late final _is.ColumnInt lastOffset;

  late final _is.ColumnInt total;

  late final _is.ColumnString source;

  late final _is.ColumnString author;

  late final _is.ColumnInt partIndex;

  late final _is.ColumnInt partCount;

  late final _is.ColumnString partTitle;

  late final _is.ColumnString partUrl;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    url,
    title,
    kind,
    nextOffset,
    lastOffset,
    total,
    source,
    author,
    partIndex,
    partCount,
    partTitle,
    partUrl,
    startedAt,
    updatedAt,
  ];
}

class ReadingItemInclude extends _is.IncludeObject {
  ReadingItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReadingItem.t;
}

class ReadingItemIncludeList extends _is.IncludeList {
  ReadingItemIncludeList._({
    _is.WhereExpressionBuilder<ReadingItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReadingItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReadingItem.t;
}

class ReadingItemRepository {
  const ReadingItemRepository._();

  /// Returns a list of [ReadingItem]s matching the given query parameters.
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
  Future<List<ReadingItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReadingItem>(
      where: where?.call(ReadingItem.t),
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReadingItem] matching the given query parameters.
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
  Future<ReadingItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingItemTable>? where,
    int? offset,
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReadingItem>(
      where: where?.call(ReadingItem.t),
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReadingItem] by its [id] or null if no such row exists.
  Future<ReadingItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReadingItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReadingItem]s in the list and returns the inserted rows.
  ///
  /// The returned [ReadingItem]s will have their `id` fields set.
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
  Future<List<ReadingItem>> insert(
    _is.DatabaseSession session,
    List<ReadingItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReadingItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReadingItem] and returns the inserted row.
  ///
  /// The returned [ReadingItem] will have its `id` field set.
  Future<ReadingItem> insertRow(
    _is.DatabaseSession session,
    ReadingItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReadingItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReadingItem]s in the list and returns the resulting rows.
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
  /// The returned [ReadingItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingItem>> upsert(
    _is.DatabaseSession session,
    List<ReadingItem> rows, {
    required _is.ColumnSelections<ReadingItemTable> conflictColumns,
    _is.ColumnSelections<ReadingItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ReadingItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReadingItem>(
      rows,
      conflictColumns: conflictColumns(ReadingItem.t),
      updateColumns: updateColumns?.call(ReadingItem.t),
      updateWhere: updateWhere?.call(ReadingItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReadingItem] and returns the resulting row.
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
  /// The returned [ReadingItem] will have its `id` field set.
  Future<ReadingItem?> upsertRow(
    _is.DatabaseSession session,
    ReadingItem row, {
    required _is.ColumnSelections<ReadingItemTable> conflictColumns,
    _is.ColumnSelections<ReadingItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ReadingItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReadingItem>(
      row,
      conflictColumns: conflictColumns(ReadingItem.t),
      updateColumns: updateColumns?.call(ReadingItem.t),
      updateWhere: updateWhere?.call(ReadingItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReadingItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingItem>> update(
    _is.DatabaseSession session,
    List<ReadingItem> rows, {
    _is.ColumnSelections<ReadingItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReadingItem>(
      rows,
      columns: columns?.call(ReadingItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReadingItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReadingItem> updateRow(
    _is.DatabaseSession session,
    ReadingItem row, {
    _is.ColumnSelections<ReadingItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReadingItem>(
      row,
      columns: columns?.call(ReadingItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadingItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReadingItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReadingItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReadingItem>(
      id,
      columnValues: columnValues(ReadingItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReadingItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReadingItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReadingItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReadingItem>(
      columnValues: columnValues(ReadingItem.t.updateTable),
      where: where(ReadingItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReadingItem]s in the list and returns the deleted rows.
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
  Future<List<ReadingItem>> delete(
    _is.DatabaseSession session,
    List<ReadingItem> rows, {
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReadingItem>(
      rows,
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReadingItem].
  Future<ReadingItem> deleteRow(
    _is.DatabaseSession session,
    ReadingItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReadingItem>(
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
  Future<List<ReadingItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReadingItemTable> where,
    _is.OrderByBuilder<ReadingItemTable>? orderBy,
    _is.OrderByListBuilder<ReadingItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReadingItem>(
      where: where(ReadingItem.t),
      orderBy: orderBy?.call(ReadingItem.t),
      orderByList: orderByList?.call(ReadingItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReadingItem>(
      where: where?.call(ReadingItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReadingItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReadingItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReadingItem>(
      where: where(ReadingItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
