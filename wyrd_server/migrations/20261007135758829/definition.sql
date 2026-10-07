BEGIN;

--
-- CREATE VECTOR EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'vector') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS vector';
  ELSE
    RAISE EXCEPTION 'Required extension "vector" is not available on this instance. Please install pgvector. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-pgvector.';
  END IF;
END
$$;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AgentStep as table agent_step
--
CREATE TABLE "agent_step" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "run" bigint NOT NULL,
    "at" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "tool" text,
    "detail" text NOT NULL,
    "output" text
);

-- Indexes
CREATE INDEX "agent_step_task_idx" ON "agent_step" USING btree ("taskId", "at");

--
-- Class AgentTask as table agent_task
--
CREATE TABLE "agent_task" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "goal" text NOT NULL,
    "everyHours" bigint,
    "status" text NOT NULL,
    "result" text,
    "previousResult" text,
    "notes" text,
    "transcript" text,
    "pendingAction" text,
    "stepsUsed" bigint NOT NULL,
    "maxSteps" bigint NOT NULL,
    "runs" bigint NOT NULL,
    "unread" boolean NOT NULL,
    "nextRunAt" timestamp without time zone NOT NULL,
    "lastRunAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "agent_task_user_idx" ON "agent_task" USING btree ("authUserId", "status");
CREATE INDEX "agent_task_due_idx" ON "agent_task" USING btree ("status", "nextRunAt");

--
-- Class Belief as table belief
--
CREATE TABLE "belief" (
    "id" bigserial PRIMARY KEY,
    "a" text NOT NULL,
    "b" text NOT NULL,
    "claim" text NOT NULL,
    "evidenceIds" json NOT NULL,
    "sources" bigint NOT NULL,
    "against" bigint NOT NULL,
    "confidence" double precision NOT NULL,
    "status" text NOT NULL,
    "origin" text NOT NULL,
    "tests" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "testedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "belief_pair_idx" ON "belief" USING btree ("a", "b");
CREATE INDEX "belief_tested_idx" ON "belief" USING btree ("testedAt");

--
-- Class ChatThread as table chat_thread
--
CREATE TABLE "chat_thread" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "subject" json NOT NULL,
    "lastReadUrl" text,
    "lastReadTitle" text,
    "lastReadItemId" bigint,
    "lastPassage" text,
    "lastDocumentId" bigint,
    "lastDocumentName" text,
    "documentAt" timestamp without time zone,
    "nextOffset" bigint,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "chat_thread_user_idx" ON "chat_thread" USING btree ("authUserId");

--
-- Class CityCharter as table city_charter
--
CREATE TABLE "city_charter" (
    "id" bigserial PRIMARY KEY,
    "charter" text NOT NULL,
    "missions" text NOT NULL,
    "author" text NOT NULL,
    "writtenAt" timestamp without time zone NOT NULL
);

--
-- Class CityDesignNote as table city_design_note
--
CREATE TABLE "city_design_note" (
    "id" bigserial PRIMARY KEY,
    "author" text NOT NULL,
    "kind" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "payload" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "decidedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "city_design_note_status_idx" ON "city_design_note" USING btree ("status");

--
-- Class ConversationTurn as table conversation_turn
--
CREATE TABLE "conversation_turn" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "userText" text NOT NULL,
    "botText" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "learnedAnswerId" bigint,
    "rating" bigint,
    "judgement" text,
    "groundingIds" json
);

-- Indexes
CREATE INDEX "conversation_turn_auth_user_id_idx" ON "conversation_turn" USING btree ("authUserId");

--
-- Class CopLogEntry as table cop_log_entry
--
CREATE TABLE "cop_log_entry" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "configKey" text NOT NULL,
    "oldValueJson" text NOT NULL,
    "newValueJson" text NOT NULL,
    "reason" text NOT NULL,
    "verdict" text NOT NULL
);

-- Indexes
CREATE INDEX "cop_log_entry_timestamp_idx" ON "cop_log_entry" USING btree ("timestamp");

--
-- Class CurriculumProgress as table curriculum_progress
--
CREATE TABLE "curriculum_progress" (
    "id" bigserial PRIMARY KEY,
    "index" bigint NOT NULL,
    "completedTitles" json NOT NULL
);

--
-- Class DiaryEntry as table diary_entry
--
CREATE TABLE "diary_entry" (
    "id" bigserial PRIMARY KEY,
    "date" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "content" text NOT NULL
);

-- Indexes
CREATE INDEX "diary_entry_timestamp_idx" ON "diary_entry" USING btree ("timestamp");

--
-- Class DreamEntry as table dream_entry
--
CREATE TABLE "dream_entry" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "content" text NOT NULL,
    "sourceBlockIds" json NOT NULL
);

