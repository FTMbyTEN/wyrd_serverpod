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

abstract class CurriculumProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CurriculumProgress._({
    this.id,
    required this.index,
    required this.completedTitles,
  });

  factory CurriculumProgress({
    int? id,
    required int index,
    required List<String> completedTitles,
  }) = _CurriculumProgressImpl;

  factory CurriculumProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumProgress(
      id: jsonSerialization['id'] as int?,
      index: jsonSerialization['index'] as int,
      completedTitles: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['completedTitles'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int index;

  List<String> completedTitles;

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CurriculumProgress copyWith({
    int? id,
    int? index,
    List<String>? completedTitles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumProgress',
      if (id != null) 'id': id,
      'index': index,
      'completedTitles': completedTitles.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurriculumProgress',
      if (id != null) 'id': id,
      'index': index,
      'completedTitles': completedTitles.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurriculumProgressImpl extends CurriculumProgress {
  _CurriculumProgressImpl({
    int? id,
    required int index,
    required List<String> completedTitles,
  }) : super._(
         id: id,
         index: index,
         completedTitles: completedTitles,
       );

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CurriculumProgress copyWith({
    Object? id = _Undefined,
    int? index,
    List<String>? completedTitles,
  }) {
    return CurriculumProgress(
      id: id is int? ? id : this.id,
      index: index ?? this.index,
      completedTitles:
          completedTitles ?? this.completedTitles.map((e0) => e0).toList(),
    );
  }
}
