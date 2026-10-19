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

/// A job a player can accept. Its rewards are fixed when the offer is made (the reward snapshot) and copied onto every
/// acceptance; a later policy never changes them.
abstract class JobOffer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  JobOffer._({
    this.id,
    required this.type,
    this.campaignId,
    required this.title,
    required this.task,
    required this.basis,
    required this.gameReward,
    required this.cashKobo,
    required this.feeKobo,
    this.policyVersion,
    this.places,
    required this.closesAt,
    required this.completeMinutes,
    required this.status,
    required this.createdBy,
    required this.createdAt,
  });

  factory JobOffer({
    int? id,
    required String type,
    int? campaignId,
    required String title,
    required String task,
    required int basis,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    int? policyVersion,
    int? places,
    required DateTime closesAt,
    required int completeMinutes,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) = _JobOfferImpl;

  factory JobOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobOffer(
      id: jsonSerialization['id'] as int?,
      type: jsonSerialization['type'] as String,
      campaignId: jsonSerialization['campaignId'] as int?,
      title: jsonSerialization['title'] as String,
      task: jsonSerialization['task'] as String,
      basis: jsonSerialization['basis'] as int,
      gameReward: jsonSerialization['gameReward'] as int,
      cashKobo: jsonSerialization['cashKobo'] as int,
      feeKobo: jsonSerialization['feeKobo'] as int,
      policyVersion: jsonSerialization['policyVersion'] as int?,
      places: jsonSerialization['places'] as int?,
      closesAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['closesAt'],
      ),
      completeMinutes: jsonSerialization['completeMinutes'] as int,
      status: jsonSerialization['status'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = JobOfferTable();

  static const db = JobOfferRepository._();

  @override
  int? id;

  /// ORDINARY_GAME_JOB | FUNDED_SPLIT_JOB
  String type;

  int? campaignId;

  String title;

  /// what the task is (delivery), checked by the server on completion
  String task;

  /// the reward basis (naira) the split was worked out from
  int basis;

  /// Game Naira paid on completion
  int gameReward;

  /// real cash reward, kobo (0 for ordinary jobs)
  int cashKobo;

  /// payout-cost allowance reserved with it, kobo
  int feeKobo;

  int? policyVersion;

  /// how many players may accept it (null: no limit beyond funding)
  int? places;

  DateTime closesAt;

  /// minutes an accepted job has to be completed
  int completeMinutes;

  /// open | closed
  String status;

  String createdBy;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobOffer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JobOffer copyWith({
    int? id,
    String? type,
    int? campaignId,
    String? title,
    String? task,
    int? basis,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    int? policyVersion,
    int? places,
    DateTime? closesAt,
    int? completeMinutes,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobOffer',
      if (id != null) 'id': id,
      'type': type,
      if (campaignId != null) 'campaignId': campaignId,
      'title': title,
      'task': task,
      'basis': basis,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      if (policyVersion != null) 'policyVersion': policyVersion,
      if (places != null) 'places': places,
      'closesAt': closesAt.toJson(),
      'completeMinutes': completeMinutes,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobOffer',
      if (id != null) 'id': id,
      'type': type,
      if (campaignId != null) 'campaignId': campaignId,
      'title': title,
      'task': task,
      'basis': basis,
      'gameReward': gameReward,
      'cashKobo': cashKobo,
      'feeKobo': feeKobo,
      if (policyVersion != null) 'policyVersion': policyVersion,
      if (places != null) 'places': places,
      'closesAt': closesAt.toJson(),
      'completeMinutes': completeMinutes,
      'status': status,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
    };
  }

  static JobOfferInclude include() {
    return JobOfferInclude._();
  }

  static JobOfferIncludeList includeList({
    _is.WhereExpressionBuilder<JobOfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    JobOfferInclude? include,
  }) {
    return JobOfferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobOfferImpl extends JobOffer {
  _JobOfferImpl({
    int? id,
    required String type,
    int? campaignId,
    required String title,
    required String task,
    required int basis,
    required int gameReward,
    required int cashKobo,
    required int feeKobo,
    int? policyVersion,
    int? places,
    required DateTime closesAt,
    required int completeMinutes,
    required String status,
    required String createdBy,
    required DateTime createdAt,
  }) : super._(
         id: id,
         type: type,
         campaignId: campaignId,
         title: title,
         task: task,
         basis: basis,
         gameReward: gameReward,
         cashKobo: cashKobo,
         feeKobo: feeKobo,
         policyVersion: policyVersion,
         places: places,
         closesAt: closesAt,
         completeMinutes: completeMinutes,
         status: status,
         createdBy: createdBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JobOffer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JobOffer copyWith({
    Object? id = _Undefined,
    String? type,
    Object? campaignId = _Undefined,
    String? title,
    String? task,
    int? basis,
    int? gameReward,
    int? cashKobo,
    int? feeKobo,
    Object? policyVersion = _Undefined,
    Object? places = _Undefined,
    DateTime? closesAt,
    int? completeMinutes,
    String? status,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return JobOffer(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      campaignId: campaignId is int? ? campaignId : this.campaignId,
      title: title ?? this.title,
      task: task ?? this.task,
      basis: basis ?? this.basis,
      gameReward: gameReward ?? this.gameReward,
      cashKobo: cashKobo ?? this.cashKobo,
      feeKobo: feeKobo ?? this.feeKobo,
      policyVersion: policyVersion is int? ? policyVersion : this.policyVersion,
      places: places is int? ? places : this.places,
      closesAt: closesAt ?? this.closesAt,
      completeMinutes: completeMinutes ?? this.completeMinutes,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class JobOfferUpdateTable extends _is.UpdateTable<JobOfferTable> {
  JobOfferUpdateTable(super.table);

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<int, int> campaignId(int? value) => _is.ColumnValue(
    table.campaignId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> task(String value) => _is.ColumnValue(
    table.task,
    value,
  );

  _is.ColumnValue<int, int> basis(int value) => _is.ColumnValue(
    table.basis,
    value,
  );

  _is.ColumnValue<int, int> gameReward(int value) => _is.ColumnValue(
    table.gameReward,
    value,
  );

  _is.ColumnValue<int, int> cashKobo(int value) => _is.ColumnValue(
    table.cashKobo,
    value,
  );

  _is.ColumnValue<int, int> feeKobo(int value) => _is.ColumnValue(
    table.feeKobo,
    value,
  );

  _is.ColumnValue<int, int> policyVersion(int? value) => _is.ColumnValue(
    table.policyVersion,
    value,
  );

  _is.ColumnValue<int, int> places(int? value) => _is.ColumnValue(
    table.places,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> closesAt(DateTime value) =>
      _is.ColumnValue(
        table.closesAt,
        value,
      );

  _is.ColumnValue<int, int> completeMinutes(int value) => _is.ColumnValue(
    table.completeMinutes,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class JobOfferTable extends _is.Table<int?> {
  JobOfferTable({super.tableRelation}) : super(tableName: 'job_offer') {
    updateTable = JobOfferUpdateTable(this);
    type = _is.ColumnString(
      'type',
      this,
    );
    campaignId = _is.ColumnInt(
      'campaignId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    task = _is.ColumnString(
      'task',
      this,
    );
    basis = _is.ColumnInt(
      'basis',
      this,
    );
    gameReward = _is.ColumnInt(
      'gameReward',
      this,
    );
    cashKobo = _is.ColumnInt(
      'cashKobo',
      this,
    );
    feeKobo = _is.ColumnInt(
      'feeKobo',
      this,
    );
    policyVersion = _is.ColumnInt(
      'policyVersion',
      this,
    );
    places = _is.ColumnInt(
      'places',
      this,
    );
    closesAt = _is.ColumnDateTime(
      'closesAt',
      this,
    );
    completeMinutes = _is.ColumnInt(
      'completeMinutes',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final JobOfferUpdateTable updateTable;

  /// ORDINARY_GAME_JOB | FUNDED_SPLIT_JOB
  late final _is.ColumnString type;

  late final _is.ColumnInt campaignId;

  late final _is.ColumnString title;

  /// what the task is (delivery), checked by the server on completion
  late final _is.ColumnString task;

  /// the reward basis (naira) the split was worked out from
  late final _is.ColumnInt basis;

  /// Game Naira paid on completion
  late final _is.ColumnInt gameReward;

  /// real cash reward, kobo (0 for ordinary jobs)
  late final _is.ColumnInt cashKobo;

  /// payout-cost allowance reserved with it, kobo
  late final _is.ColumnInt feeKobo;

  late final _is.ColumnInt policyVersion;

  /// how many players may accept it (null: no limit beyond funding)
  late final _is.ColumnInt places;

  late final _is.ColumnDateTime closesAt;

  /// minutes an accepted job has to be completed
  late final _is.ColumnInt completeMinutes;

  /// open | closed
  late final _is.ColumnString status;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    type,
    campaignId,
    title,
    task,
    basis,
    gameReward,
    cashKobo,
    feeKobo,
    policyVersion,
    places,
    closesAt,
    completeMinutes,
    status,
    createdBy,
    createdAt,
  ];
}

class JobOfferInclude extends _is.IncludeObject {
  JobOfferInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JobOffer.t;
}

class JobOfferIncludeList extends _is.IncludeList {
  JobOfferIncludeList._({
    _is.WhereExpressionBuilder<JobOfferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobOffer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JobOffer.t;
}

class JobOfferRepository {
  const JobOfferRepository._();

  /// Returns a list of [JobOffer]s matching the given query parameters.
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
  Future<List<JobOffer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobOfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobOffer>(
      where: where?.call(JobOffer.t),
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobOffer] matching the given query parameters.
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
  Future<JobOffer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobOfferTable>? where,
    int? offset,
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobOffer>(
      where: where?.call(JobOffer.t),
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobOffer] by its [id] or null if no such row exists.
  Future<JobOffer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobOffer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobOffer]s in the list and returns the inserted rows.
  ///
  /// The returned [JobOffer]s will have their `id` fields set.
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
  Future<List<JobOffer>> insert(
    _is.DatabaseSession session,
    List<JobOffer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JobOffer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JobOffer] and returns the inserted row.
  ///
  /// The returned [JobOffer] will have its `id` field set.
  Future<JobOffer> insertRow(
    _is.DatabaseSession session,
    JobOffer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobOffer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JobOffer]s in the list and returns the resulting rows.
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
  /// The returned [JobOffer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobOffer>> upsert(
    _is.DatabaseSession session,
    List<JobOffer> rows, {
    required _is.ColumnSelections<JobOfferTable> conflictColumns,
    _is.ColumnSelections<JobOfferTable>? updateColumns,
    _is.WhereExpressionBuilder<JobOfferTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JobOffer>(
      rows,
      conflictColumns: conflictColumns(JobOffer.t),
      updateColumns: updateColumns?.call(JobOffer.t),
      updateWhere: updateWhere?.call(JobOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JobOffer] and returns the resulting row.
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
  /// The returned [JobOffer] will have its `id` field set.
  Future<JobOffer?> upsertRow(
    _is.DatabaseSession session,
    JobOffer row, {
    required _is.ColumnSelections<JobOfferTable> conflictColumns,
    _is.ColumnSelections<JobOfferTable>? updateColumns,
    _is.WhereExpressionBuilder<JobOfferTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JobOffer>(
      row,
      conflictColumns: conflictColumns(JobOffer.t),
      updateColumns: updateColumns?.call(JobOffer.t),
      updateWhere: updateWhere?.call(JobOffer.t),
      transaction: transaction,
    );
  }

  /// Updates all [JobOffer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobOffer>> update(
    _is.DatabaseSession session,
    List<JobOffer> rows, {
    _is.ColumnSelections<JobOfferTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JobOffer>(
      rows,
      columns: columns?.call(JobOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JobOffer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobOffer> updateRow(
    _is.DatabaseSession session,
    JobOffer row, {
    _is.ColumnSelections<JobOfferTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobOffer>(
      row,
      columns: columns?.call(JobOffer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobOffer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobOffer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JobOfferUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JobOffer>(
      id,
      columnValues: columnValues(JobOffer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobOffer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobOffer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JobOfferUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JobOfferTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JobOffer>(
      columnValues: columnValues(JobOffer.t.updateTable),
      where: where(JobOffer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JobOffer]s in the list and returns the deleted rows.
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
  Future<List<JobOffer>> delete(
    _is.DatabaseSession session,
    List<JobOffer> rows, {
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JobOffer>(
      rows,
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JobOffer].
  Future<JobOffer> deleteRow(
    _is.DatabaseSession session,
    JobOffer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobOffer>(
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
  Future<List<JobOffer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobOfferTable> where,
    _is.OrderByBuilder<JobOfferTable>? orderBy,
    _is.OrderByListBuilder<JobOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JobOffer>(
      where: where(JobOffer.t),
      orderBy: orderBy?.call(JobOffer.t),
      orderByList: orderByList?.call(JobOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobOfferTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JobOffer>(
      where: where?.call(JobOffer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobOffer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobOfferTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobOffer>(
      where: where(JobOffer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
