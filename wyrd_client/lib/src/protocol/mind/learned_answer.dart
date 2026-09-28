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

abstract class LearnedAnswer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LearnedAnswer._({
    this.id,
    this.authUserId,
    required this.question,
    required this.intent,
    required this.topics,
    required this.answer,
    required this.score,
    required this.uses,
    required this.version,
    required this.retired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LearnedAnswer({
    int? id,
    _isc.UuidValue? authUserId,
    required String question,
    required String intent,
    required List<String> topics,
    required String answer,
    required double score,
    required int uses,
    required int version,
    required bool retired,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LearnedAnswerImpl;

  factory LearnedAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return LearnedAnswer(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      question: jsonSerialization['question'] as String,
      intent: jsonSerialization['intent'] as String,
      topics: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      answer: jsonSerialization['answer'] as String,
      score: (jsonSerialization['score'] as num).toDouble(),
      uses: jsonSerialization['uses'] as int,
      version: jsonSerialization['version'] as int,
      retired: _isc.BoolJsonExtension.fromJson(jsonSerialization['retired']),
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

  _isc.UuidValue? authUserId;

  String question;

  String intent;

  List<String> topics;

  String answer;

  double score;

  int uses;

  int version;

  bool retired;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [LearnedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LearnedAnswer copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? question,
    String? intent,
    List<String>? topics,
    String? answer,
    double? score,
    int? uses,
    int? version,
    bool? retired,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LearnedAnswer',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'question': question,
      'intent': intent,
      'topics': topics.toJson(),
      'answer': answer,
      'score': score,
      'uses': uses,
      'version': version,
      'retired': retired,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LearnedAnswer',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'question': question,
      'intent': intent,
      'topics': topics.toJson(),
      'answer': answer,
      'score': score,
      'uses': uses,
      'version': version,
      'retired': retired,
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

class _LearnedAnswerImpl extends LearnedAnswer {
  _LearnedAnswerImpl({
    int? id,
    _isc.UuidValue? authUserId,
    required String question,
    required String intent,
    required List<String> topics,
    required String answer,
    required double score,
    required int uses,
    required int version,
    required bool retired,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         question: question,
         intent: intent,
         topics: topics,
         answer: answer,
         score: score,
         uses: uses,
         version: version,
         retired: retired,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LearnedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LearnedAnswer copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    String? question,
    String? intent,
    List<String>? topics,
    String? answer,
    double? score,
    int? uses,
    int? version,
    bool? retired,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LearnedAnswer(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _isc.UuidValue? ? authUserId : this.authUserId,
      question: question ?? this.question,
      intent: intent ?? this.intent,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      answer: answer ?? this.answer,
      score: score ?? this.score,
      uses: uses ?? this.uses,
      version: version ?? this.version,
      retired: retired ?? this.retired,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
