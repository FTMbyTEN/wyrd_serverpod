BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "conversation_turn" ADD COLUMN "groundingIds" json;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "trust_score" (
    "id" bigserial PRIMARY KEY,
    "kind" text NOT NULL,
    "key" text NOT NULL,
    "good" double precision NOT NULL,
    "bad" double precision NOT NULL,
    "score" double precision NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "trust_score_kind_key_idx" ON "trust_score" USING btree ("kind", "key");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928134516930-trust', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928134516930-trust', "timestamp" = now();

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
