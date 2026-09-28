BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reading_item" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "url" text NOT NULL,
    "title" text NOT NULL,
    "kind" text NOT NULL,
    "nextOffset" bigint,
    "total" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reading_item_user_url_idx" ON "reading_item" USING btree ("authUserId", "url");
CREATE INDEX "reading_item_user_time_idx" ON "reading_item" USING btree ("authUserId", "updatedAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928204239146-library', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928204239146-library', "timestamp" = now();

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
