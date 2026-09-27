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

abstract class WordSense
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WordSense._({
    this.id,
    required this.lemma,
    required this.pos,
    required this.rank,
    required this.tagCount,
    required this.definition,
    this.example,
    required this.synonyms,
    this.hypernym,
  });

  factory WordSense({
    int? id,
    required String lemma,
    required String pos,
    required int rank,
    required int tagCount,
    required String definition,
    String? example,
    required List<String> synonyms,
    String? hypernym,
  }) = _WordSenseImpl;

  factory WordSense.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordSense(
      id: jsonSerialization['id'] as int?,
      lemma: jsonSerialization['lemma'] as String,
      pos: jsonSerialization['pos'] as String,
      rank: jsonSerialization['rank'] as int,
      tagCount: jsonSerialization['tagCount'] as int,
      definition: jsonSerialization['definition'] as String,
      example: jsonSerialization['example'] as String?,
      synonyms: _i9sln91s.Protocol().deserialize<List<String>>(
        jsonSerialization['synonyms'],
      ),
      hypernym: jsonSerialization['hypernym'] as String?,
    );
  }

  static final t = WordSenseTable();

  static const db = WordSenseRepository._();

  @override
  int? id;

  String lemma;

  String pos;

  int rank;

  int tagCount;

  String definition;

  String? example;

  List<String> synonyms;

  String? hypernym;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WordSense]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WordSense copyWith({
    int? id,
    String? lemma,
    String? pos,
    int? rank,
    int? tagCount,
    String? definition,
    String? example,
    List<String>? synonyms,
    String? hypernym,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordSense',
      if (id != null) 'id': id,
      'lemma': lemma,
      'pos': pos,
      'rank': rank,
      'tagCount': tagCount,
      'definition': definition,
      if (example != null) 'example': example,
      'synonyms': synonyms.toJson(),
      if (hypernym != null) 'hypernym': hypernym,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordSense',
      if (id != null) 'id': id,
      'lemma': lemma,
      'pos': pos,
      'rank': rank,
      'tagCount': tagCount,
      'definition': definition,
      if (example != null) 'example': example,
      'synonyms': synonyms.toJson(),
      if (hypernym != null) 'hypernym': hypernym,
    };
  }

  static WordSenseInclude include() {
    return WordSenseInclude._();
  }

  static WordSenseIncludeList includeList({
    _is.WhereExpressionBuilder<WordSenseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    WordSenseInclude? include,
  }) {
    return WordSenseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WordSenseImpl extends WordSense {
  _WordSenseImpl({
    int? id,
    required String lemma,
    required String pos,
    required int rank,
    required int tagCount,
    required String definition,
    String? example,
    required List<String> synonyms,
    String? hypernym,
  }) : super._(
         id: id,
         lemma: lemma,
         pos: pos,
         rank: rank,
         tagCount: tagCount,
         definition: definition,
         example: example,
         synonyms: synonyms,
         hypernym: hypernym,
       );

  /// Returns a shallow copy of this [WordSense]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WordSense copyWith({
    Object? id = _Undefined,
    String? lemma,
    String? pos,
    int? rank,
    int? tagCount,
    String? definition,
    Object? example = _Undefined,
    List<String>? synonyms,
    Object? hypernym = _Undefined,
  }) {
    return WordSense(
      id: id is int? ? id : this.id,
      lemma: lemma ?? this.lemma,
      pos: pos ?? this.pos,
      rank: rank ?? this.rank,
      tagCount: tagCount ?? this.tagCount,
      definition: definition ?? this.definition,
      example: example is String? ? example : this.example,
      synonyms: synonyms ?? this.synonyms.map((e0) => e0).toList(),
      hypernym: hypernym is String? ? hypernym : this.hypernym,
    );
  }
}

class WordSenseUpdateTable extends _is.UpdateTable<WordSenseTable> {
  WordSenseUpdateTable(super.table);

  _is.ColumnValue<String, String> lemma(String value) => _is.ColumnValue(
    table.lemma,
    value,
  );

  _is.ColumnValue<String, String> pos(String value) => _is.ColumnValue(
    table.pos,
    value,
  );

  _is.ColumnValue<int, int> rank(int value) => _is.ColumnValue(
    table.rank,
    value,
  );

  _is.ColumnValue<int, int> tagCount(int value) => _is.ColumnValue(
    table.tagCount,
    value,
  );

  _is.ColumnValue<String, String> definition(String value) => _is.ColumnValue(
    table.definition,
    value,
  );

  _is.ColumnValue<String, String> example(String? value) => _is.ColumnValue(
    table.example,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> synonyms(List<String> value) =>
      _is.ColumnValue(
        table.synonyms,
        value,
      );

  _is.ColumnValue<String, String> hypernym(String? value) => _is.ColumnValue(
    table.hypernym,
    value,
  );
}

class WordSenseTable extends _is.Table<int?> {
  WordSenseTable({super.tableRelation}) : super(tableName: 'word_sense') {
    updateTable = WordSenseUpdateTable(this);
    lemma = _is.ColumnString(
      'lemma',
      this,
    );
    pos = _is.ColumnString(
      'pos',
      this,
    );
    rank = _is.ColumnInt(
      'rank',
      this,
    );
    tagCount = _is.ColumnInt(
      'tagCount',
      this,
    );
    definition = _is.ColumnString(
      'definition',
      this,
    );
    example = _is.ColumnString(
      'example',
      this,
    );
    synonyms = _is.ColumnSerializable<List<String>>(
      'synonyms',
      this,
    );
    hypernym = _is.ColumnString(
      'hypernym',
      this,
    );
  }

