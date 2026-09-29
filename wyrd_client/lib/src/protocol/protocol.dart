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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wyrd_client/src/protocol/drone/drone_mission.dart' as _ik7hqtb1;
import 'package:wyrd_client/src/protocol/mind/alert_note.dart' as _i4c7ehki;
import 'package:wyrd_client/src/protocol/mind/concept_example.dart'
    as _ihzd15h8;
import 'package:wyrd_client/src/protocol/mind/conversation_turn.dart'
    as _ie2belbc;
import 'package:wyrd_client/src/protocol/mind/cop_log_entry.dart' as _iudx1gwn;
import 'package:wyrd_client/src/protocol/mind/diary_entry.dart' as _iz65e3oe;
import 'package:wyrd_client/src/protocol/mind/dream_entry.dart' as _igmpa92d;
import 'package:wyrd_client/src/protocol/mind/feed_ingest.dart' as _ipp6qnor;
import 'package:wyrd_client/src/protocol/mind/growth_snapshot.dart'
    as _ikfbn3bp;
import 'package:wyrd_client/src/protocol/mind/memory_block.dart' as _ij6z6xwm;
import 'package:wyrd_client/src/protocol/mind/quiz_question.dart' as _i0wujsep;
import 'package:wyrd_client/src/protocol/mind/reading_item.dart' as _iqdaexua;
import 'package:wyrd_client/src/protocol/mind/reasoning_note.dart' as _ii1bv1u2;
import 'package:wyrd_client/src/protocol/mind/sighting.dart' as _ijttkw09;
import 'package:wyrd_client/src/protocol/mind/user_document.dart' as _imstbkek;
import 'package:wyrd_client/src/protocol/mind/work_hit.dart' as _iv7njdft;
import 'package:wyrd_client/src/protocol/mind/work_part_info.dart' as _iepby0e1;
import 'package:wyrd_client/src/protocol/mind/world_country.dart' as _iakrxk0g;
import 'drone/drone_mission.dart' as _idcsjt5k;
import 'drone/drone_plan_result.dart' as _i1bw7vkv;
import 'drone/drone_state.dart' as _it73791y;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'mind/account_export.dart' as _ij1ha6k5;
import 'mind/alert_note.dart' as _itui3kw8;
import 'mind/belief.dart' as _ijbewlez;
import 'mind/chat_action.dart' as _iagdrx9v;
import 'mind/chat_reply.dart' as _iav0lzqw;
import 'mind/chat_thread.dart' as _ildoeobn;
import 'mind/concept_detail.dart' as _idm2402p;
import 'mind/concept_edge.dart' as _iafou6mz;
import 'mind/concept_example.dart' as _igv7j4aa;
import 'mind/concept_graph.dart' as _iggcgqw1;
import 'mind/concept_node.dart' as _iapme6ge;
import 'mind/conversation_turn.dart' as _i8fl0sel;
import 'mind/cop_log_entry.dart' as _i9dbtrq4;
import 'mind/country_detail.dart' as _imll4whi;
import 'mind/country_weather.dart' as _iny43g8g;
import 'mind/curriculum_progress.dart' as _ipo2nutw;
import 'mind/curriculum_status.dart' as _iiwgxlwr;
import 'mind/diary_entry.dart' as _i0u3uu6s;
import 'mind/digest_info.dart' as _i9vbq77t;
import 'mind/document_upload.dart' as _il5hhvzk;
import 'mind/dream_entry.dart' as _izf9406n;
import 'mind/feed_ingest.dart' as _ig20dqq5;
import 'mind/filter_report.dart' as _idq6t4e8;
import 'mind/gate_shape.dart' as _i00qabwy;
import 'mind/growth_snapshot.dart' as _iyj2s79k;
import 'mind/ingest_day.dart' as _i6r7yxin;
import 'mind/judgement_report.dart' as _i2btkl9t;
import 'mind/learned_answer.dart' as _iexdo29m;
import 'mind/learning_stats.dart' as _icoxjjkt;
import 'mind/lexicon_entry.dart' as _i37ps124;
import 'mind/lexicon_stats.dart' as _ic2pi8fi;
import 'mind/lexicon_word_summary.dart' as _i7zu42sq;
import 'mind/llm_usage_day.dart' as _i1bjxjal;
import 'mind/llm_usage_user.dart' as _ij2us809;
import 'mind/maintenance_run.dart' as _inurj49q;
import 'mind/memory_block.dart' as _if349ohh;
import 'mind/mind.dart' as _iqhk00ra;
import 'mind/mind_topic.dart' as _ix6ukv82;
import 'mind/neural_network.dart' as _ievgcfdd;
import 'mind/quarantined_item.dart' as _i80jr0fe;
import 'mind/quiz_attempt.dart' as _i7m5h6h0;
import 'mind/quiz_question.dart' as _ijwrfvys;
import 'mind/quiz_stats.dart' as _iubv8onj;
import 'mind/rating_vote.dart' as _i50atwt4;
import 'mind/reading_item.dart' as _igsakn5u;
import 'mind/reading_slice.dart' as _i8yd85bs;
import 'mind/reasoning_note.dart' as _ik02x4l4;
import 'mind/self_config.dart' as _ig7bxoiw;
import 'mind/self_config_change.dart' as _ifocq1fp;
import 'mind/sighting.dart' as _isgvgh6k;
import 'mind/synapse.dart' as _i0pqq4fp;
import 'mind/system_status.dart' as _iw7p4jzd;
import 'mind/topic_info.dart' as _i8qpvcdz;
import 'mind/trust_report.dart' as _iud9b8mc;
import 'mind/trust_score.dart' as _i79dz7me;
import 'mind/user_document.dart' as _i0a2qxp3;
import 'mind/user_fact.dart' as _i8ng53gk;
import 'mind/user_profile.dart' as _irc0lure;
import 'mind/word_sense.dart' as _itj7bvl5;
import 'mind/work_hit.dart' as _i3gwmipu;
import 'mind/work_part_info.dart' as _ijuqu3gj;
import 'mind/world_country.dart' as _iu995zpj;
export 'drone/drone_mission.dart';
export 'drone/drone_plan_result.dart';
export 'drone/drone_state.dart';
export 'greetings/greeting.dart';
export 'mind/account_export.dart';
export 'mind/alert_note.dart';
export 'mind/belief.dart';
export 'mind/chat_action.dart';
export 'mind/chat_reply.dart';
export 'mind/chat_thread.dart';
export 'mind/concept_detail.dart';
export 'mind/concept_edge.dart';
export 'mind/concept_example.dart';
export 'mind/concept_graph.dart';
export 'mind/concept_node.dart';
export 'mind/conversation_turn.dart';
export 'mind/cop_log_entry.dart';
export 'mind/country_detail.dart';
export 'mind/country_weather.dart';
export 'mind/curriculum_progress.dart';
export 'mind/curriculum_status.dart';
export 'mind/diary_entry.dart';
export 'mind/digest_info.dart';
export 'mind/document_upload.dart';
export 'mind/dream_entry.dart';
export 'mind/feed_ingest.dart';
export 'mind/filter_report.dart';
export 'mind/gate_shape.dart';
export 'mind/growth_snapshot.dart';
export 'mind/ingest_day.dart';
export 'mind/judgement_report.dart';
export 'mind/learned_answer.dart';
export 'mind/learning_stats.dart';
export 'mind/lexicon_entry.dart';
export 'mind/lexicon_stats.dart';
export 'mind/lexicon_word_summary.dart';
export 'mind/llm_usage_day.dart';
export 'mind/llm_usage_user.dart';
export 'mind/maintenance_run.dart';
export 'mind/memory_block.dart';
export 'mind/mind.dart';
export 'mind/mind_topic.dart';
export 'mind/neural_network.dart';
export 'mind/quarantined_item.dart';
export 'mind/quiz_attempt.dart';
export 'mind/quiz_question.dart';
export 'mind/quiz_stats.dart';
export 'mind/rating_vote.dart';
export 'mind/reading_item.dart';
export 'mind/reading_slice.dart';
export 'mind/reasoning_note.dart';
export 'mind/self_config.dart';
export 'mind/self_config_change.dart';
export 'mind/sighting.dart';
export 'mind/synapse.dart';
export 'mind/system_status.dart';
export 'mind/topic_info.dart';
export 'mind/trust_report.dart';
export 'mind/trust_score.dart';
export 'mind/user_document.dart';
export 'mind/user_fact.dart';
export 'mind/user_profile.dart';
export 'mind/word_sense.dart';
export 'mind/work_hit.dart';
export 'mind/work_part_info.dart';
export 'mind/world_country.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _idcsjt5k.DroneMission) {
      return _idcsjt5k.DroneMission.fromJson(data) as T;
    }
    if (t == _i1bw7vkv.DronePlanResult) {
      return _i1bw7vkv.DronePlanResult.fromJson(data) as T;
    }
    if (t == _it73791y.DroneState) {
      return _it73791y.DroneState.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ij1ha6k5.AccountExport) {
      return _ij1ha6k5.AccountExport.fromJson(data) as T;
    }
    if (t == _itui3kw8.AlertNote) {
      return _itui3kw8.AlertNote.fromJson(data) as T;
    }
    if (t == _ijbewlez.Belief) {
      return _ijbewlez.Belief.fromJson(data) as T;
    }
    if (t == _iagdrx9v.ChatAction) {
      return _iagdrx9v.ChatAction.fromJson(data) as T;
    }
    if (t == _iav0lzqw.ChatReply) {
      return _iav0lzqw.ChatReply.fromJson(data) as T;
    }
    if (t == _ildoeobn.ChatThread) {
      return _ildoeobn.ChatThread.fromJson(data) as T;
    }
    if (t == _idm2402p.ConceptDetail) {
      return _idm2402p.ConceptDetail.fromJson(data) as T;
    }
    if (t == _iafou6mz.ConceptEdge) {
      return _iafou6mz.ConceptEdge.fromJson(data) as T;
    }
    if (t == _igv7j4aa.ConceptExample) {
      return _igv7j4aa.ConceptExample.fromJson(data) as T;
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
    if (t == _i9dbtrq4.CopLogEntry) {
      return _i9dbtrq4.CopLogEntry.fromJson(data) as T;
    }
    if (t == _imll4whi.CountryDetail) {
      return _imll4whi.CountryDetail.fromJson(data) as T;
    }
    if (t == _iny43g8g.CountryWeather) {
      return _iny43g8g.CountryWeather.fromJson(data) as T;
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
    if (t == _il5hhvzk.DocumentUpload) {
      return _il5hhvzk.DocumentUpload.fromJson(data) as T;
    }
    if (t == _izf9406n.DreamEntry) {
      return _izf9406n.DreamEntry.fromJson(data) as T;
    }
    if (t == _ig20dqq5.FeedIngest) {
      return _ig20dqq5.FeedIngest.fromJson(data) as T;
    }
    if (t == _idq6t4e8.FilterReport) {
      return _idq6t4e8.FilterReport.fromJson(data) as T;
    }
    if (t == _i00qabwy.GateShape) {
      return _i00qabwy.GateShape.fromJson(data) as T;
    }
    if (t == _iyj2s79k.GrowthSnapshot) {
      return _iyj2s79k.GrowthSnapshot.fromJson(data) as T;
    }
    if (t == _i6r7yxin.IngestDay) {
      return _i6r7yxin.IngestDay.fromJson(data) as T;
    }
    if (t == _i2btkl9t.JudgementReport) {
      return _i2btkl9t.JudgementReport.fromJson(data) as T;
    }
    if (t == _iexdo29m.LearnedAnswer) {
      return _iexdo29m.LearnedAnswer.fromJson(data) as T;
    }
    if (t == _icoxjjkt.LearningStats) {
      return _icoxjjkt.LearningStats.fromJson(data) as T;
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
    if (t == _i1bjxjal.LlmUsageDay) {
      return _i1bjxjal.LlmUsageDay.fromJson(data) as T;
    }
    if (t == _ij2us809.LlmUsageUser) {
      return _ij2us809.LlmUsageUser.fromJson(data) as T;
    }
    if (t == _inurj49q.MaintenanceRun) {
      return _inurj49q.MaintenanceRun.fromJson(data) as T;
    }
    if (t == _if349ohh.MemoryBlock) {
      return _if349ohh.MemoryBlock.fromJson(data) as T;
    }
    if (t == _iqhk00ra.Mind) {
      return _iqhk00ra.Mind.fromJson(data) as T;
    }
    if (t == _ix6ukv82.MindTopic) {
      return _ix6ukv82.MindTopic.fromJson(data) as T;
    }
    if (t == _ievgcfdd.NeuralNetwork) {
      return _ievgcfdd.NeuralNetwork.fromJson(data) as T;
    }
    if (t == _i80jr0fe.QuarantinedItem) {
      return _i80jr0fe.QuarantinedItem.fromJson(data) as T;
    }
    if (t == _i7m5h6h0.QuizAttempt) {
      return _i7m5h6h0.QuizAttempt.fromJson(data) as T;
    }
    if (t == _ijwrfvys.QuizQuestion) {
      return _ijwrfvys.QuizQuestion.fromJson(data) as T;
    }
    if (t == _iubv8onj.QuizStats) {
      return _iubv8onj.QuizStats.fromJson(data) as T;
    }
    if (t == _i50atwt4.RatingVote) {
      return _i50atwt4.RatingVote.fromJson(data) as T;
    }
    if (t == _igsakn5u.ReadingItem) {
      return _igsakn5u.ReadingItem.fromJson(data) as T;
    }
    if (t == _i8yd85bs.ReadingSlice) {
      return _i8yd85bs.ReadingSlice.fromJson(data) as T;
    }
    if (t == _ik02x4l4.ReasoningNote) {
      return _ik02x4l4.ReasoningNote.fromJson(data) as T;
    }
    if (t == _ig7bxoiw.SelfConfig) {
      return _ig7bxoiw.SelfConfig.fromJson(data) as T;
    }
    if (t == _ifocq1fp.SelfConfigChange) {
      return _ifocq1fp.SelfConfigChange.fromJson(data) as T;
    }
    if (t == _isgvgh6k.Sighting) {
      return _isgvgh6k.Sighting.fromJson(data) as T;
    }
    if (t == _i0pqq4fp.Synapse) {
      return _i0pqq4fp.Synapse.fromJson(data) as T;
    }
    if (t == _iw7p4jzd.SystemStatus) {
      return _iw7p4jzd.SystemStatus.fromJson(data) as T;
    }
    if (t == _i8qpvcdz.TopicInfo) {
      return _i8qpvcdz.TopicInfo.fromJson(data) as T;
    }
    if (t == _iud9b8mc.TrustReport) {
      return _iud9b8mc.TrustReport.fromJson(data) as T;
    }
    if (t == _i79dz7me.TrustScore) {
      return _i79dz7me.TrustScore.fromJson(data) as T;
    }
    if (t == _i0a2qxp3.UserDocument) {
      return _i0a2qxp3.UserDocument.fromJson(data) as T;
    }
    if (t == _i8ng53gk.UserFact) {
      return _i8ng53gk.UserFact.fromJson(data) as T;
    }
    if (t == _irc0lure.UserProfile) {
      return _irc0lure.UserProfile.fromJson(data) as T;
    }
    if (t == _itj7bvl5.WordSense) {
      return _itj7bvl5.WordSense.fromJson(data) as T;
    }
    if (t == _i3gwmipu.WorkHit) {
      return _i3gwmipu.WorkHit.fromJson(data) as T;
    }
    if (t == _ijuqu3gj.WorkPartInfo) {
      return _ijuqu3gj.WorkPartInfo.fromJson(data) as T;
    }
    if (t == _iu995zpj.WorldCountry) {
      return _iu995zpj.WorldCountry.fromJson(data) as T;
    }
    if (t == _isc.getType<_idcsjt5k.DroneMission?>()) {
      return (data != null ? _idcsjt5k.DroneMission.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1bw7vkv.DronePlanResult?>()) {
      return (data != null ? _i1bw7vkv.DronePlanResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_it73791y.DroneState?>()) {
      return (data != null ? _it73791y.DroneState.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ij1ha6k5.AccountExport?>()) {
      return (data != null ? _ij1ha6k5.AccountExport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_itui3kw8.AlertNote?>()) {
      return (data != null ? _itui3kw8.AlertNote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijbewlez.Belief?>()) {
      return (data != null ? _ijbewlez.Belief.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iagdrx9v.ChatAction?>()) {
      return (data != null ? _iagdrx9v.ChatAction.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iav0lzqw.ChatReply?>()) {
      return (data != null ? _iav0lzqw.ChatReply.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ildoeobn.ChatThread?>()) {
      return (data != null ? _ildoeobn.ChatThread.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idm2402p.ConceptDetail?>()) {
      return (data != null ? _idm2402p.ConceptDetail.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iafou6mz.ConceptEdge?>()) {
      return (data != null ? _iafou6mz.ConceptEdge.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igv7j4aa.ConceptExample?>()) {
      return (data != null ? _igv7j4aa.ConceptExample.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iggcgqw1.ConceptGraph?>()) {
      return (data != null ? _iggcgqw1.ConceptGraph.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iapme6ge.ConceptNode?>()) {
      return (data != null ? _iapme6ge.ConceptNode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8fl0sel.ConversationTurn?>()) {
      return (data != null ? _i8fl0sel.ConversationTurn.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9dbtrq4.CopLogEntry?>()) {
      return (data != null ? _i9dbtrq4.CopLogEntry.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imll4whi.CountryDetail?>()) {
      return (data != null ? _imll4whi.CountryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iny43g8g.CountryWeather?>()) {
      return (data != null ? _iny43g8g.CountryWeather.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipo2nutw.CurriculumProgress?>()) {
      return (data != null ? _ipo2nutw.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iiwgxlwr.CurriculumStatus?>()) {
      return (data != null ? _iiwgxlwr.CurriculumStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0u3uu6s.DiaryEntry?>()) {
      return (data != null ? _i0u3uu6s.DiaryEntry.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9vbq77t.DigestInfo?>()) {
      return (data != null ? _i9vbq77t.DigestInfo.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_il5hhvzk.DocumentUpload?>()) {
      return (data != null ? _il5hhvzk.DocumentUpload.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izf9406n.DreamEntry?>()) {
      return (data != null ? _izf9406n.DreamEntry.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ig20dqq5.FeedIngest?>()) {
      return (data != null ? _ig20dqq5.FeedIngest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idq6t4e8.FilterReport?>()) {
      return (data != null ? _idq6t4e8.FilterReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i00qabwy.GateShape?>()) {
      return (data != null ? _i00qabwy.GateShape.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyj2s79k.GrowthSnapshot?>()) {
      return (data != null ? _iyj2s79k.GrowthSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6r7yxin.IngestDay?>()) {
      return (data != null ? _i6r7yxin.IngestDay.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2btkl9t.JudgementReport?>()) {
      return (data != null ? _i2btkl9t.JudgementReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iexdo29m.LearnedAnswer?>()) {
      return (data != null ? _iexdo29m.LearnedAnswer.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icoxjjkt.LearningStats?>()) {
      return (data != null ? _icoxjjkt.LearningStats.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i37ps124.LexiconEntry?>()) {
      return (data != null ? _i37ps124.LexiconEntry.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ic2pi8fi.LexiconStats?>()) {
      return (data != null ? _ic2pi8fi.LexiconStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7zu42sq.LexiconWordSummary?>()) {
      return (data != null ? _i7zu42sq.LexiconWordSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1bjxjal.LlmUsageDay?>()) {
      return (data != null ? _i1bjxjal.LlmUsageDay.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ij2us809.LlmUsageUser?>()) {
      return (data != null ? _ij2us809.LlmUsageUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inurj49q.MaintenanceRun?>()) {
      return (data != null ? _inurj49q.MaintenanceRun.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_if349ohh.MemoryBlock?>()) {
      return (data != null ? _if349ohh.MemoryBlock.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqhk00ra.Mind?>()) {
      return (data != null ? _iqhk00ra.Mind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix6ukv82.MindTopic?>()) {
      return (data != null ? _ix6ukv82.MindTopic.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ievgcfdd.NeuralNetwork?>()) {
      return (data != null ? _ievgcfdd.NeuralNetwork.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i80jr0fe.QuarantinedItem?>()) {
      return (data != null ? _i80jr0fe.QuarantinedItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7m5h6h0.QuizAttempt?>()) {
      return (data != null ? _i7m5h6h0.QuizAttempt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijwrfvys.QuizQuestion?>()) {
      return (data != null ? _ijwrfvys.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iubv8onj.QuizStats?>()) {
      return (data != null ? _iubv8onj.QuizStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i50atwt4.RatingVote?>()) {
      return (data != null ? _i50atwt4.RatingVote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igsakn5u.ReadingItem?>()) {
      return (data != null ? _igsakn5u.ReadingItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8yd85bs.ReadingSlice?>()) {
      return (data != null ? _i8yd85bs.ReadingSlice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik02x4l4.ReasoningNote?>()) {
      return (data != null ? _ik02x4l4.ReasoningNote.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ig7bxoiw.SelfConfig?>()) {
      return (data != null ? _ig7bxoiw.SelfConfig.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifocq1fp.SelfConfigChange?>()) {
      return (data != null ? _ifocq1fp.SelfConfigChange.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isgvgh6k.Sighting?>()) {
      return (data != null ? _isgvgh6k.Sighting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0pqq4fp.Synapse?>()) {
      return (data != null ? _i0pqq4fp.Synapse.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iw7p4jzd.SystemStatus?>()) {
      return (data != null ? _iw7p4jzd.SystemStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8qpvcdz.TopicInfo?>()) {
      return (data != null ? _i8qpvcdz.TopicInfo.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iud9b8mc.TrustReport?>()) {
      return (data != null ? _iud9b8mc.TrustReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i79dz7me.TrustScore?>()) {
      return (data != null ? _i79dz7me.TrustScore.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0a2qxp3.UserDocument?>()) {
      return (data != null ? _i0a2qxp3.UserDocument.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8ng53gk.UserFact?>()) {
      return (data != null ? _i8ng53gk.UserFact.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irc0lure.UserProfile?>()) {
      return (data != null ? _irc0lure.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itj7bvl5.WordSense?>()) {
      return (data != null ? _itj7bvl5.WordSense.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3gwmipu.WorkHit?>()) {
      return (data != null ? _i3gwmipu.WorkHit.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijuqu3gj.WorkPartInfo?>()) {
      return (data != null ? _ijuqu3gj.WorkPartInfo.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu995zpj.WorldCountry?>()) {
      return (data != null ? _iu995zpj.WorldCountry.fromJson(data) : null) as T;
    }
    if (t == List<_i8ng53gk.UserFact>) {
      return (data as List)
              .map((e) => deserialize<_i8ng53gk.UserFact>(e))
              .toList()
          as T;
    }
    if (t == List<_i8fl0sel.ConversationTurn>) {
      return (data as List)
              .map((e) => deserialize<_i8fl0sel.ConversationTurn>(e))
              .toList()
          as T;
    }
    if (t == List<_isgvgh6k.Sighting>) {
      return (data as List)
              .map((e) => deserialize<_isgvgh6k.Sighting>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_isgvgh6k.Sighting>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_isgvgh6k.Sighting>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iexdo29m.LearnedAnswer>) {
      return (data as List)
              .map((e) => deserialize<_iexdo29m.LearnedAnswer>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iexdo29m.LearnedAnswer>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iexdo29m.LearnedAnswer>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_if349ohh.MemoryBlock>) {
      return (data as List)
              .map((e) => deserialize<_if349ohh.MemoryBlock>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_if349ohh.MemoryBlock>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_if349ohh.MemoryBlock>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_igsakn5u.ReadingItem>) {
      return (data as List)
              .map((e) => deserialize<_igsakn5u.ReadingItem>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_igsakn5u.ReadingItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_igsakn5u.ReadingItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i0a2qxp3.UserDocument>) {
      return (data as List)
              .map((e) => deserialize<_i0a2qxp3.UserDocument>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i0a2qxp3.UserDocument>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i0a2qxp3.UserDocument>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iapme6ge.ConceptNode>) {
      return (data as List)
              .map((e) => deserialize<_iapme6ge.ConceptNode>(e))
              .toList()
          as T;
    }
    if (t == List<_igv7j4aa.ConceptExample>) {
      return (data as List)
              .map((e) => deserialize<_igv7j4aa.ConceptExample>(e))
              .toList()
          as T;
    }
    if (t == List<_iafou6mz.ConceptEdge>) {
      return (data as List)
              .map((e) => deserialize<_iafou6mz.ConceptEdge>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i80jr0fe.QuarantinedItem>) {
      return (data as List)
              .map((e) => deserialize<_i80jr0fe.QuarantinedItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i7zu42sq.LexiconWordSummary>) {
      return (data as List)
              .map((e) => deserialize<_i7zu42sq.LexiconWordSummary>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i0pqq4fp.Synapse>) {
      return (data as List)
              .map((e) => deserialize<_i0pqq4fp.Synapse>(e))
              .toList()
          as T;
    }
    if (t == List<_ifocq1fp.SelfConfigChange>) {
      return (data as List)
              .map((e) => deserialize<_ifocq1fp.SelfConfigChange>(e))
              .toList()
          as T;
    }
    if (t == List<_i79dz7me.TrustScore>) {
      return (data as List)
              .map((e) => deserialize<_i79dz7me.TrustScore>(e))
              .toList()
          as T;
    }
    if (t == List<_ik7hqtb1.DroneMission>) {
      return (data as List)
              .map((e) => deserialize<_ik7hqtb1.DroneMission>(e))
              .toList()
          as T;
    }
    if (t == List<_i4c7ehki.AlertNote>) {
      return (data as List)
              .map((e) => deserialize<_i4c7ehki.AlertNote>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_ie2belbc.ConversationTurn>) {
      return (data as List)
              .map((e) => deserialize<_ie2belbc.ConversationTurn>(e))
              .toList()
          as T;
    }
    if (t == List<_iz65e3oe.DiaryEntry>) {
      return (data as List)
              .map((e) => deserialize<_iz65e3oe.DiaryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_imstbkek.UserDocument>) {
      return (data as List)
              .map((e) => deserialize<_imstbkek.UserDocument>(e))
              .toList()
          as T;
    }
    if (t == List<_igmpa92d.DreamEntry>) {
      return (data as List)
              .map((e) => deserialize<_igmpa92d.DreamEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_ihzd15h8.ConceptExample>) {
      return (data as List)
              .map((e) => deserialize<_ihzd15h8.ConceptExample>(e))
              .toList()
          as T;
    }
    if (t == List<_ipp6qnor.FeedIngest>) {
      return (data as List)
              .map((e) => deserialize<_ipp6qnor.FeedIngest>(e))
              .toList()
          as T;
    }
    if (t == List<_ikfbn3bp.GrowthSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_ikfbn3bp.GrowthSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_iqdaexua.ReadingItem>) {
      return (data as List)
              .map((e) => deserialize<_iqdaexua.ReadingItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i0wujsep.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i0wujsep.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == List<_iepby0e1.WorkPartInfo>) {
      return (data as List)
              .map((e) => deserialize<_iepby0e1.WorkPartInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_iv7njdft.WorkHit>) {
      return (data as List)
              .map((e) => deserialize<_iv7njdft.WorkHit>(e))
              .toList()
          as T;
    }
    if (t == List<_ij6z6xwm.MemoryBlock>) {
      return (data as List)
              .map((e) => deserialize<_ij6z6xwm.MemoryBlock>(e))
              .toList()
          as T;
    }
    if (t == List<_ijttkw09.Sighting>) {
      return (data as List)
              .map((e) => deserialize<_ijttkw09.Sighting>(e))
              .toList()
          as T;
    }
    if (t == List<_ii1bv1u2.ReasoningNote>) {
      return (data as List)
              .map((e) => deserialize<_ii1bv1u2.ReasoningNote>(e))
              .toList()
          as T;
    }
    if (t == List<_iudx1gwn.CopLogEntry>) {
      return (data as List)
              .map((e) => deserialize<_iudx1gwn.CopLogEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_iakrxk0g.WorldCountry>) {
      return (data as List)
              .map((e) => deserialize<_iakrxk0g.WorldCountry>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _idcsjt5k.DroneMission => 'DroneMission',
      _i1bw7vkv.DronePlanResult => 'DronePlanResult',
      _it73791y.DroneState => 'DroneState',
      _izw8z7ou.Greeting => 'Greeting',
      _ij1ha6k5.AccountExport => 'AccountExport',
      _itui3kw8.AlertNote => 'AlertNote',
      _ijbewlez.Belief => 'Belief',
      _iagdrx9v.ChatAction => 'ChatAction',
      _iav0lzqw.ChatReply => 'ChatReply',
      _ildoeobn.ChatThread => 'ChatThread',
      _idm2402p.ConceptDetail => 'ConceptDetail',
      _iafou6mz.ConceptEdge => 'ConceptEdge',
      _igv7j4aa.ConceptExample => 'ConceptExample',
      _iggcgqw1.ConceptGraph => 'ConceptGraph',
      _iapme6ge.ConceptNode => 'ConceptNode',
      _i8fl0sel.ConversationTurn => 'ConversationTurn',
      _i9dbtrq4.CopLogEntry => 'CopLogEntry',
      _imll4whi.CountryDetail => 'CountryDetail',
      _iny43g8g.CountryWeather => 'CountryWeather',
      _ipo2nutw.CurriculumProgress => 'CurriculumProgress',
      _iiwgxlwr.CurriculumStatus => 'CurriculumStatus',
      _i0u3uu6s.DiaryEntry => 'DiaryEntry',
      _i9vbq77t.DigestInfo => 'DigestInfo',
      _il5hhvzk.DocumentUpload => 'DocumentUpload',
      _izf9406n.DreamEntry => 'DreamEntry',
      _ig20dqq5.FeedIngest => 'FeedIngest',
      _idq6t4e8.FilterReport => 'FilterReport',
      _i00qabwy.GateShape => 'GateShape',
      _iyj2s79k.GrowthSnapshot => 'GrowthSnapshot',
      _i6r7yxin.IngestDay => 'IngestDay',
      _i2btkl9t.JudgementReport => 'JudgementReport',
      _iexdo29m.LearnedAnswer => 'LearnedAnswer',
      _icoxjjkt.LearningStats => 'LearningStats',
      _i37ps124.LexiconEntry => 'LexiconEntry',
      _ic2pi8fi.LexiconStats => 'LexiconStats',
      _i7zu42sq.LexiconWordSummary => 'LexiconWordSummary',
      _i1bjxjal.LlmUsageDay => 'LlmUsageDay',
      _ij2us809.LlmUsageUser => 'LlmUsageUser',
      _inurj49q.MaintenanceRun => 'MaintenanceRun',
      _if349ohh.MemoryBlock => 'MemoryBlock',
      _iqhk00ra.Mind => 'Mind',
      _ix6ukv82.MindTopic => 'MindTopic',
      _ievgcfdd.NeuralNetwork => 'NeuralNetwork',
      _i80jr0fe.QuarantinedItem => 'QuarantinedItem',
      _i7m5h6h0.QuizAttempt => 'QuizAttempt',
      _ijwrfvys.QuizQuestion => 'QuizQuestion',
      _iubv8onj.QuizStats => 'QuizStats',
      _i50atwt4.RatingVote => 'RatingVote',
      _igsakn5u.ReadingItem => 'ReadingItem',
      _i8yd85bs.ReadingSlice => 'ReadingSlice',
      _ik02x4l4.ReasoningNote => 'ReasoningNote',
      _ig7bxoiw.SelfConfig => 'SelfConfig',
      _ifocq1fp.SelfConfigChange => 'SelfConfigChange',
      _isgvgh6k.Sighting => 'Sighting',
      _i0pqq4fp.Synapse => 'Synapse',
      _iw7p4jzd.SystemStatus => 'SystemStatus',
      _i8qpvcdz.TopicInfo => 'TopicInfo',
      _iud9b8mc.TrustReport => 'TrustReport',
      _i79dz7me.TrustScore => 'TrustScore',
      _i0a2qxp3.UserDocument => 'UserDocument',
      _i8ng53gk.UserFact => 'UserFact',
      _irc0lure.UserProfile => 'UserProfile',
      _itj7bvl5.WordSense => 'WordSense',
      _i3gwmipu.WorkHit => 'WorkHit',
      _ijuqu3gj.WorkPartInfo => 'WorkPartInfo',
      _iu995zpj.WorldCountry => 'WorldCountry',
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
      case _idcsjt5k.DroneMission():
        return 'DroneMission';
      case _i1bw7vkv.DronePlanResult():
        return 'DronePlanResult';
      case _it73791y.DroneState():
        return 'DroneState';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ij1ha6k5.AccountExport():
        return 'AccountExport';
      case _itui3kw8.AlertNote():
        return 'AlertNote';
      case _ijbewlez.Belief():
        return 'Belief';
      case _iagdrx9v.ChatAction():
        return 'ChatAction';
      case _iav0lzqw.ChatReply():
        return 'ChatReply';
      case _ildoeobn.ChatThread():
        return 'ChatThread';
      case _idm2402p.ConceptDetail():
        return 'ConceptDetail';
      case _iafou6mz.ConceptEdge():
        return 'ConceptEdge';
      case _igv7j4aa.ConceptExample():
        return 'ConceptExample';
      case _iggcgqw1.ConceptGraph():
        return 'ConceptGraph';
      case _iapme6ge.ConceptNode():
        return 'ConceptNode';
      case _i8fl0sel.ConversationTurn():
        return 'ConversationTurn';
      case _i9dbtrq4.CopLogEntry():
        return 'CopLogEntry';
      case _imll4whi.CountryDetail():
        return 'CountryDetail';
      case _iny43g8g.CountryWeather():
        return 'CountryWeather';
      case _ipo2nutw.CurriculumProgress():
        return 'CurriculumProgress';
      case _iiwgxlwr.CurriculumStatus():
        return 'CurriculumStatus';
      case _i0u3uu6s.DiaryEntry():
        return 'DiaryEntry';
      case _i9vbq77t.DigestInfo():
        return 'DigestInfo';
      case _il5hhvzk.DocumentUpload():
        return 'DocumentUpload';
      case _izf9406n.DreamEntry():
        return 'DreamEntry';
      case _ig20dqq5.FeedIngest():
        return 'FeedIngest';
      case _idq6t4e8.FilterReport():
        return 'FilterReport';
      case _i00qabwy.GateShape():
        return 'GateShape';
      case _iyj2s79k.GrowthSnapshot():
        return 'GrowthSnapshot';
      case _i6r7yxin.IngestDay():
        return 'IngestDay';
      case _i2btkl9t.JudgementReport():
        return 'JudgementReport';
      case _iexdo29m.LearnedAnswer():
        return 'LearnedAnswer';
      case _icoxjjkt.LearningStats():
        return 'LearningStats';
      case _i37ps124.LexiconEntry():
        return 'LexiconEntry';
      case _ic2pi8fi.LexiconStats():
        return 'LexiconStats';
      case _i7zu42sq.LexiconWordSummary():
        return 'LexiconWordSummary';
      case _i1bjxjal.LlmUsageDay():
        return 'LlmUsageDay';
      case _ij2us809.LlmUsageUser():
        return 'LlmUsageUser';
      case _inurj49q.MaintenanceRun():
        return 'MaintenanceRun';
      case _if349ohh.MemoryBlock():
        return 'MemoryBlock';
      case _iqhk00ra.Mind():
        return 'Mind';
      case _ix6ukv82.MindTopic():
        return 'MindTopic';
      case _ievgcfdd.NeuralNetwork():
        return 'NeuralNetwork';
      case _i80jr0fe.QuarantinedItem():
        return 'QuarantinedItem';
      case _i7m5h6h0.QuizAttempt():
        return 'QuizAttempt';
      case _ijwrfvys.QuizQuestion():
        return 'QuizQuestion';
      case _iubv8onj.QuizStats():
        return 'QuizStats';
      case _i50atwt4.RatingVote():
        return 'RatingVote';
      case _igsakn5u.ReadingItem():
        return 'ReadingItem';
      case _i8yd85bs.ReadingSlice():
        return 'ReadingSlice';
      case _ik02x4l4.ReasoningNote():
        return 'ReasoningNote';
      case _ig7bxoiw.SelfConfig():
        return 'SelfConfig';
      case _ifocq1fp.SelfConfigChange():
        return 'SelfConfigChange';
      case _isgvgh6k.Sighting():
        return 'Sighting';
      case _i0pqq4fp.Synapse():
        return 'Synapse';
      case _iw7p4jzd.SystemStatus():
        return 'SystemStatus';
      case _i8qpvcdz.TopicInfo():
        return 'TopicInfo';
      case _iud9b8mc.TrustReport():
        return 'TrustReport';
      case _i79dz7me.TrustScore():
        return 'TrustScore';
      case _i0a2qxp3.UserDocument():
        return 'UserDocument';
      case _i8ng53gk.UserFact():
        return 'UserFact';
      case _irc0lure.UserProfile():
        return 'UserProfile';
      case _itj7bvl5.WordSense():
        return 'WordSense';
      case _i3gwmipu.WorkHit():
        return 'WorkHit';
      case _ijuqu3gj.WorkPartInfo():
        return 'WorkPartInfo';
      case _iu995zpj.WorldCountry():
        return 'WorldCountry';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'DroneMission') {
      return deserialize<_idcsjt5k.DroneMission>(data['data']);
    }
    if (dataClassName == 'DronePlanResult') {
      return deserialize<_i1bw7vkv.DronePlanResult>(data['data']);
    }
    if (dataClassName == 'DroneState') {
      return deserialize<_it73791y.DroneState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'AccountExport') {
      return deserialize<_ij1ha6k5.AccountExport>(data['data']);
    }
    if (dataClassName == 'AlertNote') {
      return deserialize<_itui3kw8.AlertNote>(data['data']);
    }
    if (dataClassName == 'Belief') {
      return deserialize<_ijbewlez.Belief>(data['data']);
    }
    if (dataClassName == 'ChatAction') {
      return deserialize<_iagdrx9v.ChatAction>(data['data']);
    }
    if (dataClassName == 'ChatReply') {
      return deserialize<_iav0lzqw.ChatReply>(data['data']);
    }
    if (dataClassName == 'ChatThread') {
      return deserialize<_ildoeobn.ChatThread>(data['data']);
    }
    if (dataClassName == 'ConceptDetail') {
      return deserialize<_idm2402p.ConceptDetail>(data['data']);
    }
    if (dataClassName == 'ConceptEdge') {
      return deserialize<_iafou6mz.ConceptEdge>(data['data']);
    }
    if (dataClassName == 'ConceptExample') {
      return deserialize<_igv7j4aa.ConceptExample>(data['data']);
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
    if (dataClassName == 'CopLogEntry') {
      return deserialize<_i9dbtrq4.CopLogEntry>(data['data']);
    }
    if (dataClassName == 'CountryDetail') {
      return deserialize<_imll4whi.CountryDetail>(data['data']);
    }
    if (dataClassName == 'CountryWeather') {
      return deserialize<_iny43g8g.CountryWeather>(data['data']);
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
    if (dataClassName == 'DocumentUpload') {
      return deserialize<_il5hhvzk.DocumentUpload>(data['data']);
    }
    if (dataClassName == 'DreamEntry') {
      return deserialize<_izf9406n.DreamEntry>(data['data']);
    }
    if (dataClassName == 'FeedIngest') {
      return deserialize<_ig20dqq5.FeedIngest>(data['data']);
    }
    if (dataClassName == 'FilterReport') {
      return deserialize<_idq6t4e8.FilterReport>(data['data']);
    }
    if (dataClassName == 'GateShape') {
      return deserialize<_i00qabwy.GateShape>(data['data']);
    }
    if (dataClassName == 'GrowthSnapshot') {
      return deserialize<_iyj2s79k.GrowthSnapshot>(data['data']);
    }
    if (dataClassName == 'IngestDay') {
      return deserialize<_i6r7yxin.IngestDay>(data['data']);
    }
    if (dataClassName == 'JudgementReport') {
      return deserialize<_i2btkl9t.JudgementReport>(data['data']);
    }
    if (dataClassName == 'LearnedAnswer') {
      return deserialize<_iexdo29m.LearnedAnswer>(data['data']);
    }
    if (dataClassName == 'LearningStats') {
      return deserialize<_icoxjjkt.LearningStats>(data['data']);
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
    if (dataClassName == 'LlmUsageDay') {
      return deserialize<_i1bjxjal.LlmUsageDay>(data['data']);
    }
    if (dataClassName == 'LlmUsageUser') {
      return deserialize<_ij2us809.LlmUsageUser>(data['data']);
    }
    if (dataClassName == 'MaintenanceRun') {
      return deserialize<_inurj49q.MaintenanceRun>(data['data']);
    }
    if (dataClassName == 'MemoryBlock') {
      return deserialize<_if349ohh.MemoryBlock>(data['data']);
    }
    if (dataClassName == 'Mind') {
      return deserialize<_iqhk00ra.Mind>(data['data']);
    }
    if (dataClassName == 'MindTopic') {
      return deserialize<_ix6ukv82.MindTopic>(data['data']);
    }
    if (dataClassName == 'NeuralNetwork') {
      return deserialize<_ievgcfdd.NeuralNetwork>(data['data']);
    }
    if (dataClassName == 'QuarantinedItem') {
      return deserialize<_i80jr0fe.QuarantinedItem>(data['data']);
    }
    if (dataClassName == 'QuizAttempt') {
      return deserialize<_i7m5h6h0.QuizAttempt>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_ijwrfvys.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'QuizStats') {
      return deserialize<_iubv8onj.QuizStats>(data['data']);
    }
    if (dataClassName == 'RatingVote') {
      return deserialize<_i50atwt4.RatingVote>(data['data']);
    }
    if (dataClassName == 'ReadingItem') {
      return deserialize<_igsakn5u.ReadingItem>(data['data']);
    }
    if (dataClassName == 'ReadingSlice') {
      return deserialize<_i8yd85bs.ReadingSlice>(data['data']);
    }
    if (dataClassName == 'ReasoningNote') {
      return deserialize<_ik02x4l4.ReasoningNote>(data['data']);
    }
    if (dataClassName == 'SelfConfig') {
      return deserialize<_ig7bxoiw.SelfConfig>(data['data']);
    }
    if (dataClassName == 'SelfConfigChange') {
      return deserialize<_ifocq1fp.SelfConfigChange>(data['data']);
    }
    if (dataClassName == 'Sighting') {
      return deserialize<_isgvgh6k.Sighting>(data['data']);
    }
    if (dataClassName == 'Synapse') {
      return deserialize<_i0pqq4fp.Synapse>(data['data']);
    }
    if (dataClassName == 'SystemStatus') {
      return deserialize<_iw7p4jzd.SystemStatus>(data['data']);
    }
    if (dataClassName == 'TopicInfo') {
      return deserialize<_i8qpvcdz.TopicInfo>(data['data']);
    }
    if (dataClassName == 'TrustReport') {
      return deserialize<_iud9b8mc.TrustReport>(data['data']);
    }
    if (dataClassName == 'TrustScore') {
      return deserialize<_i79dz7me.TrustScore>(data['data']);
    }
    if (dataClassName == 'UserDocument') {
      return deserialize<_i0a2qxp3.UserDocument>(data['data']);
    }
    if (dataClassName == 'UserFact') {
      return deserialize<_i8ng53gk.UserFact>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_irc0lure.UserProfile>(data['data']);
    }
    if (dataClassName == 'WordSense') {
      return deserialize<_itj7bvl5.WordSense>(data['data']);
    }
    if (dataClassName == 'WorkHit') {
      return deserialize<_i3gwmipu.WorkHit>(data['data']);
    }
    if (dataClassName == 'WorkPartInfo') {
      return deserialize<_ijuqu3gj.WorkPartInfo>(data['data']);
    }
    if (dataClassName == 'WorldCountry') {
      return deserialize<_iu995zpj.WorldCountry>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('wyrd', this);
    _iacc.Protocol().registerHostProtocol('wyrd', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
