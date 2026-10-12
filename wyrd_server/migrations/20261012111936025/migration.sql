BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "title" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "chat_user_updated_idx" ON "chat" USING btree ("authUserId", "updatedAt");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "conversation_turn" ADD COLUMN "chatId" bigint;
CREATE INDEX "conversation_turn_chat_idx" ON "conversation_turn" USING btree ("chatId");

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261012111936025', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261012111936025', "timestamp" = now();

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
