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

abstract class LexiconEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LexiconEntry._({
    this.id,
    required this.word,
    required this.understood,
    this.definition,
    this.partOfSpeech,
    required this.learnedAt,
  });

  factory LexiconEntry({
    int? id,
    required String word,
    required bool understood,
    String? definition,
    String? partOfSpeech,
    required DateTime learnedAt,
  }) = _LexiconEntryImpl;

  factory LexiconEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LexiconEntry(
      id: jsonSerialization['id'] as int?,
      word: jsonSerialization['word'] as String,
      understood: _is.BoolJsonExtension.fromJson(
        jsonSerialization['understood'],
      ),
      definition: jsonSerialization['definition'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
      learnedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['learnedAt'],
      ),
    );
  }

  static final t = LexiconEntryTable();

  static const db = LexiconEntryRepository._();

  @override
  int? id;

  String word;

  bool understood;

  String? definition;

  String? partOfSpeech;

  DateTime learnedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LexiconEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LexiconEntry copyWith({
    int? id,
    String? word,
    bool? understood,
    String? definition,
    String? partOfSpeech,
    DateTime? learnedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LexiconEntry',
      if (id != null) 'id': id,
      'word': word,
      'understood': understood,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'learnedAt': learnedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LexiconEntry',
      if (id != null) 'id': id,
      'word': word,
      'understood': understood,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'learnedAt': learnedAt.toJson(),
    };
  }

  static LexiconEntryInclude include() {
    return LexiconEntryInclude._();
  }

  static LexiconEntryIncludeList includeList({
    _is.WhereExpressionBuilder<LexiconEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    LexiconEntryInclude? include,
  }) {
    return LexiconEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LexiconEntryImpl extends LexiconEntry {
  _LexiconEntryImpl({
    int? id,
    required String word,
    required bool understood,
    String? definition,
    String? partOfSpeech,
    required DateTime learnedAt,
  }) : super._(
         id: id,
         word: word,
         understood: understood,
         definition: definition,
         partOfSpeech: partOfSpeech,
         learnedAt: learnedAt,
       );

  /// Returns a shallow copy of this [LexiconEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LexiconEntry copyWith({
    Object? id = _Undefined,
    String? word,
    bool? understood,
    Object? definition = _Undefined,
    Object? partOfSpeech = _Undefined,
    DateTime? learnedAt,
  }) {
    return LexiconEntry(
      id: id is int? ? id : this.id,
      word: word ?? this.word,
      understood: understood ?? this.understood,
      definition: definition is String? ? definition : this.definition,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
      learnedAt: learnedAt ?? this.learnedAt,
    );
  }
}

class LexiconEntryUpdateTable extends _is.UpdateTable<LexiconEntryTable> {
  LexiconEntryUpdateTable(super.table);

  _is.ColumnValue<String, String> word(String value) => _is.ColumnValue(
    table.word,
    value,
  );

  _is.ColumnValue<bool, bool> understood(bool value) => _is.ColumnValue(
    table.understood,
    value,
  );

  _is.ColumnValue<String, String> definition(String? value) => _is.ColumnValue(
    table.definition,
    value,
  );

  _is.ColumnValue<String, String> partOfSpeech(String? value) =>
      _is.ColumnValue(
        table.partOfSpeech,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> learnedAt(DateTime value) =>
      _is.ColumnValue(
        table.learnedAt,
        value,
      );
}

class LexiconEntryTable extends _is.Table<int?> {
  LexiconEntryTable({super.tableRelation}) : super(tableName: 'lexicon_entry') {
    updateTable = LexiconEntryUpdateTable(this);
    word = _is.ColumnString(
      'word',
      this,
    );
    understood = _is.ColumnBool(
      'understood',
      this,
    );
    definition = _is.ColumnString(
      'definition',
      this,
    );
    partOfSpeech = _is.ColumnString(
      'partOfSpeech',
      this,
    );
    learnedAt = _is.ColumnDateTime(
      'learnedAt',
      this,
    );
  }

  late final LexiconEntryUpdateTable updateTable;

  late final _is.ColumnString word;

  late final _is.ColumnBool understood;

  late final _is.ColumnString definition;

  late final _is.ColumnString partOfSpeech;

  late final _is.ColumnDateTime learnedAt;

