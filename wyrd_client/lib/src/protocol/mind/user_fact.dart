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

abstract class UserFact
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserFact._({
    required this.text,
    required this.category,
    required this.timestamp,
    required this.lastMentioned,
  });

  factory UserFact({
    required String text,
    required String category,
    required DateTime timestamp,
    required DateTime lastMentioned,
  }) = _UserFactImpl;

  factory UserFact.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserFact(
      text: jsonSerialization['text'] as String,
      category: jsonSerialization['category'] as String,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      lastMentioned: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastMentioned'],
      ),
    );
  }

  String text;

  String category;

  DateTime timestamp;

  DateTime lastMentioned;

  /// Returns a shallow copy of this [UserFact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserFact copyWith({
    String? text,
    String? category,
    DateTime? timestamp,
    DateTime? lastMentioned,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserFact',
      'text': text,
      'category': category,
      'timestamp': timestamp.toJson(),
      'lastMentioned': lastMentioned.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserFact',
      'text': text,
      'category': category,
      'timestamp': timestamp.toJson(),
      'lastMentioned': lastMentioned.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _UserFactImpl extends UserFact {
  _UserFactImpl({
    required String text,
    required String category,
    required DateTime timestamp,
    required DateTime lastMentioned,
  }) : super._(
         text: text,
         category: category,
         timestamp: timestamp,
         lastMentioned: lastMentioned,
       );

  /// Returns a shallow copy of this [UserFact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserFact copyWith({
    String? text,
    String? category,
    DateTime? timestamp,
    DateTime? lastMentioned,
  }) {
    return UserFact(
      text: text ?? this.text,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      lastMentioned: lastMentioned ?? this.lastMentioned,
    );
  }
}