-- Indexes
CREATE INDEX "dream_entry_timestamp_idx" ON "dream_entry" USING btree ("timestamp");

--
-- Class DroneMission as table drone_mission
--
CREATE TABLE "drone_mission" (
    "id" bigserial PRIMARY KEY,
    "droneId" text NOT NULL,
    "kind" text NOT NULL,
    "instruction" text NOT NULL,
    "summary" text NOT NULL,
    "stepsJson" text NOT NULL,
    "status" text NOT NULL,
    "reason" text,
    "createdBy" uuid,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "drone_mission_drone_status_idx" ON "drone_mission" USING btree ("droneId", "status");

--
-- Class DroneState as table drone_state
--
CREATE TABLE "drone_state" (
    "id" bigserial PRIMARY KEY,
    "droneId" text NOT NULL,
    "connected" boolean NOT NULL,
    "armed" boolean NOT NULL,
    "mode" text,
    "lat" double precision,
    "lon" double precision,
    "relativeAltM" double precision,
    "headingDeg" double precision,
    "groundSpeedMs" double precision,
    "batteryPct" bigint,
    "gpsFix" bigint,
    "satellites" bigint,
    "homeLat" double precision,
    "homeLon" double precision,
    "missionStatus" text,
    "missionStep" bigint,
    "missionError" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "drone_state_drone_id_idx" ON "drone_state" USING btree ("droneId");

--
-- Class GameExchange as table game_exchange
--
CREATE TABLE "game_exchange" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "channel" text NOT NULL,
    "situation" text NOT NULL,
    "said" text NOT NULL,
    "reply" text NOT NULL,
    "actions" text NOT NULL,
    "outcome" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "game_exchange_user_idx" ON "game_exchange" USING btree ("authUserId");
CREATE INDEX "game_exchange_created_idx" ON "game_exchange" USING btree ("createdAt");

--
-- Class GameMatch as table game_match
--
CREATE TABLE "game_match" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "game" text NOT NULL,
    "state" text NOT NULL,
    "moves" json NOT NULL,
    "playerSide" text NOT NULL,
    "status" text NOT NULL,
    "wyrdLevel" bigint NOT NULL,
    "ratingBefore" double precision NOT NULL,
    "ratingAfter" double precision,
    "remark" text,
    "mode" text NOT NULL DEFAULT 'wyrd'::text,
    "opponentId" uuid,
    "playerName" text,
    "opponentName" text,
    "result" text,
    "version" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "game_match_user_idx" ON "game_match" USING btree ("authUserId", "status");
CREATE INDEX "game_match_open_idx" ON "game_match" USING btree ("game", "mode", "status");
CREATE INDEX "game_match_opponent_idx" ON "game_match" USING btree ("opponentId", "status");

--
-- Class GrowthSnapshot as table growth_snapshot
--
CREATE TABLE "growth_snapshot" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "vocabCount" bigint NOT NULL,
    "blockCount" bigint NOT NULL,
    "digestPercent" double precision NOT NULL,
    "curiosity" double precision NOT NULL,
    "confidence" double precision NOT NULL
);

-- Indexes
CREATE INDEX "growth_snapshot_timestamp_idx" ON "growth_snapshot" USING btree ("timestamp");

--
-- Class IngestDay as table ingest_day
--
CREATE TABLE "ingest_day" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "kept" bigint NOT NULL,
    "duplicates" bigint NOT NULL,
    "quarantined" bigint NOT NULL,
    "reasons" json NOT NULL,
    "categories" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "ingest_day_day_idx" ON "ingest_day" USING btree ("day");

--
-- Class LearnedAnswer as table learned_answer
--
CREATE TABLE "learned_answer" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid,
    "question" text NOT NULL,
    "intent" text NOT NULL,
    "topics" json NOT NULL,
    "answer" text NOT NULL,
    "score" double precision NOT NULL,
    "uses" bigint NOT NULL,
    "version" bigint NOT NULL,
    "retired" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "embedding" vector(512)
);

-- Indexes
CREATE INDEX "learned_answer_embedding_idx" ON "learned_answer" USING hnsw ("embedding" vector_cosine_ops);
CREATE INDEX "learned_answer_intent_idx" ON "learned_answer" USING btree ("intent", "retired");

