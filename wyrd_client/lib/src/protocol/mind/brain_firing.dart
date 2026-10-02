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

abstract class BrainFiring
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BrainFiring._({
    required this.path,
    required this.at,
  });

  factory BrainFiring({
    required List<String> path,
    required DateTime at,
  }) = _BrainFiringImpl;

  factory BrainFiring.fromJson(Map<String, dynamic> jsonSerialization) {
    return BrainFiring(
      path: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['path'],
      ),
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  List<String> path;

  DateTime at;

  /// Returns a shallow copy of this [BrainFiring]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BrainFiring copyWith({
    List<String>? path,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BrainFiring',
      'path': path.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BrainFiring',
      'path': path.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BrainFiringImpl extends BrainFiring {
  _BrainFiringImpl({
    required List<String> path,
    required DateTime at,
  }) : super._(
         path: path,
         at: at,
       );

  /// Returns a shallow copy of this [BrainFiring]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BrainFiring copyWith({
    List<String>? path,
    DateTime? at,
  }) {
    return BrainFiring(
      path: path ?? this.path.map((e0) => e0).toList(),
      at: at ?? this.at,
    );
  }
}
