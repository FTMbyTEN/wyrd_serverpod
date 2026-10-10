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

/// A partner's usage per day, environment and surface: requests, tokens and what the model cost (millionths of a dollar).
abstract class PartnerUsage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerUsage._({
    this.id,
    required this.day,
    required this.partner,
    required this.env,
    required this.surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) : requests = requests ?? 0,
       inputTokens = inputTokens ?? 0,
       outputTokens = outputTokens ?? 0,
       costMicros = costMicros ?? 0;

  factory PartnerUsage({
    int? id,
    required String day,
    required String partner,
    required String env,
    required String surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) = _PartnerUsageImpl;

  factory PartnerUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerUsage(
      id: jsonSerialization['id'] as int?,
      day: jsonSerialization['day'] as String,
      partner: jsonSerialization['partner'] as String,
      env: jsonSerialization['env'] as String,
      surface: jsonSerialization['surface'] as String,
      requests: jsonSerialization['requests'] as int?,
      inputTokens: jsonSerialization['inputTokens'] as int?,
      outputTokens: jsonSerialization['outputTokens'] as int?,
      costMicros: jsonSerialization['costMicros'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String day;

  String partner;

  String env;

  String surface;

  int requests;

  int inputTokens;

  int outputTokens;

  int costMicros;

  /// Returns a shallow copy of this [PartnerUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerUsage copyWith({
    int? id,
    String? day,
    String? partner,
    String? env,
    String? surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerUsage',
      if (id != null) 'id': id,
      'day': day,
      'partner': partner,
      'env': env,
      'surface': surface,
      'requests': requests,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costMicros': costMicros,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerUsage',
      if (id != null) 'id': id,
      'day': day,
      'partner': partner,
      'env': env,
      'surface': surface,
      'requests': requests,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costMicros': costMicros,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerUsageImpl extends PartnerUsage {
  _PartnerUsageImpl({
    int? id,
    required String day,
    required String partner,
    required String env,
    required String surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) : super._(
         id: id,
         day: day,
         partner: partner,
         env: env,
         surface: surface,
         requests: requests,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         costMicros: costMicros,
       );

  /// Returns a shallow copy of this [PartnerUsage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerUsage copyWith({
    Object? id = _Undefined,
    String? day,
    String? partner,
    String? env,
    String? surface,
    int? requests,
    int? inputTokens,
    int? outputTokens,
    int? costMicros,
  }) {
    return PartnerUsage(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      partner: partner ?? this.partner,
      env: env ?? this.env,
      surface: surface ?? this.surface,
      requests: requests ?? this.requests,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      costMicros: costMicros ?? this.costMicros,
    );
  }
}
