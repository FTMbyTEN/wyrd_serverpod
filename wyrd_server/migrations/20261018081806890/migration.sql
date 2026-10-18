BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_furniture" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "item" text NOT NULL,
    "price" bigint NOT NULL,
    "boughtAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "island_furniture_user_idx" ON "island_furniture" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_home" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "plot" text NOT NULL,
    "style" text NOT NULL,
    "price" bigint NOT NULL,
    "boughtAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_home_plot_idx" ON "island_home" USING btree ("plot");
CREATE INDEX "island_home_user_idx" ON "island_home" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261018081806890', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018081806890', "timestamp" = now();

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
