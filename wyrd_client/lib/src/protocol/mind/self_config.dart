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
import '../mind/self_config_change.dart' as _ieirbbk4;

abstract class SelfConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SelfConfig._({
    this.id,
    required this.toneNote,
    required this.replyLengthMax,
    required this.curiosityLevel,
    required this.history,
  });

  factory SelfConfig({
    int? id,
    required String toneNote,
    required int replyLengthMax,
    required String curiosityLevel,
    required List<_ieirbbk4.SelfConfigChange> history,
  }) = _SelfConfigImpl;

  factory SelfConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return SelfConfig(
      id: jsonSerialization['id'] as int?,
      toneNote: jsonSerialization['toneNote'] as String,
      replyLengthMax: jsonSerialization['replyLengthMax'] as int,
      curiosityLevel: jsonSerialization['curiosityLevel'] as String,
      history: _i2pladzn.Protocol()
          .deserialize<List<_ieirbbk4.SelfConfigChange>>(
            jsonSerialization['history'],
          ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String toneNote;

  int replyLengthMax;

  String curiosityLevel;

  List<_ieirbbk4.SelfConfigChange> history;

  /// Returns a shallow copy of this [SelfConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SelfConfig copyWith({
    int? id,
    String? toneNote,
    int? replyLengthMax,
    String? curiosityLevel,
    List<_ieirbbk4.SelfConfigChange>? history,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SelfConfig',
      if (id != null) 'id': id,
      'toneNote': toneNote,
      'replyLengthMax': replyLengthMax,
      'curiosityLevel': curiosityLevel,
      'history': history.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SelfConfig',
      if (id != null) 'id': id,
      'toneNote': toneNote,
      'replyLengthMax': replyLengthMax,
      'curiosityLevel': curiosityLevel,
      'history': history.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SelfConfigImpl extends SelfConfig {
  _SelfConfigImpl({
    int? id,
    required String toneNote,
    required int replyLengthMax,
    required String curiosityLevel,
    required List<_ieirbbk4.SelfConfigChange> history,
  }) : super._(
         id: id,
         toneNote: toneNote,
         replyLengthMax: replyLengthMax,
         curiosityLevel: curiosityLevel,
         history: history,
       );

  /// Returns a shallow copy of this [SelfConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SelfConfig copyWith({
    Object? id = _Undefined,
    String? toneNote,
    int? replyLengthMax,
    String? curiosityLevel,
    List<_ieirbbk4.SelfConfigChange>? history,
  }) {
    return SelfConfig(
      id: id is int? ? id : this.id,
      toneNote: toneNote ?? this.toneNote,
      replyLengthMax: replyLengthMax ?? this.replyLengthMax,
      curiosityLevel: curiosityLevel ?? this.curiosityLevel,
      history: history ?? this.history.map((e0) => e0.copyWith()).toList(),
    );
  }
}
