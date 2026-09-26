BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mind_topic" (
    "id" bigserial PRIMARY KEY,
    "topic" text NOT NULL,
    "resolved" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "mind_topic_topic_idx" ON "mind_topic" USING btree ("topic");

--
-- DATA MIGRATION (hand-written): copy the topic sets off the mind row before its columns are
-- dropped, so digest progress survives. Every resolved topic is also a seen topic.
--
INSERT INTO "mind_topic" ("topic", "resolved")
SELECT DISTINCT t, false FROM "mind", json_array_elements_text("mind"."seenTopics") AS t
ON CONFLICT ("topic") DO NOTHING;
INSERT INTO "mind_topic" ("topic", "resolved")
SELECT DISTINCT t, true FROM "mind", json_array_elements_text("mind"."resolvedTopics") AS t
ON CONFLICT ("topic") DO UPDATE SET "resolved" = true;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "mind" DROP COLUMN "seenTopics";
ALTER TABLE "mind" DROP COLUMN "resolvedTopics";


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260926115814390', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926115814390', "timestamp" = now();

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
