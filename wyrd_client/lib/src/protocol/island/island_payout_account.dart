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

/// Where a player's real earnings would be paid: one Nigerian bank account, checked two ways before it counts.
/// The bank's own name for the account (Flutterwave's account lookup) must match the legal name the player gives
/// (a soft ID check), and the email they give must answer a code sent to it.
abstract class IslandPayoutAccount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandPayoutAccount._({
    this.id,
    required this.authUserId,
    required this.bankCode,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.legalName,
    required this.nameMatch,
    required this.email,
    bool? emailVerified,
    this.emailCode,
    this.codeExpires,
    int? codeTries,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : emailVerified = emailVerified ?? false,
       codeTries = codeTries ?? 0;

  factory IslandPayoutAccount({
    int? id,
    required _isc.UuidValue authUserId,
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String legalName,
    required bool nameMatch,
    required String email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IslandPayoutAccountImpl;

  factory IslandPayoutAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandPayoutAccount(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      bankCode: jsonSerialization['bankCode'] as String,
      bankName: jsonSerialization['bankName'] as String,
      accountNumber: jsonSerialization['accountNumber'] as String,
      accountName: jsonSerialization['accountName'] as String,
      legalName: jsonSerialization['legalName'] as String,
      nameMatch: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['nameMatch'],
      ),
      email: jsonSerialization['email'] as String,
      emailVerified: jsonSerialization['emailVerified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['emailVerified']),
      emailCode: jsonSerialization['emailCode'] as String?,
      codeExpires: jsonSerialization['codeExpires'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['codeExpires'],
            ),
      codeTries: jsonSerialization['codeTries'] as int?,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String bankCode;

  String bankName;

  String accountNumber;

  /// the bank's name for the account, as Flutterwave reports it
  String accountName;

  /// the name the player says is theirs
  String legalName;

  bool nameMatch;

  String email;

  bool emailVerified;

  String? emailCode;

  DateTime? codeExpires;

  int codeTries;

  /// unverified (waiting for the email code) | verified | review (the names don't match: a person checks)
  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [IslandPayoutAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandPayoutAccount copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
    String? legalName,
    bool? nameMatch,
    String? email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandPayoutAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'legalName': legalName,
      'nameMatch': nameMatch,
      'email': email,
      'emailVerified': emailVerified,
      if (emailCode != null) 'emailCode': emailCode,
      if (codeExpires != null) 'codeExpires': codeExpires?.toJson(),
      'codeTries': codeTries,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandPayoutAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'legalName': legalName,
      'nameMatch': nameMatch,
      'email': email,
      'emailVerified': emailVerified,
      if (emailCode != null) 'emailCode': emailCode,
      if (codeExpires != null) 'codeExpires': codeExpires?.toJson(),
      'codeTries': codeTries,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandPayoutAccountImpl extends IslandPayoutAccount {
  _IslandPayoutAccountImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String legalName,
    required bool nameMatch,
    required String email,
    bool? emailVerified,
    String? emailCode,
    DateTime? codeExpires,
    int? codeTries,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         bankCode: bankCode,
         bankName: bankName,
         accountNumber: accountNumber,
         accountName: accountName,
         legalName: legalName,
         nameMatch: nameMatch,
         email: email,
         emailVerified: emailVerified,
         emailCode: emailCode,
         codeExpires: codeExpires,
         codeTries: codeTries,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IslandPayoutAccount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandPayoutAccount copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
    String? legalName,
    bool? nameMatch,
    String? email,
    bool? emailVerified,
    Object? emailCode = _Undefined,
    Object? codeExpires = _Undefined,
    int? codeTries,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IslandPayoutAccount(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      legalName: legalName ?? this.legalName,
      nameMatch: nameMatch ?? this.nameMatch,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      emailCode: emailCode is String? ? emailCode : this.emailCode,
      codeExpires: codeExpires is DateTime? ? codeExpires : this.codeExpires,
      codeTries: codeTries ?? this.codeTries,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
