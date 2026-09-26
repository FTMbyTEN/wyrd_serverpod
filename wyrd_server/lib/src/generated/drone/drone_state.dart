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

abstract class DroneState
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DroneState._({
    this.id,
    required this.droneId,
    required this.connected,
    required this.armed,
    this.mode,
    this.lat,
    this.lon,
    this.relativeAltM,
    this.headingDeg,
    this.groundSpeedMs,
    this.batteryPct,
    this.gpsFix,
    this.satellites,
    this.homeLat,
    this.homeLon,
    this.missionStatus,
    this.missionStep,
    this.missionError,
    required this.updatedAt,
  });

  factory DroneState({
    int? id,
    required String droneId,
    required bool connected,
    required bool armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    required DateTime updatedAt,
  }) = _DroneStateImpl;

  factory DroneState.fromJson(Map<String, dynamic> jsonSerialization) {
    return DroneState(
      id: jsonSerialization['id'] as int?,
      droneId: jsonSerialization['droneId'] as String,
      connected: _is.BoolJsonExtension.fromJson(jsonSerialization['connected']),
      armed: _is.BoolJsonExtension.fromJson(jsonSerialization['armed']),
      mode: jsonSerialization['mode'] as String?,
      lat: (jsonSerialization['lat'] as num?)?.toDouble(),
      lon: (jsonSerialization['lon'] as num?)?.toDouble(),
      relativeAltM: (jsonSerialization['relativeAltM'] as num?)?.toDouble(),
      headingDeg: (jsonSerialization['headingDeg'] as num?)?.toDouble(),
      groundSpeedMs: (jsonSerialization['groundSpeedMs'] as num?)?.toDouble(),
      batteryPct: jsonSerialization['batteryPct'] as int?,
      gpsFix: jsonSerialization['gpsFix'] as int?,
      satellites: jsonSerialization['satellites'] as int?,
      homeLat: (jsonSerialization['homeLat'] as num?)?.toDouble(),
      homeLon: (jsonSerialization['homeLon'] as num?)?.toDouble(),
      missionStatus: jsonSerialization['missionStatus'] as String?,
      missionStep: jsonSerialization['missionStep'] as int?,
      missionError: jsonSerialization['missionError'] as String?,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DroneStateTable();

  static const db = DroneStateRepository._();

  @override
  int? id;

  String droneId;

  bool connected;

  bool armed;

  String? mode;

  double? lat;

  double? lon;

  double? relativeAltM;

  double? headingDeg;

  double? groundSpeedMs;

  int? batteryPct;

  int? gpsFix;

  int? satellites;

  double? homeLat;

  double? homeLon;

  String? missionStatus;

  int? missionStep;

  String? missionError;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DroneState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DroneState copyWith({
    int? id,
    String? droneId,
    bool? connected,
    bool? armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DroneState',
      if (id != null) 'id': id,
      'droneId': droneId,
      'connected': connected,
      'armed': armed,
      if (mode != null) 'mode': mode,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (relativeAltM != null) 'relativeAltM': relativeAltM,
      if (headingDeg != null) 'headingDeg': headingDeg,
      if (groundSpeedMs != null) 'groundSpeedMs': groundSpeedMs,
      if (batteryPct != null) 'batteryPct': batteryPct,
      if (gpsFix != null) 'gpsFix': gpsFix,
      if (satellites != null) 'satellites': satellites,
      if (homeLat != null) 'homeLat': homeLat,
      if (homeLon != null) 'homeLon': homeLon,
      if (missionStatus != null) 'missionStatus': missionStatus,
      if (missionStep != null) 'missionStep': missionStep,
      if (missionError != null) 'missionError': missionError,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DroneState',
      if (id != null) 'id': id,
      'droneId': droneId,
      'connected': connected,
      'armed': armed,
      if (mode != null) 'mode': mode,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (relativeAltM != null) 'relativeAltM': relativeAltM,
      if (headingDeg != null) 'headingDeg': headingDeg,
      if (groundSpeedMs != null) 'groundSpeedMs': groundSpeedMs,
      if (batteryPct != null) 'batteryPct': batteryPct,
      if (gpsFix != null) 'gpsFix': gpsFix,
      if (satellites != null) 'satellites': satellites,
      if (homeLat != null) 'homeLat': homeLat,
      if (homeLon != null) 'homeLon': homeLon,
      if (missionStatus != null) 'missionStatus': missionStatus,
      if (missionStep != null) 'missionStep': missionStep,
      if (missionError != null) 'missionError': missionError,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DroneStateInclude include() {
    return DroneStateInclude._();
  }

  static DroneStateIncludeList includeList({
    _is.WhereExpressionBuilder<DroneStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    DroneStateInclude? include,
  }) {
    return DroneStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DroneStateImpl extends DroneState {
  _DroneStateImpl({
    int? id,
    required String droneId,
    required bool connected,
    required bool armed,
    String? mode,
    double? lat,
    double? lon,
    double? relativeAltM,
    double? headingDeg,
    double? groundSpeedMs,
    int? batteryPct,
    int? gpsFix,
    int? satellites,
    double? homeLat,
    double? homeLon,
    String? missionStatus,
    int? missionStep,
    String? missionError,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         droneId: droneId,
         connected: connected,
         armed: armed,
         mode: mode,
         lat: lat,
         lon: lon,
         relativeAltM: relativeAltM,
         headingDeg: headingDeg,
         groundSpeedMs: groundSpeedMs,
         batteryPct: batteryPct,
         gpsFix: gpsFix,
         satellites: satellites,
         homeLat: homeLat,
         homeLon: homeLon,
         missionStatus: missionStatus,
         missionStep: missionStep,
         missionError: missionError,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DroneState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DroneState copyWith({
    Object? id = _Undefined,
    String? droneId,
    bool? connected,
    bool? armed,
    Object? mode = _Undefined,
    Object? lat = _Undefined,
    Object? lon = _Undefined,
    Object? relativeAltM = _Undefined,
    Object? headingDeg = _Undefined,
    Object? groundSpeedMs = _Undefined,
    Object? batteryPct = _Undefined,
    Object? gpsFix = _Undefined,
    Object? satellites = _Undefined,
    Object? homeLat = _Undefined,
    Object? homeLon = _Undefined,
    Object? missionStatus = _Undefined,
    Object? missionStep = _Undefined,
    Object? missionError = _Undefined,
    DateTime? updatedAt,
  }) {
    return DroneState(
      id: id is int? ? id : this.id,
      droneId: droneId ?? this.droneId,
      connected: connected ?? this.connected,
      armed: armed ?? this.armed,
      mode: mode is String? ? mode : this.mode,
      lat: lat is double? ? lat : this.lat,
      lon: lon is double? ? lon : this.lon,
      relativeAltM: relativeAltM is double? ? relativeAltM : this.relativeAltM,
      headingDeg: headingDeg is double? ? headingDeg : this.headingDeg,
      groundSpeedMs: groundSpeedMs is double?
          ? groundSpeedMs
          : this.groundSpeedMs,
      batteryPct: batteryPct is int? ? batteryPct : this.batteryPct,
      gpsFix: gpsFix is int? ? gpsFix : this.gpsFix,
      satellites: satellites is int? ? satellites : this.satellites,
      homeLat: homeLat is double? ? homeLat : this.homeLat,
      homeLon: homeLon is double? ? homeLon : this.homeLon,
      missionStatus: missionStatus is String?
          ? missionStatus
          : this.missionStatus,
      missionStep: missionStep is int? ? missionStep : this.missionStep,
      missionError: missionError is String? ? missionError : this.missionError,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DroneStateUpdateTable extends _is.UpdateTable<DroneStateTable> {
  DroneStateUpdateTable(super.table);

  _is.ColumnValue<String, String> droneId(String value) => _is.ColumnValue(
    table.droneId,
    value,
  );

  _is.ColumnValue<bool, bool> connected(bool value) => _is.ColumnValue(
    table.connected,
    value,
  );

  _is.ColumnValue<bool, bool> armed(bool value) => _is.ColumnValue(
    table.armed,
    value,
  );

  _is.ColumnValue<String, String> mode(String? value) => _is.ColumnValue(
    table.mode,
    value,
  );

  _is.ColumnValue<double, double> lat(double? value) => _is.ColumnValue(
    table.lat,
    value,
  );

  _is.ColumnValue<double, double> lon(double? value) => _is.ColumnValue(
    table.lon,
    value,
  );

  _is.ColumnValue<double, double> relativeAltM(double? value) =>
      _is.ColumnValue(
        table.relativeAltM,
        value,
      );

  _is.ColumnValue<double, double> headingDeg(double? value) => _is.ColumnValue(
    table.headingDeg,
    value,
  );

  _is.ColumnValue<double, double> groundSpeedMs(double? value) =>
      _is.ColumnValue(
        table.groundSpeedMs,
        value,
      );

  _is.ColumnValue<int, int> batteryPct(int? value) => _is.ColumnValue(
    table.batteryPct,
    value,
  );

  _is.ColumnValue<int, int> gpsFix(int? value) => _is.ColumnValue(
    table.gpsFix,
    value,
  );

  _is.ColumnValue<int, int> satellites(int? value) => _is.ColumnValue(
    table.satellites,
    value,
  );

  _is.ColumnValue<double, double> homeLat(double? value) => _is.ColumnValue(
    table.homeLat,
    value,
  );

  _is.ColumnValue<double, double> homeLon(double? value) => _is.ColumnValue(
    table.homeLon,
    value,
  );

  _is.ColumnValue<String, String> missionStatus(String? value) =>
      _is.ColumnValue(
        table.missionStatus,
        value,
      );

  _is.ColumnValue<int, int> missionStep(int? value) => _is.ColumnValue(
    table.missionStep,
    value,
  );

  _is.ColumnValue<String, String> missionError(String? value) =>
      _is.ColumnValue(
        table.missionError,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DroneStateTable extends _is.Table<int?> {
  DroneStateTable({super.tableRelation}) : super(tableName: 'drone_state') {
    updateTable = DroneStateUpdateTable(this);
    droneId = _is.ColumnString(
      'droneId',
      this,
    );
    connected = _is.ColumnBool(
      'connected',
      this,
    );
    armed = _is.ColumnBool(
      'armed',
      this,
    );
    mode = _is.ColumnString(
      'mode',
      this,
    );
    lat = _is.ColumnDouble(
      'lat',
      this,
    );
    lon = _is.ColumnDouble(
      'lon',
      this,
    );
    relativeAltM = _is.ColumnDouble(
      'relativeAltM',
      this,
    );
    headingDeg = _is.ColumnDouble(
      'headingDeg',
      this,
    );
    groundSpeedMs = _is.ColumnDouble(
      'groundSpeedMs',
      this,
    );
    batteryPct = _is.ColumnInt(
      'batteryPct',
      this,
    );
    gpsFix = _is.ColumnInt(
      'gpsFix',
      this,
    );
    satellites = _is.ColumnInt(
      'satellites',
      this,
    );
    homeLat = _is.ColumnDouble(
      'homeLat',
      this,
    );
    homeLon = _is.ColumnDouble(
      'homeLon',
      this,
    );
    missionStatus = _is.ColumnString(
      'missionStatus',
      this,
    );
    missionStep = _is.ColumnInt(
      'missionStep',
      this,
    );
    missionError = _is.ColumnString(
      'missionError',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final DroneStateUpdateTable updateTable;

  late final _is.ColumnString droneId;

  late final _is.ColumnBool connected;

  late final _is.ColumnBool armed;

  late final _is.ColumnString mode;

  late final _is.ColumnDouble lat;

  late final _is.ColumnDouble lon;

  late final _is.ColumnDouble relativeAltM;

  late final _is.ColumnDouble headingDeg;

  late final _is.ColumnDouble groundSpeedMs;

  late final _is.ColumnInt batteryPct;

  late final _is.ColumnInt gpsFix;

  late final _is.ColumnInt satellites;

  late final _is.ColumnDouble homeLat;

  late final _is.ColumnDouble homeLon;

  late final _is.ColumnString missionStatus;

  late final _is.ColumnInt missionStep;

  late final _is.ColumnString missionError;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    droneId,
    connected,
    armed,
    mode,
    lat,
    lon,
    relativeAltM,
    headingDeg,
    groundSpeedMs,
    batteryPct,
    gpsFix,
    satellites,
    homeLat,
    homeLon,
    missionStatus,
    missionStep,
    missionError,
    updatedAt,
  ];
}

class DroneStateInclude extends _is.IncludeObject {
  DroneStateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DroneState.t;
}

class DroneStateIncludeList extends _is.IncludeList {
  DroneStateIncludeList._({
    _is.WhereExpressionBuilder<DroneStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DroneState.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DroneState.t;
}

class DroneStateRepository {
  const DroneStateRepository._();

  /// Returns a list of [DroneState]s matching the given query parameters.
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
  Future<List<DroneState>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DroneState>(
      where: where?.call(DroneState.t),
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DroneState] matching the given query parameters.
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
  Future<DroneState?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneStateTable>? where,
    int? offset,
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DroneState>(
      where: where?.call(DroneState.t),
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DroneState] by its [id] or null if no such row exists.
  Future<DroneState?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DroneState>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DroneState]s in the list and returns the inserted rows.
  ///
  /// The returned [DroneState]s will have their `id` fields set.
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
  Future<List<DroneState>> insert(
    _is.DatabaseSession session,
    List<DroneState> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DroneState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DroneState] and returns the inserted row.
  ///
  /// The returned [DroneState] will have its `id` field set.
  Future<DroneState> insertRow(
    _is.DatabaseSession session,
    DroneState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DroneState>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DroneState]s in the list and returns the resulting rows.
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
  /// The returned [DroneState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneState>> upsert(
    _is.DatabaseSession session,
    List<DroneState> rows, {
    required _is.ColumnSelections<DroneStateTable> conflictColumns,
    _is.ColumnSelections<DroneStateTable>? updateColumns,
    _is.WhereExpressionBuilder<DroneStateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DroneState>(
      rows,
      conflictColumns: conflictColumns(DroneState.t),
      updateColumns: updateColumns?.call(DroneState.t),
      updateWhere: updateWhere?.call(DroneState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DroneState] and returns the resulting row.
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
  /// The returned [DroneState] will have its `id` field set.
  Future<DroneState?> upsertRow(
    _is.DatabaseSession session,
    DroneState row, {
    required _is.ColumnSelections<DroneStateTable> conflictColumns,
    _is.ColumnSelections<DroneStateTable>? updateColumns,
    _is.WhereExpressionBuilder<DroneStateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DroneState>(
      row,
      conflictColumns: conflictColumns(DroneState.t),
      updateColumns: updateColumns?.call(DroneState.t),
      updateWhere: updateWhere?.call(DroneState.t),
      transaction: transaction,
    );
  }

  /// Updates all [DroneState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneState>> update(
    _is.DatabaseSession session,
    List<DroneState> rows, {
    _is.ColumnSelections<DroneStateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DroneState>(
      rows,
      columns: columns?.call(DroneState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DroneState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DroneState> updateRow(
    _is.DatabaseSession session,
    DroneState row, {
    _is.ColumnSelections<DroneStateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DroneState>(
      row,
      columns: columns?.call(DroneState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DroneState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DroneState?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DroneStateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DroneState>(
      id,
      columnValues: columnValues(DroneState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DroneState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DroneState>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DroneStateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DroneStateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DroneState>(
      columnValues: columnValues(DroneState.t.updateTable),
      where: where(DroneState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DroneState]s in the list and returns the deleted rows.
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
  Future<List<DroneState>> delete(
    _is.DatabaseSession session,
    List<DroneState> rows, {
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DroneState>(
      rows,
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DroneState].
  Future<DroneState> deleteRow(
    _is.DatabaseSession session,
    DroneState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DroneState>(
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
  Future<List<DroneState>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DroneStateTable> where,
    _is.OrderByBuilder<DroneStateTable>? orderBy,
    _is.OrderByListBuilder<DroneStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DroneState>(
      where: where(DroneState.t),
      orderBy: orderBy?.call(DroneState.t),
      orderByList: orderByList?.call(DroneState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DroneStateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DroneState>(
      where: where?.call(DroneState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DroneState] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DroneStateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DroneState>(
      where: where(DroneState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
