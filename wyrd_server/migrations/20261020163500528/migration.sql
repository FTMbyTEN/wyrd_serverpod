BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_jet" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "model" text NOT NULL,
    "tail" text NOT NULL,
    "livery" bigint NOT NULL,
    "showName" boolean NOT NULL DEFAULT false,
    "price" bigint NOT NULL,
    "boughtAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_jet_user_idx" ON "island_jet" USING btree ("authUserId");
CREATE UNIQUE INDEX "island_jet_tail_idx" ON "island_jet" USING btree ("tail");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261020163500528', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261020163500528', "timestamp" = now();

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
