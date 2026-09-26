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

abstract class DroneMission
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DroneMission._({
    this.id,
    required this.droneId,
    required this.kind,
    required this.instruction,
    required this.summary,
    required this.stepsJson,
    required this.status,
    this.reason,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DroneMission({
    int? id,
    required String droneId,
    required String kind,
    required String instruction,
    required String summary,
    required String stepsJson,
    required String status,
    String? reason,
    _is.UuidValue? createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DroneMissionImpl;

  factory DroneMission.fromJson(Map<String, dynamic> jsonSerialization) {
    return DroneMission(
      id: jsonSerialization['id'] as int?,
      droneId: jsonSerialization['droneId'] as String,
      kind: jsonSerialization['kind'] as String,
      instruction: jsonSerialization['instruction'] as String,
      summary: jsonSerialization['summary'] as String,
      stepsJson: jsonSerialization['stepsJson'] as String,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String?,
      createdBy: jsonSerialization['createdBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['createdBy']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DroneMissionTable();

  static const db = DroneMissionRepository._();

  @override
  int? id;

  String droneId;

  String kind;

  String instruction;

  String summary;

  String stepsJson;

  String status;

  String? reason;

  _is.UuidValue? createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DroneMission]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DroneMission copyWith({
    int? id,
    String? droneId,
    String? kind,
    String? instruction,
    String? summary,
    String? stepsJson,
    String? status,
    String? reason,
    _is.UuidValue? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DroneMission',
      if (id != null) 'id': id,
      'droneId': droneId,
      'kind': kind,
      'instruction': instruction,
      'summary': summary,
      'stepsJson': stepsJson,
      'status': status,
      if (reason != null) 'reason': reason,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DroneMission',
      if (id != null) 'id': id,
      'droneId': droneId,
      'kind': kind,
      'instruction': instruction,
      'summary': summary,
      'stepsJson': stepsJson,
      'status': status,
      if (reason != null) 'reason': reason,
      if (createdBy != null) 'createdBy': createdBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DroneMissionInclude include() {
    return DroneMissionInclude._();
  }

  static DroneMissionIncludeList includeList({
    _is.WhereExpressionBuilder<DroneMissionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    DroneMissionInclude? include,
  }) {
    return DroneMissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DroneMissionImpl extends DroneMission {
  _DroneMissionImpl({
    int? id,
    required String droneId,
    required String kind,
    required String instruction,
    required String summary,
    required String stepsJson,
    required String status,
    String? reason,
    _is.UuidValue? createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         droneId: droneId,
         kind: kind,
         instruction: instruction,
         summary: summary,
         stepsJson: stepsJson,
         status: status,
         reason: reason,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DroneMission]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DroneMission copyWith({
    Object? id = _Undefined,
    String? droneId,
    String? kind,
    String? instruction,
    String? summary,
    String? stepsJson,
    String? status,
    Object? reason = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DroneMission(
      id: id is int? ? id : this.id,
      droneId: droneId ?? this.droneId,
      kind: kind ?? this.kind,
      instruction: instruction ?? this.instruction,
      summary: summary ?? this.summary,
      stepsJson: stepsJson ?? this.stepsJson,
      status: status ?? this.status,
      reason: reason is String? ? reason : this.reason,
      createdBy: createdBy is _is.UuidValue? ? createdBy : this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DroneMissionUpdateTable extends _is.UpdateTable<DroneMissionTable> {
  DroneMissionUpdateTable(super.table);

  _is.ColumnValue<String, String> droneId(String value) => _is.ColumnValue(
    table.droneId,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> instruction(String value) => _is.ColumnValue(
    table.instruction,
    value,
  );

  _is.ColumnValue<String, String> summary(String value) => _is.ColumnValue(
    table.summary,
    value,
  );

  _is.ColumnValue<String, String> stepsJson(String value) => _is.ColumnValue(
    table.stepsJson,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> reason(String? value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> createdBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.createdBy,
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

class DroneMissionTable extends _is.Table<int?> {
  DroneMissionTable({super.tableRelation}) : super(tableName: 'drone_mission') {
    updateTable = DroneMissionUpdateTable(this);
    droneId = _is.ColumnString(
      'droneId',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    instruction = _is.ColumnString(
      'instruction',
      this,
    );
    summary = _is.ColumnString(
      'summary',
      this,
    );
    stepsJson = _is.ColumnString(
      'stepsJson',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdBy = _is.ColumnUuid(
      'createdBy',
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

  late final DroneMissionUpdateTable updateTable;

  late final _is.ColumnString droneId;

  late final _is.ColumnString kind;

  late final _is.ColumnString instruction;

  late final _is.ColumnString summary;

  late final _is.ColumnString stepsJson;

  late final _is.ColumnString status;

  late final _is.ColumnString reason;

  late final _is.ColumnUuid createdBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    droneId,
    kind,
    instruction,
    summary,
    stepsJson,
    status,
    reason,
    createdBy,
    createdAt,
    updatedAt,
  ];
}

class DroneMissionInclude extends _is.IncludeObject {
  DroneMissionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DroneMission.t;
}

class DroneMissionIncludeList extends _is.IncludeList {
  DroneMissionIncludeList._({
    _is.WhereExpressionBuilder<DroneMissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DroneMission.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DroneMission.t;
}

class DroneMissionRepository {
  const DroneMissionRepository._();

  /// Returns a list of [DroneMission]s matching the given query parameters.
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
  Future<List<DroneMission>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneMissionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DroneMission>(
      where: where?.call(DroneMission.t),
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DroneMission] matching the given query parameters.
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
  Future<DroneMission?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneMissionTable>? where,
    int? offset,
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DroneMission>(
      where: where?.call(DroneMission.t),
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DroneMission] by its [id] or null if no such row exists.
  Future<DroneMission?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DroneMission>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DroneMission]s in the list and returns the inserted rows.
  ///
  /// The returned [DroneMission]s will have their `id` fields set.
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
  Future<List<DroneMission>> insert(
    _is.DatabaseSession session,
    List<DroneMission> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DroneMission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DroneMission] and returns the inserted row.
  ///
  /// The returned [DroneMission] will have its `id` field set.
  Future<DroneMission> insertRow(
    _is.DatabaseSession session,
    DroneMission row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DroneMission>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DroneMission]s in the list and returns the resulting rows.
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
  /// The returned [DroneMission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneMission>> upsert(
    _is.DatabaseSession session,
    List<DroneMission> rows, {
    required _is.ColumnSelections<DroneMissionTable> conflictColumns,
    _is.ColumnSelections<DroneMissionTable>? updateColumns,
    _is.WhereExpressionBuilder<DroneMissionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DroneMission>(
      rows,
      conflictColumns: conflictColumns(DroneMission.t),
      updateColumns: updateColumns?.call(DroneMission.t),
      updateWhere: updateWhere?.call(DroneMission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DroneMission] and returns the resulting row.
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
  /// The returned [DroneMission] will have its `id` field set.
  Future<DroneMission?> upsertRow(
    _is.DatabaseSession session,
    DroneMission row, {
    required _is.ColumnSelections<DroneMissionTable> conflictColumns,
    _is.ColumnSelections<DroneMissionTable>? updateColumns,
    _is.WhereExpressionBuilder<DroneMissionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DroneMission>(
      row,
      conflictColumns: conflictColumns(DroneMission.t),
      updateColumns: updateColumns?.call(DroneMission.t),
      updateWhere: updateWhere?.call(DroneMission.t),
      transaction: transaction,
    );
  }

  /// Updates all [DroneMission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneMission>> update(
    _is.DatabaseSession session,
    List<DroneMission> rows, {
    _is.ColumnSelections<DroneMissionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DroneMission>(
      rows,
      columns: columns?.call(DroneMission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DroneMission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DroneMission> updateRow(
    _is.DatabaseSession session,
    DroneMission row, {
    _is.ColumnSelections<DroneMissionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DroneMission>(
      row,
      columns: columns?.call(DroneMission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DroneMission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DroneMission?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DroneMissionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DroneMission>(
      id,
      columnValues: columnValues(DroneMission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DroneMission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneMission>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DroneMissionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DroneMissionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DroneMission>(
      columnValues: columnValues(DroneMission.t.updateTable),
      where: where(DroneMission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DroneMission]s in the list and returns the deleted rows.
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
  Future<List<DroneMission>> delete(
    _is.DatabaseSession session,
    List<DroneMission> rows, {
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DroneMission>(
      rows,
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DroneMission].
  Future<DroneMission> deleteRow(
    _is.DatabaseSession session,
    DroneMission row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DroneMission>(
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
  Future<List<DroneMission>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DroneMissionTable> where,
    _is.OrderByBuilder<DroneMissionTable>? orderBy,
    _is.OrderByListBuilder<DroneMissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DroneMission>(
      where: where(DroneMission.t),
      orderBy: orderBy?.call(DroneMission.t),
      orderByList: orderByList?.call(DroneMission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneMissionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DroneMission>(
      where: where?.call(DroneMission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DroneMission] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DroneMissionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DroneMission>(
      where: where(DroneMission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
