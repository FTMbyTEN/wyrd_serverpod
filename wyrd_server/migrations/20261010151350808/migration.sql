BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_account" (
    "id" bigserial PRIMARY KEY,
    "partner" text NOT NULL,
    "env" text NOT NULL,
    "allowance" bigint,
    "used" bigint NOT NULL DEFAULT 0,
    "validUntil" timestamp without time zone,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "partner_account_idx" ON "partner_account" USING btree ("partner", "env");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_conversation" (
    "id" bigserial PRIMARY KEY,
    "convId" text NOT NULL,
    "partner" text NOT NULL,
    "env" text NOT NULL,
    "userRef" text NOT NULL,
    "surface" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "lastAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "partner_conversation_id_idx" ON "partner_conversation" USING btree ("convId");
CREATE INDEX "partner_conversation_user_idx" ON "partner_conversation" USING btree ("partner", "env", "userRef");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_deletion" (
    "id" bigserial PRIMARY KEY,
    "deletionId" text NOT NULL,
    "partner" text NOT NULL,
    "env" text NOT NULL,
    "what" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "doneAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "partner_deletion_id_idx" ON "partner_deletion" USING btree ("deletionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_idem" (
    "id" bigserial PRIMARY KEY,
    "idemKey" text NOT NULL,
    "bodyHash" text NOT NULL,
    "status" bigint NOT NULL,
    "response" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "partner_idem_key_idx" ON "partner_idem" USING btree ("idemKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_key" (
    "id" bigserial PRIMARY KEY,
    "keyHash" text NOT NULL,
    "prefix" text NOT NULL,
    "partner" text NOT NULL,
    "env" text NOT NULL,
    "label" text NOT NULL,
    "active" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "revokedAt" timestamp without time zone,
    "lastUsedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "partner_key_hash_idx" ON "partner_key" USING btree ("keyHash");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_message" (
    "id" bigserial PRIMARY KEY,
    "convId" text NOT NULL,
    "msgId" text NOT NULL,
    "role" text NOT NULL,
    "text" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "partner_message_conv_idx" ON "partner_message" USING btree ("convId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_usage" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "partner" text NOT NULL,
    "env" text NOT NULL,
    "surface" text NOT NULL,
    "requests" bigint NOT NULL DEFAULT 0,
    "inputTokens" bigint NOT NULL DEFAULT 0,
    "outputTokens" bigint NOT NULL DEFAULT 0,
    "costMicros" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "partner_usage_idx" ON "partner_usage" USING btree ("day", "partner", "env", "surface");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010151350808', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010151350808', "timestamp" = now();

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
