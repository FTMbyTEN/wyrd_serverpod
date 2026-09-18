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
import '../mind/digest_info.dart' as _iegfx6l9;

abstract class Mind implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Mind._({
    this.id,
    required this.mood,
    this.focusTopic,
    this.activeGoal,
    required this.curiosity,
    required this.confidence,
    required this.digest,
    this.lastEvent,
    required this.explorationCount,
    required this.updatedAt,
    required this.seenTopics,
    required this.resolvedTopics,
    required this.selfAnswerTimestamps,
  });

  factory Mind({
    int? id,
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    required int explorationCount,
    required DateTime updatedAt,
    required List<String> seenTopics,
    required List<String> resolvedTopics,
    required List<int> selfAnswerTimestamps,
  }) = _MindImpl;

  factory Mind.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mind(
      id: jsonSerialization['id'] as int?,
      mood: jsonSerialization['mood'] as String,
      focusTopic: jsonSerialization['focusTopic'] as String?,
      activeGoal: jsonSerialization['activeGoal'] as String?,
      curiosity: (jsonSerialization['curiosity'] as num).toDouble(),
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      digest: _i9sln91s.Protocol().deserialize<_iegfx6l9.DigestInfo>(
        jsonSerialization['digest'],
      ),
      lastEvent: jsonSerialization['lastEvent'] as String?,
      explorationCount: jsonSerialization['explorationCount'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      seenTopics: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['seenTopics'],
      ),
      resolvedTopics: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['resolvedTopics'],
      ),
      selfAnswerTimestamps: _i9sln91s.Protocol().deserialize<List<int>>(
        jsonSerialization['selfAnswerTimestamps'],
      ),
    );
  }

  static final t = MindTable();

  static const db = MindRepository._();

  @override
  int? id;

  String mood;

  String? focusTopic;

  String? activeGoal;

  double curiosity;

  double confidence;

  _iegfx6l9.DigestInfo digest;

  String? lastEvent;

  int explorationCount;

  DateTime updatedAt;

  List<String> seenTopics;

  List<String> resolvedTopics;

  List<int> selfAnswerTimestamps;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Mind copyWith({
    int? id,
    String? mood,
    String? focusTopic,
    String? activeGoal,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    String? lastEvent,
    int? explorationCount,
    DateTime? updatedAt,
    List<String>? seenTopics,
    List<String>? resolvedTopics,
    List<int>? selfAnswerTimestamps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mind',
      if (id != null) 'id': id,
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJson(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
      'seenTopics': seenTopics.toJson(),
      'resolvedTopics': resolvedTopics.toJson(),
      'selfAnswerTimestamps': selfAnswerTimestamps.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mind',
      if (id != null) 'id': id,
      'mood': mood,
      if (focusTopic != null) 'focusTopic': focusTopic,
      if (activeGoal != null) 'activeGoal': activeGoal,
      'curiosity': curiosity,
      'confidence': confidence,
      'digest': digest.toJsonForProtocol(),
      if (lastEvent != null) 'lastEvent': lastEvent,
      'explorationCount': explorationCount,
      'updatedAt': updatedAt.toJson(),
      'seenTopics': seenTopics.toJson(),
      'resolvedTopics': resolvedTopics.toJson(),
      'selfAnswerTimestamps': selfAnswerTimestamps.toJson(),
    };
  }

  static MindInclude include() {
    return MindInclude._();
  }

  static MindIncludeList includeList({
    _is.WhereExpressionBuilder<MindTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    MindInclude? include,
  }) {
    return MindIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MindImpl extends Mind {
  _MindImpl({
    int? id,
    required String mood,
    String? focusTopic,
    String? activeGoal,
    required double curiosity,
    required double confidence,
    required _iegfx6l9.DigestInfo digest,
    String? lastEvent,
    required int explorationCount,
    required DateTime updatedAt,
    required List<String> seenTopics,
    required List<String> resolvedTopics,
    required List<int> selfAnswerTimestamps,
  }) : super._(
         id: id,
         mood: mood,
         focusTopic: focusTopic,
         activeGoal: activeGoal,
         curiosity: curiosity,
         confidence: confidence,
         digest: digest,
         lastEvent: lastEvent,
         explorationCount: explorationCount,
         updatedAt: updatedAt,
         seenTopics: seenTopics,
         resolvedTopics: resolvedTopics,
         selfAnswerTimestamps: selfAnswerTimestamps,
       );

  /// Returns a shallow copy of this [Mind]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Mind copyWith({
    Object? id = _Undefined,
    String? mood,
    Object? focusTopic = _Undefined,
    Object? activeGoal = _Undefined,
    double? curiosity,
    double? confidence,
    _iegfx6l9.DigestInfo? digest,
    Object? lastEvent = _Undefined,
    int? explorationCount,
    DateTime? updatedAt,
    List<String>? seenTopics,
    List<String>? resolvedTopics,
    List<int>? selfAnswerTimestamps,
  }) {
    return Mind(
      id: id is int? ? id : this.id,
      mood: mood ?? this.mood,
      focusTopic: focusTopic is String? ? focusTopic : this.focusTopic,
      activeGoal: activeGoal is String? ? activeGoal : this.activeGoal,
      curiosity: curiosity ?? this.curiosity,
      confidence: confidence ?? this.confidence,
      digest: digest ?? this.digest.copyWith(),
      lastEvent: lastEvent is String? ? lastEvent : this.lastEvent,
      explorationCount: explorationCount ?? this.explorationCount,
      updatedAt: updatedAt ?? this.updatedAt,
      seenTopics: seenTopics ?? this.seenTopics.map((e0) => e0).toList(),
      resolvedTopics:
          resolvedTopics ?? this.resolvedTopics.map((e0) => e0).toList(),
      selfAnswerTimestamps:
          selfAnswerTimestamps ??
          this.selfAnswerTimestamps.map((e0) => e0).toList(),
    );
  }
}

