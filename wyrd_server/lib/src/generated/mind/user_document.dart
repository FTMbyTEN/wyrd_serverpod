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

abstract class UserDocument
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserDocument._({
    this.id,
    required this.authUserId,
    required this.name,
    required this.kind,
    required this.text,
    required this.chars,
    required this.words,
    this.pages,
    required this.createdAt,
  });

  factory UserDocument({
    int? id,
    required _is.UuidValue authUserId,
    required String name,
    required String kind,
    required String text,
    required int chars,
    required int words,
    int? pages,
    required DateTime createdAt,
  }) = _UserDocumentImpl;

  factory UserDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserDocument(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      name: jsonSerialization['name'] as String,
      kind: jsonSerialization['kind'] as String,
      text: jsonSerialization['text'] as String,
      chars: jsonSerialization['chars'] as int,
      words: jsonSerialization['words'] as int,
      pages: jsonSerialization['pages'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserDocumentTable();

  static const db = UserDocumentRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String name;

  String kind;

  String text;

  int chars;

  int words;

  int? pages;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserDocument copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? name,
    String? kind,
    String? text,
    int? chars,
    int? words,
    int? pages,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserDocument',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'name': name,
      'kind': kind,
      'text': text,
      'chars': chars,
      'words': words,
      if (pages != null) 'pages': pages,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserDocument',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'name': name,
      'kind': kind,
      'text': text,
      'chars': chars,
      'words': words,
      if (pages != null) 'pages': pages,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserDocumentInclude include() {
    return UserDocumentInclude._();
  }

  static UserDocumentIncludeList includeList({
    _is.WhereExpressionBuilder<UserDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    UserDocumentInclude? include,
  }) {
    return UserDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDocumentImpl extends UserDocument {
  _UserDocumentImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String name,
    required String kind,
    required String text,
    required int chars,
    required int words,
    int? pages,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         name: name,
         kind: kind,
         text: text,
         chars: chars,
         words: words,
         pages: pages,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserDocument]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserDocument copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? name,
    String? kind,
    String? text,
    int? chars,
    int? words,
    Object? pages = _Undefined,
    DateTime? createdAt,
  }) {
    return UserDocument(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      text: text ?? this.text,
      chars: chars ?? this.chars,
      words: words ?? this.words,
      pages: pages is int? ? pages : this.pages,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserDocumentUpdateTable extends _is.UpdateTable<UserDocumentTable> {
  UserDocumentUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<int, int> chars(int value) => _is.ColumnValue(
    table.chars,
    value,
  );

  _is.ColumnValue<int, int> words(int value) => _is.ColumnValue(
    table.words,
    value,
  );

  _is.ColumnValue<int, int> pages(int? value) => _is.ColumnValue(
    table.pages,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserDocumentTable extends _is.Table<int?> {
  UserDocumentTable({super.tableRelation}) : super(tableName: 'user_document') {
    updateTable = UserDocumentUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    chars = _is.ColumnInt(
      'chars',
      this,
    );
    words = _is.ColumnInt(
      'words',
      this,
    );
    pages = _is.ColumnInt(
      'pages',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserDocumentUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString name;

  late final _is.ColumnString kind;

  late final _is.ColumnString text;

  late final _is.ColumnInt chars;

  late final _is.ColumnInt words;

  late final _is.ColumnInt pages;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    name,
    kind,
    text,
    chars,
    words,
    pages,
    createdAt,
  ];
}

class UserDocumentInclude extends _is.IncludeObject {
  UserDocumentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserDocument.t;
}

class UserDocumentIncludeList extends _is.IncludeList {
  UserDocumentIncludeList._({
    _is.WhereExpressionBuilder<UserDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserDocument.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserDocument.t;
}

class UserDocumentRepository {
  const UserDocumentRepository._();

  /// Returns a list of [UserDocument]s matching the given query parameters.
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
  Future<List<UserDocument>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDocumentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserDocument>(
      where: where?.call(UserDocument.t),
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserDocument] matching the given query parameters.
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
  Future<UserDocument?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDocumentTable>? where,
    int? offset,
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserDocument>(
      where: where?.call(UserDocument.t),
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserDocument] by its [id] or null if no such row exists.
  Future<UserDocument?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserDocument>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [UserDocument]s will have their `id` fields set.
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
  Future<List<UserDocument>> insert(
    _is.DatabaseSession session,
    List<UserDocument> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserDocument] and returns the inserted row.
  ///
  /// The returned [UserDocument] will have its `id` field set.
  Future<UserDocument> insertRow(
    _is.DatabaseSession session,
    UserDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserDocument]s in the list and returns the resulting rows.
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
  /// The returned [UserDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDocument>> upsert(
    _is.DatabaseSession session,
    List<UserDocument> rows, {
    required _is.ColumnSelections<UserDocumentTable> conflictColumns,
    _is.ColumnSelections<UserDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<UserDocumentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserDocument>(
      rows,
      conflictColumns: conflictColumns(UserDocument.t),
      updateColumns: updateColumns?.call(UserDocument.t),
      updateWhere: updateWhere?.call(UserDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserDocument] and returns the resulting row.
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
  /// The returned [UserDocument] will have its `id` field set.
  Future<UserDocument?> upsertRow(
    _is.DatabaseSession session,
    UserDocument row, {
    required _is.ColumnSelections<UserDocumentTable> conflictColumns,
    _is.ColumnSelections<UserDocumentTable>? updateColumns,
    _is.WhereExpressionBuilder<UserDocumentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserDocument>(
      row,
      conflictColumns: conflictColumns(UserDocument.t),
      updateColumns: updateColumns?.call(UserDocument.t),
      updateWhere: updateWhere?.call(UserDocument.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDocument>> update(
    _is.DatabaseSession session,
    List<UserDocument> rows, {
    _is.ColumnSelections<UserDocumentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserDocument>(
      rows,
      columns: columns?.call(UserDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserDocument> updateRow(
    _is.DatabaseSession session,
    UserDocument row, {
    _is.ColumnSelections<UserDocumentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserDocument>(
      row,
      columns: columns?.call(UserDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserDocument?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserDocumentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserDocument>(
      id,
      columnValues: columnValues(UserDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDocument>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserDocumentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserDocumentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserDocument>(
      columnValues: columnValues(UserDocument.t.updateTable),
      where: where(UserDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserDocument]s in the list and returns the deleted rows.
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
  Future<List<UserDocument>> delete(
    _is.DatabaseSession session,
    List<UserDocument> rows, {
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserDocument>(
      rows,
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserDocument].
  Future<UserDocument> deleteRow(
    _is.DatabaseSession session,
    UserDocument row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserDocument>(
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
  Future<List<UserDocument>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserDocumentTable> where,
    _is.OrderByBuilder<UserDocumentTable>? orderBy,
    _is.OrderByListBuilder<UserDocumentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserDocument>(
      where: where(UserDocument.t),
      orderBy: orderBy?.call(UserDocument.t),
      orderByList: orderByList?.call(UserDocument.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDocumentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserDocument>(
      where: where?.call(UserDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserDocumentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserDocument>(
      where: where(UserDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
