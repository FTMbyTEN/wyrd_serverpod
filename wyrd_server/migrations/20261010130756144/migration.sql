BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "police_citation" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "code" text NOT NULL,
    "place" text NOT NULL,
    "evidence" text NOT NULL,
    "confidence" double precision NOT NULL,
    "outcome" text NOT NULL,
    "amount" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL,
    "paid" bigint NOT NULL DEFAULT 0,
    "owed" bigint NOT NULL DEFAULT 0,
    "entryId" bigint,
    "settledBy" text,
    "appealReason" text,
    "appealResult" text,
    "createdAt" timestamp without time zone NOT NULL,
    "settledAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "police_citation_user_idx" ON "police_citation" USING btree ("authUserId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wanted_state" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "heat" double precision NOT NULL DEFAULT 0,
    "state" text NOT NULL DEFAULT 'clear'::text,
    "stateAt" timestamp without time zone NOT NULL,
    "pursuitAt" timestamp without time zone,
    "lastPursuitAt" timestamp without time zone,
    "lastStopAt" timestamp without time zone,
    "lostSince" timestamp without time zone,
    "complyingSince" timestamp without time zone,
    "nearSince" timestamp without time zone,
    "searchUntil" timestamp without time zone,
    "calm" boolean NOT NULL DEFAULT false,
    "calls" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "wanted_state_user_idx" ON "wanted_state" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010130756144', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010130756144', "timestamp" = now();

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
