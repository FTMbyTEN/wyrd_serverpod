BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "cop_log_entry" (
    "id" bigserial PRIMARY KEY,
    "timestamp" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "configKey" text NOT NULL,
    "oldValueJson" text NOT NULL,
    "newValueJson" text NOT NULL,
    "reason" text NOT NULL,
    "verdict" text NOT NULL
);

-- Indexes
CREATE INDEX "cop_log_entry_timestamp_idx" ON "cop_log_entry" USING btree ("timestamp");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "self_config" (
    "id" bigserial PRIMARY KEY,
    "toneNote" text NOT NULL,
    "replyLengthMax" bigint NOT NULL,
    "curiosityLevel" text NOT NULL,
    "history" json NOT NULL
);


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918164200115', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918164200115', "timestamp" = now();

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
