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

/// A partner's API key (Konnectly first). Only a SHA-256 hash of the key is kept: a lost key can't be recovered,
/// only replaced. [env] is test (staging) or live (production); two keys can be active at once for rotation.
abstract class PartnerKey
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerKey._({
    this.id,
    required this.keyHash,
    required this.prefix,
    required this.partner,
    required this.env,
    required this.label,
    bool? active,
    required this.createdAt,
    this.revokedAt,
    this.lastUsedAt,
  }) : active = active ?? true;

  factory PartnerKey({
    int? id,
    required String keyHash,
    required String prefix,
    required String partner,
    required String env,
    required String label,
    bool? active,
    required DateTime createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  }) = _PartnerKeyImpl;

  factory PartnerKey.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerKey(
      id: jsonSerialization['id'] as int?,
      keyHash: jsonSerialization['keyHash'] as String,
      prefix: jsonSerialization['prefix'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      label: jsonSerialization['label'] as String,
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      lastUsedAt: jsonSerialization['lastUsedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastUsedAt']),
    );
  }

  static final t = PartnerKeyTable();

  static const db = PartnerKeyRepository._();

  @override
  int? id;

  String keyHash;

  /// the first characters of the key, to recognise it in lists (e.g. kn_test_a1b2)
  String prefix;

  String partner;

  String env;

  String label;

  bool active;

  DateTime createdAt;

  DateTime? revokedAt;

  DateTime? lastUsedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerKey]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerKey copyWith({
    int? id,
    String? keyHash,
    String? prefix,
    String? partner,
    String? env,
    String? label,
    bool? active,
    DateTime? createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerKey',
      if (id != null) 'id': id,
      'keyHash': keyHash,
      'prefix': prefix,
      'partner': partner,
      'env': env,
      'label': label,
      'active': active,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerKey',
      if (id != null) 'id': id,
      'keyHash': keyHash,
      'prefix': prefix,
      'partner': partner,
      'env': env,
      'label': label,
      'active': active,
      'createdAt': createdAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toJson(),
    };
  }

  static PartnerKeyInclude include() {
    return PartnerKeyInclude._();
  }

  static PartnerKeyIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerKeyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    PartnerKeyInclude? include,
  }) {
    return PartnerKeyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerKeyImpl extends PartnerKey {
  _PartnerKeyImpl({
    int? id,
    required String keyHash,
    required String prefix,
    required String partner,
    required String env,
    required String label,
    bool? active,
    required DateTime createdAt,
    DateTime? revokedAt,
    DateTime? lastUsedAt,
  }) : super._(
         id: id,
         keyHash: keyHash,
         prefix: prefix,
         partner: partner,
         env: env,
         label: label,
         active: active,
         createdAt: createdAt,
         revokedAt: revokedAt,
         lastUsedAt: lastUsedAt,
       );

  /// Returns a shallow copy of this [PartnerKey]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerKey copyWith({
    Object? id = _Undefined,
    String? keyHash,
    String? prefix,
    String? partner,
    String? env,
    String? label,
    bool? active,
    DateTime? createdAt,
    Object? revokedAt = _Undefined,
    Object? lastUsedAt = _Undefined,
  }) {
    return PartnerKey(
      id: id is int? ? id : this.id,
      keyHash: keyHash ?? this.keyHash,
      prefix: prefix ?? this.prefix,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      label: label ?? this.label,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      lastUsedAt: lastUsedAt is DateTime? ? lastUsedAt : this.lastUsedAt,
    );
  }
}

class PartnerKeyUpdateTable extends _is.UpdateTable<PartnerKeyTable> {
  PartnerKeyUpdateTable(super.table);

  _is.ColumnValue<String, String> keyHash(String value) => _is.ColumnValue(
    table.keyHash,
    value,
  );

  _is.ColumnValue<String, String> prefix(String value) => _is.ColumnValue(
    table.prefix,
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

  _is.ColumnValue<String, String> label(String value) => _is.ColumnValue(
    table.label,
    value,
  );

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastUsedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastUsedAt,
        value,
      );
}

