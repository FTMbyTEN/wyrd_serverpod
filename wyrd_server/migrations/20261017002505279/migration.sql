BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_car" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "model" text NOT NULL,
    "color" text NOT NULL,
    "price" bigint NOT NULL,
    "dealer" text NOT NULL,
    "active" boolean NOT NULL DEFAULT false,
    "boughtAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "island_car_user_idx" ON "island_car" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261017002505279', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261017002505279', "timestamp" = now();

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
