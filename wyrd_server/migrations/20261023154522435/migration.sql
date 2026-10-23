BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_job_share" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "source" text NOT NULL,
    "workplace" text NOT NULL,
    "title" text NOT NULL,
    "paycheck" bigint NOT NULL,
    "cashKobo" bigint NOT NULL,
    "status" text NOT NULL,
    "availableAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_job_share_source_idx" ON "island_job_share" USING btree ("source");
CREATE INDEX "island_job_share_user_idx" ON "island_job_share" USING btree ("authUserId", "status");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261023154522435', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261023154522435', "timestamp" = now();

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
