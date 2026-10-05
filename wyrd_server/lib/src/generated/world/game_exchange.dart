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

/// One moment of play, kept to teach WYRD (only with the player's consent, or the owner's own design
/// sessions): what was happening, what the player said or did, what WYRD answered and did, and how it
/// turned out. Scrubbed of personal details before it's stored.
abstract class GameExchange
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  GameExchange._({
    this.id,
    required this.authUserId,
    required this.channel,
    required this.situation,
    required this.said,
    required this.reply,
    required this.actions,
    this.outcome,
    required this.createdAt,
  });

  factory GameExchange({
    int? id,
    required _is.UuidValue authUserId,
    required String channel,
    required String situation,
    required String said,
    required String reply,
    required String actions,
    String? outcome,
    required DateTime createdAt,
  }) = _GameExchangeImpl;

  factory GameExchange.fromJson(Map<String, dynamic> jsonSerialization) {
    return GameExchange(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      channel: jsonSerialization['channel'] as String,
      situation: jsonSerialization['situation'] as String,
      said: jsonSerialization['said'] as String,
      reply: jsonSerialization['reply'] as String,
      actions: jsonSerialization['actions'] as String,
      outcome: jsonSerialization['outcome'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = GameExchangeTable();

  static const db = GameExchangeRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// speak | petition | drone | event | design
  String channel;

  /// the game's situation (JSON, scrubbed)
  String situation;

  String said;

  String reply;

  /// what WYRD did (JSON list of actions)
  String actions;

  /// how it turned out, filled in later: e.g. "mission_done", "standing:+4"
  String? outcome;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [GameExchange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  GameExchange copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? channel,
    String? situation,
    String? said,
    String? reply,
    String? actions,
    String? outcome,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GameExchange',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'channel': channel,
      'situation': situation,
      'said': said,
      'reply': reply,
      'actions': actions,
      if (outcome != null) 'outcome': outcome,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GameExchange',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'channel': channel,
      'situation': situation,
      'said': said,
      'reply': reply,
      'actions': actions,
      if (outcome != null) 'outcome': outcome,
      'createdAt': createdAt.toJson(),
    };
  }

  static GameExchangeInclude include() {
    return GameExchangeInclude._();
  }

  static GameExchangeIncludeList includeList({
    _is.WhereExpressionBuilder<GameExchangeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    GameExchangeInclude? include,
  }) {
    return GameExchangeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GameExchangeImpl extends GameExchange {
  _GameExchangeImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String channel,
    required String situation,
    required String said,
    required String reply,
    required String actions,
    String? outcome,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         channel: channel,
         situation: situation,
         said: said,
         reply: reply,
         actions: actions,
         outcome: outcome,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [GameExchange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  GameExchange copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? channel,
    String? situation,
    String? said,
    String? reply,
    String? actions,
    Object? outcome = _Undefined,
    DateTime? createdAt,
  }) {
    return GameExchange(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      channel: channel ?? this.channel,
      situation: situation ?? this.situation,
      said: said ?? this.said,
      reply: reply ?? this.reply,
      actions: actions ?? this.actions,
      outcome: outcome is String? ? outcome : this.outcome,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class GameExchangeUpdateTable extends _is.UpdateTable<GameExchangeTable> {
  GameExchangeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> channel(String value) => _is.ColumnValue(
    table.channel,
    value,
  );

  _is.ColumnValue<String, String> situation(String value) => _is.ColumnValue(
    table.situation,
    value,
  );

  _is.ColumnValue<String, String> said(String value) => _is.ColumnValue(
    table.said,
    value,
  );

  _is.ColumnValue<String, String> reply(String value) => _is.ColumnValue(
    table.reply,
    value,
  );

  _is.ColumnValue<String, String> actions(String value) => _is.ColumnValue(
    table.actions,
    value,
  );

  _is.ColumnValue<String, String> outcome(String? value) => _is.ColumnValue(
    table.outcome,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class GameExchangeTable extends _is.Table<int?> {
  GameExchangeTable({super.tableRelation}) : super(tableName: 'game_exchange') {
    updateTable = GameExchangeUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    channel = _is.ColumnString(
      'channel',
      this,
    );
    situation = _is.ColumnString(
      'situation',
      this,
    );
    said = _is.ColumnString(
      'said',
      this,
    );
    reply = _is.ColumnString(
      'reply',
      this,
    );
    actions = _is.ColumnString(
      'actions',
      this,
    );
    outcome = _is.ColumnString(
      'outcome',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final GameExchangeUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// speak | petition | drone | event | design
  late final _is.ColumnString channel;

  /// the game's situation (JSON, scrubbed)
  late final _is.ColumnString situation;

  late final _is.ColumnString said;

  late final _is.ColumnString reply;

  /// what WYRD did (JSON list of actions)
  late final _is.ColumnString actions;

  /// how it turned out, filled in later: e.g. "mission_done", "standing:+4"
  late final _is.ColumnString outcome;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    channel,
    situation,
    said,
    reply,
    actions,
    outcome,
    createdAt,
  ];
}

class GameExchangeInclude extends _is.IncludeObject {
  GameExchangeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => GameExchange.t;
}

class GameExchangeIncludeList extends _is.IncludeList {
  GameExchangeIncludeList._({
    _is.WhereExpressionBuilder<GameExchangeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GameExchange.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => GameExchange.t;
}

class GameExchangeRepository {
  const GameExchangeRepository._();

  /// Returns a list of [GameExchange]s matching the given query parameters.
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
  Future<List<GameExchange>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameExchangeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GameExchange>(
      where: where?.call(GameExchange.t),
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GameExchange] matching the given query parameters.
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
  Future<GameExchange?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameExchangeTable>? where,
    int? offset,
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GameExchange>(
      where: where?.call(GameExchange.t),
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GameExchange] by its [id] or null if no such row exists.
  Future<GameExchange?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GameExchange>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GameExchange]s in the list and returns the inserted rows.
  ///
  /// The returned [GameExchange]s will have their `id` fields set.
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
  Future<List<GameExchange>> insert(
    _is.DatabaseSession session,
    List<GameExchange> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<GameExchange>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [GameExchange] and returns the inserted row.
  ///
  /// The returned [GameExchange] will have its `id` field set.
  Future<GameExchange> insertRow(
    _is.DatabaseSession session,
    GameExchange row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<GameExchange>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [GameExchange]s in the list and returns the resulting rows.
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
  /// The returned [GameExchange]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameExchange>> upsert(
    _is.DatabaseSession session,
    List<GameExchange> rows, {
    required _is.ColumnSelections<GameExchangeTable> conflictColumns,
    _is.ColumnSelections<GameExchangeTable>? updateColumns,
    _is.WhereExpressionBuilder<GameExchangeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<GameExchange>(
      rows,
      conflictColumns: conflictColumns(GameExchange.t),
      updateColumns: updateColumns?.call(GameExchange.t),
      updateWhere: updateWhere?.call(GameExchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [GameExchange] and returns the resulting row.
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
  /// The returned [GameExchange] will have its `id` field set.
  Future<GameExchange?> upsertRow(
    _is.DatabaseSession session,
    GameExchange row, {
    required _is.ColumnSelections<GameExchangeTable> conflictColumns,
    _is.ColumnSelections<GameExchangeTable>? updateColumns,
    _is.WhereExpressionBuilder<GameExchangeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<GameExchange>(
      row,
      conflictColumns: conflictColumns(GameExchange.t),
      updateColumns: updateColumns?.call(GameExchange.t),
      updateWhere: updateWhere?.call(GameExchange.t),
      transaction: transaction,
    );
  }

  /// Updates all [GameExchange]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameExchange>> update(
    _is.DatabaseSession session,
    List<GameExchange> rows, {
    _is.ColumnSelections<GameExchangeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<GameExchange>(
      rows,
      columns: columns?.call(GameExchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [GameExchange]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GameExchange> updateRow(
    _is.DatabaseSession session,
    GameExchange row, {
    _is.ColumnSelections<GameExchangeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<GameExchange>(
      row,
      columns: columns?.call(GameExchange.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GameExchange] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GameExchange?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GameExchangeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<GameExchange>(
      id,
      columnValues: columnValues(GameExchange.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GameExchange]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameExchange>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GameExchangeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GameExchangeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<GameExchange>(
      columnValues: columnValues(GameExchange.t.updateTable),
      where: where(GameExchange.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [GameExchange]s in the list and returns the deleted rows.
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
  Future<List<GameExchange>> delete(
    _is.DatabaseSession session,
    List<GameExchange> rows, {
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<GameExchange>(
      rows,
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [GameExchange].
  Future<GameExchange> deleteRow(
    _is.DatabaseSession session,
    GameExchange row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GameExchange>(
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
  Future<List<GameExchange>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GameExchangeTable> where,
    _is.OrderByBuilder<GameExchangeTable>? orderBy,
    _is.OrderByListBuilder<GameExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<GameExchange>(
      where: where(GameExchange.t),
      orderBy: orderBy?.call(GameExchange.t),
      orderByList: orderByList?.call(GameExchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameExchangeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<GameExchange>(
      where: where?.call(GameExchange.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GameExchange] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GameExchangeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GameExchange>(
      where: where(GameExchange.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
