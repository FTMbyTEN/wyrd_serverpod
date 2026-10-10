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

/// One offence on a player's record (Fair Streets): its code, where, the evidence and how sure the city is, what came of
/// it, and any appeal. A fine is "pending" until a stop, a posting or a call settles it; then paid (and/or on the plan),
/// a caution, or waived.
abstract class PoliceCitation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PoliceCitation._({
    this.id,
    required this.authUserId,
    required this.code,
    required this.place,
    required this.evidence,
    required this.confidence,
    required this.outcome,
    int? amount,
    required this.status,
    int? paid,
    int? owed,
    this.entryId,
    this.settledBy,
    this.appealReason,
    this.appealResult,
    required this.createdAt,
    this.settledAt,
  }) : amount = amount ?? 0,
       paid = paid ?? 0,
       owed = owed ?? 0;

  factory PoliceCitation({
    int? id,
    required _is.UuidValue authUserId,
    required String code,
    required String place,
    required String evidence,
    required double confidence,
    required String outcome,
    int? amount,
    required String status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    required DateTime createdAt,
    DateTime? settledAt,
  }) = _PoliceCitationImpl;

  factory PoliceCitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoliceCitation(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      code: jsonSerialization['code'] as String,
      place: jsonSerialization['place'] as String,
      evidence: jsonSerialization['evidence'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      outcome: jsonSerialization['outcome'] as String,
      amount: jsonSerialization['amount'] as int?,
      status: jsonSerialization['status'] as String,
      paid: jsonSerialization['paid'] as int?,
      owed: jsonSerialization['owed'] as int?,
      entryId: jsonSerialization['entryId'] as int?,
      settledBy: jsonSerialization['settledBy'] as String?,
      appealReason: jsonSerialization['appealReason'] as String?,
      appealResult: jsonSerialization['appealResult'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      settledAt: jsonSerialization['settledAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['settledAt']),
    );
  }

  static final t = PoliceCitationTable();

  static const db = PoliceCitationRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  /// RL-1 | SP-1 | SP-2 | CD-1 | PT-1 | FS-1
  String code;

  String place;

  /// JSON list of {source, id, confidence, detail}
  String evidence;

  double confidence;

  /// note | warning | fine
  String outcome;

  /// the fine as issued (0 for notes and warnings)
  int amount;

  /// note | warning | pending | paid | caution | waived | overturned
  String status;

  /// what was paid now and put on the plan when it was settled, and the ledger entry
  int paid;

  int owed;

  int? entryId;

  /// how it was settled: stop | complied | posted | desk | counsel | favour | cooled
  String? settledBy;

  String? appealReason;

  /// overturned | reduced | upheld | queued
  String? appealResult;

  DateTime createdAt;

  DateTime? settledAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PoliceCitation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoliceCitation copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? code,
    String? place,
    String? evidence,
    double? confidence,
    String? outcome,
    int? amount,
    String? status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    DateTime? createdAt,
    DateTime? settledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoliceCitation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'place': place,
      'evidence': evidence,
      'confidence': confidence,
      'outcome': outcome,
      'amount': amount,
      'status': status,
      'paid': paid,
      'owed': owed,
      if (entryId != null) 'entryId': entryId,
      if (settledBy != null) 'settledBy': settledBy,
      if (appealReason != null) 'appealReason': appealReason,
      if (appealResult != null) 'appealResult': appealResult,
      'createdAt': createdAt.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PoliceCitation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'code': code,
      'place': place,
      'evidence': evidence,
      'confidence': confidence,
      'outcome': outcome,
      'amount': amount,
      'status': status,
      'paid': paid,
      'owed': owed,
      if (entryId != null) 'entryId': entryId,
      if (settledBy != null) 'settledBy': settledBy,
      if (appealReason != null) 'appealReason': appealReason,
      if (appealResult != null) 'appealResult': appealResult,
      'createdAt': createdAt.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  static PoliceCitationInclude include() {
    return PoliceCitationInclude._();
  }

  static PoliceCitationIncludeList includeList({
    _is.WhereExpressionBuilder<PoliceCitationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    PoliceCitationInclude? include,
  }) {
    return PoliceCitationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoliceCitationImpl extends PoliceCitation {
  _PoliceCitationImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String code,
    required String place,
    required String evidence,
    required double confidence,
    required String outcome,
    int? amount,
    required String status,
    int? paid,
    int? owed,
    int? entryId,
    String? settledBy,
    String? appealReason,
    String? appealResult,
    required DateTime createdAt,
    DateTime? settledAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         code: code,
         place: place,
         evidence: evidence,
         confidence: confidence,
         outcome: outcome,
         amount: amount,
         status: status,
         paid: paid,
         owed: owed,
         entryId: entryId,
         settledBy: settledBy,
         appealReason: appealReason,
         appealResult: appealResult,
         createdAt: createdAt,
         settledAt: settledAt,
       );

  /// Returns a shallow copy of this [PoliceCitation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PoliceCitation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? code,
    String? place,
    String? evidence,
    double? confidence,
    String? outcome,
    int? amount,
    String? status,
    int? paid,
    int? owed,
    Object? entryId = _Undefined,
    Object? settledBy = _Undefined,
    Object? appealReason = _Undefined,
    Object? appealResult = _Undefined,
    DateTime? createdAt,
    Object? settledAt = _Undefined,
  }) {
    return PoliceCitation(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      code: code ?? this.code,
      place: place ?? this.place,
      evidence: evidence ?? this.evidence,
      confidence: confidence ?? this.confidence,
      outcome: outcome ?? this.outcome,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paid: paid ?? this.paid,
      owed: owed ?? this.owed,
      entryId: entryId is int? ? entryId : this.entryId,
      settledBy: settledBy is String? ? settledBy : this.settledBy,
      appealReason: appealReason is String? ? appealReason : this.appealReason,
      appealResult: appealResult is String? ? appealResult : this.appealResult,
      createdAt: createdAt ?? this.createdAt,
      settledAt: settledAt is DateTime? ? settledAt : this.settledAt,
    );
  }
}

