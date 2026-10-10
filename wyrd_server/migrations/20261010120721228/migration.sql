BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "city_signal" (
    "id" bigserial PRIMARY KEY,
    "hour" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "place" text NOT NULL,
    "times" bigint NOT NULL,
    "total" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "city_signal_key_idx" ON "city_signal" USING btree ("hour", "kind", "place");
CREATE INDEX "city_signal_hour_idx" ON "city_signal" USING btree ("hour");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010120721228', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010120721228', "timestamp" = now();

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
