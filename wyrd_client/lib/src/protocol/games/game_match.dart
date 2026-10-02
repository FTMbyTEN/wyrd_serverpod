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
import 'package:wyrd_client/src/protocol/protocol.dart' as _i2pladzn;

/// A game: against WYRD, or (mode pvp) against another player. The server holds the position and
/// checks every move, so a result can be trusted and a rating means something.
abstract class GameMatch
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GameMatch._({
    this.id,
    required this.authUserId,
    required this.game,
    required this.state,
    required this.moves,
    required this.playerSide,
    required this.status,
    required this.wyrdLevel,
    required this.ratingBefore,
    this.ratingAfter,
    this.remark,
    String? mode,
    this.opponentId,
    this.playerName,
    this.opponentName,
    this.result,
    int? version,
    this.viewerSide,
    required this.createdAt,
    required this.updatedAt,
  }) : mode = mode ?? 'wyrd',
       version = version ?? 0;

  factory GameMatch({
    int? id,
    required _isc.UuidValue authUserId,
    required String game,
    required String state,
    required List<String> moves,
    required String playerSide,
    required String status,
    required int wyrdLevel,
    required double ratingBefore,
    double? ratingAfter,
    String? remark,
    String? mode,
    _isc.UuidValue? opponentId,
    String? playerName,
    String? opponentName,
    String? result,
    int? version,
    String? viewerSide,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GameMatchImpl;

  factory GameMatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return GameMatch(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      game: jsonSerialization['game'] as String,
      state: jsonSerialization['state'] as String,
      moves: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['moves'],
      ),
      playerSide: jsonSerialization['playerSide'] as String,
      status: jsonSerialization['status'] as String,
      wyrdLevel: jsonSerialization['wyrdLevel'] as int,
      ratingBefore: (jsonSerialization['ratingBefore'] as num).toDouble(),
      ratingAfter: (jsonSerialization['ratingAfter'] as num?)?.toDouble(),
      remark: jsonSerialization['remark'] as String?,
      mode: jsonSerialization['mode'] as String?,
      opponentId: jsonSerialization['opponentId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['opponentId'],
            ),
      playerName: jsonSerialization['playerName'] as String?,
      opponentName: jsonSerialization['opponentName'] as String?,
      result: jsonSerialization['result'] as String?,
      version: jsonSerialization['version'] as int?,
      viewerSide: jsonSerialization['viewerSide'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
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

  String game;

  String state;

  List<String> moves;

  String playerSide;

  String status;

  int wyrdLevel;

  double ratingBefore;

  double? ratingAfter;

  String? remark;

  String mode;

  _isc.UuidValue? opponentId;

  String? playerName;

  String? opponentName;

  String? result;

  int version;

  String? viewerSide;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [GameMatch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GameMatch copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? game,
    String? state,
    List<String>? moves,
    String? playerSide,
    String? status,
    int? wyrdLevel,
    double? ratingBefore,
    double? ratingAfter,
    String? remark,
    String? mode,
    _isc.UuidValue? opponentId,
    String? playerName,
    String? opponentName,
    String? result,
    int? version,
    String? viewerSide,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GameMatch',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'state': state,
      'moves': moves.toJson(),
      'playerSide': playerSide,
      'status': status,
      'wyrdLevel': wyrdLevel,
      'ratingBefore': ratingBefore,
      if (ratingAfter != null) 'ratingAfter': ratingAfter,
      if (remark != null) 'remark': remark,
      'mode': mode,
      if (opponentId != null) 'opponentId': opponentId?.toJson(),
      if (playerName != null) 'playerName': playerName,
      if (opponentName != null) 'opponentName': opponentName,
      if (result != null) 'result': result,
      'version': version,
      if (viewerSide != null) 'viewerSide': viewerSide,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GameMatch',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'game': game,
      'state': state,
      'moves': moves.toJson(),
      'playerSide': playerSide,
      'status': status,
      'wyrdLevel': wyrdLevel,
      'ratingBefore': ratingBefore,
      if (ratingAfter != null) 'ratingAfter': ratingAfter,
      if (remark != null) 'remark': remark,
      'mode': mode,
      if (opponentId != null) 'opponentId': opponentId?.toJson(),
      if (playerName != null) 'playerName': playerName,
      if (opponentName != null) 'opponentName': opponentName,
      if (result != null) 'result': result,
      'version': version,
      if (viewerSide != null) 'viewerSide': viewerSide,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GameMatchImpl extends GameMatch {
  _GameMatchImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String game,
    required String state,
    required List<String> moves,
    required String playerSide,
    required String status,
    required int wyrdLevel,
    required double ratingBefore,
    double? ratingAfter,
    String? remark,
    String? mode,
    _isc.UuidValue? opponentId,
    String? playerName,
    String? opponentName,
    String? result,
    int? version,
    String? viewerSide,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         game: game,
         state: state,
         moves: moves,
         playerSide: playerSide,
         status: status,
         wyrdLevel: wyrdLevel,
         ratingBefore: ratingBefore,
         ratingAfter: ratingAfter,
         remark: remark,
         mode: mode,
         opponentId: opponentId,
         playerName: playerName,
         opponentName: opponentName,
         result: result,
         version: version,
         viewerSide: viewerSide,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GameMatch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GameMatch copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? game,
    String? state,
    List<String>? moves,
    String? playerSide,
    String? status,
    int? wyrdLevel,
    double? ratingBefore,
    Object? ratingAfter = _Undefined,
    Object? remark = _Undefined,
    String? mode,
    Object? opponentId = _Undefined,
    Object? playerName = _Undefined,
    Object? opponentName = _Undefined,
    Object? result = _Undefined,
    int? version,
    Object? viewerSide = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GameMatch(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      game: game ?? this.game,
      state: state ?? this.state,
      moves: moves ?? this.moves.map((e0) => e0).toList(),
      playerSide: playerSide ?? this.playerSide,
      status: status ?? this.status,
      wyrdLevel: wyrdLevel ?? this.wyrdLevel,
      ratingBefore: ratingBefore ?? this.ratingBefore,
      ratingAfter: ratingAfter is double? ? ratingAfter : this.ratingAfter,
      remark: remark is String? ? remark : this.remark,
      mode: mode ?? this.mode,
      opponentId: opponentId is _isc.UuidValue? ? opponentId : this.opponentId,
      playerName: playerName is String? ? playerName : this.playerName,
      opponentName: opponentName is String? ? opponentName : this.opponentName,
      result: result is String? ? result : this.result,
      version: version ?? this.version,
      viewerSide: viewerSide is String? ? viewerSide : this.viewerSide,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
