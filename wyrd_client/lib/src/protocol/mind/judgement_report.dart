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

abstract class JudgementReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JudgementReport._({
    required this.checked,
    required this.passed,
    required this.softened,
    required this.corrected,
    required this.blocked,
    required this.reasons,
  });

  factory JudgementReport({
    required int checked,
    required int passed,
    required int softened,
    required int corrected,
    required int blocked,
    required Map<String, int> reasons,
  }) = _JudgementReportImpl;

  factory JudgementReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgementReport(
      checked: jsonSerialization['checked'] as int,
      passed: jsonSerialization['passed'] as int,
      softened: jsonSerialization['softened'] as int,
      corrected: jsonSerialization['corrected'] as int,
      blocked: jsonSerialization['blocked'] as int,
      reasons: _i2pladzn.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['reasons'],
      ),
    );
  }

  int checked;

  int passed;

  int softened;

  int corrected;

  int blocked;

  Map<String, int> reasons;

  /// Returns a shallow copy of this [JudgementReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JudgementReport copyWith({
    int? checked,
    int? passed,
    int? softened,
    int? corrected,
    int? blocked,
    Map<String, int>? reasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgementReport',
      'checked': checked,
      'passed': passed,
      'softened': softened,
      'corrected': corrected,
      'blocked': blocked,
      'reasons': reasons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgementReport',
      'checked': checked,
      'passed': passed,
      'softened': softened,
      'corrected': corrected,
      'blocked': blocked,
      'reasons': reasons.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _JudgementReportImpl extends JudgementReport {
  _JudgementReportImpl({
    required int checked,
    required int passed,
    required int softened,
    required int corrected,
    required int blocked,
    required Map<String, int> reasons,
  }) : super._(
         checked: checked,
         passed: passed,
         softened: softened,
         corrected: corrected,
         blocked: blocked,
         reasons: reasons,
       );

  /// Returns a shallow copy of this [JudgementReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JudgementReport copyWith({
    int? checked,
    int? passed,
    int? softened,
    int? corrected,
    int? blocked,
    Map<String, int>? reasons,
  }) {
    return JudgementReport(
      checked: checked ?? this.checked,
      passed: passed ?? this.passed,
      softened: softened ?? this.softened,
      corrected: corrected ?? this.corrected,
      blocked: blocked ?? this.blocked,
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
    );
  }
}
