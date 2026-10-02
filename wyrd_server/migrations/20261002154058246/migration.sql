BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "game_match" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "game" text NOT NULL,
    "state" text NOT NULL,
    "moves" json NOT NULL,
    "playerSide" text NOT NULL,
    "status" text NOT NULL,
    "wyrdLevel" bigint NOT NULL,
    "ratingBefore" double precision NOT NULL,
    "ratingAfter" double precision,
    "remark" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "game_match_user_idx" ON "game_match" USING btree ("authUserId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "player_rating" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "game" text NOT NULL,
    "name" text NOT NULL,
    "rating" double precision NOT NULL,
    "played" bigint NOT NULL,
    "wins" bigint NOT NULL,
    "losses" bigint NOT NULL,
    "draws" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "player_rating_user_game_idx" ON "player_rating" USING btree ("authUserId", "game");
CREATE INDEX "player_rating_board_idx" ON "player_rating" USING btree ("game", "rating");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261002154058246', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261002154058246', "timestamp" = now();

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
