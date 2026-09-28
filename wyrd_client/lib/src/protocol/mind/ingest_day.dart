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

abstract class IngestDay
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IngestDay._({
    this.id,
    required this.day,
    required this.kept,
    required this.duplicates,
    required this.quarantined,
    required this.reasons,
    required this.categories,
  });

  factory IngestDay({
    int? id,
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
  }) = _IngestDayImpl;

  factory IngestDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngestDay(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      kept: jsonSerialization['kept'] as int,
      duplicates: jsonSerialization['duplicates'] as int,
      quarantined: jsonSerialization['quarantined'] as int,
      reasons: _i2pladzn.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['reasons'],
      ),
      categories: _i2pladzn.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['categories'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String day;

  int kept;

  int duplicates;

  int quarantined;

  Map<String, int> reasons;

  Map<String, int> categories;

  /// Returns a shallow copy of this [IngestDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IngestDay copyWith({
    int? id,
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngestDay',
      if (id != null) 'id': id,
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngestDay',
      if (id != null) 'id': id,
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngestDayImpl extends IngestDay {
  _IngestDayImpl({
    int? id,
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
  }) : super._(
         id: id,
         day: day,
         kept: kept,
         duplicates: duplicates,
         quarantined: quarantined,
         reasons: reasons,
         categories: categories,
       );

  /// Returns a shallow copy of this [IngestDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IngestDay copyWith({
    Object? id = _Undefined,
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
  }) {
    return IngestDay(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      kept: kept ?? this.kept,
      duplicates: duplicates ?? this.duplicates,
      quarantined: quarantined ?? this.quarantined,
      reasons:
          reasons ??
          this.reasons.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      categories:
          categories ??
          this.categories.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
    );
  }
}
