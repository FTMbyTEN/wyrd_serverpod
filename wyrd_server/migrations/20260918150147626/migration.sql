BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "lexicon_entry" (
    "id" bigserial PRIMARY KEY,
    "word" text NOT NULL,
    "understood" boolean NOT NULL,
    "definition" text,
    "partOfSpeech" text,
    "learnedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "lexicon_entry_word_idx" ON "lexicon_entry" USING btree ("word");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260918150147626', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918150147626', "timestamp" = now();

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
