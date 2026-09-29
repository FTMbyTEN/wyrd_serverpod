BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "belief" (
    "id" bigserial PRIMARY KEY,
    "a" text NOT NULL,
    "b" text NOT NULL,
    "claim" text NOT NULL,
    "evidenceIds" json NOT NULL,
    "sources" bigint NOT NULL,
    "against" bigint NOT NULL,
    "confidence" double precision NOT NULL,
    "status" text NOT NULL,
    "origin" text NOT NULL,
    "tests" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "testedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "belief_pair_idx" ON "belief" USING btree ("a", "b");
CREATE INDEX "belief_tested_idx" ON "belief" USING btree ("testedAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260929161500353-beliefs', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260929161500353-beliefs', "timestamp" = now();

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
