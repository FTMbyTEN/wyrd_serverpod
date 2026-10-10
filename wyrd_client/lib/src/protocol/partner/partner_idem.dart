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

/// A partner request made with an Idempotency-Key: its body's hash and the response sent, so a retry within 24 hours
/// gets the same response instead of being processed again.
abstract class PartnerIdem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PartnerIdem._({
    this.id,
    required this.idemKey,
    required this.bodyHash,
    required this.status,
    required this.response,
    required this.createdAt,
  });

  factory PartnerIdem({
    int? id,
    required String idemKey,
    required String bodyHash,
    required int status,
    required String response,
    required DateTime createdAt,
  }) = _PartnerIdemImpl;

  factory PartnerIdem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerIdem(
      id: jsonSerialization['id'] as int?,
      idemKey: jsonSerialization['idemKey'] as String,
      bodyHash: jsonSerialization['bodyHash'] as String,
      status: jsonSerialization['status'] as int,
      response: jsonSerialization['response'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String idemKey;

  String bodyHash;

  int status;

  String response;

  DateTime createdAt;

  /// Returns a shallow copy of this [PartnerIdem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PartnerIdem copyWith({
    int? id,
    String? idemKey,
    String? bodyHash,
    int? status,
    String? response,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerIdem',
      if (id != null) 'id': id,
      'idemKey': idemKey,
      'bodyHash': bodyHash,
      'status': status,
      'response': response,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerIdem',
      if (id != null) 'id': id,
      'idemKey': idemKey,
      'bodyHash': bodyHash,
      'status': status,
      'response': response,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerIdemImpl extends PartnerIdem {
  _PartnerIdemImpl({
    int? id,
    required String idemKey,
    required String bodyHash,
    required int status,
    required String response,
    required DateTime createdAt,
  }) : super._(
         id: id,
         idemKey: idemKey,
         bodyHash: bodyHash,
         status: status,
         response: response,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PartnerIdem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PartnerIdem copyWith({
    Object? id = _Undefined,
    String? idemKey,
    String? bodyHash,
    int? status,
    String? response,
    DateTime? createdAt,
  }) {
    return PartnerIdem(
      id: id is int? ? id : this.id,
      idemKey: idemKey ?? this.idemKey,
      bodyHash: bodyHash ?? this.bodyHash,
      status: status ?? this.status,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
