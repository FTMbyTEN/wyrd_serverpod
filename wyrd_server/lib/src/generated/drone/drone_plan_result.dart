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
import '../drone/drone_mission.dart' as _igmjlfh6;

abstract class DronePlanResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DronePlanResult._({
    required this.accepted,
    this.reason,
    this.mission,
  });

  factory DronePlanResult({
    required bool accepted,
    String? reason,
    _igmjlfh6.DroneMission? mission,
  }) = _DronePlanResultImpl;

  factory DronePlanResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return DronePlanResult(
      accepted: _is.BoolJsonExtension.fromJson(jsonSerialization['accepted']),
      reason: jsonSerialization['reason'] as String?,
      mission: jsonSerialization['mission'] == null
          ? null
          : _i9sln91s.Protocol().deserialize<_igmjlfh6.DroneMission>(
              jsonSerialization['mission'],
            ),
    );
  }

  bool accepted;

  String? reason;

  _igmjlfh6.DroneMission? mission;

  /// Returns a shallow copy of this [DronePlanResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DronePlanResult copyWith({
    bool? accepted,
    String? reason,
    _igmjlfh6.DroneMission? mission,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DronePlanResult',
      'accepted': accepted,
      if (reason != null) 'reason': reason,
      if (mission != null) 'mission': mission?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DronePlanResult',
      'accepted': accepted,
      if (reason != null) 'reason': reason,
      if (mission != null) 'mission': mission?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DronePlanResultImpl extends DronePlanResult {
  _DronePlanResultImpl({
    required bool accepted,
    String? reason,
    _igmjlfh6.DroneMission? mission,
  }) : super._(
         accepted: accepted,
         reason: reason,
         mission: mission,
       );

  /// Returns a shallow copy of this [DronePlanResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DronePlanResult copyWith({
    bool? accepted,
    Object? reason = _Undefined,
    Object? mission = _Undefined,
  }) {
    return DronePlanResult(
      accepted: accepted ?? this.accepted,
      reason: reason is String? ? reason : this.reason,
      mission: mission is _igmjlfh6.DroneMission?
          ? mission
          : this.mission?.copyWith(),
    );
  }
}
