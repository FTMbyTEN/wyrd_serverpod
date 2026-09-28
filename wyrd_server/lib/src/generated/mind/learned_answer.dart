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

abstract class LearnedAnswer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LearnedAnswer._({
    this.id,
    this.authUserId,
    required this.question,
    required this.intent,
    required this.topics,
    required this.answer,
    required this.score,
    required this.uses,
    required this.version,
    required this.retired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LearnedAnswer({
    int? id,
    _is.UuidValue? authUserId,
    required String question,
    required String intent,
    required List<String> topics,
    required String answer,
    required double score,
    required int uses,
    required int version,
    required bool retired,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LearnedAnswerImpl;

  factory LearnedAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return LearnedAnswer(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      question: jsonSerialization['question'] as String,
      intent: jsonSerialization['intent'] as String,
      topics: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      answer: jsonSerialization['answer'] as String,
      score: (jsonSerialization['score'] as num).toDouble(),
      uses: jsonSerialization['uses'] as int,
      version: jsonSerialization['version'] as int,
      retired: _is.BoolJsonExtension.fromJson(jsonSerialization['retired']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = LearnedAnswerTable();

  static const db = LearnedAnswerRepository._();

  @override
  int? id;

  _is.UuidValue? authUserId;

  String question;

  String intent;

  List<String> topics;

  String answer;

  double score;

  int uses;

  int version;

  bool retired;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LearnedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LearnedAnswer copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? question,
    String? intent,
    List<String>? topics,
    String? answer,
    double? score,
    int? uses,
    int? version,
    bool? retired,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearnedAnswer',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'question': question,
      'intent': intent,
      'topics': topics.toJson(),
      'answer': answer,
      'score': score,
      'uses': uses,
      'version': version,
      'retired': retired,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LearnedAnswer',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'question': question,
      'intent': intent,
      'topics': topics.toJson(),
      'answer': answer,
      'score': score,
      'uses': uses,
      'version': version,
      'retired': retired,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static LearnedAnswerInclude include() {
    return LearnedAnswerInclude._();
  }

  static LearnedAnswerIncludeList includeList({
    _is.WhereExpressionBuilder<LearnedAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    LearnedAnswerInclude? include,
  }) {
    return LearnedAnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearnedAnswerImpl extends LearnedAnswer {
  _LearnedAnswerImpl({
    int? id,
    _is.UuidValue? authUserId,
    required String question,
    required String intent,
    required List<String> topics,
    required String answer,
    required double score,
    required int uses,
    required int version,
    required bool retired,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         question: question,
         intent: intent,
         topics: topics,
         answer: answer,
         score: score,
         uses: uses,
         version: version,
         retired: retired,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LearnedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LearnedAnswer copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    String? question,
    String? intent,
    List<String>? topics,
    String? answer,
    double? score,
    int? uses,
    int? version,
    bool? retired,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LearnedAnswer(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      question: question ?? this.question,
      intent: intent ?? this.intent,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      answer: answer ?? this.answer,
      score: score ?? this.score,
      uses: uses ?? this.uses,
      version: version ?? this.version,
      retired: retired ?? this.retired,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LearnedAnswerUpdateTable extends _is.UpdateTable<LearnedAnswerTable> {
  LearnedAnswerUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> question(String value) => _is.ColumnValue(
    table.question,
    value,
  );

  _is.ColumnValue<String, String> intent(String value) => _is.ColumnValue(
    table.intent,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> topics(List<String> value) =>
      _is.ColumnValue(
        table.topics,
        value,
      );

  _is.ColumnValue<String, String> answer(String value) => _is.ColumnValue(
    table.answer,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<int, int> uses(int value) => _is.ColumnValue(
    table.uses,
    value,
  );

  _is.ColumnValue<int, int> version(int value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<bool, bool> retired(bool value) => _is.ColumnValue(
    table.retired,
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

class LearnedAnswerTable extends _is.Table<int?> {
  LearnedAnswerTable({super.tableRelation})
    : super(tableName: 'learned_answer') {
    updateTable = LearnedAnswerUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    question = _is.ColumnString(
      'question',
      this,
    );
    intent = _is.ColumnString(
      'intent',
      this,
    );
    topics = _is.ColumnSerializable<List<String>>(
      'topics',
      this,
    );
    answer = _is.ColumnString(
      'answer',
      this,
    );
    score = _is.ColumnDouble(
      'score',
      this,
    );
    uses = _is.ColumnInt(
      'uses',
      this,
    );
    version = _is.ColumnInt(
      'version',
      this,
    );
    retired = _is.ColumnBool(
      'retired',
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

  late final LearnedAnswerUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString question;

  late final _is.ColumnString intent;

  late final _is.ColumnSerializable<List<String>> topics;

  late final _is.ColumnString answer;

  late final _is.ColumnDouble score;

  late final _is.ColumnInt uses;

  late final _is.ColumnInt version;

  late final _is.ColumnBool retired;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    question,
    intent,
    topics,
    answer,
    score,
    uses,
    version,
    retired,
    createdAt,
    updatedAt,
  ];
}

class LearnedAnswerInclude extends _is.IncludeObject {
  LearnedAnswerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LearnedAnswer.t;
}

class LearnedAnswerIncludeList extends _is.IncludeList {
  LearnedAnswerIncludeList._({
    _is.WhereExpressionBuilder<LearnedAnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LearnedAnswer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LearnedAnswer.t;
}

class LearnedAnswerRepository {
  const LearnedAnswerRepository._();

  /// Returns a list of [LearnedAnswer]s matching the given query parameters.
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
  Future<List<LearnedAnswer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnedAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LearnedAnswer>(
      where: where?.call(LearnedAnswer.t),
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LearnedAnswer] matching the given query parameters.
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
  Future<LearnedAnswer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnedAnswerTable>? where,
    int? offset,
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LearnedAnswer>(
      where: where?.call(LearnedAnswer.t),
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LearnedAnswer] by its [id] or null if no such row exists.
  Future<LearnedAnswer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LearnedAnswer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LearnedAnswer]s in the list and returns the inserted rows.
  ///
  /// The returned [LearnedAnswer]s will have their `id` fields set.
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
  Future<List<LearnedAnswer>> insert(
    _is.DatabaseSession session,
    List<LearnedAnswer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LearnedAnswer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LearnedAnswer] and returns the inserted row.
  ///
  /// The returned [LearnedAnswer] will have its `id` field set.
  Future<LearnedAnswer> insertRow(
    _is.DatabaseSession session,
    LearnedAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LearnedAnswer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LearnedAnswer]s in the list and returns the resulting rows.
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
  /// The returned [LearnedAnswer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LearnedAnswer>> upsert(
    _is.DatabaseSession session,
    List<LearnedAnswer> rows, {
    required _is.ColumnSelections<LearnedAnswerTable> conflictColumns,
    _is.ColumnSelections<LearnedAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<LearnedAnswerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LearnedAnswer>(
      rows,
      conflictColumns: conflictColumns(LearnedAnswer.t),
      updateColumns: updateColumns?.call(LearnedAnswer.t),
      updateWhere: updateWhere?.call(LearnedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LearnedAnswer] and returns the resulting row.
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
  /// The returned [LearnedAnswer] will have its `id` field set.
  Future<LearnedAnswer?> upsertRow(
    _is.DatabaseSession session,
    LearnedAnswer row, {
    required _is.ColumnSelections<LearnedAnswerTable> conflictColumns,
    _is.ColumnSelections<LearnedAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<LearnedAnswerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LearnedAnswer>(
      row,
      conflictColumns: conflictColumns(LearnedAnswer.t),
      updateColumns: updateColumns?.call(LearnedAnswer.t),
      updateWhere: updateWhere?.call(LearnedAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates all [LearnedAnswer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LearnedAnswer>> update(
    _is.DatabaseSession session,
    List<LearnedAnswer> rows, {
    _is.ColumnSelections<LearnedAnswerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LearnedAnswer>(
      rows,
      columns: columns?.call(LearnedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LearnedAnswer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LearnedAnswer> updateRow(
    _is.DatabaseSession session,
    LearnedAnswer row, {
    _is.ColumnSelections<LearnedAnswerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LearnedAnswer>(
      row,
      columns: columns?.call(LearnedAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LearnedAnswer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LearnedAnswer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LearnedAnswerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LearnedAnswer>(
      id,
      columnValues: columnValues(LearnedAnswer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LearnedAnswer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LearnedAnswer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LearnedAnswerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LearnedAnswerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LearnedAnswer>(
      columnValues: columnValues(LearnedAnswer.t.updateTable),
      where: where(LearnedAnswer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LearnedAnswer]s in the list and returns the deleted rows.
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
  Future<List<LearnedAnswer>> delete(
    _is.DatabaseSession session,
    List<LearnedAnswer> rows, {
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LearnedAnswer>(
      rows,
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LearnedAnswer].
  Future<LearnedAnswer> deleteRow(
    _is.DatabaseSession session,
    LearnedAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LearnedAnswer>(
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
  Future<List<LearnedAnswer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LearnedAnswerTable> where,
    _is.OrderByBuilder<LearnedAnswerTable>? orderBy,
    _is.OrderByListBuilder<LearnedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LearnedAnswer>(
      where: where(LearnedAnswer.t),
      orderBy: orderBy?.call(LearnedAnswer.t),
      orderByList: orderByList?.call(LearnedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnedAnswerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LearnedAnswer>(
      where: where?.call(LearnedAnswer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LearnedAnswer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LearnedAnswerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LearnedAnswer>(
      where: where(LearnedAnswer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
