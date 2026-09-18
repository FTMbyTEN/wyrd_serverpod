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

abstract class MemoryBlock
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MemoryBlock._({
    this.id,
    this.legacyId,
    required this.timestamp,
    required this.source,
    this.feedSource,
    this.title,
    this.extract,
    this.url,
    this.userText,
    this.botText,
    this.triggeredBy,
    required this.topics,
    this.curriculum,
  });

  factory MemoryBlock({
    int? id,
    String? legacyId,
    required DateTime timestamp,
    required String source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    required List<String> topics,
    String? curriculum,
  }) = _MemoryBlockImpl;

  factory MemoryBlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemoryBlock(
      id: jsonSerialization['id'] as int?,
      legacyId: jsonSerialization['legacyId'] as String?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      source: jsonSerialization['source'] as String,
      feedSource: jsonSerialization['feedSource'] as String?,
      title: jsonSerialization['title'] as String?,
      extract: jsonSerialization['extract'] as String?,
      url: jsonSerialization['url'] as String?,
      userText: jsonSerialization['userText'] as String?,
      botText: jsonSerialization['botText'] as String?,
      triggeredBy: jsonSerialization['triggeredBy'] as String?,
      topics: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      curriculum: jsonSerialization['curriculum'] as String?,
    );
  }

  static final t = MemoryBlockTable();

  static const db = MemoryBlockRepository._();

  @override
  int? id;

  String? legacyId;

  DateTime timestamp;

  String source;

  String? feedSource;

  String? title;

  String? extract;

  String? url;

  String? userText;

  String? botText;

  String? triggeredBy;

  List<String> topics;

  String? curriculum;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MemoryBlock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MemoryBlock copyWith({
    int? id,
    String? legacyId,
    DateTime? timestamp,
    String? source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    List<String>? topics,
    String? curriculum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemoryBlock',
      if (id != null) 'id': id,
      if (legacyId != null) 'legacyId': legacyId,
      'timestamp': timestamp.toJson(),
      'source': source,
      if (feedSource != null) 'feedSource': feedSource,
      if (title != null) 'title': title,
      if (extract != null) 'extract': extract,
      if (url != null) 'url': url,
      if (userText != null) 'userText': userText,
      if (botText != null) 'botText': botText,
      if (triggeredBy != null) 'triggeredBy': triggeredBy,
      'topics': topics.toJson(),
      if (curriculum != null) 'curriculum': curriculum,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemoryBlock',
      if (id != null) 'id': id,
      if (legacyId != null) 'legacyId': legacyId,
      'timestamp': timestamp.toJson(),
      'source': source,
      if (feedSource != null) 'feedSource': feedSource,
      if (title != null) 'title': title,
      if (extract != null) 'extract': extract,
      if (url != null) 'url': url,
      if (userText != null) 'userText': userText,
      if (botText != null) 'botText': botText,
      if (triggeredBy != null) 'triggeredBy': triggeredBy,
      'topics': topics.toJson(),
      if (curriculum != null) 'curriculum': curriculum,
    };
  }

  static MemoryBlockInclude include() {
    return MemoryBlockInclude._();
  }

  static MemoryBlockIncludeList includeList({
    _is.WhereExpressionBuilder<MemoryBlockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    MemoryBlockInclude? include,
  }) {
    return MemoryBlockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryBlockImpl extends MemoryBlock {
  _MemoryBlockImpl({
    int? id,
    String? legacyId,
    required DateTime timestamp,
    required String source,
    String? feedSource,
    String? title,
    String? extract,
    String? url,
    String? userText,
    String? botText,
    String? triggeredBy,
    required List<String> topics,
    String? curriculum,
  }) : super._(
         id: id,
         legacyId: legacyId,
         timestamp: timestamp,
         source: source,
         feedSource: feedSource,
         title: title,
         extract: extract,
         url: url,
         userText: userText,
         botText: botText,
         triggeredBy: triggeredBy,
         topics: topics,
         curriculum: curriculum,
       );

  /// Returns a shallow copy of this [MemoryBlock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MemoryBlock copyWith({
    Object? id = _Undefined,
    Object? legacyId = _Undefined,
    DateTime? timestamp,
    String? source,
    Object? feedSource = _Undefined,
    Object? title = _Undefined,
    Object? extract = _Undefined,
    Object? url = _Undefined,
    Object? userText = _Undefined,
    Object? botText = _Undefined,
    Object? triggeredBy = _Undefined,
    List<String>? topics,
    Object? curriculum = _Undefined,
  }) {
    return MemoryBlock(
      id: id is int? ? id : this.id,
      legacyId: legacyId is String? ? legacyId : this.legacyId,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      feedSource: feedSource is String? ? feedSource : this.feedSource,
      title: title is String? ? title : this.title,
      extract: extract is String? ? extract : this.extract,
      url: url is String? ? url : this.url,
      userText: userText is String? ? userText : this.userText,
      botText: botText is String? ? botText : this.botText,
      triggeredBy: triggeredBy is String? ? triggeredBy : this.triggeredBy,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      curriculum: curriculum is String? ? curriculum : this.curriculum,
    );
  }
}

