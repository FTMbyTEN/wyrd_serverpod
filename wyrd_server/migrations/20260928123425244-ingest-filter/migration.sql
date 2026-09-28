BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ingest_day" (
    "id" bigserial PRIMARY KEY,
    "day" text NOT NULL,
    "kept" bigint NOT NULL,
    "duplicates" bigint NOT NULL,
    "quarantined" bigint NOT NULL,
    "reasons" json NOT NULL,
    "categories" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "ingest_day_day_idx" ON "ingest_day" USING btree ("day");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "memory_block" ADD COLUMN "quality" double precision;
ALTER TABLE "memory_block" ADD COLUMN "category" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "quarantined_item" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "source" text NOT NULL,
    "title" text NOT NULL,
    "url" text,
    "extract" text,
    "score" double precision NOT NULL,
    "reasons" json NOT NULL
);

-- Indexes
CREATE INDEX "quarantined_item_time_idx" ON "quarantined_item" USING btree ("timestamp");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928123425244-ingest-filter', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928123425244-ingest-filter', "timestamp" = now();

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
