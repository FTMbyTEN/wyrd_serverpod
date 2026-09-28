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

abstract class QuizAttempt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizAttempt._({
    this.id,
    required this.authUserId,
    this.readingItemId,
    required this.title,
    required this.correct,
    required this.total,
    required this.missed,
    required this.at,
  });

  factory QuizAttempt({
    int? id,
    required _isc.UuidValue authUserId,
    int? readingItemId,
    required String title,
    required int correct,
    required int total,
    required List<String> missed,
    required DateTime at,
  }) = _QuizAttemptImpl;

  factory QuizAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAttempt(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      readingItemId: jsonSerialization['readingItemId'] as int?,
      title: jsonSerialization['title'] as String,
      correct: jsonSerialization['correct'] as int,
      total: jsonSerialization['total'] as int,
      missed: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['missed'],
      ),
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  int? readingItemId;

  String title;

  int correct;

  int total;

  List<String> missed;

  DateTime at;

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizAttempt copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? readingItemId,
    String? title,
    int? correct,
    int? total,
    List<String>? missed,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (readingItemId != null) 'readingItemId': readingItemId,
      'title': title,
      'correct': correct,
      'total': total,
      'missed': missed.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (readingItemId != null) 'readingItemId': readingItemId,
      'title': title,
      'correct': correct,
      'total': total,
      'missed': missed.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAttemptImpl extends QuizAttempt {
  _QuizAttemptImpl({
    int? id,
    required _isc.UuidValue authUserId,
    int? readingItemId,
    required String title,
    required int correct,
    required int total,
    required List<String> missed,
    required DateTime at,
  }) : super._(
         id: id,
         authUserId: authUserId,
         readingItemId: readingItemId,
         title: title,
         correct: correct,
         total: total,
         missed: missed,
         at: at,
       );

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizAttempt copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? readingItemId = _Undefined,
    String? title,
    int? correct,
    int? total,
    List<String>? missed,
    DateTime? at,
  }) {
    return QuizAttempt(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      readingItemId: readingItemId is int? ? readingItemId : this.readingItemId,
      title: title ?? this.title,
      correct: correct ?? this.correct,
      total: total ?? this.total,
      missed: missed ?? this.missed.map((e0) => e0).toList(),
      at: at ?? this.at,
    );
  }
}
