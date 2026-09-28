BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "memory_block" ADD COLUMN "ownerId" uuid;
CREATE INDEX "memory_block_owner_idx" ON "memory_block" USING btree ("ownerId");

--
-- MIGRATION VERSION FOR wyrd
--

-- Who each existing chat/photo memory came from: the conversation turn with the same text.
UPDATE "memory_block" b SET "ownerId" = t."authUserId"
FROM "conversation_turn" t
WHERE b."source" IN ('chat', 'photo') AND b."ownerId" IS NULL
  AND t."userText" = b."userText" AND t."botText" = b."botText";

-- Remove public output written before chats and photos were kept out of it.
CREATE TEMP TABLE private_block ON COMMIT DROP AS
  SELECT "id" FROM "memory_block" WHERE "source" IN ('chat', 'photo');
-- topics that only ever came up in people's chats or photos
CREATE TEMP TABLE private_topic ON COMMIT DROP AS
  SELECT DISTINCT lower(x) AS topic FROM "memory_block" b, json_array_elements_text(b."topics") x
  WHERE b."source" IN ('chat', 'photo')
  EXCEPT
  SELECT DISTINCT lower(x) FROM "memory_block" b, json_array_elements_text(b."topics") x
  WHERE b."source" NOT IN ('chat', 'photo');

-- self-questions: the log names the memories each answer drew on
CREATE TEMP TABLE tainted_note ON COMMIT DROP AS
  SELECT n."id", substring(n."content" from '- topic: ([^\n]*)') AS topic,
         substring(n."content" from 'Q: ([^\n]*)') AS question
  FROM "reasoning_note" n
  WHERE n."kind" = 'self' AND (
    lower(substring(n."content" from '- topic: ([^\n]*)')) IN (SELECT topic FROM private_topic)
    OR EXISTS (
      SELECT 1 FROM unnest(string_to_array(substring(n."content" from 'supporting blocks: ([0-9, ]+)'), ',')) s
      WHERE trim(s) <> '' AND trim(s)::bigint IN (SELECT "id" FROM private_block)));
CREATE TEMP TABLE removed_block ON COMMIT DROP AS
  SELECT b."id" FROM "memory_block" b
  WHERE (b."source" = 'self' AND (lower(b."answeredTopic") IN (SELECT topic FROM private_topic)
         OR EXISTS (SELECT 1 FROM tainted_note n WHERE n.topic = b."answeredTopic" AND n.question = b."question")))
     OR (b."source" = 'synthesis' AND (
         EXISTS (SELECT 1 FROM json_array_elements_text(coalesce(b."sourceBlockIds", '[]'::json)) s
                 WHERE s::bigint IN (SELECT "id" FROM private_block))
         OR EXISTS (SELECT 1 FROM json_array_elements_text(coalesce(b."sourceTopics", '[]'::json)) s
                    WHERE lower(s) IN (SELECT topic FROM private_topic))));
DELETE FROM "reasoning_note" WHERE "id" IN (SELECT "id" FROM tainted_note);
DELETE FROM "dream_entry" d WHERE EXISTS (
  SELECT 1 FROM json_array_elements_text(d."sourceBlockIds") s
  WHERE s::bigint IN (SELECT "id" FROM removed_block) OR s::bigint IN (SELECT "id" FROM private_block));
DELETE FROM "memory_block" WHERE "id" IN (SELECT "id" FROM removed_block);
-- diary entries that name a topic only people's chats or photos mentioned
DELETE FROM "diary_entry" d WHERE EXISTS (
  SELECT 1 FROM private_topic p
  WHERE length(p.topic) >= 4 AND p.topic ~ '^[a-z0-9 -]+$' AND d."content" ~* ('\m' || p.topic || '\M'));
-- a focus that came from a chat
UPDATE "mind" SET "focusTopic" = NULL, "activeGoal" = NULL
WHERE lower("focusTopic") IN (SELECT topic FROM private_topic);

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928162226622-privacy-owner', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928162226622-privacy-owner', "timestamp" = now();

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
