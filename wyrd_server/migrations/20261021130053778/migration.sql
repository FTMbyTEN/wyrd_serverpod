BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "island_payout_account" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "bankCode" text NOT NULL,
    "bankName" text NOT NULL,
    "accountNumber" text NOT NULL,
    "accountName" text NOT NULL,
    "legalName" text NOT NULL,
    "nameMatch" boolean NOT NULL,
    "email" text NOT NULL,
    "emailVerified" boolean NOT NULL DEFAULT false,
    "emailCode" text,
    "codeExpires" timestamp without time zone,
    "codeTries" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "island_payout_account_user_idx" ON "island_payout_account" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261021130053778', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261021130053778', "timestamp" = now();

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
