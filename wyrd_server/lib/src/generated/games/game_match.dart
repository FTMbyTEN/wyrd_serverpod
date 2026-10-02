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

/// A game against WYRD (or, later, another player). The server holds the position and checks every move.
abstract class GameMatch
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  GameMatch._({
    this.id,
    required this.authUserId,
    required this.game,
    required this.state,
    required this.moves,
    required this.playerSide,
    required this.status,
    required this.wyrdLevel,
    required this.ratingBefore,
    this.ratingAfter,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GameMatch({
    int? id,
    required _is.UuidValue authUserId,
    required String game,
    required String state,
    required List<String> moves,
    required String playerSide,
    required String status,
    required int wyrdLevel,
    required double ratingBefore,
    double? ratingAfter,
    String? remark,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GameMatchImpl;

  factory GameMatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return GameMatch(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      game: jsonSerialization['game'] as String,
      state: jsonSerialization['state'] as String,
      moves: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['moves'],
      ),
      playerSide: jsonSerialization['playerSide'] as String,
      status: jsonSerialization['status'] as String,
      wyrdLevel: jsonSerialization['wyrdLevel'] as int,
      ratingBefore: (jsonSerialization['ratingBefore'] as num).toDouble(),
      ratingAfter: (jsonSerialization['ratingAfter'] as num?)?.toDouble(),
      remark: jsonSerialization['remark'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = GameMatchTable();

  static const db = GameMatchRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String game;

  String state;

  List<String> moves;

  String playerSide;

  String status;

  int wyrdLevel;

  double ratingBefore;

  double? ratingAfter;

  String? remark;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [GameMatch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  GameMatch copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? game,
    String? state,
    List<String>? moves,
    String? playerSide,
    String? status,
    int? wyrdLevel,
    double? ratingBefore,
    double? ratingAfter,
    String? remark,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GameMatch',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'state': state,
      'moves': moves.toJson(),
      'playerSide': playerSide,
      'status': status,
      'wyrdLevel': wyrdLevel,
      'ratingBefore': ratingBefore,
      if (ratingAfter != null) 'ratingAfter': ratingAfter,
      if (remark != null) 'remark': remark,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GameMatch',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'state': state,
      'moves': moves.toJson(),
      'playerSide': playerSide,
      'status': status,
      'wyrdLevel': wyrdLevel,
      'ratingBefore': ratingBefore,
      if (ratingAfter != null) 'ratingAfter': ratingAfter,
      if (remark != null) 'remark': remark,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static GameMatchInclude include() {
    return GameMatchInclude._();
  }

  static GameMatchIncludeList includeList({
    _is.WhereExpressionBuilder<GameMatchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    GameMatchInclude? include,
  }) {
    return GameMatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GameMatchImpl extends GameMatch {
  _GameMatchImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String game,
    required String state,
    required List<String> moves,
    required String playerSide,
    required String status,
    required int wyrdLevel,
    required double ratingBefore,
    double? ratingAfter,
    String? remark,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         game: game,
         state: state,
         moves: moves,
         playerSide: playerSide,
         status: status,
         wyrdLevel: wyrdLevel,
         ratingBefore: ratingBefore,
         ratingAfter: ratingAfter,
         remark: remark,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GameMatch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  GameMatch copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? game,
    String? state,
    List<String>? moves,
    String? playerSide,
    String? status,
    int? wyrdLevel,
    double? ratingBefore,
    Object? ratingAfter = _Undefined,
    Object? remark = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GameMatch(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      game: game ?? this.game,
      state: state ?? this.state,
      moves: moves ?? this.moves.map((e0) => e0).toList(),
      playerSide: playerSide ?? this.playerSide,
      status: status ?? this.status,
      wyrdLevel: wyrdLevel ?? this.wyrdLevel,
      ratingBefore: ratingBefore ?? this.ratingBefore,
      ratingAfter: ratingAfter is double? ? ratingAfter : this.ratingAfter,
      remark: remark is String? ? remark : this.remark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class GameMatchUpdateTable extends _is.UpdateTable<GameMatchTable> {
  GameMatchUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> game(String value) => _is.ColumnValue(
    table.game,
    value,
  );

  _is.ColumnValue<String, String> state(String value) => _is.ColumnValue(
    table.state,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> moves(List<String> value) =>
      _is.ColumnValue(
        table.moves,
        value,
      );

  _is.ColumnValue<String, String> playerSide(String value) => _is.ColumnValue(
    table.playerSide,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> wyrdLevel(int value) => _is.ColumnValue(
    table.wyrdLevel,
    value,
  );

  _is.ColumnValue<double, double> ratingBefore(double value) => _is.ColumnValue(
    table.ratingBefore,
    value,
  );

  _is.ColumnValue<double, double> ratingAfter(double? value) => _is.ColumnValue(
    table.ratingAfter,
    value,
  );

  _is.ColumnValue<String, String> remark(String? value) => _is.ColumnValue(
    table.remark,
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

class GameMatchTable extends _is.Table<int?> {
  GameMatchTable({super.tableRelation}) : super(tableName: 'game_match') {
    updateTable = GameMatchUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    game = _is.ColumnString(
      'game',
      this,
    );
    state = _is.ColumnString(
      'state',
      this,
    );
    moves = _is.ColumnSerializable<List<String>>(
      'moves',
      this,
    );
    playerSide = _is.ColumnString(
      'playerSide',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    wyrdLevel = _is.ColumnInt(
      'wyrdLevel',
      this,
    );
    ratingBefore = _is.ColumnDouble(
      'ratingBefore',
      this,
    );
    ratingAfter = _is.ColumnDouble(
      'ratingAfter',
      this,
    );
    remark = _is.ColumnString(
      'remark',
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

  late final GameMatchUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString game;

  late final _is.ColumnString state;

  late final _is.ColumnSerializable<List<String>> moves;

  late final _is.ColumnString playerSide;

  late final _is.ColumnString status;

  late final _is.ColumnInt wyrdLevel;

  late final _is.ColumnDouble ratingBefore;

  late final _is.ColumnDouble ratingAfter;

  late final _is.ColumnString remark;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    game,
    state,
    moves,
    playerSide,
    status,
    wyrdLevel,
    ratingBefore,
    ratingAfter,
    remark,
    createdAt,
    updatedAt,
  ];
}

class GameMatchInclude extends _is.IncludeObject {
  GameMatchInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => GameMatch.t;
}

class GameMatchIncludeList extends _is.IncludeList {
  GameMatchIncludeList._({
    _is.WhereExpressionBuilder<GameMatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GameMatch.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => GameMatch.t;
}

class GameMatchRepository {
  const GameMatchRepository._();

  /// Returns a list of [GameMatch]s matching the given query parameters.
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
  Future<List<GameMatch>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameMatchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GameMatch>(
      where: where?.call(GameMatch.t),
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GameMatch] matching the given query parameters.
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
  Future<GameMatch?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameMatchTable>? where,
    int? offset,
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GameMatch>(
      where: where?.call(GameMatch.t),
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GameMatch] by its [id] or null if no such row exists.
  Future<GameMatch?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GameMatch>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GameMatch]s in the list and returns the inserted rows.
  ///
  /// The returned [GameMatch]s will have their `id` fields set.
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
  Future<List<GameMatch>> insert(
    _is.DatabaseSession session,
    List<GameMatch> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<GameMatch>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [GameMatch] and returns the inserted row.
  ///
  /// The returned [GameMatch] will have its `id` field set.
  Future<GameMatch> insertRow(
    _is.DatabaseSession session,
    GameMatch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<GameMatch>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [GameMatch]s in the list and returns the resulting rows.
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
  /// The returned [GameMatch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameMatch>> upsert(
    _is.DatabaseSession session,
    List<GameMatch> rows, {
    required _is.ColumnSelections<GameMatchTable> conflictColumns,
    _is.ColumnSelections<GameMatchTable>? updateColumns,
    _is.WhereExpressionBuilder<GameMatchTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<GameMatch>(
      rows,
      conflictColumns: conflictColumns(GameMatch.t),
      updateColumns: updateColumns?.call(GameMatch.t),
      updateWhere: updateWhere?.call(GameMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [GameMatch] and returns the resulting row.
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
  /// The returned [GameMatch] will have its `id` field set.
  Future<GameMatch?> upsertRow(
    _is.DatabaseSession session,
    GameMatch row, {
    required _is.ColumnSelections<GameMatchTable> conflictColumns,
    _is.ColumnSelections<GameMatchTable>? updateColumns,
    _is.WhereExpressionBuilder<GameMatchTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<GameMatch>(
      row,
      conflictColumns: conflictColumns(GameMatch.t),
      updateColumns: updateColumns?.call(GameMatch.t),
      updateWhere: updateWhere?.call(GameMatch.t),
      transaction: transaction,
    );
  }

  /// Updates all [GameMatch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameMatch>> update(
    _is.DatabaseSession session,
    List<GameMatch> rows, {
    _is.ColumnSelections<GameMatchTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<GameMatch>(
      rows,
      columns: columns?.call(GameMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [GameMatch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GameMatch> updateRow(
    _is.DatabaseSession session,
    GameMatch row, {
    _is.ColumnSelections<GameMatchTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<GameMatch>(
      row,
      columns: columns?.call(GameMatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GameMatch] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GameMatch?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GameMatchUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<GameMatch>(
      id,
      columnValues: columnValues(GameMatch.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GameMatch]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GameMatch>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GameMatchUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GameMatchTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<GameMatch>(
      columnValues: columnValues(GameMatch.t.updateTable),
      where: where(GameMatch.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [GameMatch]s in the list and returns the deleted rows.
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
  Future<List<GameMatch>> delete(
    _is.DatabaseSession session,
    List<GameMatch> rows, {
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<GameMatch>(
      rows,
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [GameMatch].
  Future<GameMatch> deleteRow(
    _is.DatabaseSession session,
    GameMatch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GameMatch>(
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
  Future<List<GameMatch>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GameMatchTable> where,
    _is.OrderByBuilder<GameMatchTable>? orderBy,
    _is.OrderByListBuilder<GameMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<GameMatch>(
      where: where(GameMatch.t),
      orderBy: orderBy?.call(GameMatch.t),
      orderByList: orderByList?.call(GameMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GameMatchTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<GameMatch>(
      where: where?.call(GameMatch.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GameMatch] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GameMatchTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GameMatch>(
      where: where(GameMatch.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
