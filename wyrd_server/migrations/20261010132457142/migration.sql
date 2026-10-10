BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "city_flag" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "value" text NOT NULL,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "city_flag_name_idx" ON "city_flag" USING btree ("name");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010132457142', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010132457142', "timestamp" = now();

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