class PartnerKeyTable extends _is.Table<int?> {
  PartnerKeyTable({super.tableRelation}) : super(tableName: 'partner_key') {
    updateTable = PartnerKeyUpdateTable(this);
    keyHash = _is.ColumnString(
      'keyHash',
      this,
    );
    prefix = _is.ColumnString(
      'prefix',
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
    label = _is.ColumnString(
      'label',
      this,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
    lastUsedAt = _is.ColumnDateTime(
      'lastUsedAt',
      this,
    );
  }

  late final PartnerKeyUpdateTable updateTable;

  late final _is.ColumnString keyHash;

  /// the first characters of the key, to recognise it in lists (e.g. kn_test_a1b2)
  late final _is.ColumnString prefix;

  late final _is.ColumnString partner;

  late final _is.ColumnString env;

  late final _is.ColumnString label;

  late final _is.ColumnBool active;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime revokedAt;

  late final _is.ColumnDateTime lastUsedAt;

  @override
  List<_is.Column> get columns => [
    id,
    keyHash,
    prefix,
    partner,
    env,
    label,
    active,
    createdAt,
    revokedAt,
    lastUsedAt,
  ];
}

class PartnerKeyInclude extends _is.IncludeObject {
  PartnerKeyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerKey.t;
}

class PartnerKeyIncludeList extends _is.IncludeList {
  PartnerKeyIncludeList._({
    _is.WhereExpressionBuilder<PartnerKeyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerKey.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerKey.t;
}

class PartnerKeyRepository {
  const PartnerKeyRepository._();

  /// Returns a list of [PartnerKey]s matching the given query parameters.
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
  Future<List<PartnerKey>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerKeyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerKey>(
      where: where?.call(PartnerKey.t),
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerKey] matching the given query parameters.
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
  Future<PartnerKey?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerKeyTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerKey>(
      where: where?.call(PartnerKey.t),
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerKey] by its [id] or null if no such row exists.
  Future<PartnerKey?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerKey>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerKey]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerKey]s will have their `id` fields set.
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
  Future<List<PartnerKey>> insert(
    _is.DatabaseSession session,
    List<PartnerKey> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerKey>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerKey] and returns the inserted row.
  ///
  /// The returned [PartnerKey] will have its `id` field set.
  Future<PartnerKey> insertRow(
    _is.DatabaseSession session,
    PartnerKey row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerKey>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerKey]s in the list and returns the resulting rows.
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
  /// The returned [PartnerKey]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerKey>> upsert(
    _is.DatabaseSession session,
    List<PartnerKey> rows, {
    required _is.ColumnSelections<PartnerKeyTable> conflictColumns,
    _is.ColumnSelections<PartnerKeyTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerKeyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerKey>(
      rows,
      conflictColumns: conflictColumns(PartnerKey.t),
      updateColumns: updateColumns?.call(PartnerKey.t),
      updateWhere: updateWhere?.call(PartnerKey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerKey] and returns the resulting row.
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
  /// The returned [PartnerKey] will have its `id` field set.
  Future<PartnerKey?> upsertRow(
    _is.DatabaseSession session,
    PartnerKey row, {
    required _is.ColumnSelections<PartnerKeyTable> conflictColumns,
    _is.ColumnSelections<PartnerKeyTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerKeyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerKey>(
      row,
      conflictColumns: conflictColumns(PartnerKey.t),
      updateColumns: updateColumns?.call(PartnerKey.t),
      updateWhere: updateWhere?.call(PartnerKey.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerKey]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerKey>> update(
    _is.DatabaseSession session,
    List<PartnerKey> rows, {
    _is.ColumnSelections<PartnerKeyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerKey>(
      rows,
      columns: columns?.call(PartnerKey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerKey]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerKey> updateRow(
    _is.DatabaseSession session,
    PartnerKey row, {
    _is.ColumnSelections<PartnerKeyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerKey>(
      row,
      columns: columns?.call(PartnerKey.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerKey] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerKey?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerKeyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerKey>(
      id,
      columnValues: columnValues(PartnerKey.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerKey]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerKey>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerKeyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PartnerKeyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerKey>(
      columnValues: columnValues(PartnerKey.t.updateTable),
      where: where(PartnerKey.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerKey]s in the list and returns the deleted rows.
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
  Future<List<PartnerKey>> delete(
    _is.DatabaseSession session,
    List<PartnerKey> rows, {
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerKey>(
      rows,
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerKey].
  Future<PartnerKey> deleteRow(
    _is.DatabaseSession session,
    PartnerKey row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerKey>(
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
  Future<List<PartnerKey>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerKeyTable> where,
    _is.OrderByBuilder<PartnerKeyTable>? orderBy,
    _is.OrderByListBuilder<PartnerKeyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerKey>(
      where: where(PartnerKey.t),
      orderBy: orderBy?.call(PartnerKey.t),
      orderByList: orderByList?.call(PartnerKey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerKeyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerKey>(
      where: where?.call(PartnerKey.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerKey] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerKeyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerKey>(
      where: where(PartnerKey.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
