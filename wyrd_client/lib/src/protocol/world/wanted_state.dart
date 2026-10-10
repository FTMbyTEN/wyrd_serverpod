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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Where a player stands with the police, held by the server (Fair Streets): their heat (stars are its whole part),
/// the wanted state machine's state and its timers, the Calm streets setting, and when they last made each call.
abstract class WantedState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WantedState._({
    this.id,
    required this.authUserId,
    double? heat,
    String? state,
    required this.stateAt,
    this.pursuitAt,
    this.lastPursuitAt,
    this.lastStopAt,
    this.lostSince,
    this.complyingSince,
    this.nearSince,
    this.searchUntil,
    bool? calm,
    this.calls,
    required this.updatedAt,
  }) : heat = heat ?? 0.0,
       state = state ?? 'clear',
       calm = calm ?? false;

  factory WantedState({
    int? id,
    required _isc.UuidValue authUserId,
    double? heat,
    String? state,
    required DateTime stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    required DateTime updatedAt,
  }) = _WantedStateImpl;

  factory WantedState.fromJson(Map<String, dynamic> jsonSerialization) {
    return WantedState(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      heat: (jsonSerialization['heat'] as num?)?.toDouble(),
      state: jsonSerialization['state'] as String?,
      stateAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['stateAt'],
      ),
      pursuitAt: jsonSerialization['pursuitAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['pursuitAt']),
      lastPursuitAt: jsonSerialization['lastPursuitAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastPursuitAt'],
            ),
      lastStopAt: jsonSerialization['lastStopAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStopAt'],
            ),
      lostSince: jsonSerialization['lostSince'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['lostSince']),
      complyingSince: jsonSerialization['complyingSince'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['complyingSince'],
            ),
      nearSince: jsonSerialization['nearSince'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['nearSince']),
      searchUntil: jsonSerialization['searchUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['searchUntil'],
            ),
      calm: jsonSerialization['calm'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['calm']),
      calls: jsonSerialization['calls'] as String?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  double heat;

  /// clear | watched | pursuit | complying | searching | cooling
  String state;

  DateTime stateAt;

  DateTime? pursuitAt;

  DateTime? lastPursuitAt;

  DateTime? lastStopAt;

  DateTime? lostSince;

  DateTime? complyingSince;

  DateTime? nearSince;

  DateTime? searchUntil;

  /// pursuits become posted citations
  bool calm;

  /// when each contact was last called, JSON {id: iso}
  String? calls;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WantedState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WantedState copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    double? heat,
    String? state,
    DateTime? stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WantedState',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'heat': heat,
      'state': state,
      'stateAt': stateAt.toJson(),
      if (pursuitAt != null) 'pursuitAt': pursuitAt?.toJson(),
      if (lastPursuitAt != null) 'lastPursuitAt': lastPursuitAt?.toJson(),
      if (lastStopAt != null) 'lastStopAt': lastStopAt?.toJson(),
      if (lostSince != null) 'lostSince': lostSince?.toJson(),
      if (complyingSince != null) 'complyingSince': complyingSince?.toJson(),
      if (nearSince != null) 'nearSince': nearSince?.toJson(),
      if (searchUntil != null) 'searchUntil': searchUntil?.toJson(),
      'calm': calm,
      if (calls != null) 'calls': calls,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WantedState',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'heat': heat,
      'state': state,
      'stateAt': stateAt.toJson(),
      if (pursuitAt != null) 'pursuitAt': pursuitAt?.toJson(),
      if (lastPursuitAt != null) 'lastPursuitAt': lastPursuitAt?.toJson(),
      if (lastStopAt != null) 'lastStopAt': lastStopAt?.toJson(),
      if (lostSince != null) 'lostSince': lostSince?.toJson(),
      if (complyingSince != null) 'complyingSince': complyingSince?.toJson(),
      if (nearSince != null) 'nearSince': nearSince?.toJson(),
      if (searchUntil != null) 'searchUntil': searchUntil?.toJson(),
      'calm': calm,
      if (calls != null) 'calls': calls,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WantedStateImpl extends WantedState {
  _WantedStateImpl({
    int? id,
    required _isc.UuidValue authUserId,
    double? heat,
    String? state,
    required DateTime stateAt,
    DateTime? pursuitAt,
    DateTime? lastPursuitAt,
    DateTime? lastStopAt,
    DateTime? lostSince,
    DateTime? complyingSince,
    DateTime? nearSince,
    DateTime? searchUntil,
    bool? calm,
    String? calls,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         heat: heat,
         state: state,
         stateAt: stateAt,
         pursuitAt: pursuitAt,
         lastPursuitAt: lastPursuitAt,
         lastStopAt: lastStopAt,
         lostSince: lostSince,
         complyingSince: complyingSince,
         nearSince: nearSince,
         searchUntil: searchUntil,
         calm: calm,
         calls: calls,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WantedState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WantedState copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    double? heat,
    String? state,
    DateTime? stateAt,
    Object? pursuitAt = _Undefined,
    Object? lastPursuitAt = _Undefined,
    Object? lastStopAt = _Undefined,
    Object? lostSince = _Undefined,
    Object? complyingSince = _Undefined,
    Object? nearSince = _Undefined,
    Object? searchUntil = _Undefined,
    bool? calm,
    Object? calls = _Undefined,
    DateTime? updatedAt,
  }) {
    return WantedState(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      heat: heat ?? this.heat,
      state: state ?? this.state,
      stateAt: stateAt ?? this.stateAt,
      pursuitAt: pursuitAt is DateTime? ? pursuitAt : this.pursuitAt,
      lastPursuitAt: lastPursuitAt is DateTime?
          ? lastPursuitAt
          : this.lastPursuitAt,
      lastStopAt: lastStopAt is DateTime? ? lastStopAt : this.lastStopAt,
      lostSince: lostSince is DateTime? ? lostSince : this.lostSince,
      complyingSince: complyingSince is DateTime?
          ? complyingSince
          : this.complyingSince,
      nearSince: nearSince is DateTime? ? nearSince : this.nearSince,
      searchUntil: searchUntil is DateTime? ? searchUntil : this.searchUntil,
      calm: calm ?? this.calm,
      calls: calls is String? ? calls : this.calls,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
