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

abstract class Sighting
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Sighting._({
    this.id,
    required this.authUserId,
    required this.timestamp,
    required this.description,
    this.question,
    this.trackingNote,
  });

  factory Sighting({
    int? id,
    required _is.UuidValue authUserId,
    required DateTime timestamp,
    required String description,
    String? question,
    String? trackingNote,
  }) = _SightingImpl;

  factory Sighting.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sighting(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      description: jsonSerialization['description'] as String,
      question: jsonSerialization['question'] as String?,
      trackingNote: jsonSerialization['trackingNote'] as String?,
    );
  }

  static final t = SightingTable();

  static const db = SightingRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  DateTime timestamp;

  String description;

  String? question;

  String? trackingNote;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Sighting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Sighting copyWith({
    int? id,
    _is.UuidValue? authUserId,
    DateTime? timestamp,
    String? description,
    String? question,
    String? trackingNote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sighting',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'timestamp': timestamp.toJson(),
      'description': description,
      if (question != null) 'question': question,
      if (trackingNote != null) 'trackingNote': trackingNote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Sighting',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'timestamp': timestamp.toJson(),
      'description': description,
      if (question != null) 'question': question,
      if (trackingNote != null) 'trackingNote': trackingNote,
    };
  }

  static SightingInclude include() {
    return SightingInclude._();
  }

  static SightingIncludeList includeList({
    _is.WhereExpressionBuilder<SightingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    SightingInclude? include,
  }) {
    return SightingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SightingImpl extends Sighting {
  _SightingImpl({
    int? id,
    required _is.UuidValue authUserId,
    required DateTime timestamp,
    required String description,
    String? question,
    String? trackingNote,
  }) : super._(
         id: id,
         authUserId: authUserId,
         timestamp: timestamp,
         description: description,
         question: question,
         trackingNote: trackingNote,
       );

  /// Returns a shallow copy of this [Sighting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Sighting copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    DateTime? timestamp,
    String? description,
    Object? question = _Undefined,
    Object? trackingNote = _Undefined,
  }) {
    return Sighting(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      timestamp: timestamp ?? this.timestamp,
      description: description ?? this.description,
      question: question is String? ? question : this.question,
      trackingNote: trackingNote is String? ? trackingNote : this.trackingNote,
    );
  }
}

class SightingUpdateTable extends _is.UpdateTable<SightingTable> {
  SightingUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> question(String? value) => _is.ColumnValue(
    table.question,
    value,
  );

  _is.ColumnValue<String, String> trackingNote(String? value) =>
      _is.ColumnValue(
        table.trackingNote,
        value,
      );
}

class SightingTable extends _is.Table<int?> {
  SightingTable({super.tableRelation}) : super(tableName: 'sighting') {
    updateTable = SightingUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    question = _is.ColumnString(
      'question',
      this,
    );
    trackingNote = _is.ColumnString(
      'trackingNote',
      this,
    );
  }

  late final SightingUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString description;

  late final _is.ColumnString question;

  late final _is.ColumnString trackingNote;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    timestamp,
    description,
    question,
    trackingNote,
  ];
}

class SightingInclude extends _is.IncludeObject {
  SightingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Sighting.t;
}

class SightingIncludeList extends _is.IncludeList {
  SightingIncludeList._({
    _is.WhereExpressionBuilder<SightingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Sighting.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Sighting.t;
}

class SightingRepository {
  const SightingRepository._();

  /// Returns a list of [Sighting]s matching the given query parameters.
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
  Future<List<Sighting>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SightingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Sighting>(
      where: where?.call(Sighting.t),
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Sighting] matching the given query parameters.
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
  Future<Sighting?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SightingTable>? where,
    int? offset,
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Sighting>(
      where: where?.call(Sighting.t),
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Sighting] by its [id] or null if no such row exists.
  Future<Sighting?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Sighting>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Sighting]s in the list and returns the inserted rows.
  ///
  /// The returned [Sighting]s will have their `id` fields set.
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
  Future<List<Sighting>> insert(
    _is.DatabaseSession session,
    List<Sighting> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Sighting>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Sighting] and returns the inserted row.
  ///
  /// The returned [Sighting] will have its `id` field set.
  Future<Sighting> insertRow(
    _is.DatabaseSession session,
    Sighting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Sighting>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Sighting]s in the list and returns the resulting rows.
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
  /// The returned [Sighting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sighting>> upsert(
    _is.DatabaseSession session,
    List<Sighting> rows, {
    required _is.ColumnSelections<SightingTable> conflictColumns,
    _is.ColumnSelections<SightingTable>? updateColumns,
    _is.WhereExpressionBuilder<SightingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Sighting>(
      rows,
      conflictColumns: conflictColumns(Sighting.t),
      updateColumns: updateColumns?.call(Sighting.t),
      updateWhere: updateWhere?.call(Sighting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Sighting] and returns the resulting row.
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
  /// The returned [Sighting] will have its `id` field set.
  Future<Sighting?> upsertRow(
    _is.DatabaseSession session,
    Sighting row, {
    required _is.ColumnSelections<SightingTable> conflictColumns,
    _is.ColumnSelections<SightingTable>? updateColumns,
    _is.WhereExpressionBuilder<SightingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Sighting>(
      row,
      conflictColumns: conflictColumns(Sighting.t),
      updateColumns: updateColumns?.call(Sighting.t),
      updateWhere: updateWhere?.call(Sighting.t),
      transaction: transaction,
    );
  }

  /// Updates all [Sighting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sighting>> update(
    _is.DatabaseSession session,
    List<Sighting> rows, {
    _is.ColumnSelections<SightingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Sighting>(
      rows,
      columns: columns?.call(Sighting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Sighting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Sighting> updateRow(
    _is.DatabaseSession session,
    Sighting row, {
    _is.ColumnSelections<SightingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Sighting>(
      row,
      columns: columns?.call(Sighting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sighting] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Sighting?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SightingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Sighting>(
      id,
      columnValues: columnValues(Sighting.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Sighting]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sighting>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SightingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SightingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Sighting>(
      columnValues: columnValues(Sighting.t.updateTable),
      where: where(Sighting.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Sighting]s in the list and returns the deleted rows.
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
  Future<List<Sighting>> delete(
    _is.DatabaseSession session,
    List<Sighting> rows, {
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Sighting>(
      rows,
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Sighting].
  Future<Sighting> deleteRow(
    _is.DatabaseSession session,
    Sighting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Sighting>(
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
  Future<List<Sighting>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SightingTable> where,
    _is.OrderByBuilder<SightingTable>? orderBy,
    _is.OrderByListBuilder<SightingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Sighting>(
      where: where(Sighting.t),
      orderBy: orderBy?.call(Sighting.t),
      orderByList: orderByList?.call(Sighting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SightingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Sighting>(
      where: where?.call(Sighting.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Sighting] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SightingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Sighting>(
      where: where(Sighting.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
