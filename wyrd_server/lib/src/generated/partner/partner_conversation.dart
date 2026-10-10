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

/// One partner conversation, belonging to one user reference and one partner environment. Deleted 30 days after its
/// last message (7 on staging).
abstract class PartnerConversation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerConversation._({
    this.id,
    required this.convId,
    required this.partner,
    required this.env,
    required this.userRef,
    required this.surface,
    required this.createdAt,
    required this.lastAt,
  });

  factory PartnerConversation({
    int? id,
    required String convId,
    required String partner,
    required String env,
    required String userRef,
    required String surface,
    required DateTime createdAt,
    required DateTime lastAt,
  }) = _PartnerConversationImpl;

  factory PartnerConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerConversation(
      id: jsonSerialization['id'] as int?,
      convId: jsonSerialization['convId'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      userRef: jsonSerialization['userRef'] as String,
      surface: jsonSerialization['surface'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastAt']),
    );
  }

  static final t = PartnerConversationTable();

  static const db = PartnerConversationRepository._();

  @override
  int? id;

  String convId;

  String partner;

  String env;

  String userRef;

  String surface;

  DateTime createdAt;

  DateTime lastAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerConversation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerConversation copyWith({
    int? id,
    String? convId,
    String? partner,
    String? env,
    String? userRef,
    String? surface,
    DateTime? createdAt,
    DateTime? lastAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerConversation',
      if (id != null) 'id': id,
      'convId': convId,
      'partner': partner,
      'env': env,
      'userRef': userRef,
      'surface': surface,
      'createdAt': createdAt.toJson(),
      'lastAt': lastAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerConversation',
      if (id != null) 'id': id,
      'convId': convId,
      'partner': partner,
      'env': env,
      'userRef': userRef,
      'surface': surface,
      'createdAt': createdAt.toJson(),
      'lastAt': lastAt.toJson(),
    };
  }

  static PartnerConversationInclude include() {
    return PartnerConversationInclude._();
  }

  static PartnerConversationIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerConversationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    PartnerConversationInclude? include,
  }) {
    return PartnerConversationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerConversationImpl extends PartnerConversation {
  _PartnerConversationImpl({
    int? id,
    required String convId,
    required String partner,
    required String env,
    required String userRef,
    required String surface,
    required DateTime createdAt,
    required DateTime lastAt,
  }) : super._(
         id: id,
         convId: convId,
         partner: partner,
         env: env,
         userRef: userRef,
         surface: surface,
         createdAt: createdAt,
         lastAt: lastAt,
       );

  /// Returns a shallow copy of this [PartnerConversation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerConversation copyWith({
    Object? id = _Undefined,
    String? convId,
    String? partner,
    String? env,
    String? userRef,
    String? surface,
    DateTime? createdAt,
    DateTime? lastAt,
  }) {
    return PartnerConversation(
      id: id is int? ? id : this.id,
      convId: convId ?? this.convId,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      userRef: userRef ?? this.userRef,
      surface: surface ?? this.surface,
      createdAt: createdAt ?? this.createdAt,
      lastAt: lastAt ?? this.lastAt,
    );
  }
}

