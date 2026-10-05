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

/// WYRD's own charter for its open-world Lagos, written by WYRD: how it means to deal with players,
/// and the board of missions it has written for them. Rewritten about once a week.
abstract class CityCharter
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CityCharter._({
    this.id,
    required this.charter,
    required this.missions,
    required this.author,
    required this.writtenAt,
  });

  factory CityCharter({
    int? id,
    required String charter,
    required String missions,
    required String author,
    required DateTime writtenAt,
  }) = _CityCharterImpl;

  factory CityCharter.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityCharter(
      id: jsonSerialization['id'] as int?,
      charter: jsonSerialization['charter'] as String,
      missions: jsonSerialization['missions'] as String,
      author: jsonSerialization['author'] as String,
      writtenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['writtenAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// how WYRD, as the Authority, wishes to interact with players (its words)
  String charter;

  /// the mission board, as JSON: [{id, kind, title, brief, street, reward, minStanding}]
  String missions;

  /// 'wyrd' when WYRD wrote it, 'seed' for the starting board
  String author;

  DateTime writtenAt;

  /// Returns a shallow copy of this [CityCharter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CityCharter copyWith({
    int? id,
    String? charter,
    String? missions,
    String? author,
    DateTime? writtenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityCharter',
      if (id != null) 'id': id,
      'charter': charter,
      'missions': missions,
      'author': author,
      'writtenAt': writtenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CityCharter',
      if (id != null) 'id': id,
      'charter': charter,
      'missions': missions,
      'author': author,
      'writtenAt': writtenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityCharterImpl extends CityCharter {
  _CityCharterImpl({
    int? id,
    required String charter,
    required String missions,
    required String author,
    required DateTime writtenAt,
  }) : super._(
         id: id,
         charter: charter,
         missions: missions,
         author: author,
         writtenAt: writtenAt,
       );

  /// Returns a shallow copy of this [CityCharter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CityCharter copyWith({
    Object? id = _Undefined,
    String? charter,
    String? missions,
    String? author,
    DateTime? writtenAt,
  }) {
    return CityCharter(
      id: id is int? ? id : this.id,
      charter: charter ?? this.charter,
      missions: missions ?? this.missions,
      author: author ?? this.author,
      writtenAt: writtenAt ?? this.writtenAt,
    );
  }
}
