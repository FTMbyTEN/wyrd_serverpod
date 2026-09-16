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

abstract class DigestInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DigestInfo._({
    required this.totalTopics,
    required this.answeredTopics,
    required this.backlog,
    required this.percent,
    this.ratePerMin,
    this.etaMinutes,
    this.etaAt,
  });

  factory DigestInfo({
    required int totalTopics,
    required int answeredTopics,
    required int backlog,
    required double percent,
    double? ratePerMin,
    double? etaMinutes,
    DateTime? etaAt,
  }) = _DigestInfoImpl;

  factory DigestInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return DigestInfo(
      totalTopics: jsonSerialization['totalTopics'] as int,
      answeredTopics: jsonSerialization['answeredTopics'] as int,
      backlog: jsonSerialization['backlog'] as int,
      percent: (jsonSerialization['percent'] as num).toDouble(),
      ratePerMin: (jsonSerialization['ratePerMin'] as num?)?.toDouble(),
      etaMinutes: (jsonSerialization['etaMinutes'] as num?)?.toDouble(),
      etaAt: jsonSerialization['etaAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['etaAt']),
    );
  }

  int totalTopics;

  int answeredTopics;

  int backlog;

  double percent;

  double? ratePerMin;

  double? etaMinutes;

  DateTime? etaAt;

  /// Returns a shallow copy of this [DigestInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DigestInfo copyWith({
    int? totalTopics,
    int? answeredTopics,
    int? backlog,
    double? percent,
    double? ratePerMin,
    double? etaMinutes,
    DateTime? etaAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DigestInfo',
      'totalTopics': totalTopics,
      'answeredTopics': answeredTopics,
      'backlog': backlog,
      'percent': percent,
      if (ratePerMin != null) 'ratePerMin': ratePerMin,
      if (etaMinutes != null) 'etaMinutes': etaMinutes,
      if (etaAt != null) 'etaAt': etaAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DigestInfo',
      'totalTopics': totalTopics,
      'answeredTopics': answeredTopics,
      'backlog': backlog,
      'percent': percent,
      if (ratePerMin != null) 'ratePerMin': ratePerMin,
      if (etaMinutes != null) 'etaMinutes': etaMinutes,
      if (etaAt != null) 'etaAt': etaAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DigestInfoImpl extends DigestInfo {
  _DigestInfoImpl({
    required int totalTopics,
    required int answeredTopics,
    required int backlog,
    required double percent,
    double? ratePerMin,
    double? etaMinutes,
    DateTime? etaAt,
  }) : super._(
         totalTopics: totalTopics,
         answeredTopics: answeredTopics,
         backlog: backlog,
         percent: percent,
         ratePerMin: ratePerMin,
         etaMinutes: etaMinutes,
         etaAt: etaAt,
       );

  /// Returns a shallow copy of this [DigestInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DigestInfo copyWith({
    int? totalTopics,
    int? answeredTopics,
    int? backlog,
    double? percent,
    Object? ratePerMin = _Undefined,
    Object? etaMinutes = _Undefined,
    Object? etaAt = _Undefined,
  }) {
    return DigestInfo(
      totalTopics: totalTopics ?? this.totalTopics,
      answeredTopics: answeredTopics ?? this.answeredTopics,
      backlog: backlog ?? this.backlog,
      percent: percent ?? this.percent,
      ratePerMin: ratePerMin is double? ? ratePerMin : this.ratePerMin,
      etaMinutes: etaMinutes is double? ? etaMinutes : this.etaMinutes,
      etaAt: etaAt is DateTime? ? etaAt : this.etaAt,
    );
  }
}
