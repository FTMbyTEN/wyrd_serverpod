BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quiz_attempt" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "readingItemId" bigint,
    "title" text NOT NULL,
    "correct" bigint NOT NULL,
    "total" bigint NOT NULL,
    "missed" json NOT NULL,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "quiz_attempt_user_idx" ON "quiz_attempt" USING btree ("authUserId", "at");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928221357950-quiz', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928221357950-quiz', "timestamp" = now();

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
