BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "curriculum_progress" (
    "id" bigserial PRIMARY KEY,
    "index" bigint NOT NULL,
    "completedTitles" json NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "memory_block" DROP COLUMN "curriculum";
ALTER TABLE "memory_block" ADD COLUMN "curriculumSubject" text;
ALTER TABLE "memory_block" ADD COLUMN "curriculumLevel" text;

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918163507744', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918163507744', "timestamp" = now();

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
