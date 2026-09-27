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

abstract class Sighting
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Sighting._({
    this.id,
    required this.authUserId,
    required this.timestamp,
    required this.description,
    this.question,
    this.trackingNote,
  });

  factory Sighting({
    int? id,
    required _isc.UuidValue authUserId,
    required DateTime timestamp,
    required String description,
    String? question,
    String? trackingNote,
  }) = _SightingImpl;

  factory Sighting.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sighting(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      description: jsonSerialization['description'] as String,
      question: jsonSerialization['question'] as String?,
      trackingNote: jsonSerialization['trackingNote'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  DateTime timestamp;

  String description;

  String? question;

  String? trackingNote;

  /// Returns a shallow copy of this [Sighting]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Sighting copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    DateTime? timestamp,
    String? description,
    String? question,
    String? trackingNote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sighting',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'timestamp': timestamp.toJson(),
      'description': description,
      if (question != null) 'question': question,
      if (trackingNote != null) 'trackingNote': trackingNote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Sighting',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'timestamp': timestamp.toJson(),
      'description': description,
      if (question != null) 'question': question,
      if (trackingNote != null) 'trackingNote': trackingNote,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SightingImpl extends Sighting {
  _SightingImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required DateTime timestamp,
    required String description,
    String? question,
    String? trackingNote,
  }) : super._(
         id: id,
         authUserId: authUserId,
         timestamp: timestamp,
         description: description,
         question: question,
         trackingNote: trackingNote,
       );

  /// Returns a shallow copy of this [Sighting]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Sighting copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    DateTime? timestamp,
    String? description,
    Object? question = _Undefined,
    Object? trackingNote = _Undefined,
  }) {
    return Sighting(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      timestamp: timestamp ?? this.timestamp,
      description: description ?? this.description,
      question: question is String? ? question : this.question,
      trackingNote: trackingNote is String? ? trackingNote : this.trackingNote,
    );
  }
}