  late final WordSenseUpdateTable updateTable;

  late final _is.ColumnString lemma;

  late final _is.ColumnString pos;

  late final _is.ColumnInt rank;

  late final _is.ColumnInt tagCount;

  late final _is.ColumnString definition;

  late final _is.ColumnString example;

  late final _is.ColumnSerializable<List<String>> synonyms;

  late final _is.ColumnString hypernym;

  @override
  List<_is.Column> get columns => [
    id,
    lemma,
    pos,
    rank,
    tagCount,
    definition,
    example,
    synonyms,
    hypernym,
  ];
}

class WordSenseInclude extends _is.IncludeObject {
  WordSenseInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WordSense.t;
}

class WordSenseIncludeList extends _is.IncludeList {
  WordSenseIncludeList._({
    _is.WhereExpressionBuilder<WordSenseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WordSense.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WordSense.t;
}

class WordSenseRepository {
  const WordSenseRepository._();

  /// Returns a list of [WordSense]s matching the given query parameters.
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
  Future<List<WordSense>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WordSenseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WordSense>(
      where: where?.call(WordSense.t),
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WordSense] matching the given query parameters.
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
  Future<WordSense?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WordSenseTable>? where,
    int? offset,
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WordSense>(
      where: where?.call(WordSense.t),
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WordSense] by its [id] or null if no such row exists.
  Future<WordSense?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WordSense>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WordSense]s in the list and returns the inserted rows.
  ///
  /// The returned [WordSense]s will have their `id` fields set.
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
  Future<List<WordSense>> insert(
    _is.DatabaseSession session,
    List<WordSense> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WordSense>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WordSense] and returns the inserted row.
  ///
  /// The returned [WordSense] will have its `id` field set.
  Future<WordSense> insertRow(
    _is.DatabaseSession session,
    WordSense row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WordSense>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [WordSense]s in the list and returns the resulting rows.
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
  /// The returned [WordSense]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WordSense>> upsert(
    _is.DatabaseSession session,
    List<WordSense> rows, {
    required _is.ColumnSelections<WordSenseTable> conflictColumns,
    _is.ColumnSelections<WordSenseTable>? updateColumns,
    _is.WhereExpressionBuilder<WordSenseTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WordSense>(
      rows,
      conflictColumns: conflictColumns(WordSense.t),
      updateColumns: updateColumns?.call(WordSense.t),
      updateWhere: updateWhere?.call(WordSense.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WordSense] and returns the resulting row.
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
  /// The returned [WordSense] will have its `id` field set.
  Future<WordSense?> upsertRow(
    _is.DatabaseSession session,
    WordSense row, {
    required _is.ColumnSelections<WordSenseTable> conflictColumns,
    _is.ColumnSelections<WordSenseTable>? updateColumns,
    _is.WhereExpressionBuilder<WordSenseTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WordSense>(
      row,
      conflictColumns: conflictColumns(WordSense.t),
      updateColumns: updateColumns?.call(WordSense.t),
      updateWhere: updateWhere?.call(WordSense.t),
      transaction: transaction,
    );
  }

  /// Updates all [WordSense]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WordSense>> update(
    _is.DatabaseSession session,
    List<WordSense> rows, {
    _is.ColumnSelections<WordSenseTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WordSense>(
      rows,
      columns: columns?.call(WordSense.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WordSense]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WordSense> updateRow(
    _is.DatabaseSession session,
    WordSense row, {
    _is.ColumnSelections<WordSenseTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WordSense>(
      row,
      columns: columns?.call(WordSense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WordSense] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WordSense?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WordSenseUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WordSense>(
      id,
      columnValues: columnValues(WordSense.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WordSense]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WordSense>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WordSenseUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WordSenseTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WordSense>(
      columnValues: columnValues(WordSense.t.updateTable),
      where: where(WordSense.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WordSense]s in the list and returns the deleted rows.
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
  Future<List<WordSense>> delete(
    _is.DatabaseSession session,
    List<WordSense> rows, {
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WordSense>(
      rows,
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WordSense].
  Future<WordSense> deleteRow(
    _is.DatabaseSession session,
    WordSense row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WordSense>(
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
  Future<List<WordSense>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WordSenseTable> where,
    _is.OrderByBuilder<WordSenseTable>? orderBy,
    _is.OrderByListBuilder<WordSenseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WordSense>(
      where: where(WordSense.t),
      orderBy: orderBy?.call(WordSense.t),
      orderByList: orderByList?.call(WordSense.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WordSenseTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WordSense>(
      where: where?.call(WordSense.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WordSense] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WordSenseTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WordSense>(
      where: where(WordSense.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
