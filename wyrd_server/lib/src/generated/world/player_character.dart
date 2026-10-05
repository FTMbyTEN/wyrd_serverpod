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

/// A player's own character in NAIJA 2099, made in the character creator before they first enter
/// the city: which body, its proportions, skin tone, outfit colour, neon trim and street name.
abstract class PlayerCharacter
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PlayerCharacter._({
    this.id,
    required this.authUserId,
    required this.base,
    int? outfit,
    required this.name,
    required this.height,
    required this.build,
    required this.shoulders,
    required this.hips,
    required this.skin,
    required this.outfitHue,
    required this.neon,
    required this.createdAt,
    required this.updatedAt,
  }) : outfit = outfit ?? 0;

  factory PlayerCharacter({
    int? id,
    required _is.UuidValue authUserId,
    required String base,
    int? outfit,
    required String name,
    required double height,
    required double build,
    required double shoulders,
    required double hips,
    required double skin,
    required double outfitHue,
    required int neon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlayerCharacterImpl;

  factory PlayerCharacter.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerCharacter(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      base: jsonSerialization['base'] as String,
      outfit: jsonSerialization['outfit'] as int?,
      name: jsonSerialization['name'] as String,
      height: (jsonSerialization['height'] as num).toDouble(),
      build: (jsonSerialization['build'] as num).toDouble(),
      shoulders: (jsonSerialization['shoulders'] as num).toDouble(),
      hips: (jsonSerialization['hips'] as num).toDouble(),
      skin: (jsonSerialization['skin'] as num).toDouble(),
      outfitHue: (jsonSerialization['outfitHue'] as num).toDouble(),
      neon: jsonSerialization['neon'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PlayerCharacterTable();

  static const db = PlayerCharacterRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// the base body: 'ten' (a man) or 'ama' (a woman)
  String base;

  /// the outfit from the wardrobe (0 = the body's own)
  int outfit;

  /// the name the city (and WYRD) knows them by
  String name;

  /// proportions, each -1 .. 1 (0 = the base's own)
  double height;

  double build;

  double shoulders;

  double hips;

  /// skin tone -1 (darker) .. 1 (lighter); outfit hue shift in degrees; neon trim colour (0xRRGGBB)
  double skin;

  double outfitHue;

  int neon;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PlayerCharacter]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlayerCharacter copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? base,
    int? outfit,
    String? name,
    double? height,
    double? build,
    double? shoulders,
    double? hips,
    double? skin,
    double? outfitHue,
    int? neon,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerCharacter',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'base': base,
      'outfit': outfit,
      'name': name,
      'height': height,
      'build': build,
      'shoulders': shoulders,
      'hips': hips,
      'skin': skin,
      'outfitHue': outfitHue,
      'neon': neon,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlayerCharacter',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'base': base,
      'outfit': outfit,
      'name': name,
      'height': height,
      'build': build,
      'shoulders': shoulders,
      'hips': hips,
      'skin': skin,
      'outfitHue': outfitHue,
      'neon': neon,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PlayerCharacterInclude include() {
    return PlayerCharacterInclude._();
  }

  static PlayerCharacterIncludeList includeList({
    _is.WhereExpressionBuilder<PlayerCharacterTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    PlayerCharacterInclude? include,
  }) {
    return PlayerCharacterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerCharacterImpl extends PlayerCharacter {
  _PlayerCharacterImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String base,
    int? outfit,
    required String name,
    required double height,
    required double build,
    required double shoulders,
    required double hips,
    required double skin,
    required double outfitHue,
    required int neon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         base: base,
         outfit: outfit,
         name: name,
         height: height,
         build: build,
         shoulders: shoulders,
         hips: hips,
         skin: skin,
         outfitHue: outfitHue,
         neon: neon,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerCharacter]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlayerCharacter copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? base,
    int? outfit,
    String? name,
    double? height,
    double? build,
    double? shoulders,
    double? hips,
    double? skin,
    double? outfitHue,
    int? neon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlayerCharacter(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      base: base ?? this.base,
      outfit: outfit ?? this.outfit,
      name: name ?? this.name,
      height: height ?? this.height,
      build: build ?? this.build,
      shoulders: shoulders ?? this.shoulders,
      hips: hips ?? this.hips,
      skin: skin ?? this.skin,
      outfitHue: outfitHue ?? this.outfitHue,
      neon: neon ?? this.neon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PlayerCharacterUpdateTable extends _is.UpdateTable<PlayerCharacterTable> {
  PlayerCharacterUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> base(String value) => _is.ColumnValue(
    table.base,
    value,
  );

  _is.ColumnValue<int, int> outfit(int value) => _is.ColumnValue(
    table.outfit,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<double, double> height(double value) => _is.ColumnValue(
    table.height,
    value,
  );

  _is.ColumnValue<double, double> build(double value) => _is.ColumnValue(
    table.build,
    value,
  );

  _is.ColumnValue<double, double> shoulders(double value) => _is.ColumnValue(
    table.shoulders,
    value,
  );

  _is.ColumnValue<double, double> hips(double value) => _is.ColumnValue(
    table.hips,
    value,
  );

  _is.ColumnValue<double, double> skin(double value) => _is.ColumnValue(
    table.skin,
    value,
  );

  _is.ColumnValue<double, double> outfitHue(double value) => _is.ColumnValue(
    table.outfitHue,
    value,
  );

  _is.ColumnValue<int, int> neon(int value) => _is.ColumnValue(
    table.neon,
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

class PlayerCharacterTable extends _is.Table<int?> {
  PlayerCharacterTable({super.tableRelation})
    : super(tableName: 'player_character') {
    updateTable = PlayerCharacterUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    base = _is.ColumnString(
      'base',
      this,
    );
    outfit = _is.ColumnInt(
      'outfit',
      this,
      hasDefault: true,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    height = _is.ColumnDouble(
      'height',
      this,
    );
    build = _is.ColumnDouble(
      'build',
      this,
    );
    shoulders = _is.ColumnDouble(
      'shoulders',
      this,
    );
    hips = _is.ColumnDouble(
      'hips',
      this,
    );
    skin = _is.ColumnDouble(
      'skin',
      this,
    );
    outfitHue = _is.ColumnDouble(
      'outfitHue',
      this,
    );
    neon = _is.ColumnInt(
      'neon',
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

  late final PlayerCharacterUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// the base body: 'ten' (a man) or 'ama' (a woman)
  late final _is.ColumnString base;

  /// the outfit from the wardrobe (0 = the body's own)
  late final _is.ColumnInt outfit;

  /// the name the city (and WYRD) knows them by
  late final _is.ColumnString name;

  /// proportions, each -1 .. 1 (0 = the base's own)
  late final _is.ColumnDouble height;

  late final _is.ColumnDouble build;

  late final _is.ColumnDouble shoulders;

  late final _is.ColumnDouble hips;

  /// skin tone -1 (darker) .. 1 (lighter); outfit hue shift in degrees; neon trim colour (0xRRGGBB)
  late final _is.ColumnDouble skin;

  late final _is.ColumnDouble outfitHue;

  late final _is.ColumnInt neon;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    base,
    outfit,
    name,
    height,
    build,
    shoulders,
    hips,
    skin,
    outfitHue,
    neon,
    createdAt,
    updatedAt,
  ];
}

class PlayerCharacterInclude extends _is.IncludeObject {
  PlayerCharacterInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PlayerCharacter.t;
}

class PlayerCharacterIncludeList extends _is.IncludeList {
  PlayerCharacterIncludeList._({
    _is.WhereExpressionBuilder<PlayerCharacterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlayerCharacter.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PlayerCharacter.t;
}

class PlayerCharacterRepository {
  const PlayerCharacterRepository._();

  /// Returns a list of [PlayerCharacter]s matching the given query parameters.
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
  Future<List<PlayerCharacter>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerCharacterTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PlayerCharacter>(
      where: where?.call(PlayerCharacter.t),
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PlayerCharacter] matching the given query parameters.
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
  Future<PlayerCharacter?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerCharacterTable>? where,
    int? offset,
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PlayerCharacter>(
      where: where?.call(PlayerCharacter.t),
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PlayerCharacter] by its [id] or null if no such row exists.
  Future<PlayerCharacter?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PlayerCharacter>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PlayerCharacter]s in the list and returns the inserted rows.
  ///
  /// The returned [PlayerCharacter]s will have their `id` fields set.
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
  Future<List<PlayerCharacter>> insert(
    _is.DatabaseSession session,
    List<PlayerCharacter> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PlayerCharacter>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PlayerCharacter] and returns the inserted row.
  ///
  /// The returned [PlayerCharacter] will have its `id` field set.
  Future<PlayerCharacter> insertRow(
    _is.DatabaseSession session,
    PlayerCharacter row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlayerCharacter>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PlayerCharacter]s in the list and returns the resulting rows.
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
  /// The returned [PlayerCharacter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerCharacter>> upsert(
    _is.DatabaseSession session,
    List<PlayerCharacter> rows, {
    required _is.ColumnSelections<PlayerCharacterTable> conflictColumns,
    _is.ColumnSelections<PlayerCharacterTable>? updateColumns,
    _is.WhereExpressionBuilder<PlayerCharacterTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PlayerCharacter>(
      rows,
      conflictColumns: conflictColumns(PlayerCharacter.t),
      updateColumns: updateColumns?.call(PlayerCharacter.t),
      updateWhere: updateWhere?.call(PlayerCharacter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PlayerCharacter] and returns the resulting row.
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
  /// The returned [PlayerCharacter] will have its `id` field set.
  Future<PlayerCharacter?> upsertRow(
    _is.DatabaseSession session,
    PlayerCharacter row, {
    required _is.ColumnSelections<PlayerCharacterTable> conflictColumns,
    _is.ColumnSelections<PlayerCharacterTable>? updateColumns,
    _is.WhereExpressionBuilder<PlayerCharacterTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PlayerCharacter>(
      row,
      conflictColumns: conflictColumns(PlayerCharacter.t),
      updateColumns: updateColumns?.call(PlayerCharacter.t),
      updateWhere: updateWhere?.call(PlayerCharacter.t),
      transaction: transaction,
    );
  }

  /// Updates all [PlayerCharacter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerCharacter>> update(
    _is.DatabaseSession session,
    List<PlayerCharacter> rows, {
    _is.ColumnSelections<PlayerCharacterTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PlayerCharacter>(
      rows,
      columns: columns?.call(PlayerCharacter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PlayerCharacter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlayerCharacter> updateRow(
    _is.DatabaseSession session,
    PlayerCharacter row, {
    _is.ColumnSelections<PlayerCharacterTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlayerCharacter>(
      row,
      columns: columns?.call(PlayerCharacter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayerCharacter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlayerCharacter?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PlayerCharacterUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PlayerCharacter>(
      id,
      columnValues: columnValues(PlayerCharacter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlayerCharacter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlayerCharacter>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PlayerCharacterUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PlayerCharacterTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PlayerCharacter>(
      columnValues: columnValues(PlayerCharacter.t.updateTable),
      where: where(PlayerCharacter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PlayerCharacter]s in the list and returns the deleted rows.
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
  Future<List<PlayerCharacter>> delete(
    _is.DatabaseSession session,
    List<PlayerCharacter> rows, {
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PlayerCharacter>(
      rows,
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PlayerCharacter].
  Future<PlayerCharacter> deleteRow(
    _is.DatabaseSession session,
    PlayerCharacter row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlayerCharacter>(
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
  Future<List<PlayerCharacter>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlayerCharacterTable> where,
    _is.OrderByBuilder<PlayerCharacterTable>? orderBy,
    _is.OrderByListBuilder<PlayerCharacterTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PlayerCharacter>(
      where: where(PlayerCharacter.t),
      orderBy: orderBy?.call(PlayerCharacter.t),
      orderByList: orderByList?.call(PlayerCharacter.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlayerCharacterTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PlayerCharacter>(
      where: where?.call(PlayerCharacter.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PlayerCharacter] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlayerCharacterTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PlayerCharacter>(
      where: where(PlayerCharacter.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
