BEGIN;

--
-- ACTION CREATE TABLE
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
-- DATA MIGRATION (hand-written): remove WYRD's self-echo from memory. Schema is unchanged by
-- this block. Canned self-answers ("...ties back to a few things I've run into before...") were
-- stored as memories, so their boilerplate words became the most frequent topics, its focus,
-- and 'resolved' digest progress. The code no longer stores them; this removes the old ones.
--

-- 1. the canned answers themselves (current wording and the old Node server's wording)
DELETE FROM "memory_block"
WHERE "source" = 'self' AND (
     "answer" LIKE '%ties back to a few things I''ve run into before%'
  OR "answer" LIKE '%connects to something I''ve seen before, so I''ve got at least a little to go on%'
  OR "answer" LIKE '%keeping it as an open question until more comes in%'
  OR "answer" LIKE '%seems to connect to%enough grounding to treat this as a working answer%'
  OR "answer" LIKE '%I don''t have enough supporting data on%filing this as an open question%'
);

-- 2. boilerplate words that only ever entered the topic set through those answers
DELETE FROM "mind_topic"
WHERE "topic" IN ('ties', 'feels', 'seen', 'least', 'little', 'got', 'something', 'things', 'keeping', 'comes');

-- 3. a topic is resolved only if a real self-answer about it remains
UPDATE "mind_topic" SET "resolved" = false;
UPDATE "mind_topic" AS mt SET "resolved" = true
FROM (SELECT DISTINCT "answeredTopic" AS t FROM "memory_block"
      WHERE "source" = 'self' AND "answeredTopic" IS NOT NULL) AS real
WHERE mt."topic" = real.t;

-- 4. the mind's focus, answer rate and self-question count reflect real answers only
UPDATE "mind" SET
  "focusTopic" = NULL,
  "selfAnswerTimestamps" = '[]'::json,
  "explorationCount" = (SELECT count(*) FROM "memory_block" WHERE "source" = 'self')
WHERE "id" = 1;

INSERT INTO "maintenance_run" ("name", "ranAt", "note")
VALUES ('cleanup-self-echo', now(), 'removed canned self-answers from memory; recomputed resolved topics');


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260926191336496-cleanup-self-echo', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926191336496-cleanup-self-echo', "timestamp" = now();

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
