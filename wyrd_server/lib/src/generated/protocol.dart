/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:wyrd_server/src/generated/mind/conversation_turn.dart'
    as _i619x11i;
import 'package:wyrd_server/src/generated/mind/diary_entry.dart' as _idet4410;
import 'package:wyrd_server/src/generated/mind/dream_entry.dart' as _ijdvl27e;
import 'package:wyrd_server/src/generated/mind/feed_ingest.dart' as _icnxukj3;
import 'package:wyrd_server/src/generated/mind/growth_snapshot.dart'
    as _iaqmuv2j;
import 'package:wyrd_server/src/generated/mind/memory_block.dart' as _i5d4cblk;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'mind/chat_reply.dart' as _iav0lzqw;
import 'mind/concept_edge.dart' as _iafou6mz;
import 'mind/concept_graph.dart' as _iggcgqw1;
import 'mind/concept_node.dart' as _iapme6ge;
import 'mind/conversation_turn.dart' as _i8fl0sel;
import 'mind/curriculum_progress.dart' as _ipo2nutw;
import 'mind/curriculum_status.dart' as _iiwgxlwr;
import 'mind/diary_entry.dart' as _i0u3uu6s;
import 'mind/digest_info.dart' as _i9vbq77t;
import 'mind/dream_entry.dart' as _izf9406n;
import 'mind/feed_ingest.dart' as _ig20dqq5;
import 'mind/growth_snapshot.dart' as _iyj2s79k;
import 'mind/lexicon_entry.dart' as _i37ps124;
import 'mind/lexicon_stats.dart' as _ic2pi8fi;
import 'mind/lexicon_word_summary.dart' as _i7zu42sq;
import 'mind/memory_block.dart' as _if349ohh;
import 'mind/mind.dart' as _iqhk00ra;
import 'mind/user_fact.dart' as _i8ng53gk;
import 'mind/user_profile.dart' as _irc0lure;
export 'greetings/greeting.dart';
export 'mind/chat_reply.dart';
export 'mind/concept_edge.dart';
export 'mind/concept_graph.dart';
export 'mind/concept_node.dart';
export 'mind/conversation_turn.dart';
export 'mind/curriculum_progress.dart';
export 'mind/curriculum_status.dart';
export 'mind/diary_entry.dart';
export 'mind/digest_info.dart';
export 'mind/dream_entry.dart';
export 'mind/feed_ingest.dart';
export 'mind/growth_snapshot.dart';
export 'mind/lexicon_entry.dart';
export 'mind/lexicon_stats.dart';
export 'mind/lexicon_word_summary.dart';
export 'mind/memory_block.dart';
export 'mind/mind.dart';
export 'mind/user_fact.dart';
export 'mind/user_profile.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'conversation_turn',
      dartName: 'ConversationTurn',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'userText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'botText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'conversation_turn_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'curriculum_progress',
      dartName: 'CurriculumProgress',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'index',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'completedTitles',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'diary_entry',
      dartName: 'DiaryEntry',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'date',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'content',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'diary_entry_timestamp_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dream_entry',
      dartName: 'DreamEntry',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'content',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceBlockIds',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dream_entry_timestamp_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'growth_snapshot',
      dartName: 'GrowthSnapshot',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'vocabCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'blockCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'digestPercent',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'curiosity',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'confidence',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'growth_snapshot_timestamp_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'lexicon_entry',
      dartName: 'LexiconEntry',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'word',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'understood',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'definition',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'partOfSpeech',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'learnedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'lexicon_entry_word_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'word',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'memory_block',
      dartName: 'MemoryBlock',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'legacyId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'timestamp',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'feedSource',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'extract',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'url',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'userText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'botText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'triggeredBy',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'topics',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'curriculumSubject',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'curriculumLevel',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'question',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'answer',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'answeredTopic',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'insight',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceBlockIds',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceTopics',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'memory_block_timestamp_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'mind',
      dartName: 'Mind',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'mood',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'focusTopic',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'activeGoal',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'curiosity',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'confidence',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'digest',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:DigestInfo',
        ),
        _isp.ColumnDefinition(
          name: 'lastEvent',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'explorationCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'seenTopics',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedTopics',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'selfAnswerTimestamps',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_profile',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'wyrd',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'username',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'facts',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserFact>',
        ),
        _isp.ColumnDefinition(
          name: 'visitCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'firstSeen',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastSeen',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_profile_auth_user_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _iav0lzqw.ChatReply) {
      return _iav0lzqw.ChatReply.fromJson(data) as T;
    }
    if (t == _iafou6mz.ConceptEdge) {
      return _iafou6mz.ConceptEdge.fromJson(data) as T;
    }
    if (t == _iggcgqw1.ConceptGraph) {
      return _iggcgqw1.ConceptGraph.fromJson(data) as T;
    }
    if (t == _iapme6ge.ConceptNode) {
      return _iapme6ge.ConceptNode.fromJson(data) as T;
    }
    if (t == _i8fl0sel.ConversationTurn) {
      return _i8fl0sel.ConversationTurn.fromJson(data) as T;
    }
    if (t == _ipo2nutw.CurriculumProgress) {
      return _ipo2nutw.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _iiwgxlwr.CurriculumStatus) {
      return _iiwgxlwr.CurriculumStatus.fromJson(data) as T;
    }
    if (t == _i0u3uu6s.DiaryEntry) {
      return _i0u3uu6s.DiaryEntry.fromJson(data) as T;
    }
    if (t == _i9vbq77t.DigestInfo) {
      return _i9vbq77t.DigestInfo.fromJson(data) as T;
    }
    if (t == _izf9406n.DreamEntry) {
      return _izf9406n.DreamEntry.fromJson(data) as T;
    }
    if (t == _ig20dqq5.FeedIngest) {
      return _ig20dqq5.FeedIngest.fromJson(data) as T;
    }
    if (t == _iyj2s79k.GrowthSnapshot) {
      return _iyj2s79k.GrowthSnapshot.fromJson(data) as T;
    }
    if (t == _i37ps124.LexiconEntry) {
      return _i37ps124.LexiconEntry.fromJson(data) as T;
    }
    if (t == _ic2pi8fi.LexiconStats) {
      return _ic2pi8fi.LexiconStats.fromJson(data) as T;
    }
    if (t == _i7zu42sq.LexiconWordSummary) {
      return _i7zu42sq.LexiconWordSummary.fromJson(data) as T;
    }
    if (t == _if349ohh.MemoryBlock) {
      return _if349ohh.MemoryBlock.fromJson(data) as T;
    }
    if (t == _iqhk00ra.Mind) {
      return _iqhk00ra.Mind.fromJson(data) as T;
    }
    if (t == _i8ng53gk.UserFact) {
      return _i8ng53gk.UserFact.fromJson(data) as T;
    }
    if (t == _irc0lure.UserProfile) {
      return _irc0lure.UserProfile.fromJson(data) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iav0lzqw.ChatReply?>()) {
      return (data != null ? _iav0lzqw.ChatReply.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iafou6mz.ConceptEdge?>()) {
      return (data != null ? _iafou6mz.ConceptEdge.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iggcgqw1.ConceptGraph?>()) {
      return (data != null ? _iggcgqw1.ConceptGraph.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iapme6ge.ConceptNode?>()) {
      return (data != null ? _iapme6ge.ConceptNode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8fl0sel.ConversationTurn?>()) {
      return (data != null ? _i8fl0sel.ConversationTurn.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipo2nutw.CurriculumProgress?>()) {
      return (data != null ? _ipo2nutw.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iiwgxlwr.CurriculumStatus?>()) {
      return (data != null ? _iiwgxlwr.CurriculumStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0u3uu6s.DiaryEntry?>()) {
      return (data != null ? _i0u3uu6s.DiaryEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9vbq77t.DigestInfo?>()) {
      return (data != null ? _i9vbq77t.DigestInfo.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izf9406n.DreamEntry?>()) {
      return (data != null ? _izf9406n.DreamEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ig20dqq5.FeedIngest?>()) {
      return (data != null ? _ig20dqq5.FeedIngest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyj2s79k.GrowthSnapshot?>()) {
      return (data != null ? _iyj2s79k.GrowthSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i37ps124.LexiconEntry?>()) {
      return (data != null ? _i37ps124.LexiconEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ic2pi8fi.LexiconStats?>()) {
      return (data != null ? _ic2pi8fi.LexiconStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7zu42sq.LexiconWordSummary?>()) {
      return (data != null ? _i7zu42sq.LexiconWordSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_if349ohh.MemoryBlock?>()) {
      return (data != null ? _if349ohh.MemoryBlock.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqhk00ra.Mind?>()) {
      return (data != null ? _iqhk00ra.Mind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8ng53gk.UserFact?>()) {
      return (data != null ? _i8ng53gk.UserFact.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irc0lure.UserProfile?>()) {
      return (data != null ? _irc0lure.UserProfile.fromJson(data) : null) as T;
    }
    if (t == List<_iapme6ge.ConceptNode>) {
      return (data as List)
              .map((e) => deserialize<_iapme6ge.ConceptNode>(e))
              .toList()
          as T;
    }
    if (t == List<_iafou6mz.ConceptEdge>) {
      return (data as List)
              .map((e) => deserialize<_iafou6mz.ConceptEdge>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i7zu42sq.LexiconWordSummary>) {
      return (data as List)
              .map((e) => deserialize<_i7zu42sq.LexiconWordSummary>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i8ng53gk.UserFact>) {
      return (data as List)
              .map((e) => deserialize<_i8ng53gk.UserFact>(e))
              .toList()
          as T;
    }
    if (t == List<_i619x11i.ConversationTurn>) {
      return (data as List)
              .map((e) => deserialize<_i619x11i.ConversationTurn>(e))
              .toList()
          as T;
    }
    if (t == List<_idet4410.DiaryEntry>) {
      return (data as List)
              .map((e) => deserialize<_idet4410.DiaryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_ijdvl27e.DreamEntry>) {
      return (data as List)
              .map((e) => deserialize<_ijdvl27e.DreamEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_icnxukj3.FeedIngest>) {
      return (data as List)
              .map((e) => deserialize<_icnxukj3.FeedIngest>(e))
              .toList()
          as T;
    }
    if (t == List<_iaqmuv2j.GrowthSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_iaqmuv2j.GrowthSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i5d4cblk.MemoryBlock>) {
      return (data as List)
              .map((e) => deserialize<_i5d4cblk.MemoryBlock>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _iav0lzqw.ChatReply => 'ChatReply',
      _iafou6mz.ConceptEdge => 'ConceptEdge',
      _iggcgqw1.ConceptGraph => 'ConceptGraph',
      _iapme6ge.ConceptNode => 'ConceptNode',
      _i8fl0sel.ConversationTurn => 'ConversationTurn',
      _ipo2nutw.CurriculumProgress => 'CurriculumProgress',
      _iiwgxlwr.CurriculumStatus => 'CurriculumStatus',
      _i0u3uu6s.DiaryEntry => 'DiaryEntry',
      _i9vbq77t.DigestInfo => 'DigestInfo',
      _izf9406n.DreamEntry => 'DreamEntry',
      _ig20dqq5.FeedIngest => 'FeedIngest',
      _iyj2s79k.GrowthSnapshot => 'GrowthSnapshot',
      _i37ps124.LexiconEntry => 'LexiconEntry',
      _ic2pi8fi.LexiconStats => 'LexiconStats',
      _i7zu42sq.LexiconWordSummary => 'LexiconWordSummary',
      _if349ohh.MemoryBlock => 'MemoryBlock',
      _iqhk00ra.Mind => 'Mind',
      _i8ng53gk.UserFact => 'UserFact',
      _irc0lure.UserProfile => 'UserProfile',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('wyrd.', '');
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _iav0lzqw.ChatReply():
        return 'ChatReply';
      case _iafou6mz.ConceptEdge():
        return 'ConceptEdge';
      case _iggcgqw1.ConceptGraph():
        return 'ConceptGraph';
      case _iapme6ge.ConceptNode():
        return 'ConceptNode';
      case _i8fl0sel.ConversationTurn():
        return 'ConversationTurn';
      case _ipo2nutw.CurriculumProgress():
        return 'CurriculumProgress';
      case _iiwgxlwr.CurriculumStatus():
        return 'CurriculumStatus';
      case _i0u3uu6s.DiaryEntry():
        return 'DiaryEntry';
      case _i9vbq77t.DigestInfo():
        return 'DigestInfo';
      case _izf9406n.DreamEntry():
        return 'DreamEntry';
      case _ig20dqq5.FeedIngest():
        return 'FeedIngest';
      case _iyj2s79k.GrowthSnapshot():
        return 'GrowthSnapshot';
      case _i37ps124.LexiconEntry():
        return 'LexiconEntry';
      case _ic2pi8fi.LexiconStats():
        return 'LexiconStats';
      case _i7zu42sq.LexiconWordSummary():
        return 'LexiconWordSummary';
      case _if349ohh.MemoryBlock():
        return 'MemoryBlock';
      case _iqhk00ra.Mind():
        return 'Mind';
      case _i8ng53gk.UserFact():
        return 'UserFact';
      case _irc0lure.UserProfile():
        return 'UserProfile';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'ChatReply') {
      return deserialize<_iav0lzqw.ChatReply>(data['data']);
    }
    if (dataClassName == 'ConceptEdge') {
      return deserialize<_iafou6mz.ConceptEdge>(data['data']);
    }
    if (dataClassName == 'ConceptGraph') {
      return deserialize<_iggcgqw1.ConceptGraph>(data['data']);
    }
    if (dataClassName == 'ConceptNode') {
      return deserialize<_iapme6ge.ConceptNode>(data['data']);
    }
    if (dataClassName == 'ConversationTurn') {
      return deserialize<_i8fl0sel.ConversationTurn>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_ipo2nutw.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumStatus') {
      return deserialize<_iiwgxlwr.CurriculumStatus>(data['data']);
    }
    if (dataClassName == 'DiaryEntry') {
      return deserialize<_i0u3uu6s.DiaryEntry>(data['data']);
    }
    if (dataClassName == 'DigestInfo') {
      return deserialize<_i9vbq77t.DigestInfo>(data['data']);
    }
    if (dataClassName == 'DreamEntry') {
      return deserialize<_izf9406n.DreamEntry>(data['data']);
    }
    if (dataClassName == 'FeedIngest') {
      return deserialize<_ig20dqq5.FeedIngest>(data['data']);
    }
    if (dataClassName == 'GrowthSnapshot') {
      return deserialize<_iyj2s79k.GrowthSnapshot>(data['data']);
    }
    if (dataClassName == 'LexiconEntry') {
      return deserialize<_i37ps124.LexiconEntry>(data['data']);
    }
    if (dataClassName == 'LexiconStats') {
      return deserialize<_ic2pi8fi.LexiconStats>(data['data']);
    }
    if (dataClassName == 'LexiconWordSummary') {
      return deserialize<_i7zu42sq.LexiconWordSummary>(data['data']);
    }
    if (dataClassName == 'MemoryBlock') {
      return deserialize<_if349ohh.MemoryBlock>(data['data']);
    }
    if (dataClassName == 'Mind') {
      return deserialize<_iqhk00ra.Mind>(data['data']);
    }
    if (dataClassName == 'UserFact') {
      return deserialize<_i8ng53gk.UserFact>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_irc0lure.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('wyrd', this);
    _iacs.Protocol().registerHostProtocol('wyrd', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i8fl0sel.ConversationTurn:
        return _i8fl0sel.ConversationTurn.t;
      case _ipo2nutw.CurriculumProgress:
        return _ipo2nutw.CurriculumProgress.t;
      case _i0u3uu6s.DiaryEntry:
        return _i0u3uu6s.DiaryEntry.t;
      case _izf9406n.DreamEntry:
        return _izf9406n.DreamEntry.t;
      case _iyj2s79k.GrowthSnapshot:
        return _iyj2s79k.GrowthSnapshot.t;
      case _i37ps124.LexiconEntry:
        return _i37ps124.LexiconEntry.t;
      case _if349ohh.MemoryBlock:
        return _if349ohh.MemoryBlock.t;
      case _iqhk00ra.Mind:
        return _iqhk00ra.Mind.t;
      case _irc0lure.UserProfile:
        return _irc0lure.UserProfile.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'wyrd';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
