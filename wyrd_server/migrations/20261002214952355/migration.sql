BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "game_match" ADD COLUMN "mode" text NOT NULL DEFAULT 'wyrd'::text;
ALTER TABLE "game_match" ADD COLUMN "opponentId" uuid;
ALTER TABLE "game_match" ADD COLUMN "playerName" text;
ALTER TABLE "game_match" ADD COLUMN "opponentName" text;
ALTER TABLE "game_match" ADD COLUMN "result" text;
ALTER TABLE "game_match" ADD COLUMN "version" bigint NOT NULL DEFAULT 0;
CREATE INDEX "game_match_open_idx" ON "game_match" USING btree ("game", "mode", "status");
CREATE INDEX "game_match_opponent_idx" ON "game_match" USING btree ("opponentId", "status");

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261002214952355', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261002214952355', "timestamp" = now();

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
