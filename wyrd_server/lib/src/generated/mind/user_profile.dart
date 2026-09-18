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

abstract class UserProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserProfile._({
    this.id,
    required this.authUserId,
    this.username,
    required this.facts,
    required this.visitCount,
    required this.firstSeen,
    required this.lastSeen,
  });

  factory UserProfile({
    int? id,
    required _is.UuidValue authUserId,
    String? username,
    required List<String> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      username: jsonSerialization['username'] as String?,
      facts: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['facts'],
      ),
      visitCount: jsonSerialization['visitCount'] as int,
      firstSeen: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeen'],
      ),
      lastSeen: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeen'],
      ),
    );
  }

  static final t = UserProfileTable();

  static const db = UserProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String? username;

  List<String> facts;

  int visitCount;

  DateTime firstSeen;

  DateTime lastSeen;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? username,
    List<String>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (username != null) 'username': username,
      'facts': facts.toJson(),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (username != null) 'username': username,
      'facts': facts.toJson(),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
    };
  }

  static UserProfileInclude include() {
    return UserProfileInclude._();
  }

  static UserProfileIncludeList includeList({
    _is.WhereExpressionBuilder<UserProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    UserProfileInclude? include,
  }) {
    return UserProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    String? username,
    required List<String> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
  }) : super._(
         id: id,
         authUserId: authUserId,
         username: username,
         facts: facts,
         visitCount: visitCount,
         firstSeen: firstSeen,
         lastSeen: lastSeen,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? username = _Undefined,
    List<String>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      username: username is String? ? username : this.username,
      facts: facts ?? this.facts.map((e0) => e0).toList(),
      visitCount: visitCount ?? this.visitCount,
      firstSeen: firstSeen ?? this.firstSeen,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

class UserProfileUpdateTable extends _is.UpdateTable<UserProfileTable> {
  UserProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> username(String? value) => _is.ColumnValue(
    table.username,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> facts(List<String> value) =>
      _is.ColumnValue(
        table.facts,
        value,
      );

  _is.ColumnValue<int, int> visitCount(int value) => _is.ColumnValue(
    table.visitCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> firstSeen(DateTime value) =>
      _is.ColumnValue(
        table.firstSeen,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSeen(DateTime value) =>
      _is.ColumnValue(
        table.lastSeen,
        value,
      );
}

class UserProfileTable extends _is.Table<int?> {
  UserProfileTable({super.tableRelation}) : super(tableName: 'user_profile') {
    updateTable = UserProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    username = _is.ColumnString(
      'username',
      this,
    );
    facts = _is.ColumnSerializable<List<String>>(
      'facts',
      this,
    );
    visitCount = _is.ColumnInt(
      'visitCount',
      this,
    );
    firstSeen = _is.ColumnDateTime(
      'firstSeen',
      this,
    );
    lastSeen = _is.ColumnDateTime(
      'lastSeen',
      this,
    );
  }

  late final UserProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString username;

  late final _is.ColumnSerializable<List<String>> facts;

  late final _is.ColumnInt visitCount;

  late final _is.ColumnDateTime firstSeen;

  late final _is.ColumnDateTime lastSeen;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    username,
    facts,
    visitCount,
    firstSeen,
    lastSeen,
  ];
}

class UserProfileInclude extends _is.IncludeObject {
  UserProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserProfile.t;
}

class UserProfileIncludeList extends _is.IncludeList {
  UserProfileIncludeList._({
    _is.WhereExpressionBuilder<UserProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserProfile.t;
}

class UserProfileRepository {
  const UserProfileRepository._();

  /// Returns a list of [UserProfile]s matching the given query parameters.
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
  Future<List<UserProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserProfile>(
      where: where?.call(UserProfile.t),
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserProfile] matching the given query parameters.
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
  Future<UserProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserProfile>(
      where: where?.call(UserProfile.t),
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserProfile] by its [id] or null if no such row exists.
  Future<UserProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [UserProfile]s will have their `id` fields set.
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
  Future<List<UserProfile>> insert(
    _is.DatabaseSession session,
    List<UserProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserProfile] and returns the inserted row.
  ///
  /// The returned [UserProfile] will have its `id` field set.
  Future<UserProfile> insertRow(
    _is.DatabaseSession session,
    UserProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserProfile]s in the list and returns the resulting rows.
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
  /// The returned [UserProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserProfile>> upsert(
    _is.DatabaseSession session,
    List<UserProfile> rows, {
    required _is.ColumnSelections<UserProfileTable> conflictColumns,
    _is.ColumnSelections<UserProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<UserProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserProfile>(
      rows,
      conflictColumns: conflictColumns(UserProfile.t),
      updateColumns: updateColumns?.call(UserProfile.t),
      updateWhere: updateWhere?.call(UserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserProfile] and returns the resulting row.
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
  /// The returned [UserProfile] will have its `id` field set.
  Future<UserProfile?> upsertRow(
    _is.DatabaseSession session,
    UserProfile row, {
    required _is.ColumnSelections<UserProfileTable> conflictColumns,
    _is.ColumnSelections<UserProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<UserProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserProfile>(
      row,
      conflictColumns: conflictColumns(UserProfile.t),
      updateColumns: updateColumns?.call(UserProfile.t),
      updateWhere: updateWhere?.call(UserProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserProfile>> update(
    _is.DatabaseSession session,
    List<UserProfile> rows, {
    _is.ColumnSelections<UserProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserProfile>(
      rows,
      columns: columns?.call(UserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserProfile> updateRow(
    _is.DatabaseSession session,
    UserProfile row, {
    _is.ColumnSelections<UserProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserProfile>(
      row,
      columns: columns?.call(UserProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserProfile>(
      id,
      columnValues: columnValues(UserProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserProfile>(
      columnValues: columnValues(UserProfile.t.updateTable),
      where: where(UserProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserProfile]s in the list and returns the deleted rows.
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
  Future<List<UserProfile>> delete(
    _is.DatabaseSession session,
    List<UserProfile> rows, {
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserProfile>(
      rows,
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserProfile].
  Future<UserProfile> deleteRow(
    _is.DatabaseSession session,
    UserProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserProfile>(
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
  Future<List<UserProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserProfileTable> where,
    _is.OrderByBuilder<UserProfileTable>? orderBy,
    _is.OrderByListBuilder<UserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserProfile>(
      where: where(UserProfile.t),
      orderBy: orderBy?.call(UserProfile.t),
      orderByList: orderByList?.call(UserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserProfile>(
      where: where?.call(UserProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserProfile>(
      where: where(UserProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
