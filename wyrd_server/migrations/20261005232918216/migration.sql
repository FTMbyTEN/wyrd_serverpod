BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "world_citizen" ADD COLUMN "naira" bigint NOT NULL DEFAULT 5000;
ALTER TABLE "world_citizen" ADD COLUMN "homeSlug" text;
ALTER TABLE "world_citizen" ADD COLUMN "homeMode" text;
ALTER TABLE "world_citizen" ADD COLUMN "rentPaidUntil" timestamp without time zone;
ALTER TABLE "world_citizen" ADD COLUMN "paidToday" text;

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261005232918216', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005232918216', "timestamp" = now();

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