--
-- Class LexiconEntry as table lexicon_entry
--
CREATE TABLE "lexicon_entry" (
    "id" bigserial PRIMARY KEY,
    "word" text NOT NULL,
    "understood" boolean NOT NULL,
    "definition" text,
    "partOfSpeech" text,
    "learnedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "lexicon_entry_word_idx" ON "lexicon_entry" USING btree ("word");

--
-- Class LlmUsageDay as table llm_usage_day
--
CREATE TABLE "llm_usage_day" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "costMicroUsd" bigint NOT NULL,
    "calls" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "llm_usage_day_day_idx" ON "llm_usage_day" USING btree ("day");

--
-- Class LlmUsageUser as table llm_usage_user
--
CREATE TABLE "llm_usage_user" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "authUserId" uuid NOT NULL,
    "costMicroUsd" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "llm_usage_user_day_idx" ON "llm_usage_user" USING btree ("day", "authUserId");

--
-- Class MaintenanceRun as table maintenance_run
--
CREATE TABLE "maintenance_run" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "ranAt" timestamp without time zone NOT NULL,
    "note" text
);

-- Indexes
CREATE UNIQUE INDEX "maintenance_run_name_idx" ON "maintenance_run" USING btree ("name");

--
-- Class MemoryBlock as table memory_block
--
CREATE TABLE "memory_block" (
    "id" bigserial PRIMARY KEY,
    "legacyId" text,
    "timestamp" timestamp without time zone NOT NULL,
    "source" text NOT NULL,
    "feedSource" text,
    "title" text,
    "extract" text,
    "url" text,
    "userText" text,
    "botText" text,
    "triggeredBy" text,
    "topics" json NOT NULL,
    "curriculumSubject" text,
    "curriculumLevel" text,
    "question" text,
    "answer" text,
    "answeredTopic" text,
    "insight" text,
    "sourceBlockIds" json,
    "sourceTopics" json,
    "quality" double precision,
    "category" text,
    "embedding" vector(512),
    "ownerId" uuid
);

-- Indexes
CREATE INDEX "memory_block_owner_idx" ON "memory_block" USING btree ("ownerId");
CREATE INDEX "memory_block_embedding_idx" ON "memory_block" USING hnsw ("embedding" vector_cosine_ops);
CREATE INDEX "memory_block_timestamp_idx" ON "memory_block" USING btree ("timestamp");

--
-- Class Mind as table mind
--
CREATE TABLE "mind" (
    "id" bigserial PRIMARY KEY,
    "mood" text NOT NULL,
    "focusTopic" text,
    "activeGoal" text,
    "curiosity" double precision NOT NULL,
    "confidence" double precision NOT NULL,
    "digest" json NOT NULL,
    "lastEvent" text,
    "explorationCount" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "selfAnswerTimestamps" json NOT NULL
);

--
-- Class MindTopic as table mind_topic
--
CREATE TABLE "mind_topic" (
    "id" bigserial PRIMARY KEY,
    "topic" text NOT NULL,
    "resolved" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "mind_topic_topic_idx" ON "mind_topic" USING btree ("topic");

--
-- Class PlayerCharacter as table player_character
--
CREATE TABLE "player_character" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "base" text NOT NULL,
    "outfit" bigint NOT NULL DEFAULT 0,
    "name" text NOT NULL,
    "height" double precision NOT NULL,
    "build" double precision NOT NULL,
    "shoulders" double precision NOT NULL,
    "hips" double precision NOT NULL,
    "skin" double precision NOT NULL,
    "outfitHue" double precision NOT NULL,
    "neon" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "player_character_user_idx" ON "player_character" USING btree ("authUserId");

--
-- Class PlayerRating as table player_rating
--
CREATE TABLE "player_rating" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "game" text NOT NULL,
    "name" text NOT NULL,
    "rating" double precision NOT NULL,
    "played" bigint NOT NULL,
    "wins" bigint NOT NULL,
    "losses" bigint NOT NULL,
    "draws" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "player_rating_user_game_idx" ON "player_rating" USING btree ("authUserId", "game");
CREATE INDEX "player_rating_board_idx" ON "player_rating" USING btree ("game", "rating");

--
-- Class QuarantinedItem as table quarantined_item
--
CREATE TABLE "quarantined_item" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "source" text NOT NULL,
    "title" text NOT NULL,
    "url" text,
    "extract" text,
    "score" double precision NOT NULL,
    "reasons" json NOT NULL
);

-- Indexes
CREATE INDEX "quarantined_item_time_idx" ON "quarantined_item" USING btree ("timestamp");

--
-- Class QuizAttempt as table quiz_attempt
--
CREATE TABLE "quiz_attempt" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "readingItemId" bigint,
    "title" text NOT NULL,
    "correct" bigint NOT NULL,
    "total" bigint NOT NULL,
    "missed" json NOT NULL,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "quiz_attempt_user_idx" ON "quiz_attempt" USING btree ("authUserId", "at");

