BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "eval_run" (
    "id" bigserial PRIMARY KEY,
    "startedAt" timestamp without time zone NOT NULL,
    "model" text NOT NULL,
    "passed" bigint NOT NULL,
    "total" bigint NOT NULL,
    "costMicroUsd" bigint NOT NULL,
    "ms" bigint NOT NULL,
    "results" text NOT NULL
);

-- Indexes
CREATE INDEX "eval_run_started_idx" ON "eval_run" USING btree ("startedAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261012111213462', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261012111213462', "timestamp" = now();

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
