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

/// A partner's usage per day, environment and surface: requests, tokens and what the model cost (millionths of a dollar).
abstract class PartnerUsage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerUsage._({
    this.id,
    required this.day,
    required this.partner,
    required this.env,
    required this.surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) : requests = requests ?? 0,
       inputTokens = inputTokens ?? 0,
       outputTokens = outputTokens ?? 0,
       costMicros = costMicros ?? 0;

  factory PartnerUsage({
    int? id,
    required String day,
    required String partner,
    required String env,
    required String surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) = _PartnerUsageImpl;

  factory PartnerUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerUsage(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      surface: jsonSerialization['surface'] as String,
      requests: jsonSerialization['requests'] as int?,
      inputTokens: jsonSerialization['inputTokens'] as int?,
      outputTokens: jsonSerialization['outputTokens'] as int?,
      costMicros: jsonSerialization['costMicros'] as int?,
    );
  }

  static final t = PartnerUsageTable();

  static const db = PartnerUsageRepository._();

  @override
  int? id;

  String day;

  String partner;

  String env;

  String surface;

  int requests;

  int inputTokens;

  int outputTokens;

  int costMicros;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerUsage copyWith({
    int? id,
    String? day,
    String? partner,
    String? env,
    String? surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerUsage',
      if (id != null) 'id': id,
      'day': day,
      'partner': partner,
      'env': env,
      'surface': surface,
      'requests': requests,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costMicros': costMicros,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerUsage',
      if (id != null) 'id': id,
      'day': day,
      'partner': partner,
      'env': env,
      'surface': surface,
      'requests': requests,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costMicros': costMicros,
    };
  }

  static PartnerUsageInclude include() {
    return PartnerUsageInclude._();
  }

  static PartnerUsageIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    PartnerUsageInclude? include,
  }) {
    return PartnerUsageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerUsageImpl extends PartnerUsage {
  _PartnerUsageImpl({
    int? id,
    required String day,
    required String partner,
    required String env,
    required String surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) : super._(
         id: id,
         day: day,
         partner: partner,
         env: env,
         surface: surface,
         requests: requests,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         costMicros: costMicros,
       );

  /// Returns a shallow copy of this [PartnerUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerUsage copyWith({
    Object? id = _Undefined,
    String? day,
    String? partner,
    String? env,
    String? surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) {
    return PartnerUsage(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      surface: surface ?? this.surface,
      requests: requests ?? this.requests,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      costMicros: costMicros ?? this.costMicros,
    );
  }
}

class PartnerUsageUpdateTable extends _is.UpdateTable<PartnerUsageTable> {
  PartnerUsageUpdateTable(super.table);

  _is.ColumnValue<String, String> day(String value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<String, String> partner(String value) => _is.ColumnValue(
    table.partner,
    value,
  );

  _is.ColumnValue<String, String> env(String value) => _is.ColumnValue(
    table.env,
    value,
  );

  _is.ColumnValue<String, String> surface(String value) => _is.ColumnValue(
    table.surface,
    value,
  );

  _is.ColumnValue<int, int> requests(int value) => _is.ColumnValue(
    table.requests,
    value,
  );

  _is.ColumnValue<int, int> inputTokens(int value) => _is.ColumnValue(
    table.inputTokens,
    value,
  );

  _is.ColumnValue<int, int> outputTokens(int value) => _is.ColumnValue(
    table.outputTokens,
    value,
  );

  _is.ColumnValue<int, int> costMicros(int value) => _is.ColumnValue(
    table.costMicros,
    value,
  );
}

class PartnerUsageTable extends _is.Table<int?> {
  PartnerUsageTable({super.tableRelation}) : super(tableName: 'partner_usage') {
    updateTable = PartnerUsageUpdateTable(this);
    day = _is.ColumnString(
      'day',
      this,
    );
    partner = _is.ColumnString(
      'partner',
      this,
    );
    env = _is.ColumnString(
      'env',
      this,
    );
    surface = _is.ColumnString(
      'surface',
      this,
    );
    requests = _is.ColumnInt(
      'requests',
      this,
      hasDefault: true,
    );
    inputTokens = _is.ColumnInt(
      'inputTokens',
      this,
      hasDefault: true,
    );
    outputTokens = _is.ColumnInt(
      'outputTokens',
      this,
      hasDefault: true,
    );
    costMicros = _is.ColumnInt(
      'costMicros',
      this,
      hasDefault: true,
    );
  }

  late final PartnerUsageUpdateTable updateTable;

  late final _is.ColumnString day;

  late final _is.ColumnString partner;

  late final _is.ColumnString env;

  late final _is.ColumnString surface;

  late final _is.ColumnInt requests;

  late final _is.ColumnInt inputTokens;

  late final _is.ColumnInt outputTokens;

  late final _is.ColumnInt costMicros;

  @override
  List<_is.Column> get columns => [
    id,
    day,
    partner,
    env,
    surface,
    requests,
    inputTokens,
    outputTokens,
    costMicros,
  ];
}

class PartnerUsageInclude extends _is.IncludeObject {
  PartnerUsageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerUsage.t;
}

class PartnerUsageIncludeList extends _is.IncludeList {
  PartnerUsageIncludeList._({
    _is.WhereExpressionBuilder<PartnerUsageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerUsage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerUsage.t;
}

class PartnerUsageRepository {
  const PartnerUsageRepository._();

  /// Returns a list of [PartnerUsage]s matching the given query parameters.
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
  Future<List<PartnerUsage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerUsage>(
      where: where?.call(PartnerUsage.t),
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerUsage] matching the given query parameters.
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
  Future<PartnerUsage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerUsageTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerUsage>(
      where: where?.call(PartnerUsage.t),
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerUsage] by its [id] or null if no such row exists.
  Future<PartnerUsage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerUsage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerUsage]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerUsage]s will have their `id` fields set.
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
  Future<List<PartnerUsage>> insert(
    _is.DatabaseSession session,
    List<PartnerUsage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerUsage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerUsage] and returns the inserted row.
  ///
  /// The returned [PartnerUsage] will have its `id` field set.
  Future<PartnerUsage> insertRow(
    _is.DatabaseSession session,
    PartnerUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerUsage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerUsage]s in the list and returns the resulting rows.
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
  /// The returned [PartnerUsage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerUsage>> upsert(
    _is.DatabaseSession session,
    List<PartnerUsage> rows, {
    required _is.ColumnSelections<PartnerUsageTable> conflictColumns,
    _is.ColumnSelections<PartnerUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerUsageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerUsage>(
      rows,
      conflictColumns: conflictColumns(PartnerUsage.t),
      updateColumns: updateColumns?.call(PartnerUsage.t),
      updateWhere: updateWhere?.call(PartnerUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerUsage] and returns the resulting row.
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
  /// The returned [PartnerUsage] will have its `id` field set.
  Future<PartnerUsage?> upsertRow(
    _is.DatabaseSession session,
    PartnerUsage row, {
    required _is.ColumnSelections<PartnerUsageTable> conflictColumns,
    _is.ColumnSelections<PartnerUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerUsageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerUsage>(
      row,
      conflictColumns: conflictColumns(PartnerUsage.t),
      updateColumns: updateColumns?.call(PartnerUsage.t),
      updateWhere: updateWhere?.call(PartnerUsage.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerUsage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerUsage>> update(
    _is.DatabaseSession session,
    List<PartnerUsage> rows, {
    _is.ColumnSelections<PartnerUsageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerUsage>(
      rows,
      columns: columns?.call(PartnerUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerUsage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerUsage> updateRow(
    _is.DatabaseSession session,
    PartnerUsage row, {
    _is.ColumnSelections<PartnerUsageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerUsage>(
      row,
      columns: columns?.call(PartnerUsage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerUsage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerUsage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerUsageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerUsage>(
      id,
      columnValues: columnValues(PartnerUsage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerUsage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerUsage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerUsageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PartnerUsageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerUsage>(
      columnValues: columnValues(PartnerUsage.t.updateTable),
      where: where(PartnerUsage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerUsage]s in the list and returns the deleted rows.
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
  Future<List<PartnerUsage>> delete(
    _is.DatabaseSession session,
    List<PartnerUsage> rows, {
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerUsage>(
      rows,
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerUsage].
  Future<PartnerUsage> deleteRow(
    _is.DatabaseSession session,
    PartnerUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerUsage>(
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
  Future<List<PartnerUsage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerUsageTable> where,
    _is.OrderByBuilder<PartnerUsageTable>? orderBy,
    _is.OrderByListBuilder<PartnerUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerUsage>(
      where: where(PartnerUsage.t),
      orderBy: orderBy?.call(PartnerUsage.t),
      orderByList: orderByList?.call(PartnerUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerUsageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerUsage>(
      where: where?.call(PartnerUsage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerUsage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerUsageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerUsage>(
      where: where(PartnerUsage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