class PartnerConversationUpdateTable
    extends _is.UpdateTable<PartnerConversationTable> {
  PartnerConversationUpdateTable(super.table);

  _is.ColumnValue<String, String> convId(String value) => _is.ColumnValue(
    table.convId,
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

  _is.ColumnValue<String, String> userRef(String value) => _is.ColumnValue(
    table.userRef,
    value,
  );

  _is.ColumnValue<String, String> surface(String value) => _is.ColumnValue(
    table.surface,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastAt(DateTime value) => _is.ColumnValue(
    table.lastAt,
    value,
  );
}

class PartnerConversationTable extends _is.Table<int?> {
  PartnerConversationTable({super.tableRelation})
    : super(tableName: 'partner_conversation') {
    updateTable = PartnerConversationUpdateTable(this);
    convId = _is.ColumnString(
      'convId',
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
    userRef = _is.ColumnString(
      'userRef',
      this,
    );
    surface = _is.ColumnString(
      'surface',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    lastAt = _is.ColumnDateTime(
      'lastAt',
      this,
    );
  }

  late final PartnerConversationUpdateTable updateTable;

  late final _is.ColumnString convId;

  late final _is.ColumnString partner;

  late final _is.ColumnString env;

  late final _is.ColumnString userRef;

  late final _is.ColumnString surface;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime lastAt;

  @override
  List<_is.Column> get columns => [
    id,
    convId,
    partner,
    env,
    userRef,
    surface,
    createdAt,
    lastAt,
  ];
}

class PartnerConversationInclude extends _is.IncludeObject {
  PartnerConversationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerConversation.t;
}

class PartnerConversationIncludeList extends _is.IncludeList {
  PartnerConversationIncludeList._({
    _is.WhereExpressionBuilder<PartnerConversationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerConversation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerConversation.t;
}

class PartnerConversationRepository {
  const PartnerConversationRepository._();

  /// Returns a list of [PartnerConversation]s matching the given query parameters.
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
  Future<List<PartnerConversation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerConversationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerConversation>(
      where: where?.call(PartnerConversation.t),
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerConversation] matching the given query parameters.
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
  Future<PartnerConversation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerConversationTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerConversation>(
      where: where?.call(PartnerConversation.t),
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerConversation] by its [id] or null if no such row exists.
  Future<PartnerConversation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerConversation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerConversation]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerConversation]s will have their `id` fields set.
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
  Future<List<PartnerConversation>> insert(
    _is.DatabaseSession session,
    List<PartnerConversation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerConversation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerConversation] and returns the inserted row.
  ///
  /// The returned [PartnerConversation] will have its `id` field set.
  Future<PartnerConversation> insertRow(
    _is.DatabaseSession session,
    PartnerConversation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerConversation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerConversation]s in the list and returns the resulting rows.
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
  /// The returned [PartnerConversation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerConversation>> upsert(
    _is.DatabaseSession session,
    List<PartnerConversation> rows, {
    required _is.ColumnSelections<PartnerConversationTable> conflictColumns,
    _is.ColumnSelections<PartnerConversationTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerConversationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerConversation>(
      rows,
      conflictColumns: conflictColumns(PartnerConversation.t),
      updateColumns: updateColumns?.call(PartnerConversation.t),
      updateWhere: updateWhere?.call(PartnerConversation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerConversation] and returns the resulting row.
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
  /// The returned [PartnerConversation] will have its `id` field set.
  Future<PartnerConversation?> upsertRow(
    _is.DatabaseSession session,
    PartnerConversation row, {
    required _is.ColumnSelections<PartnerConversationTable> conflictColumns,
    _is.ColumnSelections<PartnerConversationTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerConversationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerConversation>(
      row,
      conflictColumns: conflictColumns(PartnerConversation.t),
      updateColumns: updateColumns?.call(PartnerConversation.t),
      updateWhere: updateWhere?.call(PartnerConversation.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerConversation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerConversation>> update(
    _is.DatabaseSession session,
    List<PartnerConversation> rows, {
    _is.ColumnSelections<PartnerConversationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerConversation>(
      rows,
      columns: columns?.call(PartnerConversation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerConversation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerConversation> updateRow(
    _is.DatabaseSession session,
    PartnerConversation row, {
    _is.ColumnSelections<PartnerConversationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerConversation>(
      row,
      columns: columns?.call(PartnerConversation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerConversation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerConversation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerConversationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerConversation>(
      id,
      columnValues: columnValues(PartnerConversation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerConversation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerConversation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerConversationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PartnerConversationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerConversation>(
      columnValues: columnValues(PartnerConversation.t.updateTable),
      where: where(PartnerConversation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerConversation]s in the list and returns the deleted rows.
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
  Future<List<PartnerConversation>> delete(
    _is.DatabaseSession session,
    List<PartnerConversation> rows, {
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerConversation>(
      rows,
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerConversation].
  Future<PartnerConversation> deleteRow(
    _is.DatabaseSession session,
    PartnerConversation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerConversation>(
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
  Future<List<PartnerConversation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerConversationTable> where,
    _is.OrderByBuilder<PartnerConversationTable>? orderBy,
    _is.OrderByListBuilder<PartnerConversationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerConversation>(
      where: where(PartnerConversation.t),
      orderBy: orderBy?.call(PartnerConversation.t),
      orderByList: orderByList?.call(PartnerConversation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerConversationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerConversation>(
      where: where?.call(PartnerConversation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerConversation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerConversationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerConversation>(
      where: where(PartnerConversation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
