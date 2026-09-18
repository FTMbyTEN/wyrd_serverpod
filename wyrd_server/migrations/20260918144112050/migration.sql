BEGIN;

--
-- ACTION CREATE TABLE
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
    "seenTopics" json NOT NULL,
    "resolvedTopics" json NOT NULL,
    "selfAnswerTimestamps" json NOT NULL
);


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918144112050', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918144112050', "timestamp" = now();

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
