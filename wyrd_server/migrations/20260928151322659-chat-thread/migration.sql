BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_thread" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "subject" json NOT NULL,
    "lastReadUrl" text,
    "lastReadTitle" text,
    "nextOffset" bigint,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "chat_thread_user_idx" ON "chat_thread" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928151322659-chat-thread', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928151322659-chat-thread', "timestamp" = now();

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



--
-- DATA: the feed stored the same few stories over and over before the ingest filter existed
-- (97% repeats). Keep the first copy of each article, remove the rest, now rather than waiting for sleep.
--
DELETE FROM "memory_block" WHERE "id" IN (
    SELECT "id" FROM (
        SELECT "id", row_number() OVER (PARTITION BY lower("title"), "url" ORDER BY "id") AS n
        FROM "memory_block" WHERE "source" = 'net' AND "title" IS NOT NULL
    ) x WHERE n > 1
);

COMMIT;