class MemoryBlockUpdateTable extends _is.UpdateTable<MemoryBlockTable> {
  MemoryBlockUpdateTable(super.table);

  _is.ColumnValue<String, String> legacyId(String? value) => _is.ColumnValue(
    table.legacyId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> feedSource(String? value) => _is.ColumnValue(
    table.feedSource,
    value,
  );

  _is.ColumnValue<String, String> title(String? value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> extract(String? value) => _is.ColumnValue(
    table.extract,
    value,
  );

  _is.ColumnValue<String, String> url(String? value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> userText(String? value) => _is.ColumnValue(
    table.userText,
    value,
  );

  _is.ColumnValue<String, String> botText(String? value) => _is.ColumnValue(
    table.botText,
    value,
  );

  _is.ColumnValue<String, String> triggeredBy(String? value) => _is.ColumnValue(
    table.triggeredBy,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> topics(List<String> value) =>
      _is.ColumnValue(
        table.topics,
        value,
      );

  _is.ColumnValue<String, String> curriculum(String? value) => _is.ColumnValue(
    table.curriculum,
    value,
  );
}

class MemoryBlockTable extends _is.Table<int?> {
  MemoryBlockTable({super.tableRelation}) : super(tableName: 'memory_block') {
    updateTable = MemoryBlockUpdateTable(this);
    legacyId = _is.ColumnString(
      'legacyId',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    feedSource = _is.ColumnString(
      'feedSource',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    extract = _is.ColumnString(
      'extract',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    userText = _is.ColumnString(
      'userText',
      this,
    );
    botText = _is.ColumnString(
      'botText',
      this,
    );
    triggeredBy = _is.ColumnString(
      'triggeredBy',
      this,
    );
    topics = _is.ColumnSerializable<List<String>>(
      'topics',
      this,
    );
    curriculum = _is.ColumnString(
      'curriculum',
      this,
    );
  }

  late final MemoryBlockUpdateTable updateTable;

  late final _is.ColumnString legacyId;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString source;

  late final _is.ColumnString feedSource;

  late final _is.ColumnString title;

  late final _is.ColumnString extract;

  late final _is.ColumnString url;

  late final _is.ColumnString userText;

  late final _is.ColumnString botText;

  late final _is.ColumnString triggeredBy;

  late final _is.ColumnSerializable<List<String>> topics;

  late final _is.ColumnString curriculum;

  @override
  List<_is.Column> get columns => [
    id,
    legacyId,
    timestamp,
    source,
    feedSource,
    title,
    extract,
    url,
    userText,
    botText,
    triggeredBy,
    topics,
    curriculum,
  ];
}

class MemoryBlockInclude extends _is.IncludeObject {
  MemoryBlockInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MemoryBlock.t;
}

class MemoryBlockIncludeList extends _is.IncludeList {
  MemoryBlockIncludeList._({
    _is.WhereExpressionBuilder<MemoryBlockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MemoryBlock.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MemoryBlock.t;
}

class MemoryBlockRepository {
  const MemoryBlockRepository._();

  /// Returns a list of [MemoryBlock]s matching the given query parameters.
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
  Future<List<MemoryBlock>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryBlockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MemoryBlock>(
      where: where?.call(MemoryBlock.t),
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MemoryBlock] matching the given query parameters.
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
  Future<MemoryBlock?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryBlockTable>? where,
    int? offset,
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MemoryBlock>(
      where: where?.call(MemoryBlock.t),
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MemoryBlock] by its [id] or null if no such row exists.
  Future<MemoryBlock?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MemoryBlock>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MemoryBlock]s in the list and returns the inserted rows.
  ///
  /// The returned [MemoryBlock]s will have their `id` fields set.
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
  Future<List<MemoryBlock>> insert(
    _is.DatabaseSession session,
    List<MemoryBlock> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MemoryBlock>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MemoryBlock] and returns the inserted row.
  ///
  /// The returned [MemoryBlock] will have its `id` field set.
  Future<MemoryBlock> insertRow(
    _is.DatabaseSession session,
    MemoryBlock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MemoryBlock>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MemoryBlock]s in the list and returns the resulting rows.
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
  /// The returned [MemoryBlock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MemoryBlock>> upsert(
    _is.DatabaseSession session,
    List<MemoryBlock> rows, {
    required _is.ColumnSelections<MemoryBlockTable> conflictColumns,
    _is.ColumnSelections<MemoryBlockTable>? updateColumns,
    _is.WhereExpressionBuilder<MemoryBlockTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MemoryBlock>(
      rows,
      conflictColumns: conflictColumns(MemoryBlock.t),
      updateColumns: updateColumns?.call(MemoryBlock.t),
      updateWhere: updateWhere?.call(MemoryBlock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MemoryBlock] and returns the resulting row.
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
  /// The returned [MemoryBlock] will have its `id` field set.
  Future<MemoryBlock?> upsertRow(
    _is.DatabaseSession session,
    MemoryBlock row, {
    required _is.ColumnSelections<MemoryBlockTable> conflictColumns,
    _is.ColumnSelections<MemoryBlockTable>? updateColumns,
    _is.WhereExpressionBuilder<MemoryBlockTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MemoryBlock>(
      row,
      conflictColumns: conflictColumns(MemoryBlock.t),
      updateColumns: updateColumns?.call(MemoryBlock.t),
      updateWhere: updateWhere?.call(MemoryBlock.t),
      transaction: transaction,
    );
  }

  /// Updates all [MemoryBlock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MemoryBlock>> update(
    _is.DatabaseSession session,
    List<MemoryBlock> rows, {
    _is.ColumnSelections<MemoryBlockTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MemoryBlock>(
      rows,
      columns: columns?.call(MemoryBlock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MemoryBlock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MemoryBlock> updateRow(
    _is.DatabaseSession session,
    MemoryBlock row, {
    _is.ColumnSelections<MemoryBlockTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MemoryBlock>(
      row,
      columns: columns?.call(MemoryBlock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MemoryBlock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MemoryBlock?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MemoryBlockUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MemoryBlock>(
      id,
      columnValues: columnValues(MemoryBlock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MemoryBlock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MemoryBlock>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MemoryBlockUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MemoryBlockTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MemoryBlock>(
      columnValues: columnValues(MemoryBlock.t.updateTable),
      where: where(MemoryBlock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MemoryBlock]s in the list and returns the deleted rows.
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
  Future<List<MemoryBlock>> delete(
    _is.DatabaseSession session,
    List<MemoryBlock> rows, {
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MemoryBlock>(
      rows,
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MemoryBlock].
  Future<MemoryBlock> deleteRow(
    _is.DatabaseSession session,
    MemoryBlock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MemoryBlock>(
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
  Future<List<MemoryBlock>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MemoryBlockTable> where,
    _is.OrderByBuilder<MemoryBlockTable>? orderBy,
    _is.OrderByListBuilder<MemoryBlockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MemoryBlock>(
      where: where(MemoryBlock.t),
      orderBy: orderBy?.call(MemoryBlock.t),
      orderByList: orderByList?.call(MemoryBlock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryBlockTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MemoryBlock>(
      where: where?.call(MemoryBlock.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MemoryBlock] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MemoryBlockTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MemoryBlock>(
      where: where(MemoryBlock.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
