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

abstract class CurriculumStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CurriculumStatus._({
    required this.subject,
    required this.level,
    required this.title,
    required this.position,
    required this.total,
    required this.lap,
    required this.recentlyCompleted,
  });

  factory CurriculumStatus({
    required String subject,
    required String level,
    required String title,
    required int position,
    required int total,
    required int lap,
    required List<String> recentlyCompleted,
  }) = _CurriculumStatusImpl;

  factory CurriculumStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumStatus(
      subject: jsonSerialization['subject'] as String,
      level: jsonSerialization['level'] as String,
      title: jsonSerialization['title'] as String,
      position: jsonSerialization['position'] as int,
      total: jsonSerialization['total'] as int,
      lap: jsonSerialization['lap'] as int,
      recentlyCompleted: _i2pladzn.Protocol().deserialize<List<String>>(
        jsonSerialization['recentlyCompleted'],
      ),
    );
  }

  String subject;

  String level;

  String title;

  int position;

  int total;

  int lap;

  List<String> recentlyCompleted;

  /// Returns a shallow copy of this [CurriculumStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CurriculumStatus copyWith({
    String? subject,
    String? level,
    String? title,
    int? position,
    int? total,
    int? lap,
    List<String>? recentlyCompleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumStatus',
      'subject': subject,
      'level': level,
      'title': title,
      'position': position,
      'total': total,
      'lap': lap,
      'recentlyCompleted': recentlyCompleted.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurriculumStatus',
      'subject': subject,
      'level': level,
      'title': title,
      'position': position,
      'total': total,
      'lap': lap,
      'recentlyCompleted': recentlyCompleted.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CurriculumStatusImpl extends CurriculumStatus {
  _CurriculumStatusImpl({
    required String subject,
    required String level,
    required String title,
    required int position,
    required int total,
    required int lap,
    required List<String> recentlyCompleted,
  }) : super._(
         subject: subject,
         level: level,
         title: title,
         position: position,
         total: total,
         lap: lap,
         recentlyCompleted: recentlyCompleted,
       );

  /// Returns a shallow copy of this [CurriculumStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CurriculumStatus copyWith({
    String? subject,
    String? level,
    String? title,
    int? position,
    int? total,
    int? lap,
    List<String>? recentlyCompleted,
  }) {
    return CurriculumStatus(
      subject: subject ?? this.subject,
      level: level ?? this.level,
      title: title ?? this.title,
      position: position ?? this.position,
      total: total ?? this.total,
      lap: lap ?? this.lap,
      recentlyCompleted:
          recentlyCompleted ?? this.recentlyCompleted.map((e0) => e0).toList(),
    );
  }
}
