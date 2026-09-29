BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "chat_thread" ADD COLUMN "lastDocumentId" bigint;
ALTER TABLE "chat_thread" ADD COLUMN "lastDocumentName" text;
ALTER TABLE "chat_thread" ADD COLUMN "documentAt" timestamp without time zone;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_document" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "name" text NOT NULL,
    "kind" text NOT NULL,
    "text" text NOT NULL,
    "chars" bigint NOT NULL,
    "words" bigint NOT NULL,
    "pages" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_document_user_idx" ON "user_document" USING btree ("authUserId", "createdAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260929160306225-documents', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260929160306225-documents', "timestamp" = now();

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
