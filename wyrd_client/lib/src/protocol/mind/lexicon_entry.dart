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

abstract class LexiconEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LexiconEntry._({
    this.id,
    required this.word,
    required this.understood,
    this.definition,
    this.partOfSpeech,
    required this.learnedAt,
  });

  factory LexiconEntry({
    int? id,
    required String word,
    required bool understood,
    String? definition,
    String? partOfSpeech,
    required DateTime learnedAt,
  }) = _LexiconEntryImpl;

  factory LexiconEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LexiconEntry(
      id: jsonSerialization['id'] as int?,
      word: jsonSerialization['word'] as String,
      understood: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['understood'],
      ),
      definition: jsonSerialization['definition'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
      learnedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['learnedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String word;

  bool understood;

  String? definition;

  String? partOfSpeech;

  DateTime learnedAt;

  /// Returns a shallow copy of this [LexiconEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LexiconEntry copyWith({
    int? id,
    String? word,
    bool? understood,
    String? definition,
    String? partOfSpeech,
    DateTime? learnedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LexiconEntry',
      if (id != null) 'id': id,
      'word': word,
      'understood': understood,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'learnedAt': learnedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LexiconEntry',
      if (id != null) 'id': id,
      'word': word,
      'understood': understood,
      if (definition != null) 'definition': definition,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'learnedAt': learnedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LexiconEntryImpl extends LexiconEntry {
  _LexiconEntryImpl({
    int? id,
    required String word,
    required bool understood,
    String? definition,
    String? partOfSpeech,
    required DateTime learnedAt,
  }) : super._(
         id: id,
         word: word,
         understood: understood,
         definition: definition,
         partOfSpeech: partOfSpeech,
         learnedAt: learnedAt,
       );

  /// Returns a shallow copy of this [LexiconEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LexiconEntry copyWith({
    Object? id = _Undefined,
    String? word,
    bool? understood,
    Object? definition = _Undefined,
    Object? partOfSpeech = _Undefined,
    DateTime? learnedAt,
  }) {
    return LexiconEntry(
      id: id is int? ? id : this.id,
      word: word ?? this.word,
      understood: understood ?? this.understood,
      definition: definition is String? ? definition : this.definition,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
      learnedAt: learnedAt ?? this.learnedAt,
    );
  }
}
