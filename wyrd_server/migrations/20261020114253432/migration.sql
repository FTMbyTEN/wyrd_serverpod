BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_grid_career" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "track" text NOT NULL,
    "xp" bigint NOT NULL,
    "level" bigint NOT NULL,
    "examAfter" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "island_grid_career_user_track_idx" ON "island_grid_career" USING btree ("authUserId", "track");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_grid_work" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "kind" text NOT NULL,
    "track" text NOT NULL,
    "level" bigint NOT NULL,
    "spec" text NOT NULL,
    "status" text NOT NULL,
    "score" bigint,
    "paid" bigint,
    "issuedAt" timestamp without time zone NOT NULL,
    "doneAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "island_grid_work_user_idx" ON "island_grid_work" USING btree ("authUserId", "kind", "status");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261020114253432', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261020114253432', "timestamp" = now();

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
