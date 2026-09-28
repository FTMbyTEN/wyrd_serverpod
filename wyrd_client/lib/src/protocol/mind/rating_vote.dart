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

abstract class RatingVote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RatingVote._({
    this.id,
    required this.authUserId,
    required this.kind,
    required this.key,
    required this.value,
  });

  factory RatingVote({
    int? id,
    required _isc.UuidValue authUserId,
    required String kind,
    required String key,
    required double value,
  }) = _RatingVoteImpl;

  factory RatingVote.fromJson(Map<String, dynamic> jsonSerialization) {
    return RatingVote(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      kind: jsonSerialization['kind'] as String,
      key: jsonSerialization['key'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String kind;

  String key;

  double value;

  /// Returns a shallow copy of this [RatingVote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RatingVote copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? kind,
    String? key,
    double? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RatingVote',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'key': key,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RatingVote',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'kind': kind,
      'key': key,
      'value': value,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingVoteImpl extends RatingVote {
  _RatingVoteImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String kind,
    required String key,
    required double value,
  }) : super._(
         id: id,
         authUserId: authUserId,
         kind: kind,
         key: key,
         value: value,
       );

  /// Returns a shallow copy of this [RatingVote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RatingVote copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? kind,
    String? key,
    double? value,
  }) {
    return RatingVote(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      kind: kind ?? this.kind,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}
