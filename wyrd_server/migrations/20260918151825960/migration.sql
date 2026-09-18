BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "diary_entry" (
    "id" bigserial PRIMARY KEY,
    "date" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "content" text NOT NULL
);

-- Indexes
CREATE INDEX "diary_entry_timestamp_idx" ON "diary_entry" USING btree ("timestamp");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dream_entry" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "content" text NOT NULL,
    "sourceBlockIds" json NOT NULL
);

-- Indexes
CREATE INDEX "dream_entry_timestamp_idx" ON "dream_entry" USING btree ("timestamp");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "growth_snapshot" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "vocabCount" bigint NOT NULL,
    "blockCount" bigint NOT NULL,
    "digestPercent" double precision NOT NULL,
    "curiosity" double precision NOT NULL,
    "confidence" double precision NOT NULL
);

-- Indexes
CREATE INDEX "growth_snapshot_timestamp_idx" ON "growth_snapshot" USING btree ("timestamp");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918151825960', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918151825960', "timestamp" = now();

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