  @override
  List<_is.Column> get columns => [
    id,
    word,
    understood,
    definition,
    partOfSpeech,
    learnedAt,
  ];
}

class LexiconEntryInclude extends _is.IncludeObject {
  LexiconEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LexiconEntry.t;
}

class LexiconEntryIncludeList extends _is.IncludeList {
  LexiconEntryIncludeList._({
    _is.WhereExpressionBuilder<LexiconEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LexiconEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LexiconEntry.t;
}

class LexiconEntryRepository {
  const LexiconEntryRepository._();

  /// Returns a list of [LexiconEntry]s matching the given query parameters.
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
  Future<List<LexiconEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LexiconEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LexiconEntry>(
      where: where?.call(LexiconEntry.t),
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LexiconEntry] matching the given query parameters.
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
  Future<LexiconEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LexiconEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LexiconEntry>(
      where: where?.call(LexiconEntry.t),
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LexiconEntry] by its [id] or null if no such row exists.
  Future<LexiconEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LexiconEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LexiconEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [LexiconEntry]s will have their `id` fields set.
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
  Future<List<LexiconEntry>> insert(
    _is.DatabaseSession session,
    List<LexiconEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LexiconEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LexiconEntry] and returns the inserted row.
  ///
  /// The returned [LexiconEntry] will have its `id` field set.
  Future<LexiconEntry> insertRow(
    _is.DatabaseSession session,
    LexiconEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LexiconEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LexiconEntry]s in the list and returns the resulting rows.
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
  /// The returned [LexiconEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LexiconEntry>> upsert(
    _is.DatabaseSession session,
    List<LexiconEntry> rows, {
    required _is.ColumnSelections<LexiconEntryTable> conflictColumns,
    _is.ColumnSelections<LexiconEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<LexiconEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LexiconEntry>(
      rows,
      conflictColumns: conflictColumns(LexiconEntry.t),
      updateColumns: updateColumns?.call(LexiconEntry.t),
      updateWhere: updateWhere?.call(LexiconEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LexiconEntry] and returns the resulting row.
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
  /// The returned [LexiconEntry] will have its `id` field set.
  Future<LexiconEntry?> upsertRow(
    _is.DatabaseSession session,
    LexiconEntry row, {
    required _is.ColumnSelections<LexiconEntryTable> conflictColumns,
    _is.ColumnSelections<LexiconEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<LexiconEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LexiconEntry>(
      row,
      conflictColumns: conflictColumns(LexiconEntry.t),
      updateColumns: updateColumns?.call(LexiconEntry.t),
      updateWhere: updateWhere?.call(LexiconEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [LexiconEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LexiconEntry>> update(
    _is.DatabaseSession session,
    List<LexiconEntry> rows, {
    _is.ColumnSelections<LexiconEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LexiconEntry>(
      rows,
      columns: columns?.call(LexiconEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LexiconEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LexiconEntry> updateRow(
    _is.DatabaseSession session,
    LexiconEntry row, {
    _is.ColumnSelections<LexiconEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LexiconEntry>(
      row,
      columns: columns?.call(LexiconEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LexiconEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LexiconEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LexiconEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LexiconEntry>(
      id,
      columnValues: columnValues(LexiconEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LexiconEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LexiconEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LexiconEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LexiconEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LexiconEntry>(
      columnValues: columnValues(LexiconEntry.t.updateTable),
      where: where(LexiconEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LexiconEntry]s in the list and returns the deleted rows.
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
  Future<List<LexiconEntry>> delete(
    _is.DatabaseSession session,
    List<LexiconEntry> rows, {
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LexiconEntry>(
      rows,
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LexiconEntry].
  Future<LexiconEntry> deleteRow(
    _is.DatabaseSession session,
    LexiconEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LexiconEntry>(
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
  Future<List<LexiconEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LexiconEntryTable> where,
    _is.OrderByBuilder<LexiconEntryTable>? orderBy,
    _is.OrderByListBuilder<LexiconEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LexiconEntry>(
      where: where(LexiconEntry.t),
      orderBy: orderBy?.call(LexiconEntry.t),
      orderByList: orderByList?.call(LexiconEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LexiconEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LexiconEntry>(
      where: where?.call(LexiconEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LexiconEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LexiconEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LexiconEntry>(
      where: where(LexiconEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
