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

/// Where a player's real earnings would be paid: one Nigerian bank account, checked two ways before it counts.
/// The bank's own name for the account (Flutterwave's account lookup) must match the legal name the player gives
/// (a soft ID check), and the email they give must answer a code sent to it.
abstract class IslandPayoutAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IslandPayoutAccount._({
    this.id,
    required this.authUserId,
    required this.bankCode,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.legalName,
    required this.nameMatch,
    required this.email,
    bool? emailVerified,
    this.emailCode,
    this.codeExpires,
    int? codeTries,
    required this.status,
    this.dateOfBirth,
    this.termsAcceptedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : emailVerified = emailVerified ?? false,
       codeTries = codeTries ?? 0;

  factory IslandPayoutAccount({
    int? id,
    required _is.UuidValue authUserId,
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String legalName,
    required bool nameMatch,
    required String email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    required String status,
    DateTime? dateOfBirth,
    DateTime? termsAcceptedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IslandPayoutAccountImpl;

  factory IslandPayoutAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandPayoutAccount(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      bankCode: jsonSerialization['bankCode'] as String,
      bankName: jsonSerialization['bankName'] as String,
      accountNumber: jsonSerialization['accountNumber'] as String,
      accountName: jsonSerialization['accountName'] as String,
      legalName: jsonSerialization['legalName'] as String,
      nameMatch: _is.BoolJsonExtension.fromJson(jsonSerialization['nameMatch']),
      email: jsonSerialization['email'] as String,
      emailVerified: jsonSerialization['emailVerified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['emailVerified']),
      emailCode: jsonSerialization['emailCode'] as String?,
      codeExpires: jsonSerialization['codeExpires'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['codeExpires'],
            ),
      codeTries: jsonSerialization['codeTries'] as int?,
      status: jsonSerialization['status'] as String,
      dateOfBirth: jsonSerialization['dateOfBirth'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateOfBirth'],
            ),
      termsAcceptedAt: jsonSerialization['termsAcceptedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['termsAcceptedAt'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = IslandPayoutAccountTable();

  static const db = IslandPayoutAccountRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String bankCode;

  String bankName;

  String accountNumber;

  /// the bank's name for the account, as Flutterwave reports it
  String accountName;

  /// the name the player says is theirs
  String legalName;

  bool nameMatch;

  String email;

  bool emailVerified;

  String? emailCode;

  DateTime? codeExpires;

  int codeTries;

  /// unverified (waiting for the email code) | verified | review (the names don't match: a person checks)
  String status;

  /// for the age check (18 or older to withdraw)
  DateTime? dateOfBirth;

  /// when the player accepted the payout terms
  DateTime? termsAcceptedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IslandPayoutAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IslandPayoutAccount copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
    String? legalName,
    bool? nameMatch,
    String? email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    String? status,
    DateTime? dateOfBirth,
    DateTime? termsAcceptedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandPayoutAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'legalName': legalName,
      'nameMatch': nameMatch,
      'email': email,
      'emailVerified': emailVerified,
      if (emailCode != null) 'emailCode': emailCode,
      if (codeExpires != null) 'codeExpires': codeExpires?.toJson(),
      'codeTries': codeTries,
      'status': status,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      if (termsAcceptedAt != null) 'termsAcceptedAt': termsAcceptedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandPayoutAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'legalName': legalName,
      'nameMatch': nameMatch,
      'email': email,
      'emailVerified': emailVerified,
      if (emailCode != null) 'emailCode': emailCode,
      if (codeExpires != null) 'codeExpires': codeExpires?.toJson(),
      'codeTries': codeTries,
      'status': status,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      if (termsAcceptedAt != null) 'termsAcceptedAt': termsAcceptedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IslandPayoutAccountInclude include() {
    return IslandPayoutAccountInclude._();
  }

  static IslandPayoutAccountIncludeList includeList({
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    IslandPayoutAccountInclude? include,
  }) {
    return IslandPayoutAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandPayoutAccountImpl extends IslandPayoutAccount {
  _IslandPayoutAccountImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String legalName,
    required bool nameMatch,
    required String email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    required String status,
    DateTime? dateOfBirth,
    DateTime? termsAcceptedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         bankCode: bankCode,
         bankName: bankName,
         accountNumber: accountNumber,
         accountName: accountName,
         legalName: legalName,
         nameMatch: nameMatch,
         email: email,
         emailVerified: emailVerified,
         emailCode: emailCode,
         codeExpires: codeExpires,
         codeTries: codeTries,
         status: status,
         dateOfBirth: dateOfBirth,
         termsAcceptedAt: termsAcceptedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IslandPayoutAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IslandPayoutAccount copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
    String? legalName,
    bool? nameMatch,
    String? email,
    bool? emailVerified,
    Object? emailCode = _Undefined,
    Object? codeExpires = _Undefined,
    int? codeTries,
    String? status,
    Object? dateOfBirth = _Undefined,
    Object? termsAcceptedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IslandPayoutAccount(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      legalName: legalName ?? this.legalName,
      nameMatch: nameMatch ?? this.nameMatch,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      emailCode: emailCode is String? ? emailCode : this.emailCode,
      codeExpires: codeExpires is DateTime? ? codeExpires : this.codeExpires,
      codeTries: codeTries ?? this.codeTries,
      status: status ?? this.status,
      dateOfBirth: dateOfBirth is DateTime? ? dateOfBirth : this.dateOfBirth,
      termsAcceptedAt: termsAcceptedAt is DateTime?
          ? termsAcceptedAt
          : this.termsAcceptedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IslandPayoutAccountUpdateTable
    extends _is.UpdateTable<IslandPayoutAccountTable> {
  IslandPayoutAccountUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> bankCode(String value) => _is.ColumnValue(
    table.bankCode,
    value,
  );

  _is.ColumnValue<String, String> bankName(String value) => _is.ColumnValue(
    table.bankName,
    value,
  );

  _is.ColumnValue<String, String> accountNumber(String value) =>
      _is.ColumnValue(
        table.accountNumber,
        value,
      );

  _is.ColumnValue<String, String> accountName(String value) => _is.ColumnValue(
    table.accountName,
    value,
  );

  _is.ColumnValue<String, String> legalName(String value) => _is.ColumnValue(
    table.legalName,
    value,
  );

  _is.ColumnValue<bool, bool> nameMatch(bool value) => _is.ColumnValue(
    table.nameMatch,
    value,
  );

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<bool, bool> emailVerified(bool value) => _is.ColumnValue(
    table.emailVerified,
    value,
  );

  _is.ColumnValue<String, String> emailCode(String? value) => _is.ColumnValue(
    table.emailCode,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> codeExpires(DateTime? value) =>
      _is.ColumnValue(
        table.codeExpires,
        value,
      );

  _is.ColumnValue<int, int> codeTries(int value) => _is.ColumnValue(
    table.codeTries,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dateOfBirth(DateTime? value) =>
      _is.ColumnValue(
        table.dateOfBirth,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> termsAcceptedAt(DateTime? value) =>
      _is.ColumnValue(
        table.termsAcceptedAt,
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

class IslandPayoutAccountTable extends _is.Table<int?> {
  IslandPayoutAccountTable({super.tableRelation})
    : super(tableName: 'island_payout_account') {
    updateTable = IslandPayoutAccountUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    bankCode = _is.ColumnString(
      'bankCode',
      this,
    );
    bankName = _is.ColumnString(
      'bankName',
      this,
    );
    accountNumber = _is.ColumnString(
      'accountNumber',
      this,
    );
    accountName = _is.ColumnString(
      'accountName',
      this,
    );
    legalName = _is.ColumnString(
      'legalName',
      this,
    );
    nameMatch = _is.ColumnBool(
      'nameMatch',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    emailVerified = _is.ColumnBool(
      'emailVerified',
      this,
      hasDefault: true,
    );
    emailCode = _is.ColumnString(
      'emailCode',
      this,
    );
    codeExpires = _is.ColumnDateTime(
      'codeExpires',
      this,
    );
    codeTries = _is.ColumnInt(
      'codeTries',
      this,
      hasDefault: true,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    dateOfBirth = _is.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    termsAcceptedAt = _is.ColumnDateTime(
      'termsAcceptedAt',
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

  late final IslandPayoutAccountUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString bankCode;

  late final _is.ColumnString bankName;

  late final _is.ColumnString accountNumber;

  /// the bank's name for the account, as Flutterwave reports it
  late final _is.ColumnString accountName;

  /// the name the player says is theirs
  late final _is.ColumnString legalName;

  late final _is.ColumnBool nameMatch;

  late final _is.ColumnString email;

  late final _is.ColumnBool emailVerified;

  late final _is.ColumnString emailCode;

  late final _is.ColumnDateTime codeExpires;

  late final _is.ColumnInt codeTries;

  /// unverified (waiting for the email code) | verified | review (the names don't match: a person checks)
  late final _is.ColumnString status;

  /// for the age check (18 or older to withdraw)
  late final _is.ColumnDateTime dateOfBirth;

  /// when the player accepted the payout terms
  late final _is.ColumnDateTime termsAcceptedAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    bankCode,
    bankName,
    accountNumber,
    accountName,
    legalName,
    nameMatch,
    email,
    emailVerified,
    emailCode,
    codeExpires,
    codeTries,
    status,
    dateOfBirth,
    termsAcceptedAt,
    createdAt,
    updatedAt,
  ];
}

class IslandPayoutAccountInclude extends _is.IncludeObject {
  IslandPayoutAccountInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => IslandPayoutAccount.t;
}

class IslandPayoutAccountIncludeList extends _is.IncludeList {
  IslandPayoutAccountIncludeList._({
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IslandPayoutAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IslandPayoutAccount.t;
}

class IslandPayoutAccountRepository {
  const IslandPayoutAccountRepository._();

  /// Returns a list of [IslandPayoutAccount]s matching the given query parameters.
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
  Future<List<IslandPayoutAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IslandPayoutAccount>(
      where: where?.call(IslandPayoutAccount.t),
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IslandPayoutAccount] matching the given query parameters.
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
  Future<IslandPayoutAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IslandPayoutAccount>(
      where: where?.call(IslandPayoutAccount.t),
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IslandPayoutAccount] by its [id] or null if no such row exists.
  Future<IslandPayoutAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IslandPayoutAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IslandPayoutAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [IslandPayoutAccount]s will have their `id` fields set.
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
  Future<List<IslandPayoutAccount>> insert(
    _is.DatabaseSession session,
    List<IslandPayoutAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IslandPayoutAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IslandPayoutAccount] and returns the inserted row.
  ///
  /// The returned [IslandPayoutAccount] will have its `id` field set.
  Future<IslandPayoutAccount> insertRow(
    _is.DatabaseSession session,
    IslandPayoutAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IslandPayoutAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IslandPayoutAccount]s in the list and returns the resulting rows.
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
  /// The returned [IslandPayoutAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPayoutAccount>> upsert(
    _is.DatabaseSession session,
    List<IslandPayoutAccount> rows, {
    required _is.ColumnSelections<IslandPayoutAccountTable> conflictColumns,
    _is.ColumnSelections<IslandPayoutAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IslandPayoutAccount>(
      rows,
      conflictColumns: conflictColumns(IslandPayoutAccount.t),
      updateColumns: updateColumns?.call(IslandPayoutAccount.t),
      updateWhere: updateWhere?.call(IslandPayoutAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IslandPayoutAccount] and returns the resulting row.
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
  /// The returned [IslandPayoutAccount] will have its `id` field set.
  Future<IslandPayoutAccount?> upsertRow(
    _is.DatabaseSession session,
    IslandPayoutAccount row, {
    required _is.ColumnSelections<IslandPayoutAccountTable> conflictColumns,
    _is.ColumnSelections<IslandPayoutAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IslandPayoutAccount>(
      row,
      conflictColumns: conflictColumns(IslandPayoutAccount.t),
      updateColumns: updateColumns?.call(IslandPayoutAccount.t),
      updateWhere: updateWhere?.call(IslandPayoutAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [IslandPayoutAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPayoutAccount>> update(
    _is.DatabaseSession session,
    List<IslandPayoutAccount> rows, {
    _is.ColumnSelections<IslandPayoutAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IslandPayoutAccount>(
      rows,
      columns: columns?.call(IslandPayoutAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IslandPayoutAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IslandPayoutAccount> updateRow(
    _is.DatabaseSession session,
    IslandPayoutAccount row, {
    _is.ColumnSelections<IslandPayoutAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IslandPayoutAccount>(
      row,
      columns: columns?.call(IslandPayoutAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IslandPayoutAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IslandPayoutAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IslandPayoutAccountUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IslandPayoutAccount>(
      id,
      columnValues: columnValues(IslandPayoutAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IslandPayoutAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IslandPayoutAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IslandPayoutAccountUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<IslandPayoutAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IslandPayoutAccount>(
      columnValues: columnValues(IslandPayoutAccount.t.updateTable),
      where: where(IslandPayoutAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IslandPayoutAccount]s in the list and returns the deleted rows.
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
  Future<List<IslandPayoutAccount>> delete(
    _is.DatabaseSession session,
    List<IslandPayoutAccount> rows, {
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IslandPayoutAccount>(
      rows,
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IslandPayoutAccount].
  Future<IslandPayoutAccount> deleteRow(
    _is.DatabaseSession session,
    IslandPayoutAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IslandPayoutAccount>(
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
  Future<List<IslandPayoutAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandPayoutAccountTable> where,
    _is.OrderByBuilder<IslandPayoutAccountTable>? orderBy,
    _is.OrderByListBuilder<IslandPayoutAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IslandPayoutAccount>(
      where: where(IslandPayoutAccount.t),
      orderBy: orderBy?.call(IslandPayoutAccount.t),
      orderByList: orderByList?.call(IslandPayoutAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IslandPayoutAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IslandPayoutAccount>(
      where: where?.call(IslandPayoutAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IslandPayoutAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IslandPayoutAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IslandPayoutAccount>(
      where: where(IslandPayoutAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
