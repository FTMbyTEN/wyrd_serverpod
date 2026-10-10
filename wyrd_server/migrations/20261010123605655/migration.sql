BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "naira_entry" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "authUserId" uuid NOT NULL,
    "amount" bigint NOT NULL,
    "balanceAfter" bigint NOT NULL,
    "kind" text NOT NULL,
    "counter" text NOT NULL,
    "memo" text NOT NULL,
    "status" text NOT NULL DEFAULT 'posted'::text,
    "reverses" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "naira_entry_key_idx" ON "naira_entry" USING btree ("key");
CREATE INDEX "naira_entry_user_idx" ON "naira_entry" USING btree ("authUserId", "createdAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261010123605655', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010123605655', "timestamp" = now();

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
