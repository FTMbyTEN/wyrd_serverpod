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

/// A real job, posted by an employer on LAGOS ISLAND. It shows on the job board once WYRD's operator
/// has checked it (status open).
abstract class IslandJob
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandJob._({
    this.id,
    required this.employerUserId,
    required this.company,
    required this.title,
    required this.pay,
    required this.skills,
    required this.location,
    required this.about,
    required this.contact,
    String? status,
    required this.createdAt,
  }) : status = status ?? 'pending';

  factory IslandJob({
    int? id,
    required _is.UuidValue employerUserId,
    required String company,
    required String title,
    required String pay,
    required String skills,
    required String location,
    required String about,
    required String contact,
    String? status,
    required DateTime createdAt,
  }) = _IslandJobImpl;

  factory IslandJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJob(
      id: jsonSerialization['id'] as int?,
      employerUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['employerUserId'],
      ),
      company: jsonSerialization['company'] as String,
      title: jsonSerialization['title'] as String,
      pay: jsonSerialization['pay'] as String,
      skills: jsonSerialization['skills'] as String,
      location: jsonSerialization['location'] as String,
      about: jsonSerialization['about'] as String,
      contact: jsonSerialization['contact'] as String,
      status: jsonSerialization['status'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = IslandJobTable();

  static const db = IslandJobRepository._();

  @override
  int? id;

  _is.UuidValue employerUserId;

  String company;

  String title;

  /// as the employer wrote it, e.g. "₦250,000 a month"
  String pay;

  /// the skills it needs, comma separated
  String skills;

  String location;

  String about;

  /// how the employer wants to be reached; shown to an applicant only after they apply
  String contact;

  /// pending | open | closed | rejected
  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandJob copyWith({
    int? id,
    _is.UuidValue? employerUserId,
    String? company,
    String? title,
    String? pay,
    String? skills,
    String? location,
    String? about,
    String? contact,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJob',
      if (id != null) 'id': id,
      'employerUserId': employerUserId.toJson(),
      'company': company,
      'title': title,
      'pay': pay,
      'skills': skills,
      'location': location,
      'about': about,
      'contact': contact,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJob',
      if (id != null) 'id': id,
      'employerUserId': employerUserId.toJson(),
      'company': company,
      'title': title,
      'pay': pay,
      'skills': skills,
      'location': location,
      'about': about,
      'contact': contact,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static IslandJobInclude include() {
    return IslandJobInclude._();
  }

  static IslandJobIncludeList includeList({
    _is.WhereExpressionBuilder<IslandJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    IslandJobInclude? include,
  }) {
    return IslandJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandJobImpl extends IslandJob {
  _IslandJobImpl({
    int? id,
    required _is.UuidValue employerUserId,
    required String company,
    required String title,
    required String pay,
    required String skills,
    required String location,
    required String about,
    required String contact,
    String? status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         employerUserId: employerUserId,
         company: company,
         title: title,
         pay: pay,
         skills: skills,
         location: location,
         about: about,
         contact: contact,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandJob copyWith({
    Object? id = _Undefined,
    _is.UuidValue? employerUserId,
    String? company,
    String? title,
    String? pay,
    String? skills,
    String? location,
    String? about,
    String? contact,
    String? status,
    DateTime? createdAt,
  }) {
    return IslandJob(
      id: id is int? ? id : this.id,
      employerUserId: employerUserId ?? this.employerUserId,
      company: company ?? this.company,
      title: title ?? this.title,
      pay: pay ?? this.pay,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      about: about ?? this.about,
      contact: contact ?? this.contact,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class IslandJobUpdateTable extends _is.UpdateTable<IslandJobTable> {
  IslandJobUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> employerUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.employerUserId,
    value,
  );

  _is.ColumnValue<String, String> company(String value) => _is.ColumnValue(
    table.company,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> pay(String value) => _is.ColumnValue(
    table.pay,
    value,
  );

  _is.ColumnValue<String, String> skills(String value) => _is.ColumnValue(
    table.skills,
    value,
  );

  _is.ColumnValue<String, String> location(String value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> about(String value) => _is.ColumnValue(
    table.about,
    value,
  );

  _is.ColumnValue<String, String> contact(String value) => _is.ColumnValue(
    table.contact,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class IslandJobTable extends _is.Table<int?> {
  IslandJobTable({super.tableRelation}) : super(tableName: 'island_job') {
    updateTable = IslandJobUpdateTable(this);
    employerUserId = _is.ColumnUuid(
      'employerUserId',
      this,
    );
    company = _is.ColumnString(
      'company',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    pay = _is.ColumnString(
      'pay',
      this,
    );
    skills = _is.ColumnString(
      'skills',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    about = _is.ColumnString(
      'about',
      this,
    );
    contact = _is.ColumnString(
      'contact',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final IslandJobUpdateTable updateTable;

  late final _is.ColumnUuid employerUserId;

  late final _is.ColumnString company;

  late final _is.ColumnString title;

  /// as the employer wrote it, e.g. "₦250,000 a month"
  late final _is.ColumnString pay;

  /// the skills it needs, comma separated
  late final _is.ColumnString skills;

  late final _is.ColumnString location;

  late final _is.ColumnString about;

  /// how the employer wants to be reached; shown to an applicant only after they apply
  late final _is.ColumnString contact;

  /// pending | open | closed | rejected
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    employerUserId,
    company,
    title,
    pay,
    skills,
    location,
    about,
    contact,
    status,
    createdAt,
  ];
}

class IslandJobInclude extends _is.IncludeObject {
  IslandJobInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandJob.t;
}

class IslandJobIncludeList extends _is.IncludeList {
  IslandJobIncludeList._({
    _is.WhereExpressionBuilder<IslandJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandJob.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandJob.t;
}

class IslandJobRepository {
  const IslandJobRepository._();

  /// Returns a list of [IslandJob]s matching the given query parameters.
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
  Future<List<IslandJob>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandJob>(
      where: where?.call(IslandJob.t),
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandJob] matching the given query parameters.
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
  Future<IslandJob?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandJob>(
      where: where?.call(IslandJob.t),
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandJob] by its [id] or null if no such row exists.
  Future<IslandJob?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandJob]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandJob]s will have their `id` fields set.
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
  Future<List<IslandJob>> insert(
    _is.DatabaseSession session,
    List<IslandJob> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandJob] and returns the inserted row.
  ///
  /// The returned [IslandJob] will have its `id` field set.
  Future<IslandJob> insertRow(
    _is.DatabaseSession session,
    IslandJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandJob>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandJob]s in the list and returns the resulting rows.
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
  /// The returned [IslandJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJob>> upsert(
    _is.DatabaseSession session,
    List<IslandJob> rows, {
    required _is.ColumnSelections<IslandJobTable> conflictColumns,
    _is.ColumnSelections<IslandJobTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJobTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandJob>(
      rows,
      conflictColumns: conflictColumns(IslandJob.t),
      updateColumns: updateColumns?.call(IslandJob.t),
      updateWhere: updateWhere?.call(IslandJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandJob] and returns the resulting row.
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
  /// The returned [IslandJob] will have its `id` field set.
  Future<IslandJob?> upsertRow(
    _is.DatabaseSession session,
    IslandJob row, {
    required _is.ColumnSelections<IslandJobTable> conflictColumns,
    _is.ColumnSelections<IslandJobTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandJobTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandJob>(
      row,
      conflictColumns: conflictColumns(IslandJob.t),
      updateColumns: updateColumns?.call(IslandJob.t),
      updateWhere: updateWhere?.call(IslandJob.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJob>> update(
    _is.DatabaseSession session,
    List<IslandJob> rows, {
    _is.ColumnSelections<IslandJobTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandJob>(
      rows,
      columns: columns?.call(IslandJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandJob> updateRow(
    _is.DatabaseSession session,
    IslandJob row, {
    _is.ColumnSelections<IslandJobTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandJob>(
      row,
      columns: columns?.call(IslandJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandJob?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandJobUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandJob>(
      id,
      columnValues: columnValues(IslandJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandJob>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandJobUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IslandJobTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandJob>(
      columnValues: columnValues(IslandJob.t.updateTable),
      where: where(IslandJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandJob]s in the list and returns the deleted rows.
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
  Future<List<IslandJob>> delete(
    _is.DatabaseSession session,
    List<IslandJob> rows, {
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandJob>(
      rows,
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandJob].
  Future<IslandJob> deleteRow(
    _is.DatabaseSession session,
    IslandJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandJob>(
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
  Future<List<IslandJob>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJobTable> where,
    _is.OrderByBuilder<IslandJobTable>? orderBy,
    _is.OrderByListBuilder<IslandJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandJob>(
      where: where(IslandJob.t),
      orderBy: orderBy?.call(IslandJob.t),
      orderByList: orderByList?.call(IslandJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandJobTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandJob>(
      where: where?.call(IslandJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandJob] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandJobTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandJob>(
      where: where(IslandJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
