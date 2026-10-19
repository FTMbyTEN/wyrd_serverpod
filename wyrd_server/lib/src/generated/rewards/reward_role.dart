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

/// Who may do what with the rewards treasury: viewer (read the reports), operator (offers, reviews, proposals, pauses),
/// approver (approve another admin's proposal). Granted by the owner (the drone operator).
abstract class RewardRole
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardRole._({
    this.id,
    required this.authUserId,
    required this.role,
    required this.grantedBy,
    required this.createdAt,
  });

  factory RewardRole({
    int? id,
    required _is.UuidValue authUserId,
    required String role,
    required _is.UuidValue grantedBy,
    required DateTime createdAt,
  }) = _RewardRoleImpl;

  factory RewardRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardRole(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String,
      grantedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['grantedBy'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RewardRoleTable();

  static const db = RewardRoleRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String role;

  _is.UuidValue grantedBy;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardRole copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? role,
    _is.UuidValue? grantedBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      'grantedBy': grantedBy.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      'grantedBy': grantedBy.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardRoleInclude include() {
    return RewardRoleInclude._();
  }

  static RewardRoleIncludeList includeList({
    _is.WhereExpressionBuilder<RewardRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    RewardRoleInclude? include,
  }) {
    return RewardRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardRoleImpl extends RewardRole {
  _RewardRoleImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String role,
    required _is.UuidValue grantedBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         role: role,
         grantedBy: grantedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardRole copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? role,
    _is.UuidValue? grantedBy,
    DateTime? createdAt,
  }) {
    return RewardRole(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      grantedBy: grantedBy ?? this.grantedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardRoleUpdateTable extends _is.UpdateTable<RewardRoleTable> {
  RewardRoleUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> grantedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.grantedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RewardRoleTable extends _is.Table<int?> {
  RewardRoleTable({super.tableRelation}) : super(tableName: 'reward_role') {
    updateTable = RewardRoleUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    grantedBy = _is.ColumnUuid(
      'grantedBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RewardRoleUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString role;

  late final _is.ColumnUuid grantedBy;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    role,
    grantedBy,
    createdAt,
  ];
}

class RewardRoleInclude extends _is.IncludeObject {
  RewardRoleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardRole.t;
}

class RewardRoleIncludeList extends _is.IncludeList {
  RewardRoleIncludeList._({
    _is.WhereExpressionBuilder<RewardRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardRole.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardRole.t;
}

class RewardRoleRepository {
  const RewardRoleRepository._();

  /// Returns a list of [RewardRole]s matching the given query parameters.
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
  Future<List<RewardRole>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardRole>(
      where: where?.call(RewardRole.t),
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardRole] matching the given query parameters.
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
  Future<RewardRole?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardRoleTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardRole>(
      where: where?.call(RewardRole.t),
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardRole] by its [id] or null if no such row exists.
  Future<RewardRole?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardRole>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardRole]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardRole]s will have their `id` fields set.
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
  Future<List<RewardRole>> insert(
    _is.DatabaseSession session,
    List<RewardRole> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardRole] and returns the inserted row.
  ///
  /// The returned [RewardRole] will have its `id` field set.
  Future<RewardRole> insertRow(
    _is.DatabaseSession session,
    RewardRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardRole>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardRole]s in the list and returns the resulting rows.
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
  /// The returned [RewardRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardRole>> upsert(
    _is.DatabaseSession session,
    List<RewardRole> rows, {
    required _is.ColumnSelections<RewardRoleTable> conflictColumns,
    _is.ColumnSelections<RewardRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardRoleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardRole>(
      rows,
      conflictColumns: conflictColumns(RewardRole.t),
      updateColumns: updateColumns?.call(RewardRole.t),
      updateWhere: updateWhere?.call(RewardRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardRole] and returns the resulting row.
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
  /// The returned [RewardRole] will have its `id` field set.
  Future<RewardRole?> upsertRow(
    _is.DatabaseSession session,
    RewardRole row, {
    required _is.ColumnSelections<RewardRoleTable> conflictColumns,
    _is.ColumnSelections<RewardRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardRoleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardRole>(
      row,
      conflictColumns: conflictColumns(RewardRole.t),
      updateColumns: updateColumns?.call(RewardRole.t),
      updateWhere: updateWhere?.call(RewardRole.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardRole>> update(
    _is.DatabaseSession session,
    List<RewardRole> rows, {
    _is.ColumnSelections<RewardRoleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardRole>(
      rows,
      columns: columns?.call(RewardRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardRole> updateRow(
    _is.DatabaseSession session,
    RewardRole row, {
    _is.ColumnSelections<RewardRoleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardRole>(
      row,
      columns: columns?.call(RewardRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardRole?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardRoleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardRole>(
      id,
      columnValues: columnValues(RewardRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardRole>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardRoleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardRoleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardRole>(
      columnValues: columnValues(RewardRole.t.updateTable),
      where: where(RewardRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardRole]s in the list and returns the deleted rows.
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
  Future<List<RewardRole>> delete(
    _is.DatabaseSession session,
    List<RewardRole> rows, {
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardRole>(
      rows,
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardRole].
  Future<RewardRole> deleteRow(
    _is.DatabaseSession session,
    RewardRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardRole>(
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
  Future<List<RewardRole>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardRoleTable> where,
    _is.OrderByBuilder<RewardRoleTable>? orderBy,
    _is.OrderByListBuilder<RewardRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardRole>(
      where: where(RewardRole.t),
      orderBy: orderBy?.call(RewardRole.t),
      orderByList: orderByList?.call(RewardRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardRoleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardRole>(
      where: where?.call(RewardRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardRole] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardRoleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardRole>(
      where: where(RewardRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