class PoliceCitationUpdateTable extends _is.UpdateTable<PoliceCitationTable> {
  PoliceCitationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<String, String> place(String value) => _is.ColumnValue(
    table.place,
    value,
  );

  _is.ColumnValue<String, String> evidence(String value) => _is.ColumnValue(
    table.evidence,
    value,
  );

  _is.ColumnValue<double, double> confidence(double value) => _is.ColumnValue(
    table.confidence,
    value,
  );

  _is.ColumnValue<String, String> outcome(String value) => _is.ColumnValue(
    table.outcome,
    value,
  );

  _is.ColumnValue<int, int> amount(int value) => _is.ColumnValue(
    table.amount,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> paid(int value) => _is.ColumnValue(
    table.paid,
    value,
  );

  _is.ColumnValue<int, int> owed(int value) => _is.ColumnValue(
    table.owed,
    value,
  );

  _is.ColumnValue<int, int> entryId(int? value) => _is.ColumnValue(
    table.entryId,
    value,
  );

  _is.ColumnValue<String, String> settledBy(String? value) => _is.ColumnValue(
    table.settledBy,
    value,
  );

  _is.ColumnValue<String, String> appealReason(String? value) =>
      _is.ColumnValue(
        table.appealReason,
        value,
      );

  _is.ColumnValue<String, String> appealResult(String? value) =>
      _is.ColumnValue(
        table.appealResult,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> settledAt(DateTime? value) =>
      _is.ColumnValue(
        table.settledAt,
        value,
      );
}

class PoliceCitationTable extends _is.Table<int?> {
  PoliceCitationTable({super.tableRelation})
    : super(tableName: 'police_citation') {
    updateTable = PoliceCitationUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    place = _is.ColumnString(
      'place',
      this,
    );
    evidence = _is.ColumnString(
      'evidence',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    outcome = _is.ColumnString(
      'outcome',
      this,
    );
    amount = _is.ColumnInt(
      'amount',
      this,
      hasDefault: true,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    paid = _is.ColumnInt(
      'paid',
      this,
      hasDefault: true,
    );
    owed = _is.ColumnInt(
      'owed',
      this,
      hasDefault: true,
    );
    entryId = _is.ColumnInt(
      'entryId',
      this,
    );
    settledBy = _is.ColumnString(
      'settledBy',
      this,
    );
    appealReason = _is.ColumnString(
      'appealReason',
      this,
    );
    appealResult = _is.ColumnString(
      'appealResult',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    settledAt = _is.ColumnDateTime(
      'settledAt',
      this,
    );
  }

  late final PoliceCitationUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// RL-1 | SP-1 | SP-2 | CD-1 | PT-1 | FS-1
  late final _is.ColumnString code;

  late final _is.ColumnString place;

  /// JSON list of {source, id, confidence, detail}
  late final _is.ColumnString evidence;

  late final _is.ColumnDouble confidence;

  /// note | warning | fine
  late final _is.ColumnString outcome;

  /// the fine as issued (0 for notes and warnings)
  late final _is.ColumnInt amount;

  /// note | warning | pending | paid | caution | waived | overturned
  late final _is.ColumnString status;

  /// what was paid now and put on the plan when it was settled, and the ledger entry
  late final _is.ColumnInt paid;

  late final _is.ColumnInt owed;

  late final _is.ColumnInt entryId;

  /// how it was settled: stop | complied | posted | desk | counsel | favour | cooled
  late final _is.ColumnString settledBy;

  late final _is.ColumnString appealReason;

  /// overturned | reduced | upheld | queued
  late final _is.ColumnString appealResult;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime settledAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    code,
    place,
    evidence,
    confidence,
    outcome,
    amount,
    status,
    paid,
    owed,
    entryId,
    settledBy,
    appealReason,
    appealResult,
    createdAt,
    settledAt,
  ];
}

class PoliceCitationInclude extends _is.IncludeObject {
  PoliceCitationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PoliceCitation.t;
}

class PoliceCitationIncludeList extends _is.IncludeList {
  PoliceCitationIncludeList._({
    _is.WhereExpressionBuilder<PoliceCitationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoliceCitation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PoliceCitation.t;
}

class PoliceCitationRepository {
  const PoliceCitationRepository._();

  /// Returns a list of [PoliceCitation]s matching the given query parameters.
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
  Future<List<PoliceCitation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoliceCitationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoliceCitation>(
      where: where?.call(PoliceCitation.t),
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoliceCitation] matching the given query parameters.
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
  Future<PoliceCitation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoliceCitationTable>? where,
    int? offset,
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoliceCitation>(
      where: where?.call(PoliceCitation.t),
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoliceCitation] by its [id] or null if no such row exists.
  Future<PoliceCitation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoliceCitation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoliceCitation]s in the list and returns the inserted rows.
  ///
  /// The returned [PoliceCitation]s will have their `id` fields set.
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
  Future<List<PoliceCitation>> insert(
    _is.DatabaseSession session,
    List<PoliceCitation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoliceCitation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoliceCitation] and returns the inserted row.
  ///
  /// The returned [PoliceCitation] will have its `id` field set.
  Future<PoliceCitation> insertRow(
    _is.DatabaseSession session,
    PoliceCitation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoliceCitation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoliceCitation]s in the list and returns the resulting rows.
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
  /// The returned [PoliceCitation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoliceCitation>> upsert(
    _is.DatabaseSession session,
    List<PoliceCitation> rows, {
    required _is.ColumnSelections<PoliceCitationTable> conflictColumns,
    _is.ColumnSelections<PoliceCitationTable>? updateColumns,
    _is.WhereExpressionBuilder<PoliceCitationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoliceCitation>(
      rows,
      conflictColumns: conflictColumns(PoliceCitation.t),
      updateColumns: updateColumns?.call(PoliceCitation.t),
      updateWhere: updateWhere?.call(PoliceCitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoliceCitation] and returns the resulting row.
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
  /// The returned [PoliceCitation] will have its `id` field set.
  Future<PoliceCitation?> upsertRow(
    _is.DatabaseSession session,
    PoliceCitation row, {
    required _is.ColumnSelections<PoliceCitationTable> conflictColumns,
    _is.ColumnSelections<PoliceCitationTable>? updateColumns,
    _is.WhereExpressionBuilder<PoliceCitationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoliceCitation>(
      row,
      conflictColumns: conflictColumns(PoliceCitation.t),
      updateColumns: updateColumns?.call(PoliceCitation.t),
      updateWhere: updateWhere?.call(PoliceCitation.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoliceCitation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoliceCitation>> update(
    _is.DatabaseSession session,
    List<PoliceCitation> rows, {
    _is.ColumnSelections<PoliceCitationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoliceCitation>(
      rows,
      columns: columns?.call(PoliceCitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoliceCitation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoliceCitation> updateRow(
    _is.DatabaseSession session,
    PoliceCitation row, {
    _is.ColumnSelections<PoliceCitationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoliceCitation>(
      row,
      columns: columns?.call(PoliceCitation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoliceCitation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoliceCitation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PoliceCitationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoliceCitation>(
      id,
      columnValues: columnValues(PoliceCitation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoliceCitation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoliceCitation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoliceCitationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PoliceCitationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoliceCitation>(
      columnValues: columnValues(PoliceCitation.t.updateTable),
      where: where(PoliceCitation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoliceCitation]s in the list and returns the deleted rows.
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
  Future<List<PoliceCitation>> delete(
    _is.DatabaseSession session,
    List<PoliceCitation> rows, {
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoliceCitation>(
      rows,
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoliceCitation].
  Future<PoliceCitation> deleteRow(
    _is.DatabaseSession session,
    PoliceCitation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoliceCitation>(
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
  Future<List<PoliceCitation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoliceCitationTable> where,
    _is.OrderByBuilder<PoliceCitationTable>? orderBy,
    _is.OrderByListBuilder<PoliceCitationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoliceCitation>(
      where: where(PoliceCitation.t),
      orderBy: orderBy?.call(PoliceCitation.t),
      orderByList: orderByList?.call(PoliceCitation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoliceCitationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoliceCitation>(
      where: where?.call(PoliceCitation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoliceCitation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoliceCitationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoliceCitation>(
      where: where(PoliceCitation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
