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
import '../mind/chat_thread.dart' as _i0zx8u49;
import '../mind/conversation_turn.dart' as _igyss20b;
import '../mind/learned_answer.dart' as _ilehim93;
import '../mind/memory_block.dart' as _i0t6eg5q;
import '../mind/reading_item.dart' as _iq1pc8u4;
import '../mind/sighting.dart' as _i3snlpz5;
import '../mind/user_document.dart' as _irdux050;
import '../mind/user_fact.dart' as _il0k3um2;

abstract class AccountExport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AccountExport._({
    this.email,
    required this.facts,
    required this.visitCount,
    required this.firstSeen,
    required this.lastSeen,
    required this.conversation,
    this.sightings,
    this.learnedAnswers,
    this.memories,
    this.thread,
    this.readingList,
    this.documents,
  });

  factory AccountExport({
    String? email,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
    required List<_igyss20b.ConversationTurn> conversation,
    List<_i3snlpz5.Sighting>? sightings,
    List<_ilehim93.LearnedAnswer>? learnedAnswers,
    List<_i0t6eg5q.MemoryBlock>? memories,
    _i0zx8u49.ChatThread? thread,
    List<_iq1pc8u4.ReadingItem>? readingList,
    List<_irdux050.UserDocument>? documents,
  }) = _AccountExportImpl;

  factory AccountExport.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountExport(
      email: jsonSerialization['email'] as String?,
      facts: _i2pladzn.Protocol().deserialize<List<_il0k3um2.UserFact>>(
        jsonSerialization['facts'],
      ),
      visitCount: jsonSerialization['visitCount'] as int,
      firstSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeen'],
      ),
      lastSeen: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeen'],
      ),
      conversation: _i2pladzn.Protocol()
          .deserialize<List<_igyss20b.ConversationTurn>>(
            jsonSerialization['conversation'],
          ),
      sightings: jsonSerialization['sightings'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<_i3snlpz5.Sighting>>(
              jsonSerialization['sightings'],
            ),
      learnedAnswers: jsonSerialization['learnedAnswers'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<_ilehim93.LearnedAnswer>>(
              jsonSerialization['learnedAnswers'],
            ),
      memories: jsonSerialization['memories'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<_i0t6eg5q.MemoryBlock>>(
              jsonSerialization['memories'],
            ),
      thread: jsonSerialization['thread'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<_i0zx8u49.ChatThread>(
              jsonSerialization['thread'],
            ),
      readingList: jsonSerialization['readingList'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<_iq1pc8u4.ReadingItem>>(
              jsonSerialization['readingList'],
            ),
      documents: jsonSerialization['documents'] == null
          ? null
          : _i2pladzn.Protocol().deserialize<List<_irdux050.UserDocument>>(
              jsonSerialization['documents'],
            ),
    );
  }

  String? email;

  List<_il0k3um2.UserFact> facts;

  int visitCount;

  DateTime firstSeen;

  DateTime lastSeen;

  List<_igyss20b.ConversationTurn> conversation;

  List<_i3snlpz5.Sighting>? sightings;

  List<_ilehim93.LearnedAnswer>? learnedAnswers;

  List<_i0t6eg5q.MemoryBlock>? memories;

  _i0zx8u49.ChatThread? thread;

  List<_iq1pc8u4.ReadingItem>? readingList;

  List<_irdux050.UserDocument>? documents;

  /// Returns a shallow copy of this [AccountExport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AccountExport copyWith({
    String? email,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
    List<_igyss20b.ConversationTurn>? conversation,
    List<_i3snlpz5.Sighting>? sightings,
    List<_ilehim93.LearnedAnswer>? learnedAnswers,
    List<_i0t6eg5q.MemoryBlock>? memories,
    _i0zx8u49.ChatThread? thread,
    List<_iq1pc8u4.ReadingItem>? readingList,
    List<_irdux050.UserDocument>? documents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountExport',
      if (email != null) 'email': email,
      'facts': facts.toJson(valueToJson: (v) => v.toJson()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
      'conversation': conversation.toJson(valueToJson: (v) => v.toJson()),
      if (sightings != null)
        'sightings': sightings?.toJson(valueToJson: (v) => v.toJson()),
      if (learnedAnswers != null)
        'learnedAnswers': learnedAnswers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (memories != null)
        'memories': memories?.toJson(valueToJson: (v) => v.toJson()),
      if (thread != null) 'thread': thread?.toJson(),
      if (readingList != null)
        'readingList': readingList?.toJson(valueToJson: (v) => v.toJson()),
      if (documents != null)
        'documents': documents?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountExport',
      if (email != null) 'email': email,
      'facts': facts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'visitCount': visitCount,
      'firstSeen': firstSeen.toJson(),
      'lastSeen': lastSeen.toJson(),
      'conversation': conversation.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (sightings != null)
        'sightings': sightings?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (learnedAnswers != null)
        'learnedAnswers': learnedAnswers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (memories != null)
        'memories': memories?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (thread != null) 'thread': thread?.toJsonForProtocol(),
      if (readingList != null)
        'readingList': readingList?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (documents != null)
        'documents': documents?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountExportImpl extends AccountExport {
  _AccountExportImpl({
    String? email,
    required List<_il0k3um2.UserFact> facts,
    required int visitCount,
    required DateTime firstSeen,
    required DateTime lastSeen,
    required List<_igyss20b.ConversationTurn> conversation,
    List<_i3snlpz5.Sighting>? sightings,
    List<_ilehim93.LearnedAnswer>? learnedAnswers,
    List<_i0t6eg5q.MemoryBlock>? memories,
    _i0zx8u49.ChatThread? thread,
    List<_iq1pc8u4.ReadingItem>? readingList,
    List<_irdux050.UserDocument>? documents,
  }) : super._(
         email: email,
         facts: facts,
         visitCount: visitCount,
         firstSeen: firstSeen,
         lastSeen: lastSeen,
         conversation: conversation,
         sightings: sightings,
         learnedAnswers: learnedAnswers,
         memories: memories,
         thread: thread,
         readingList: readingList,
         documents: documents,
       );

  /// Returns a shallow copy of this [AccountExport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AccountExport copyWith({
    Object? email = _Undefined,
    List<_il0k3um2.UserFact>? facts,
    int? visitCount,
    DateTime? firstSeen,
    DateTime? lastSeen,
    List<_igyss20b.ConversationTurn>? conversation,
    Object? sightings = _Undefined,
    Object? learnedAnswers = _Undefined,
    Object? memories = _Undefined,
    Object? thread = _Undefined,
    Object? readingList = _Undefined,
    Object? documents = _Undefined,
  }) {
    return AccountExport(
      email: email is String? ? email : this.email,
      facts: facts ?? this.facts.map((e0) => e0.copyWith()).toList(),
      visitCount: visitCount ?? this.visitCount,
      firstSeen: firstSeen ?? this.firstSeen,
      lastSeen: lastSeen ?? this.lastSeen,
      conversation:
          conversation ?? this.conversation.map((e0) => e0.copyWith()).toList(),
      sightings: sightings is List<_i3snlpz5.Sighting>?
          ? sightings
          : this.sightings?.map((e0) => e0.copyWith()).toList(),
      learnedAnswers: learnedAnswers is List<_ilehim93.LearnedAnswer>?
          ? learnedAnswers
          : this.learnedAnswers?.map((e0) => e0.copyWith()).toList(),
      memories: memories is List<_i0t6eg5q.MemoryBlock>?
          ? memories
          : this.memories?.map((e0) => e0.copyWith()).toList(),
      thread: thread is _i0zx8u49.ChatThread?
          ? thread
          : this.thread?.copyWith(),
      readingList: readingList is List<_iq1pc8u4.ReadingItem>?
          ? readingList
          : this.readingList?.map((e0) => e0.copyWith()).toList(),
      documents: documents is List<_irdux050.UserDocument>?
          ? documents
          : this.documents?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
