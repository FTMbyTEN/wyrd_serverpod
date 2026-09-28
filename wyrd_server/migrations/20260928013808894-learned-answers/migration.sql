BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "conversation_turn" ADD COLUMN "learnedAnswerId" bigint;
--
-- ACTION CREATE TABLE
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
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "learned_answer_intent_idx" ON "learned_answer" USING btree ("intent", "retired");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928013808894-learned-answers', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928013808894-learned-answers', "timestamp" = now();

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
