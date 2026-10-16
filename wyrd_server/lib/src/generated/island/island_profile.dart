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

/// A WYRD user on LAGOS ISLAND: the name others see, the skills they choose to show employers, their
/// messaging public key (the private key never leaves their browser), and their personal HQ.
abstract class IslandProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandProfile._({
    this.id,
    required this.authUserId,
    required this.handle,
    String? skills,
    bool? openToWork,
    this.pubKey,
    this.hqName,
    String? hqColor,
    bool? hqLocked,
    String? hqInvites,
    this.look,
    required this.createdAt,
  }) : skills = skills ?? '',
       openToWork = openToWork ?? false,
       hqColor = hqColor ?? '#A855F7',
       hqLocked = hqLocked ?? true,
       hqInvites = hqInvites ?? '[]';

  factory IslandProfile({
    int? id,
    required _is.UuidValue authUserId,
    required String handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    String? hqInvites,
    String? look,
    required DateTime createdAt,
  }) = _IslandProfileImpl;

  factory IslandProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      handle: jsonSerialization['handle'] as String,
      skills: jsonSerialization['skills'] as String?,
      openToWork: jsonSerialization['openToWork'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['openToWork']),
      pubKey: jsonSerialization['pubKey'] as String?,
      hqName: jsonSerialization['hqName'] as String?,
      hqColor: jsonSerialization['hqColor'] as String?,
      hqLocked: jsonSerialization['hqLocked'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['hqLocked']),
      hqInvites: jsonSerialization['hqInvites'] as String?,
      look: jsonSerialization['look'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandProfileTable();

  static const db = IslandProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// the name on the island, unique (letters, digits, _ . -)
  String handle;

  /// what they can do, comma separated, as they wrote it; used for job matching only when openToWork
  String skills;

  bool openToWork;

  /// their ECDH P-256 public key (JWK, JSON); messages to them are encrypted with it in the browser
  String? pubKey;

  /// their HQ: its name, colour, whether anyone may walk in, and who is invited (JSON list of handles)
  String? hqName;

  String hqColor;

  bool hqLocked;

  String hqInvites;

  /// how they look on the island: "g,skin,hair,style,bottom" (g: m or f), chosen when they joined
  String? look;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    String? hqInvites,
    String? look,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'handle': handle,
      'skills': skills,
      'openToWork': openToWork,
      if (pubKey != null) 'pubKey': pubKey,
      if (hqName != null) 'hqName': hqName,
      'hqColor': hqColor,
      'hqLocked': hqLocked,
      'hqInvites': hqInvites,
      if (look != null) 'look': look,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'handle': handle,
      'skills': skills,
      'openToWork': openToWork,
      if (pubKey != null) 'pubKey': pubKey,
      if (hqName != null) 'hqName': hqName,
      'hqColor': hqColor,
      'hqLocked': hqLocked,
      'hqInvites': hqInvites,
      if (look != null) 'look': look,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandProfileInclude include() {
    return IslandProfileInclude._();
  }

  static IslandProfileIncludeList includeList({
    _is.WhereExpressionBuilder<IslandProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    IslandProfileInclude? include,
  }) {
    return IslandProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandProfileImpl extends IslandProfile {
  _IslandProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String handle,
    String? skills,
    bool? openToWork,
    String? pubKey,
    String? hqName,
    String? hqColor,
    bool? hqLocked,
    String? hqInvites,
    String? look,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         handle: handle,
         skills: skills,
         openToWork: openToWork,
         pubKey: pubKey,
         hqName: hqName,
         hqColor: hqColor,
         hqLocked: hqLocked,
         hqInvites: hqInvites,
         look: look,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? handle,
    String? skills,
    bool? openToWork,
    Object? pubKey = _Undefined,
    Object? hqName = _Undefined,
    String? hqColor,
    bool? hqLocked,
    String? hqInvites,
    Object? look = _Undefined,
    DateTime? createdAt,
  }) {
    return IslandProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      handle: handle ?? this.handle,
      skills: skills ?? this.skills,
      openToWork: openToWork ?? this.openToWork,
      pubKey: pubKey is String? ? pubKey : this.pubKey,
      hqName: hqName is String? ? hqName : this.hqName,
      hqColor: hqColor ?? this.hqColor,
      hqLocked: hqLocked ?? this.hqLocked,
      hqInvites: hqInvites ?? this.hqInvites,
      look: look is String? ? look : this.look,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandProfileUpdateTable extends _is.UpdateTable<IslandProfileTable> {
  IslandProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> handle(String value) => _is.ColumnValue(
    table.handle,
    value,
  );

  _is.ColumnValue<String, String> skills(String value) => _is.ColumnValue(
    table.skills,
    value,
  );

  _is.ColumnValue<bool, bool> openToWork(bool value) => _is.ColumnValue(
    table.openToWork,
    value,
  );

  _is.ColumnValue<String, String> pubKey(String? value) => _is.ColumnValue(
    table.pubKey,
    value,
  );

  _is.ColumnValue<String, String> hqName(String? value) => _is.ColumnValue(
    table.hqName,
    value,
  );

  _is.ColumnValue<String, String> hqColor(String value) => _is.ColumnValue(
    table.hqColor,
    value,
  );

  _is.ColumnValue<bool, bool> hqLocked(bool value) => _is.ColumnValue(
    table.hqLocked,
    value,
  );

  _is.ColumnValue<String, String> hqInvites(String value) => _is.ColumnValue(
    table.hqInvites,
    value,
  );

  _is.ColumnValue<String, String> look(String? value) => _is.ColumnValue(
    table.look,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandProfileTable extends _is.Table<int?> {
  IslandProfileTable({super.tableRelation})
    : super(tableName: 'island_profile') {
    updateTable = IslandProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    handle = _is.ColumnString(
      'handle',
      this,
    );
    skills = _is.ColumnString(
      'skills',
      this,
      hasDefault: true,
    );
    openToWork = _is.ColumnBool(
      'openToWork',
      this,
      hasDefault: true,
    );
    pubKey = _is.ColumnString(
      'pubKey',
      this,
    );
    hqName = _is.ColumnString(
      'hqName',
      this,
    );
    hqColor = _is.ColumnString(
      'hqColor',
      this,
      hasDefault: true,
    );
    hqLocked = _is.ColumnBool(
      'hqLocked',
      this,
      hasDefault: true,
    );
    hqInvites = _is.ColumnString(
      'hqInvites',
      this,
      hasDefault: true,
    );
    look = _is.ColumnString(
      'look',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// the name on the island, unique (letters, digits, _ . -)
  late final _is.ColumnString handle;

  /// what they can do, comma separated, as they wrote it; used for job matching only when openToWork
  late final _is.ColumnString skills;

  late final _is.ColumnBool openToWork;

  /// their ECDH P-256 public key (JWK, JSON); messages to them are encrypted with it in the browser
  late final _is.ColumnString pubKey;

  /// their HQ: its name, colour, whether anyone may walk in, and who is invited (JSON list of handles)
  late final _is.ColumnString hqName;

  late final _is.ColumnString hqColor;

  late final _is.ColumnBool hqLocked;

  late final _is.ColumnString hqInvites;

  /// how they look on the island: "g,skin,hair,style,bottom" (g: m or f), chosen when they joined
  late final _is.ColumnString look;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    handle,
    skills,
    openToWork,
    pubKey,
    hqName,
    hqColor,
    hqLocked,
    hqInvites,
    look,
    createdAt,
  ];
}

class IslandProfileInclude extends _is.IncludeObject {
  IslandProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandProfile.t;
}

class IslandProfileIncludeList extends _is.IncludeList {
  IslandProfileIncludeList._({
    _is.WhereExpressionBuilder<IslandProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandProfile.t;
}

class IslandProfileRepository {
  const IslandProfileRepository._();

  /// Returns a list of [IslandProfile]s matching the given query parameters.
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
  Future<List<IslandProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandProfile>(
      where: where?.call(IslandProfile.t),
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandProfile] matching the given query parameters.
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
  Future<IslandProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandProfile>(
      where: where?.call(IslandProfile.t),
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandProfile] by its [id] or null if no such row exists.
  Future<IslandProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandProfile]s will have their `id` fields set.
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
  Future<List<IslandProfile>> insert(
    _is.DatabaseSession session,
    List<IslandProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandProfile] and returns the inserted row.
  ///
  /// The returned [IslandProfile] will have its `id` field set.
  Future<IslandProfile> insertRow(
    _is.DatabaseSession session,
    IslandProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandProfile]s in the list and returns the resulting rows.
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
  /// The returned [IslandProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandProfile>> upsert(
    _is.DatabaseSession session,
    List<IslandProfile> rows, {
    required _is.ColumnSelections<IslandProfileTable> conflictColumns,
    _is.ColumnSelections<IslandProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandProfile>(
      rows,
      conflictColumns: conflictColumns(IslandProfile.t),
      updateColumns: updateColumns?.call(IslandProfile.t),
      updateWhere: updateWhere?.call(IslandProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandProfile] and returns the resulting row.
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
  /// The returned [IslandProfile] will have its `id` field set.
  Future<IslandProfile?> upsertRow(
    _is.DatabaseSession session,
    IslandProfile row, {
    required _is.ColumnSelections<IslandProfileTable> conflictColumns,
    _is.ColumnSelections<IslandProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandProfile>(
      row,
      conflictColumns: conflictColumns(IslandProfile.t),
      updateColumns: updateColumns?.call(IslandProfile.t),
      updateWhere: updateWhere?.call(IslandProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandProfile>> update(
    _is.DatabaseSession session,
    List<IslandProfile> rows, {
    _is.ColumnSelections<IslandProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandProfile>(
      rows,
      columns: columns?.call(IslandProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandProfile> updateRow(
    _is.DatabaseSession session,
    IslandProfile row, {
    _is.ColumnSelections<IslandProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandProfile>(
      row,
      columns: columns?.call(IslandProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandProfile>(
      id,
      columnValues: columnValues(IslandProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandProfile>(
      columnValues: columnValues(IslandProfile.t.updateTable),
      where: where(IslandProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandProfile]s in the list and returns the deleted rows.
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
  Future<List<IslandProfile>> delete(
    _is.DatabaseSession session,
    List<IslandProfile> rows, {
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandProfile>(
      rows,
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandProfile].
  Future<IslandProfile> deleteRow(
    _is.DatabaseSession session,
    IslandProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandProfile>(
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
  Future<List<IslandProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandProfileTable> where,
    _is.OrderByBuilder<IslandProfileTable>? orderBy,
    _is.OrderByListBuilder<IslandProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandProfile>(
      where: where(IslandProfile.t),
      orderBy: orderBy?.call(IslandProfile.t),
      orderByList: orderByList?.call(IslandProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandProfile>(
      where: where?.call(IslandProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandProfile>(
      where: where(IslandProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