--
-- Class RatingVote as table rating_vote
--
CREATE TABLE "rating_vote" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "kind" text NOT NULL,
    "key" text NOT NULL,
    "value" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "rating_vote_idx" ON "rating_vote" USING btree ("authUserId", "kind", "key");

--
-- Class ReadingItem as table reading_item
--
CREATE TABLE "reading_item" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "url" text NOT NULL,
    "title" text NOT NULL,
    "kind" text NOT NULL,
    "nextOffset" bigint,
    "lastOffset" bigint,
    "total" bigint NOT NULL,
    "source" text,
    "author" text,
    "partIndex" bigint,
    "partCount" bigint,
    "partTitle" text,
    "partUrl" text,
    "startedAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reading_item_user_url_idx" ON "reading_item" USING btree ("authUserId", "url");
CREATE INDEX "reading_item_user_time_idx" ON "reading_item" USING btree ("authUserId", "updatedAt");

--
-- Class ReasoningNote as table reasoning_note
--
CREATE TABLE "reasoning_note" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "content" text NOT NULL
);

-- Indexes
CREATE INDEX "reasoning_note_timestamp_idx" ON "reasoning_note" USING btree ("timestamp");

--
-- Class SelfConfig as table self_config
--
CREATE TABLE "self_config" (
    "id" bigserial PRIMARY KEY,
    "toneNote" text NOT NULL,
    "replyLengthMax" bigint NOT NULL,
    "curiosityLevel" text NOT NULL,
    "history" json NOT NULL
);

--
-- Class Sighting as table sighting
--
CREATE TABLE "sighting" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "description" text NOT NULL,
    "question" text,
    "trackingNote" text
);

-- Indexes
CREATE INDEX "sighting_user_time_idx" ON "sighting" USING btree ("authUserId", "timestamp");

--
-- Class Synapse as table synapse
--
CREATE TABLE "synapse" (
    "id" bigserial PRIMARY KEY,
    "a" text NOT NULL,
    "b" text NOT NULL,
    "weight" double precision NOT NULL,
    "fires" bigint NOT NULL,
    "lastFired" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "synapse_pair_idx" ON "synapse" USING btree ("a", "b");
CREATE INDEX "synapse_weight_idx" ON "synapse" USING btree ("weight");

--
-- Class TrustScore as table trust_score
--
CREATE TABLE "trust_score" (
    "id" bigserial PRIMARY KEY,
    "kind" text NOT NULL,
    "key" text NOT NULL,
    "good" double precision NOT NULL,
    "bad" double precision NOT NULL,
    "score" double precision NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "trust_score_kind_key_idx" ON "trust_score" USING btree ("kind", "key");

--
-- Class UserDocument as table user_document
--
CREATE TABLE "user_document" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "name" text NOT NULL,
    "kind" text NOT NULL,
    "text" text NOT NULL,
    "summary" text,
    "chars" bigint NOT NULL,
    "words" bigint NOT NULL,
    "pages" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_document_user_idx" ON "user_document" USING btree ("authUserId", "createdAt");

--
-- Class UserProfile as table user_profile
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "username" text,
    "email" text,
    "avatar" text,
    "facts" json NOT NULL,
    "visitCount" bigint NOT NULL,
    "firstSeen" timestamp without time zone NOT NULL,
    "lastSeen" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_auth_user_id_idx" ON "user_profile" USING btree ("authUserId");

--
-- Class WordSense as table word_sense
--
CREATE TABLE "word_sense" (
    "id" bigserial PRIMARY KEY,
    "lemma" text NOT NULL,
    "pos" text NOT NULL,
    "rank" bigint NOT NULL,
    "tagCount" bigint NOT NULL,
    "definition" text NOT NULL,
    "example" text,
    "synonyms" json NOT NULL,
    "hypernym" text
);

-- Indexes
CREATE UNIQUE INDEX "word_sense_lemma_idx" ON "word_sense" USING btree ("lemma", "pos", "rank");

--
-- Class WorldCitizen as table world_citizen
--
CREATE TABLE "world_citizen" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "standing" bigint NOT NULL DEFAULT 0,
    "missionsDone" bigint NOT NULL DEFAULT 0,
    "record" text,
    "mission" text,
    "trainingOptIn" boolean NOT NULL DEFAULT false,
    "trainingAsked" boolean NOT NULL DEFAULT false,
    "naira" bigint NOT NULL DEFAULT 5000,
    "homeSlug" text,
    "homeMode" text,
    "rentPaidUntil" timestamp without time zone,
    "paidToday" text,
    "guideDone" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "world_citizen_user_idx" ON "world_citizen" USING btree ("authUserId");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "key" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "key", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261007135758829', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007135758829', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
