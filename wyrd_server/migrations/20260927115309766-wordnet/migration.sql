BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "word_sense" (
    "id" bigserial PRIMARY KEY,
    "lemma" text NOT NULL,
    "pos" text NOT NULL,
    "rank" bigint NOT NULL,
    "tagCount" bigint NOT NULL,
    "definition" text NOT NULL,
    "example" text,
    "synonyms" json NOT NULL,
    "hypernym" text
);

-- Indexes
CREATE UNIQUE INDEX "word_sense_lemma_idx" ON "word_sense" USING btree ("lemma", "pos", "rank");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260927115309766-wordnet', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927115309766-wordnet', "timestamp" = now();

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
