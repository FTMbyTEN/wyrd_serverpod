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

/// A member of an encrypted group, with their own wrapped copy of the group key.
abstract class IslandMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandMember._({
    this.id,
    required this.groupId,
    required this.authUserId,
    required this.wrappedKey,
    required this.wrapperPub,
    required this.addedAt,
  });

  factory IslandMember({
    int? id,
    required int groupId,
    required _is.UuidValue authUserId,
    required String wrappedKey,
    required String wrapperPub,
    required DateTime addedAt,
  }) = _IslandMemberImpl;

  factory IslandMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandMember(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      wrappedKey: jsonSerialization['wrappedKey'] as String,
      wrapperPub: jsonSerialization['wrapperPub'] as String,
      addedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['addedAt']),
    );
  }

  static final t = IslandMemberTable();

  static const db = IslandMemberRepository._();

  @override
  int? id;

  int groupId;

  _is.UuidValue authUserId;

  /// the group key (AES-GCM) encrypted for this member: base64 iv.ciphertext, with the key agreed
  /// between [wrapperPub] and the member's own key pair
  String wrappedKey;

  /// the public key (JWK) of whoever wrapped it
  String wrapperPub;

  DateTime addedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandMember copyWith({
    int? id,
    int? groupId,
    _is.UuidValue? authUserId,
    String? wrappedKey,
    String? wrapperPub,
    DateTime? addedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandMember',
      if (id != null) 'id': id,
      'groupId': groupId,
      'authUserId': authUserId.toJson(),
      'wrappedKey': wrappedKey,
      'wrapperPub': wrapperPub,
      'addedAt': addedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandMember',
      if (id != null) 'id': id,
      'groupId': groupId,
      'authUserId': authUserId.toJson(),
      'wrappedKey': wrappedKey,
      'wrapperPub': wrapperPub,
      'addedAt': addedAt.toJson(),
    };
  }

  static IslandMemberInclude include() {
    return IslandMemberInclude._();
  }

  static IslandMemberIncludeList includeList({
    _is.WhereExpressionBuilder<IslandMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    IslandMemberInclude? include,
  }) {
    return IslandMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandMemberImpl extends IslandMember {
  _IslandMemberImpl({
    int? id,
    required int groupId,
    required _is.UuidValue authUserId,
    required String wrappedKey,
    required String wrapperPub,
    required DateTime addedAt,
  }) : super._(
         id: id,
         groupId: groupId,
         authUserId: authUserId,
         wrappedKey: wrappedKey,
         wrapperPub: wrapperPub,
         addedAt: addedAt,
       );

  /// Returns a shallow copy of this [IslandMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandMember copyWith({
    Object? id = _Undefined,
    int? groupId,
    _is.UuidValue? authUserId,
    String? wrappedKey,
    String? wrapperPub,
    DateTime? addedAt,
  }) {
    return IslandMember(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      authUserId: authUserId ?? this.authUserId,
      wrappedKey: wrappedKey ?? this.wrappedKey,
      wrapperPub: wrapperPub ?? this.wrapperPub,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

class IslandMemberUpdateTable extends _is.UpdateTable<IslandMemberTable> {
  IslandMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> groupId(int value) => _is.ColumnValue(
    table.groupId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> wrappedKey(String value) => _is.ColumnValue(
    table.wrappedKey,
    value,
  );

  _is.ColumnValue<String, String> wrapperPub(String value) => _is.ColumnValue(
    table.wrapperPub,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> addedAt(DateTime value) =>
      _is.ColumnValue(
        table.addedAt,
        value,
      );
}

class IslandMemberTable extends _is.Table<int?> {
  IslandMemberTable({super.tableRelation}) : super(tableName: 'island_member') {
    updateTable = IslandMemberUpdateTable(this);
    groupId = _is.ColumnInt(
      'groupId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    wrappedKey = _is.ColumnString(
      'wrappedKey',
      this,
    );
    wrapperPub = _is.ColumnString(
      'wrapperPub',
      this,
    );
    addedAt = _is.ColumnDateTime(
      'addedAt',
      this,
    );
  }

  late final IslandMemberUpdateTable updateTable;

  late final _is.ColumnInt groupId;

  late final _is.ColumnUuid authUserId;

  /// the group key (AES-GCM) encrypted for this member: base64 iv.ciphertext, with the key agreed
  /// between [wrapperPub] and the member's own key pair
  late final _is.ColumnString wrappedKey;

  /// the public key (JWK) of whoever wrapped it
  late final _is.ColumnString wrapperPub;

  late final _is.ColumnDateTime addedAt;

  @override
  List<_is.Column> get columns => [
    id,
    groupId,
    authUserId,
    wrappedKey,
    wrapperPub,
    addedAt,
  ];
}

class IslandMemberInclude extends _is.IncludeObject {
  IslandMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandMember.t;
}

class IslandMemberIncludeList extends _is.IncludeList {
  IslandMemberIncludeList._({
    _is.WhereExpressionBuilder<IslandMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandMember.t;
}

class IslandMemberRepository {
  const IslandMemberRepository._();

  /// Returns a list of [IslandMember]s matching the given query parameters.
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
  Future<List<IslandMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandMember>(
      where: where?.call(IslandMember.t),
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandMember] matching the given query parameters.
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
  Future<IslandMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandMember>(
      where: where?.call(IslandMember.t),
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandMember] by its [id] or null if no such row exists.
  Future<IslandMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandMember]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandMember]s will have their `id` fields set.
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
  Future<List<IslandMember>> insert(
    _is.DatabaseSession session,
    List<IslandMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandMember] and returns the inserted row.
  ///
  /// The returned [IslandMember] will have its `id` field set.
  Future<IslandMember> insertRow(
    _is.DatabaseSession session,
    IslandMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandMember]s in the list and returns the resulting rows.
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
  /// The returned [IslandMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMember>> upsert(
    _is.DatabaseSession session,
    List<IslandMember> rows, {
    required _is.ColumnSelections<IslandMemberTable> conflictColumns,
    _is.ColumnSelections<IslandMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandMember>(
      rows,
      conflictColumns: conflictColumns(IslandMember.t),
      updateColumns: updateColumns?.call(IslandMember.t),
      updateWhere: updateWhere?.call(IslandMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandMember] and returns the resulting row.
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
  /// The returned [IslandMember] will have its `id` field set.
  Future<IslandMember?> upsertRow(
    _is.DatabaseSession session,
    IslandMember row, {
    required _is.ColumnSelections<IslandMemberTable> conflictColumns,
    _is.ColumnSelections<IslandMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandMember>(
      row,
      conflictColumns: conflictColumns(IslandMember.t),
      updateColumns: updateColumns?.call(IslandMember.t),
      updateWhere: updateWhere?.call(IslandMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMember>> update(
    _is.DatabaseSession session,
    List<IslandMember> rows, {
    _is.ColumnSelections<IslandMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandMember>(
      rows,
      columns: columns?.call(IslandMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandMember> updateRow(
    _is.DatabaseSession session,
    IslandMember row, {
    _is.ColumnSelections<IslandMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandMember>(
      row,
      columns: columns?.call(IslandMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandMember>(
      id,
      columnValues: columnValues(IslandMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandMember>(
      columnValues: columnValues(IslandMember.t.updateTable),
      where: where(IslandMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandMember]s in the list and returns the deleted rows.
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
  Future<List<IslandMember>> delete(
    _is.DatabaseSession session,
    List<IslandMember> rows, {
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandMember>(
      rows,
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandMember].
  Future<IslandMember> deleteRow(
    _is.DatabaseSession session,
    IslandMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandMember>(
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
  Future<List<IslandMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandMemberTable> where,
    _is.OrderByBuilder<IslandMemberTable>? orderBy,
    _is.OrderByListBuilder<IslandMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandMember>(
      where: where(IslandMember.t),
      orderBy: orderBy?.call(IslandMember.t),
      orderByList: orderByList?.call(IslandMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandMember>(
      where: where?.call(IslandMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandMember>(
      where: where(IslandMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
