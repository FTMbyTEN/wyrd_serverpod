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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wyrd_server/src/generated/protocol.dart' as _i9sln91s;
import '../mind/quarantined_item.dart' as _ipxbzp22;

abstract class FilterReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FilterReport._({
    required this.day,
    required this.kept,
    required this.duplicates,
    required this.quarantined,
    required this.reasons,
    required this.categories,
    required this.recent,
  });

  factory FilterReport({
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
    required List<_ipxbzp22.QuarantinedItem> recent,
  }) = _FilterReportImpl;

  factory FilterReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return FilterReport(
      day: jsonSerialization['day'] as String,
      kept: jsonSerialization['kept'] as int,
      duplicates: jsonSerialization['duplicates'] as int,
      quarantined: jsonSerialization['quarantined'] as int,
      reasons: _i9sln91s.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['reasons'],
      ),
      categories: _i9sln91s.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['categories'],
      ),
      recent: _i9sln91s.Protocol().deserialize<List<_ipxbzp22.QuarantinedItem>>(
        jsonSerialization['recent'],
      ),
    );
  }

  String day;

  int kept;

  int duplicates;

  int quarantined;

  Map<String, int> reasons;

  Map<String, int> categories;

  List<_ipxbzp22.QuarantinedItem> recent;

  /// Returns a shallow copy of this [FilterReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FilterReport copyWith({
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
    List<_ipxbzp22.QuarantinedItem>? recent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FilterReport',
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
      'recent': recent.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FilterReport',
      'day': day,
      'kept': kept,
      'duplicates': duplicates,
      'quarantined': quarantined,
      'reasons': reasons.toJson(),
      'categories': categories.toJson(),
      'recent': recent.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FilterReportImpl extends FilterReport {
  _FilterReportImpl({
    required String day,
    required int kept,
    required int duplicates,
    required int quarantined,
    required Map<String, int> reasons,
    required Map<String, int> categories,
    required List<_ipxbzp22.QuarantinedItem> recent,
  }) : super._(
         day: day,
         kept: kept,
         duplicates: duplicates,
         quarantined: quarantined,
         reasons: reasons,
         categories: categories,
         recent: recent,
       );

  /// Returns a shallow copy of this [FilterReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FilterReport copyWith({
    String? day,
    int? kept,
    int? duplicates,
    int? quarantined,
    Map<String, int>? reasons,
    Map<String, int>? categories,
    List<_ipxbzp22.QuarantinedItem>? recent,
  }) {
    return FilterReport(
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
      recent: recent ?? this.recent.map((e0) => e0.copyWith()).toList(),
    );
  }
}
