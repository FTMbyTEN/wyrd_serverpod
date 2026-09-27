BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sighting" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "description" text NOT NULL,
    "question" text,
    "trackingNote" text
);

-- Indexes
CREATE INDEX "sighting_user_time_idx" ON "sighting" USING btree ("authUserId", "timestamp");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260927113017044-visual-memory', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927113017044-visual-memory', "timestamp" = now();

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
