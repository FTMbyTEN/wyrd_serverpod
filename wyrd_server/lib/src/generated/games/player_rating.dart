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

/// A player's rating in one game (Elo, starting at 1000), and their record against WYRD.
abstract class PlayerRating
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PlayerRating._({
    this.id,
    required this.authUserId,
    required this.game,
    required this.name,
    required this.rating,
    required this.played,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.updatedAt,
  });

  factory PlayerRating({
    int? id,
    required _is.UuidValue authUserId,
    required String game,
    required String name,
    required double rating,
    required int played,
    required int wins,
    required int losses,
    required int draws,
    required DateTime updatedAt,
  }) = _PlayerRatingImpl;

  factory PlayerRating.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerRating(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      game: jsonSerialization['game'] as String,
      name: jsonSerialization['name'] as String,
      rating: (jsonSerialization['rating'] as num).toDouble(),
      played: jsonSerialization['played'] as int,
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
      draws: jsonSerialization['draws'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PlayerRatingTable();

  static const db = PlayerRatingRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String game;

  String name;

  double rating;

  int played;

  int wins;

  int losses;

  int draws;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlayerRating copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? game,
    String? name,
    double? rating,
    int? played,
    int? wins,
    int? losses,
    int? draws,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerRating',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'name': name,
      'rating': rating,
      'played': played,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlayerRating',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'name': name,
      'rating': rating,
      'played': played,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PlayerRatingInclude include() {
    return PlayerRatingInclude._();
  }

  static PlayerRatingIncludeList includeList({
    _is.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    PlayerRatingInclude? include,
  }) {
    return PlayerRatingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerRatingImpl extends PlayerRating {
  _PlayerRatingImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String game,
    required String name,
    required double rating,
    required int played,
    required int wins,
    required int losses,
    required int draws,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         game: game,
         name: name,
         rating: rating,
         played: played,
         wins: wins,
         losses: losses,
         draws: draws,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerRating]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlayerRating copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? game,
    String? name,
    double? rating,
    int? played,
    int? wins,
    int? losses,
    int? draws,
    DateTime? updatedAt,
  }) {
    return PlayerRating(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      game: game ?? this.game,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      played: played ?? this.played,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PlayerRatingUpdateTable extends _is.UpdateTable<PlayerRatingTable> {
  PlayerRatingUpdateTable(super.table);

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

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<double, double> rating(double value) => _is.ColumnValue(
    table.rating,
    value,
  );

  _is.ColumnValue<int, int> played(int value) => _is.ColumnValue(
    table.played,
    value,
  );

  _is.ColumnValue<int, int> wins(int value) => _is.ColumnValue(
    table.wins,
    value,
  );

  _is.ColumnValue<int, int> losses(int value) => _is.ColumnValue(
    table.losses,
    value,
  );

  _is.ColumnValue<int, int> draws(int value) => _is.ColumnValue(
    table.draws,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PlayerRatingTable extends _is.Table<int?> {
  PlayerRatingTable({super.tableRelation}) : super(tableName: 'player_rating') {
    updateTable = PlayerRatingUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    game = _is.ColumnString(
      'game',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    rating = _is.ColumnDouble(
      'rating',
      this,
    );
    played = _is.ColumnInt(
      'played',
      this,
    );
    wins = _is.ColumnInt(
      'wins',
      this,
    );
    losses = _is.ColumnInt(
      'losses',
      this,
    );
    draws = _is.ColumnInt(
      'draws',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final PlayerRatingUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString game;

  late final _is.ColumnString name;

  late final _is.ColumnDouble rating;

  late final _is.ColumnInt played;

  late final _is.ColumnInt wins;

  late final _is.ColumnInt losses;

  late final _is.ColumnInt draws;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    game,
    name,
    rating,
    played,
    wins,
    losses,
    draws,
    updatedAt,
  ];
}

class PlayerRatingInclude extends _is.IncludeObject {
  PlayerRatingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PlayerRating.t;
}

class PlayerRatingIncludeList extends _is.IncludeList {
  PlayerRatingIncludeList._({
    _is.WhereExpressionBuilder<PlayerRatingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlayerRating.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PlayerRating.t;
}

class PlayerRatingRepository {
  const PlayerRatingRepository._();

  /// Returns a list of [PlayerRating]s matching the given query parameters.
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
  Future<List<PlayerRating>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PlayerRating>(
      where: where?.call(PlayerRating.t),
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PlayerRating] matching the given query parameters.
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
  Future<PlayerRating?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? offset,
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PlayerRating>(
      where: where?.call(PlayerRating.t),
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PlayerRating] by its [id] or null if no such row exists.
  Future<PlayerRating?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PlayerRating>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PlayerRating]s in the list and returns the inserted rows.
  ///
  /// The returned [PlayerRating]s will have their `id` fields set.
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
  Future<List<PlayerRating>> insert(
    _is.DatabaseSession session,
    List<PlayerRating> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PlayerRating>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PlayerRating] and returns the inserted row.
  ///
  /// The returned [PlayerRating] will have its `id` field set.
  Future<PlayerRating> insertRow(
    _is.DatabaseSession session,
    PlayerRating row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlayerRating>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PlayerRating]s in the list and returns the resulting rows.
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
  /// The returned [PlayerRating]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerRating>> upsert(
    _is.DatabaseSession session,
    List<PlayerRating> rows, {
    required _is.ColumnSelections<PlayerRatingTable> conflictColumns,
    _is.ColumnSelections<PlayerRatingTable>? updateColumns,
    _is.WhereExpressionBuilder<PlayerRatingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PlayerRating>(
      rows,
      conflictColumns: conflictColumns(PlayerRating.t),
      updateColumns: updateColumns?.call(PlayerRating.t),
      updateWhere: updateWhere?.call(PlayerRating.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PlayerRating] and returns the resulting row.
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
  /// The returned [PlayerRating] will have its `id` field set.
  Future<PlayerRating?> upsertRow(
    _is.DatabaseSession session,
    PlayerRating row, {
    required _is.ColumnSelections<PlayerRatingTable> conflictColumns,
    _is.ColumnSelections<PlayerRatingTable>? updateColumns,
    _is.WhereExpressionBuilder<PlayerRatingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PlayerRating>(
      row,
      conflictColumns: conflictColumns(PlayerRating.t),
      updateColumns: updateColumns?.call(PlayerRating.t),
      updateWhere: updateWhere?.call(PlayerRating.t),
      transaction: transaction,
    );
  }

  /// Updates all [PlayerRating]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerRating>> update(
    _is.DatabaseSession session,
    List<PlayerRating> rows, {
    _is.ColumnSelections<PlayerRatingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PlayerRating>(
      rows,
      columns: columns?.call(PlayerRating.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PlayerRating]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlayerRating> updateRow(
    _is.DatabaseSession session,
    PlayerRating row, {
    _is.ColumnSelections<PlayerRatingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlayerRating>(
      row,
      columns: columns?.call(PlayerRating.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayerRating] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlayerRating?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PlayerRatingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PlayerRating>(
      id,
      columnValues: columnValues(PlayerRating.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlayerRating]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerRating>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PlayerRatingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PlayerRatingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PlayerRating>(
      columnValues: columnValues(PlayerRating.t.updateTable),
      where: where(PlayerRating.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PlayerRating]s in the list and returns the deleted rows.
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
  Future<List<PlayerRating>> delete(
    _is.DatabaseSession session,
    List<PlayerRating> rows, {
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PlayerRating>(
      rows,
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PlayerRating].
  Future<PlayerRating> deleteRow(
    _is.DatabaseSession session,
    PlayerRating row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlayerRating>(
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
  Future<List<PlayerRating>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlayerRatingTable> where,
    _is.OrderByBuilder<PlayerRatingTable>? orderBy,
    _is.OrderByListBuilder<PlayerRatingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PlayerRating>(
      where: where(PlayerRating.t),
      orderBy: orderBy?.call(PlayerRating.t),
      orderByList: orderByList?.call(PlayerRating.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerRatingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PlayerRating>(
      where: where?.call(PlayerRating.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PlayerRating] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlayerRatingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PlayerRating>(
      where: where(PlayerRating.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
