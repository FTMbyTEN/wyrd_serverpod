BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_friend" (
    "id" bigserial PRIMARY KEY,
    "fromUser" uuid NOT NULL,
    "toUser" uuid NOT NULL,
    "status" text NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL,
    "decidedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "island_friend_pair_idx" ON "island_friend" USING btree ("fromUser", "toUser");
CREATE INDEX "island_friend_to_idx" ON "island_friend" USING btree ("toUser", "status");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261020204045760', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261020204045760', "timestamp" = now();

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
