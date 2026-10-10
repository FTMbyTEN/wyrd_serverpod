BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "naira_dispute" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "entryId" bigint NOT NULL,
    "reason" text NOT NULL,
    "status" text NOT NULL,
    "refundEntryId" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "naira_dispute_entry_idx" ON "naira_dispute" USING btree ("entryId");
CREATE INDEX "naira_dispute_user_idx" ON "naira_dispute" USING btree ("authUserId", "createdAt");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "world_citizen" ADD COLUMN "debt" bigint NOT NULL DEFAULT 0;
ALTER TABLE "world_citizen" ADD COLUMN "debtSince" timestamp without time zone;
ALTER TABLE "world_citizen" ADD COLUMN "rentGraceUntil" timestamp without time zone;
ALTER TABLE "world_citizen" ADD COLUMN "fineWarnedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010125544440', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010125544440', "timestamp" = now();

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
