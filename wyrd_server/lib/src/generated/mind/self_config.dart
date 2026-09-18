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
import '../mind/self_config_change.dart' as _ieirbbk4;

abstract class SelfConfig
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SelfConfig._({
    this.id,
    required this.toneNote,
    required this.replyLengthMax,
    required this.curiosityLevel,
    required this.history,
  });

  factory SelfConfig({
    int? id,
    required String toneNote,
    required int replyLengthMax,
    required String curiosityLevel,
    required List<_ieirbbk4.SelfConfigChange> history,
  }) = _SelfConfigImpl;

  factory SelfConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return SelfConfig(
      id: jsonSerialization['id'] as int?,
      toneNote: jsonSerialization['toneNote'] as String,
      replyLengthMax: jsonSerialization['replyLengthMax'] as int,
      curiosityLevel: jsonSerialization['curiosityLevel'] as String,
      history: _i9sln91s.Protocol()
          .deserialize<List<_ieirbbk4.SelfConfigChange>>(
            jsonSerialization['history'],
          ),
    );
  }

  static final t = SelfConfigTable();

  static const db = SelfConfigRepository._();

  @override
  int? id;

  String toneNote;

  int replyLengthMax;

  String curiosityLevel;

  List<_ieirbbk4.SelfConfigChange> history;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SelfConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SelfConfig copyWith({
    int? id,
    String? toneNote,
    int? replyLengthMax,
    String? curiosityLevel,
    List<_ieirbbk4.SelfConfigChange>? history,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SelfConfig',
      if (id != null) 'id': id,
      'toneNote': toneNote,
      'replyLengthMax': replyLengthMax,
      'curiosityLevel': curiosityLevel,
      'history': history.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SelfConfig',
      if (id != null) 'id': id,
      'toneNote': toneNote,
      'replyLengthMax': replyLengthMax,
      'curiosityLevel': curiosityLevel,
      'history': history.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SelfConfigInclude include() {
    return SelfConfigInclude._();
  }

  static SelfConfigIncludeList includeList({
    _is.WhereExpressionBuilder<SelfConfigTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    SelfConfigInclude? include,
  }) {
    return SelfConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SelfConfigImpl extends SelfConfig {
  _SelfConfigImpl({
    int? id,
    required String toneNote,
    required int replyLengthMax,
    required String curiosityLevel,
    required List<_ieirbbk4.SelfConfigChange> history,
  }) : super._(
         id: id,
         toneNote: toneNote,
         replyLengthMax: replyLengthMax,
         curiosityLevel: curiosityLevel,
         history: history,
       );

  /// Returns a shallow copy of this [SelfConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SelfConfig copyWith({
    Object? id = _Undefined,
    String? toneNote,
    int? replyLengthMax,
    String? curiosityLevel,
    List<_ieirbbk4.SelfConfigChange>? history,
  }) {
    return SelfConfig(
      id: id is int? ? id : this.id,
      toneNote: toneNote ?? this.toneNote,
      replyLengthMax: replyLengthMax ?? this.replyLengthMax,
      curiosityLevel: curiosityLevel ?? this.curiosityLevel,
      history: history ?? this.history.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SelfConfigUpdateTable extends _is.UpdateTable<SelfConfigTable> {
  SelfConfigUpdateTable(super.table);

  _is.ColumnValue<String, String> toneNote(String value) => _is.ColumnValue(
    table.toneNote,
    value,
  );

  _is.ColumnValue<int, int> replyLengthMax(int value) => _is.ColumnValue(
    table.replyLengthMax,
    value,
  );

  _is.ColumnValue<String, String> curiosityLevel(String value) =>
      _is.ColumnValue(
        table.curiosityLevel,
        value,
      );

  _is.ColumnValue<
    List<_ieirbbk4.SelfConfigChange>,
    List<_ieirbbk4.SelfConfigChange>
  >
  history(List<_ieirbbk4.SelfConfigChange> value) => _is.ColumnValue(
    table.history,
    value,
  );
}

class SelfConfigTable extends _is.Table<int?> {
  SelfConfigTable({super.tableRelation}) : super(tableName: 'self_config') {
    updateTable = SelfConfigUpdateTable(this);
    toneNote = _is.ColumnString(
      'toneNote',
      this,
    );
    replyLengthMax = _is.ColumnInt(
      'replyLengthMax',
      this,
    );
    curiosityLevel = _is.ColumnString(
      'curiosityLevel',
      this,
    );
    history = _is.ColumnSerializable<List<_ieirbbk4.SelfConfigChange>>(
      'history',
      this,
    );
  }

  late final SelfConfigUpdateTable updateTable;

  late final _is.ColumnString toneNote;

  late final _is.ColumnInt replyLengthMax;

  late final _is.ColumnString curiosityLevel;

  late final _is.ColumnSerializable<List<_ieirbbk4.SelfConfigChange>> history;

  @override
  List<_is.Column> get columns => [
    id,
    toneNote,
    replyLengthMax,
    curiosityLevel,
    history,
  ];
}

class SelfConfigInclude extends _is.IncludeObject {
  SelfConfigInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SelfConfig.t;
}

class SelfConfigIncludeList extends _is.IncludeList {
  SelfConfigIncludeList._({
    _is.WhereExpressionBuilder<SelfConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SelfConfig.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SelfConfig.t;
}

class SelfConfigRepository {
  const SelfConfigRepository._();

  /// Returns a list of [SelfConfig]s matching the given query parameters.
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
  Future<List<SelfConfig>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SelfConfigTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SelfConfig>(
      where: where?.call(SelfConfig.t),
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SelfConfig] matching the given query parameters.
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
  Future<SelfConfig?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SelfConfigTable>? where,
    int? offset,
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SelfConfig>(
      where: where?.call(SelfConfig.t),
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SelfConfig] by its [id] or null if no such row exists.
  Future<SelfConfig?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SelfConfig>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SelfConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [SelfConfig]s will have their `id` fields set.
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
  Future<List<SelfConfig>> insert(
    _is.DatabaseSession session,
    List<SelfConfig> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SelfConfig>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SelfConfig] and returns the inserted row.
  ///
  /// The returned [SelfConfig] will have its `id` field set.
  Future<SelfConfig> insertRow(
    _is.DatabaseSession session,
    SelfConfig row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SelfConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SelfConfig]s in the list and returns the resulting rows.
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
  /// The returned [SelfConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SelfConfig>> upsert(
    _is.DatabaseSession session,
    List<SelfConfig> rows, {
    required _is.ColumnSelections<SelfConfigTable> conflictColumns,
    _is.ColumnSelections<SelfConfigTable>? updateColumns,
    _is.WhereExpressionBuilder<SelfConfigTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SelfConfig>(
      rows,
      conflictColumns: conflictColumns(SelfConfig.t),
      updateColumns: updateColumns?.call(SelfConfig.t),
      updateWhere: updateWhere?.call(SelfConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SelfConfig] and returns the resulting row.
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
  /// The returned [SelfConfig] will have its `id` field set.
  Future<SelfConfig?> upsertRow(
    _is.DatabaseSession session,
    SelfConfig row, {
    required _is.ColumnSelections<SelfConfigTable> conflictColumns,
    _is.ColumnSelections<SelfConfigTable>? updateColumns,
    _is.WhereExpressionBuilder<SelfConfigTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SelfConfig>(
      row,
      conflictColumns: conflictColumns(SelfConfig.t),
      updateColumns: updateColumns?.call(SelfConfig.t),
      updateWhere: updateWhere?.call(SelfConfig.t),
      transaction: transaction,
    );
  }

  /// Updates all [SelfConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SelfConfig>> update(
    _is.DatabaseSession session,
    List<SelfConfig> rows, {
    _is.ColumnSelections<SelfConfigTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SelfConfig>(
      rows,
      columns: columns?.call(SelfConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SelfConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SelfConfig> updateRow(
    _is.DatabaseSession session,
    SelfConfig row, {
    _is.ColumnSelections<SelfConfigTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SelfConfig>(
      row,
      columns: columns?.call(SelfConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SelfConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SelfConfig?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SelfConfigUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SelfConfig>(
      id,
      columnValues: columnValues(SelfConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SelfConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SelfConfig>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SelfConfigUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SelfConfigTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SelfConfig>(
      columnValues: columnValues(SelfConfig.t.updateTable),
      where: where(SelfConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SelfConfig]s in the list and returns the deleted rows.
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
  Future<List<SelfConfig>> delete(
    _is.DatabaseSession session,
    List<SelfConfig> rows, {
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SelfConfig>(
      rows,
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SelfConfig].
  Future<SelfConfig> deleteRow(
    _is.DatabaseSession session,
    SelfConfig row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SelfConfig>(
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
  Future<List<SelfConfig>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SelfConfigTable> where,
    _is.OrderByBuilder<SelfConfigTable>? orderBy,
    _is.OrderByListBuilder<SelfConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SelfConfig>(
      where: where(SelfConfig.t),
      orderBy: orderBy?.call(SelfConfig.t),
      orderByList: orderByList?.call(SelfConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SelfConfigTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SelfConfig>(
      where: where?.call(SelfConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SelfConfig] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SelfConfigTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SelfConfig>(
      where: where(SelfConfig.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
