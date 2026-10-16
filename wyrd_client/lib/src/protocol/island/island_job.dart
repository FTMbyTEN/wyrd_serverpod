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

/// A real job, posted by an employer on LAGOS ISLAND. It shows on the job board once WYRD's operator
/// has checked it (status open).
abstract class IslandJob
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IslandJob._({
    this.id,
    required this.employerUserId,
    required this.company,
    required this.title,
    required this.pay,
    required this.skills,
    required this.location,
    required this.about,
    required this.contact,
    String? status,
    required this.createdAt,
  }) : status = status ?? 'pending';

  factory IslandJob({
    int? id,
    required _isc.UuidValue employerUserId,
    required String company,
    required String title,
    required String pay,
    required String skills,
    required String location,
    required String about,
    required String contact,
    String? status,
    required DateTime createdAt,
  }) = _IslandJobImpl;

  factory IslandJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return IslandJob(
      id: jsonSerialization['id'] as int?,
      employerUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['employerUserId'],
      ),
      company: jsonSerialization['company'] as String,
      title: jsonSerialization['title'] as String,
      pay: jsonSerialization['pay'] as String,
      skills: jsonSerialization['skills'] as String,
      location: jsonSerialization['location'] as String,
      about: jsonSerialization['about'] as String,
      contact: jsonSerialization['contact'] as String,
      status: jsonSerialization['status'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue employerUserId;

  String company;

  String title;

  /// as the employer wrote it, e.g. "₦250,000 a month"
  String pay;

  /// the skills it needs, comma separated
  String skills;

  String location;

  String about;

  /// how the employer wants to be reached; shown to an applicant only after they apply
  String contact;

  /// pending | open | closed | rejected
  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [IslandJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IslandJob copyWith({
    int? id,
    _isc.UuidValue? employerUserId,
    String? company,
    String? title,
    String? pay,
    String? skills,
    String? location,
    String? about,
    String? contact,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IslandJob',
      if (id != null) 'id': id,
      'employerUserId': employerUserId.toJson(),
      'company': company,
      'title': title,
      'pay': pay,
      'skills': skills,
      'location': location,
      'about': about,
      'contact': contact,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IslandJob',
      if (id != null) 'id': id,
      'employerUserId': employerUserId.toJson(),
      'company': company,
      'title': title,
      'pay': pay,
      'skills': skills,
      'location': location,
      'about': about,
      'contact': contact,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IslandJobImpl extends IslandJob {
  _IslandJobImpl({
    int? id,
    required _isc.UuidValue employerUserId,
    required String company,
    required String title,
    required String pay,
    required String skills,
    required String location,
    required String about,
    required String contact,
    String? status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         employerUserId: employerUserId,
         company: company,
         title: title,
         pay: pay,
         skills: skills,
         location: location,
         about: about,
         contact: contact,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [IslandJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IslandJob copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? employerUserId,
    String? company,
    String? title,
    String? pay,
    String? skills,
    String? location,
    String? about,
    String? contact,
    String? status,
    DateTime? createdAt,
  }) {
    return IslandJob(
      id: id is int? ? id : this.id,
      employerUserId: employerUserId ?? this.employerUserId,
      company: company ?? this.company,
      title: title ?? this.title,
      pay: pay ?? this.pay,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      about: about ?? this.about,
      contact: contact ?? this.contact,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
