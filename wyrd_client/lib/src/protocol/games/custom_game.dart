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

/// A game WYRD programmed for someone at their request (build_game, written in the background):
/// one self-contained HTML document, played full screen in a sandboxed frame from their Games tab.
abstract class CustomGame
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomGame._({
    this.id,
    required this.authUserId,
    required this.title,
    required this.blurb,
    required this.html,
    this.status,
    this.wyrdBest,
    this.wyrdRounds,
    this.wyrdParams,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomGame({
    int? id,
    required _isc.UuidValue authUserId,
    required String title,
    required String blurb,
    required String html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CustomGameImpl;

  factory CustomGame.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomGame(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String,
      blurb: jsonSerialization['blurb'] as String,
      html: jsonSerialization['html'] as String,
      status: jsonSerialization['status'] as String?,
      wyrdBest: jsonSerialization['wyrdBest'] as int?,
      wyrdRounds: jsonSerialization['wyrdRounds'] as int?,
      wyrdParams: jsonSerialization['wyrdParams'] as String?,
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

  String title;

  String blurb;

  String html;

  String? status;

  int? wyrdBest;

  int? wyrdRounds;

  String? wyrdParams;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CustomGame]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomGame copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? title,
    String? blurb,
    String? html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomGame',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'blurb': blurb,
      'html': html,
      if (status != null) 'status': status,
      if (wyrdBest != null) 'wyrdBest': wyrdBest,
      if (wyrdRounds != null) 'wyrdRounds': wyrdRounds,
      if (wyrdParams != null) 'wyrdParams': wyrdParams,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomGame',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'blurb': blurb,
      'html': html,
      if (status != null) 'status': status,
      if (wyrdBest != null) 'wyrdBest': wyrdBest,
      if (wyrdRounds != null) 'wyrdRounds': wyrdRounds,
      if (wyrdParams != null) 'wyrdParams': wyrdParams,
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

class _CustomGameImpl extends CustomGame {
  _CustomGameImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String title,
    required String blurb,
    required String html,
    String? status,
    int? wyrdBest,
    int? wyrdRounds,
    String? wyrdParams,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         title: title,
         blurb: blurb,
         html: html,
         status: status,
         wyrdBest: wyrdBest,
         wyrdRounds: wyrdRounds,
         wyrdParams: wyrdParams,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CustomGame]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomGame copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? title,
    String? blurb,
    String? html,
    Object? status = _Undefined,
    Object? wyrdBest = _Undefined,
    Object? wyrdRounds = _Undefined,
    Object? wyrdParams = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomGame(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      title: title ?? this.title,
      blurb: blurb ?? this.blurb,
      html: html ?? this.html,
      status: status is String? ? status : this.status,
      wyrdBest: wyrdBest is int? ? wyrdBest : this.wyrdBest,
      wyrdRounds: wyrdRounds is int? ? wyrdRounds : this.wyrdRounds,
      wyrdParams: wyrdParams is String? ? wyrdParams : this.wyrdParams,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
