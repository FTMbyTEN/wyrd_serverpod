BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rating_vote" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "kind" text NOT NULL,
    "key" text NOT NULL,
    "value" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "rating_vote_idx" ON "rating_vote" USING btree ("authUserId", "kind", "key");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260928164031344-rating-vote', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928164031344-rating-vote', "timestamp" = now();

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
