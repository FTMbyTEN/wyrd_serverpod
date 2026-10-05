BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "city_charter" (
    "id" bigserial PRIMARY KEY,
    "charter" text NOT NULL,
    "missions" text NOT NULL,
    "author" text NOT NULL,
    "writtenAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "world_citizen_user_idx" ON "world_citizen" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261005170829169', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005170829169', "timestamp" = now();

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
