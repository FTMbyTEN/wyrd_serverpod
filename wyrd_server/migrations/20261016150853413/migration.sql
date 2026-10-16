BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_access" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "requesterId" uuid NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_access_idx" ON "island_access" USING btree ("ownerId", "requesterId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_application" (
    "id" bigserial PRIMARY KEY,
    "jobId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "note" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_application_idx" ON "island_application" USING btree ("jobId", "authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_group" (
    "id" bigserial PRIMARY KEY,
    "createdBy" uuid NOT NULL,
    "nameCt" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_job" (
    "id" bigserial PRIMARY KEY,
    "employerUserId" uuid NOT NULL,
    "company" text NOT NULL,
    "title" text NOT NULL,
    "pay" text NOT NULL,
    "skills" text NOT NULL,
    "location" text NOT NULL,
    "about" text NOT NULL,
    "contact" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "island_job_status_idx" ON "island_job" USING btree ("status", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_member" (
    "id" bigserial PRIMARY KEY,
    "groupId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "wrappedKey" text NOT NULL,
    "wrapperPub" text NOT NULL,
    "addedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_member_idx" ON "island_member" USING btree ("groupId", "authUserId");
CREATE INDEX "island_member_user_idx" ON "island_member" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_message" (
    "id" bigserial PRIMARY KEY,
    "groupId" bigint NOT NULL,
    "senderId" uuid NOT NULL,
    "ct" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "island_message_group_idx" ON "island_message" USING btree ("groupId", "id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "handle" text NOT NULL,
    "skills" text NOT NULL DEFAULT ''::text,
    "openToWork" boolean NOT NULL DEFAULT false,
    "pubKey" text,
    "hqName" text,
    "hqColor" text NOT NULL DEFAULT '#A855F7'::text,
    "hqLocked" boolean NOT NULL DEFAULT true,
    "hqInvites" text NOT NULL DEFAULT '[]'::text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_profile_user_idx" ON "island_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX "island_profile_handle_idx" ON "island_profile" USING btree ("handle");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_show" (
    "id" bigserial PRIMARY KEY,
    "hostUserId" uuid NOT NULL,
    "artist" text NOT NULL,
    "title" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "minutes" bigint NOT NULL DEFAULT 60,
    "price" bigint NOT NULL,
    "capacity" bigint NOT NULL DEFAULT 500,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "island_show_time_idx" ON "island_show" USING btree ("status", "startsAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_ticket" (
    "id" bigserial PRIMARY KEY,
    "showId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_ticket_idx" ON "island_ticket" USING btree ("showId", "authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261016150853413', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261016150853413', "timestamp" = now();

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
