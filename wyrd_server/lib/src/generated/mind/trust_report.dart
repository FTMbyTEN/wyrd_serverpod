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
import '../mind/trust_score.dart' as _ise5tdh2;

abstract class TrustReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TrustReport._({
    required this.trustedSources,
    required this.doubtedSources,
    required this.trustedTopics,
    required this.doubtedTopics,
    required this.tracked,
    required this.evidence,
  });

  factory TrustReport({
    required List<_ise5tdh2.TrustScore> trustedSources,
    required List<_ise5tdh2.TrustScore> doubtedSources,
    required List<_ise5tdh2.TrustScore> trustedTopics,
    required List<_ise5tdh2.TrustScore> doubtedTopics,
    required int tracked,
    required double evidence,
  }) = _TrustReportImpl;

  factory TrustReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrustReport(
      trustedSources: _i9sln91s.Protocol()
          .deserialize<List<_ise5tdh2.TrustScore>>(
            jsonSerialization['trustedSources'],
          ),
      doubtedSources: _i9sln91s.Protocol()
          .deserialize<List<_ise5tdh2.TrustScore>>(
            jsonSerialization['doubtedSources'],
          ),
      trustedTopics: _i9sln91s.Protocol()
          .deserialize<List<_ise5tdh2.TrustScore>>(
            jsonSerialization['trustedTopics'],
          ),
      doubtedTopics: _i9sln91s.Protocol()
          .deserialize<List<_ise5tdh2.TrustScore>>(
            jsonSerialization['doubtedTopics'],
          ),
      tracked: jsonSerialization['tracked'] as int,
      evidence: (jsonSerialization['evidence'] as num).toDouble(),
    );
  }

  List<_ise5tdh2.TrustScore> trustedSources;

  List<_ise5tdh2.TrustScore> doubtedSources;

  List<_ise5tdh2.TrustScore> trustedTopics;

  List<_ise5tdh2.TrustScore> doubtedTopics;

  int tracked;

  double evidence;

  /// Returns a shallow copy of this [TrustReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TrustReport copyWith({
    List<_ise5tdh2.TrustScore>? trustedSources,
    List<_ise5tdh2.TrustScore>? doubtedSources,
    List<_ise5tdh2.TrustScore>? trustedTopics,
    List<_ise5tdh2.TrustScore>? doubtedTopics,
    int? tracked,
    double? evidence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrustReport',
      'trustedSources': trustedSources.toJson(valueToJson: (v) => v.toJson()),
      'doubtedSources': doubtedSources.toJson(valueToJson: (v) => v.toJson()),
      'trustedTopics': trustedTopics.toJson(valueToJson: (v) => v.toJson()),
      'doubtedTopics': doubtedTopics.toJson(valueToJson: (v) => v.toJson()),
      'tracked': tracked,
      'evidence': evidence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrustReport',
      'trustedSources': trustedSources.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'doubtedSources': doubtedSources.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'trustedTopics': trustedTopics.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'doubtedTopics': doubtedTopics.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'tracked': tracked,
      'evidence': evidence,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TrustReportImpl extends TrustReport {
  _TrustReportImpl({
    required List<_ise5tdh2.TrustScore> trustedSources,
    required List<_ise5tdh2.TrustScore> doubtedSources,
    required List<_ise5tdh2.TrustScore> trustedTopics,
    required List<_ise5tdh2.TrustScore> doubtedTopics,
    required int tracked,
    required double evidence,
  }) : super._(
         trustedSources: trustedSources,
         doubtedSources: doubtedSources,
         trustedTopics: trustedTopics,
         doubtedTopics: doubtedTopics,
         tracked: tracked,
         evidence: evidence,
       );

  /// Returns a shallow copy of this [TrustReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TrustReport copyWith({
    List<_ise5tdh2.TrustScore>? trustedSources,
    List<_ise5tdh2.TrustScore>? doubtedSources,
    List<_ise5tdh2.TrustScore>? trustedTopics,
    List<_ise5tdh2.TrustScore>? doubtedTopics,
    int? tracked,
    double? evidence,
  }) {
    return TrustReport(
      trustedSources:
          trustedSources ??
          this.trustedSources.map((e0) => e0.copyWith()).toList(),
      doubtedSources:
          doubtedSources ??
          this.doubtedSources.map((e0) => e0.copyWith()).toList(),
      trustedTopics:
          trustedTopics ??
          this.trustedTopics.map((e0) => e0.copyWith()).toList(),
      doubtedTopics:
          doubtedTopics ??
          this.doubtedTopics.map((e0) => e0.copyWith()).toList(),
      tracked: tracked ?? this.tracked,
      evidence: evidence ?? this.evidence,
    );
  }
}
