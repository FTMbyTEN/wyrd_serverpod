BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_topup" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "txRef" text NOT NULL,
    "pack" text NOT NULL,
    "amountNgn" bigint NOT NULL,
    "naira" bigint NOT NULL,
    "status" text NOT NULL,
    "flwId" text,
    "createdAt" timestamp without time zone NOT NULL,
    "paidAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "island_topup_ref_idx" ON "island_topup" USING btree ("txRef");
CREATE INDEX "island_topup_user_idx" ON "island_topup" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261021100504369', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261021100504369', "timestamp" = now();

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