class MindUpdateTable extends _is.UpdateTable<MindTable> {
  MindUpdateTable(super.table);

  _is.ColumnValue<String, String> mood(String value) => _is.ColumnValue(
    table.mood,
    value,
  );

  _is.ColumnValue<String, String> focusTopic(String? value) => _is.ColumnValue(
    table.focusTopic,
    value,
  );

  _is.ColumnValue<String, String> activeGoal(String? value) => _is.ColumnValue(
    table.activeGoal,
    value,
  );

  _is.ColumnValue<double, double> curiosity(double value) => _is.ColumnValue(
    table.curiosity,
    value,
  );

  _is.ColumnValue<double, double> confidence(double value) => _is.ColumnValue(
    table.confidence,
    value,
  );

  _is.ColumnValue<_iegfx6l9.DigestInfo, _iegfx6l9.DigestInfo> digest(
    _iegfx6l9.DigestInfo value,
  ) => _is.ColumnValue(
    table.digest,
    value,
  );

  _is.ColumnValue<String, String> lastEvent(String? value) => _is.ColumnValue(
    table.lastEvent,
    value,
  );

  _is.ColumnValue<int, int> explorationCount(int value) => _is.ColumnValue(
    table.explorationCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> seenTopics(List<String> value) =>
      _is.ColumnValue(
        table.seenTopics,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> resolvedTopics(
    List<String> value,
  ) => _is.ColumnValue(
    table.resolvedTopics,
    value,
  );

  _is.ColumnValue<List<int>, List<int>> selfAnswerTimestamps(List<int> value) =>
      _is.ColumnValue(
        table.selfAnswerTimestamps,
        value,
      );
}

class MindTable extends _is.Table<int?> {
  MindTable({super.tableRelation}) : super(tableName: 'mind') {
    updateTable = MindUpdateTable(this);
    mood = _is.ColumnString(
      'mood',
      this,
    );
    focusTopic = _is.ColumnString(
      'focusTopic',
      this,
    );
    activeGoal = _is.ColumnString(
      'activeGoal',
      this,
    );
    curiosity = _is.ColumnDouble(
      'curiosity',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    digest = _is.ColumnSerializable<_iegfx6l9.DigestInfo>(
      'digest',
      this,
    );
    lastEvent = _is.ColumnString(
      'lastEvent',
      this,
    );
    explorationCount = _is.ColumnInt(
      'explorationCount',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
    seenTopics = _is.ColumnSerializable<List<String>>(
      'seenTopics',
      this,
    );
    resolvedTopics = _is.ColumnSerializable<List<String>>(
      'resolvedTopics',
      this,
    );
    selfAnswerTimestamps = _is.ColumnSerializable<List<int>>(
      'selfAnswerTimestamps',
      this,
    );
  }

  late final MindUpdateTable updateTable;

  late final _is.ColumnString mood;

  late final _is.ColumnString focusTopic;

  late final _is.ColumnString activeGoal;

  late final _is.ColumnDouble curiosity;

  late final _is.ColumnDouble confidence;

  late final _is.ColumnSerializable<_iegfx6l9.DigestInfo> digest;

  late final _is.ColumnString lastEvent;

  late final _is.ColumnInt explorationCount;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnSerializable<List<String>> seenTopics;

  late final _is.ColumnSerializable<List<String>> resolvedTopics;

  late final _is.ColumnSerializable<List<int>> selfAnswerTimestamps;

  @override
  List<_is.Column> get columns => [
    id,
    mood,
    focusTopic,
    activeGoal,
    curiosity,
    confidence,
    digest,
    lastEvent,
    explorationCount,
    updatedAt,
    seenTopics,
    resolvedTopics,
    selfAnswerTimestamps,
  ];
}

class MindInclude extends _is.IncludeObject {
  MindInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Mind.t;
}

class MindIncludeList extends _is.IncludeList {
  MindIncludeList._({
    _is.WhereExpressionBuilder<MindTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mind.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Mind.t;
}

class MindRepository {
  const MindRepository._();

  /// Returns a list of [Mind]s matching the given query parameters.
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
  Future<List<Mind>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MindTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mind>(
      where: where?.call(Mind.t),
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mind] matching the given query parameters.
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
  Future<Mind?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MindTable>? where,
    int? offset,
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mind>(
      where: where?.call(Mind.t),
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mind] by its [id] or null if no such row exists.
  Future<Mind?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mind>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mind]s in the list and returns the inserted rows.
  ///
  /// The returned [Mind]s will have their `id` fields set.
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
  Future<List<Mind>> insert(
    _is.DatabaseSession session,
    List<Mind> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Mind>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Mind] and returns the inserted row.
  ///
  /// The returned [Mind] will have its `id` field set.
  Future<Mind> insertRow(
    _is.DatabaseSession session,
    Mind row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mind>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Mind]s in the list and returns the resulting rows.
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
  /// The returned [Mind]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mind>> upsert(
    _is.DatabaseSession session,
    List<Mind> rows, {
    required _is.ColumnSelections<MindTable> conflictColumns,
    _is.ColumnSelections<MindTable>? updateColumns,
    _is.WhereExpressionBuilder<MindTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Mind>(
      rows,
      conflictColumns: conflictColumns(Mind.t),
      updateColumns: updateColumns?.call(Mind.t),
      updateWhere: updateWhere?.call(Mind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Mind] and returns the resulting row.
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
  /// The returned [Mind] will have its `id` field set.
  Future<Mind?> upsertRow(
    _is.DatabaseSession session,
    Mind row, {
    required _is.ColumnSelections<MindTable> conflictColumns,
    _is.ColumnSelections<MindTable>? updateColumns,
    _is.WhereExpressionBuilder<MindTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Mind>(
      row,
      conflictColumns: conflictColumns(Mind.t),
      updateColumns: updateColumns?.call(Mind.t),
      updateWhere: updateWhere?.call(Mind.t),
      transaction: transaction,
    );
  }

  /// Updates all [Mind]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mind>> update(
    _is.DatabaseSession session,
    List<Mind> rows, {
    _is.ColumnSelections<MindTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Mind>(
      rows,
      columns: columns?.call(Mind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Mind]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mind> updateRow(
    _is.DatabaseSession session,
    Mind row, {
    _is.ColumnSelections<MindTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mind>(
      row,
      columns: columns?.call(Mind.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mind] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mind?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MindUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Mind>(
      id,
      columnValues: columnValues(Mind.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mind]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mind>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MindUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MindTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Mind>(
      columnValues: columnValues(Mind.t.updateTable),
      where: where(Mind.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Mind]s in the list and returns the deleted rows.
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
  Future<List<Mind>> delete(
    _is.DatabaseSession session,
    List<Mind> rows, {
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Mind>(
      rows,
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Mind].
  Future<Mind> deleteRow(
    _is.DatabaseSession session,
    Mind row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mind>(
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
  Future<List<Mind>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MindTable> where,
    _is.OrderByBuilder<MindTable>? orderBy,
    _is.OrderByListBuilder<MindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Mind>(
      where: where(Mind.t),
      orderBy: orderBy?.call(Mind.t),
      orderByList: orderByList?.call(Mind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MindTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Mind>(
      where: where?.call(Mind.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mind] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MindTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mind>(
      where: where(Mind.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
