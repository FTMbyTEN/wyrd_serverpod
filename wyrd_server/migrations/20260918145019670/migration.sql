BEGIN;

--
-- ACTION CREATE TABLE
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
    "curriculum" text
);

-- Indexes
CREATE INDEX "memory_block_timestamp_idx" ON "memory_block" USING btree ("timestamp");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "username" text,
    "facts" json NOT NULL,
    "visitCount" bigint NOT NULL,
    "firstSeen" timestamp without time zone NOT NULL,
    "lastSeen" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_auth_user_id_idx" ON "user_profile" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918145019670', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918145019670', "timestamp" = now();

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
